


/*
1.0
curl --location --request GET 'https://finalize-testing.bytetech.co/finalize_test?version=1.0&order_id=1323PYAA3A' \
--header 'Authorization: KALSDFIO9RWR02JFOWEFJ20JIWEFOI'

1.1
curl --location --request GET 'https://finalize-testing.bytetech.co/finalize_test?version=1.1&order_id=1323PYAA3A' \
--header 'Authorization: KALSDFIO9RWR02JFOWEFJ20JIWEFOI'

show report with all needed columns
*/
package main

import (
    "fmt"
    "os"
    "log"
    "bufio"
    "io/ioutil"
  	 "net/http"
    "flag"
    // "crypto/tls"
    "encoding/json"
    "github.com/tealeg/xlsx"
    "strings"
    "strconv"
    "database/sql"
    _ "github.com/lib/pq"
    "time"

//    "net/http/cookiejar"

)

const  (
  NumCol = 3
)
var (
  TOTAL = 0.0;
  storeID = "1587"
)

// Defaults
var (
  // mysql Local DB Settings
  whost = os.Getenv("DB_W_Host")
  rhost = os.Getenv("DB_R_Host")
  user = os.Getenv("DB_User")
  password  = os.Getenv("DB_Password")
  db_name  = os.Getenv("DB_Name")
  port = os.Getenv("DB_Port")

  //  mysql database core package Variables
  Db *sql.DB
  DbR *sql.DB
  Date
)

type Payment struct {
    Card_pan string `json:"card_pan"`
    Card_type string `json:"card_type"`
    First_name string `json:"first_name"`
    Ksn string `json:"ksn"`
    Last_name string `json:"last_name"`
    Magne_print string `json:"magne_print"`
    Magne_print_status string `json:"magne_print_status"`
    Track2 string `json:"track2"`
    Validate int64 `json:"validate"`
}
type P_products struct {
    Epc string `json:"epc"`
    Price float64 `json"price"`
}


type SyncTrasact struct {
  //ClientId string  `json:"clientId"`
  Coupon string  `json:"coupon"`
  //  Value float64  `json:"value"`
  Created int64  `json:"created"`
  Currency string  `json:"currency"`
  Email string  `json:"email"`
  Order_id string   `json:"order_id"`

  Payment Payment   `json:"payment"`

  Payment_system string   `json:"payment_system"`
  Purchased_products []P_products   `json:"purchased_products"`

  Stamp int64   `json:"stamp"`

  Tablet_processing_done int64   `json:"tablet_processing_done"`
  Time int64   `json:"time"`
  Time_capture int64   `json:"time_capture"`
  Time_closed int64   `json:"time_closed"`
  Time_door_closed int64   `json:"time_door_closed"`
  Time_door_opened int64   `json:"time_door_opened"`
  Time_opened int64   `json:"time_opened"`
  Time_preauth int64   `json:"time_preauth"`

}


func main() {


      currentTime := time.Now()

      fmt.Println("Current Time in String: ", currentTime.String())

      fmt.Println("MM-DD-YYYY : ", currentTime.Format("01-02-2006"))
      exit;
  InitDB();


  head,body,_ := KioskLoginFromProd();
  fmt.Println("Head->",head,"\n\nBody->",body)
  cookie := GetLoginCookie(head,body)
  fmt.Println("Head->",head,"\n\nBody->",body)



  flag.Parse()
  inputf := flag.Arg(0)
  fmt.Println(inputf)
    file, err := os.Open(inputf)
    if err != nil {
        log.Fatal(err)
    }
    defer file.Close()

    scanner := bufio.NewScanner(file)
    ct :=0
    harray :="";
    for scanner.Scan() {             // internally, it advances token based on sperator
      line:=scanner.Text();
//      fmt.Printf("->%s<-",line)  // token in unicode-char
      if ct == 0 {
        harray = line
      }else{
        p := ProcessLine(line,harray)
//        fmt.Println(p)  // token in unicode-char
        out, _ := json.Marshal(p)
        fmt.Println("\nMARSHAL3->",string(out))
        _,err :=ProcessTransactions(cookie,string(out))
        if err != nil{
          fmt.Printf("Error in Process Tran for %s -> %v\n",p.Order_id,err)
        }

      }

      ct++
    } // End of for scanner.Scan()

    fmt.Println("TOTAL -> ",TOTAL)
}

func ProcessLine(text string,h string)(* SyncTrasact){
//./discount := new(DiscountArray)
  head := strings.Split(h,"\t");

  sync := new(SyncTrasact)
  oldP := new(Payment)
  s := strings.Split(text,"\t");

  //ct:=0
  x:=0
  for i := 0; i < len(s); i++ {
    if (head[x]=="purchased_products"){
      fmt.Printf("\n\nin pp i=%d x=%d epc=%s \nWorking len(s)->%d on %s\n",i,x,s[i],len(s),s[0])
      nump :=0
      for j :=0; j<(len(s)-i); j++{
        if(len(s[i+j]) <24){
          nump=j
          j--
          break;
        }
      }

      pp := new(P_products)
      for j:=0; j<nump;j++{
        pp.Epc =s[i+j]
        pp.Price,_ =strconv.ParseFloat(s[i+j+nump],64)
        fmt.Printf("HERE i=%d,j=%d\t epc=%s, nump=%d,price=%v,\n",i,j,s[i+j],nump,s[i+j+nump])
        sync.Purchased_products=append(sync.Purchased_products,*pp)
        TOTAL += pp.Price
      }
      //x=i+2*nump;
      i +=2*(nump-1)

    }else if (head[x]=="coupon"){
      sync.Coupon=s[i]
    }else if (head[x]=="created"){
      sync.Created,_ =strconv.ParseInt(s[i],10,64)
    }else if (head[x]=="currency"){
      sync.Currency=s[i]
    }else if (head[x]=="email"){
      sync.Email=s[i]
    }else if (head[x]=="order_id"){
      sync.Order_id=s[i]
      oldP,_ = KioskGetPaymentFromOrderID(s[i])
    }else if (head[x]=="payment_system"){
      sync.Payment_system=s[i]
    }else if (head[x]=="stamp"){
      sync.Stamp,_ =strconv.ParseInt(s[i],10,64)
    }else if (head[x]=="tablet_processing_done"){
      sync.Tablet_processing_done,_ =strconv.ParseInt(s[i],10,64)
    }else if (head[x]=="time"){
      sync.Time,_ =strconv.ParseInt(s[i],10,64)
    }else if (head[x]=="time_capture"){
      sync.Time_capture,_ =strconv.ParseInt(s[i],10,64)
    }else if (head[x]=="time_closed"){
      sync.Time_closed,_ =strconv.ParseInt(s[i],10,64)
    }else if (head[x]=="time_door_closed"){
      sync.Time_door_closed,_ =strconv.ParseInt(s[i],10,64)
    }else if (head[x]=="time_door_opened"){
      sync.Time_door_opened,_ =strconv.ParseInt(s[i],10,64)
    }else if (head[x]=="time_opened"){
      fmt.Printf("TimeOpened pp i=%d x=%d time_opened=%s \nWorking on %s\n",i,x,s[i],s[0])
      sync.Time_opened,_ =strconv.ParseInt(s[i],10,64)
    }else if (head[x]=="time_preauth"){
      sync.Time_preauth,_ =strconv.ParseInt(s[i],10,64)
    }else if (head[x]=="card_pan"){
      if(oldP.Card_pan ==""){
        sync.Payment.Card_pan=s[i]
      }else{
        sync.Payment.Card_pan=oldP.Card_pan
      }

    }else if (head[x]=="card_type"){
      if(oldP.Card_type ==""){
        sync.Payment.Card_type=s[i]
      }else{
        sync.Payment.Card_type=oldP.Card_type
      }
    }else if (head[x]=="first_name"){
      if(oldP.First_name ==""){
        sync.Payment.First_name=s[i]
      }else{
        sync.Payment.First_name=oldP.First_name
      }    }else if (head[x]=="ksn"){

    }else if (head[x]=="last_name"){
      if(oldP.Last_name ==""){
        sync.Payment.Last_name=s[i]
      }else{
        sync.Payment.Last_name=oldP.Last_name
      }

    }else if (head[x]=="magne_print"){
      if(oldP.Magne_print ==""){
        sync.Payment.Magne_print=s[i]
      }else{
        sync.Payment.Magne_print=oldP.Magne_print
      }
    }else if (head[x]=="magne_print_status"){
      if(oldP.Magne_print_status ==""){
        sync.Payment.Magne_print_status=s[i]
      }else{
        sync.Payment.Magne_print_status=oldP.Magne_print_status
      }

    }else if (head[x]=="track2"){
      if(oldP.Track2 ==""){
        sync.Payment.Track2=s[i]
      }else{
        sync.Payment.Track2=oldP.Track2
      }
    }else if (head[x]=="validate"){
      sync.Payment.Validate=1
      // if(oldP.Validate <1){
      //   sync.Payment.Validate,_=strconv.ParseInt(s[i],10,64)
      // }else{
      //   sync.Payment.Validate=oldP.Validate
      // }
    }

    x++
  }
  // fmt.Println("sync.payment.validate->",sync.Payment.Validate)
  // fmt.Println("sync.payment.last_name->",sync.Payment.Last_name)
  // fmt.Println("sync.payment.track2->",sync.Payment.Track2)

   out, _ := json.Marshal(sync)
   fmt.Println("\nMARSHAL3->",string(out))
  //
  fmt.Printf("\nMe->%v",&sync)

  return sync
}

/*
                1.0	1.1
0          1    2  3   4
order_id	QTY	EPC	QTY	EPC
*/

func WriteRow (text []string,sheet *xlsx.Sheet ) (bool){
  var row *xlsx.Row
  var cell *xlsx.Cell

  for i := 0; i < len(text); i++ {
//    fmt.Println("inWrite->",text[i])
    if i == 0 {
      row = sheet.AddRow()
    }
      cell = row.AddCell()
      cell.Value = text[i]
  }
    return true
}

func KioskLoginFromProd() (string,string,error){

//  sql := `SELECT rl.start_ts,rl.request_headers,rl.cookie,rl.request_body
  sql := `
  SELECT rl.request_headers,rl.request_body
  FROM mixalot.request_log rl
  WHERE rl.start_ts >=  NOW()- interval '6 days'
    AND rl.endpoint='/login' AND rl.kiosk_id = '`+storeID+"'"+`
  ORDER by rl.start_ts DESC LIMIT 1; `

  fmt.Printf("%s\n->%s<-\n",sql,storeID)

  //return "","",nil
  rows, err := DbR.Query(sql)
  if err != nil {
    fmt.Println("in KioskLoginFromProd error",err)
    return "", "", err
  }
  defer rows.Close()

  rows.Next()
  var req_head string
  var req_body string
  err = rows.Scan(&req_head,&req_body)
/*  // Adjust to work on stage
//  req_head = strings.Replace(req_head,"kiosk-prod","kiosk-stg", -1)
  req_body = strings.Replace(req_body,"kiosk-prod","kiosk-stg", -1)

  req_head = strings.Replace(req_head,"production","stage", -1)
  req_body = strings.Replace(req_body,"production","stage", -1)

  //fmt.Printf("head=%s\n\nbody=%s\n\n",req_head,req_body)
*/
  return req_head,req_body,err

}


func KioskGetPaymentFromOrderID(orderID string) (*Payment,error){
//  sql := `SELECT rl.start_ts,rl.request_headers,rl.cookie,rl.request_body
sql := `SELECT rl.request_body_json::json->'payment' as payment_Object
FROM mixalot.request_log rl
WHERE  rl.kiosk_id='`+storeID+`'
	AND rl.start_ts>'2020-06-14' AND rl.endpoint='/sync_transact'
	AND text(rl.request_body::json->'order_id')='"`+orderID+`"'
ORDER BY rl.start_ts DESC
LIMIT 1;`

  // fmt.Println(sql)
  //return "","",nil
  rows, err := DbR.Query(sql)
  pay := new(Payment)

  if err != nil {
    fmt.Println("in KioskLastPnPFromProd error",err)
    return pay, err
  }
  defer rows.Close()

  rows.Next()
  //var req_head string
  obj :="";
  err = rows.Scan(&obj)
  var result map[string]string

  if (err != nil){
    return pay,err

  }else{
//    iob, _ := ioutil.ReadAll(obj)
    //json.Unmarshal([]byte(obj), &pay)
//    json.NewDecoder(obj).Decode(pay)
    json.Unmarshal([]byte(obj), &result)
    pay.First_name=result["first_name"]
    pay.Last_name=result["last_name"]
    pay.Card_pan=result["card_pan"]
    pay.Card_type=result["card_type"]
    pay.Magne_print=result["magne_print"]
    pay.Magne_print_status=result["magne_print_status"]
    pay.Track2=result["track2"]
    pay.Ksn=result["ksn"]
    pay.Validate,_= strconv.ParseInt(result["validate"],10,65)

  }

  //fmt.Println("result=",result);
  //fmt.Println("PAY=",pay);
  return pay,err

}

func InitDB() {
    // Create DB connections
      fmt.Println("In IntiDB")
      var err error
      //sql.Open("mysql", "<username>:<pw>@tcp(<HOST>:<port>)/<dbname>")
      uri := fmt.Sprintf("host=%s port=%s user=%s "+
    "password=%s dbname=%s sslmode=disable",
    whost, port, user, password, db_name)
    // DB connection
      fmt.Println(fmt.Sprintf("V=%v",uri))

      // Establish connections using the uri created above
      db, err := sql.Open("postgres", uri)

      if err != nil {
          log.Println("Here in Error InitDB",err)
          db, err = sql.Open("postgres", uri)
          if err != nil {
              log.Println("Here in Error 2 in InitDB",err)

          }
          //log.Panic(err)
      }
      // Verify connection with a Ping
      if err = db.Ping(); err != nil {
        log.Println("Bad Ping Here in Error InitDB",err)
        // Retry connection
        db, err = sql.Open("postgres", uri)
        if err = db.Ping(); err != nil {
            log.Println("Bad 2 Ping Here in Error InitDB",err)
            // Log Connection Error
        }else{
          // Assign Write Connection
          log.Print("Successfuly Connected to -->"+whost+"<--\n")
          Db=db
        }
      }else{
        // Assign Write Connection
        log.Print("Successfuly Connected to -->"+whost+"<--\n")
        Db=db
      }
      //  Create uri for read only DB

      uriR := fmt.Sprintf("host=%s port=%d user=%s "+
    "password=%s dbname=%s sslmode=disable",
    rhost, port, user, password, db_name)

      fmt.Println(fmt.Sprintf("V=%v",uriR))

      // Establish connection
      dbR, err2 := sql.Open("postgres", uriR)
//      db, err := sql.Open("mysql", fmt.Sprintf("%v:%v@/%v%v",host,user,password,db_name))
      if err2 != nil {
        log.Println("Here in Error InitDB dbR",err)
      }

      if err2 = dbR.Ping(); err != nil {
        log.Println("Bad Ping Here in Error  dbR InitDB",err)

        // Re try read connection if it did not work.
        dbR, err2 = sql.Open("postgres", uriR)
        if err2 = dbR.Ping(); err != nil {
            log.Println("Bad 2 Ping Here in Error  dbR InitDB",err)
            return
        }
      }
      log.Print("Successfuly Connected to -->"+rhost+"<--\n")
      DbR=db

  }

func GetLoginCookie (req_head string,req_body string)(string){

      req, err := http.NewRequest("POST", "http://kiosk-prod.bytefoods.com/login", strings.NewReader(req_body))
      if err != nil {
      	// handle err
      }

      req.Header.Set("Content-Type", "application/x-www-form-urlencoded")
      req.Header.Set("Connection","keep-alive")
      req.Header.Set("Accept","*/*")
      req.Header.Set("Content-Type","application/json")
      req.Header.Set("Host","localhost:5000")
      req.Header.Set("Content-Length","317")
      req.Header.Set("Accept-Encoding","gzip, deflate, br")
      req.Header.Set("User-Agent","PostmanRuntime/7.24.1")

      resp, err := http.DefaultClient.Do(req)
      if err != nil {

      }
      defer resp.Body.Close()

/*      body, err3 :=  ioutil.ReadAll(resp.Body)
      if err3 != nil {
        return fmt.Sprintf("Error Reading body %v",err3)
      }
      */
      head :=  resp.Header;
      fmt.Printf("\nhead=%s\n",head,"\nheadcookie=%s ->",head["Set-Cookie"][0],"<-\n")
      c ,_ :=json.Marshal(head["Set-Cookie"][0])

      return strings.Replace(string(c),"\"","", -1)

}
func ProcessTransactions(cookie string,req_body string)(string,error){

      req, err := http.NewRequest("POST", "http://kiosk-stg.bytefoods.com/sync_transact", strings.NewReader(req_body))
//      req, err := http.NewRequest("POST", "http://kiosk-prod.bytefoods.com/sync_transact",strings.NewReader(req_body))
      if err != nil {
        return "",err
      }

      fmt.Printf("Cookie=>%s<=\n",cookie)
      /*
       {'Cookie': 'pantry-sid=eyJpYXQiOjE1OTMxNTcyNDQsImV4cCI6MTU5NDE5NzY0NCwiYWxnIjoiSFMyNTYifQ.eyJzZXJpYWwiOiIwMDAwMWIzMWFjMTMifQ.RS3PqVmMx2NfDcV0wnJeh7Riuao8O-SH4GUnsbsbwwY',
      'Connection': 'Keep-Alive',
      'Content-Type': 'application/json; charset=UTF-8', 'Host': 'kiosk-prod.bytefoods.com', 'User-Agent': 'okhttp/3.12.4',
      'Content-Length': '729'}
      {'User-Agent': 'okhttp/3.12.4', 'Connection': 'Keep-Alive', 'Content-Type': 'application/json; charset=UTF-8', 'Content-Length': '670', 'Cookie': 'pantry-sid=eyJpYXQiOjE1OTMxNTcyNDQsImV4cCI6MTU5NDE5NzY0NCwiYWxnIjoiSFMyNTYifQ.eyJzZXJpYWwiOiIwMDAwMWIzMWFjMTMifQ.RS3PqVmMx2NfDcV0wnJeh7Riuao8O-SH4GUnsbsbwwY', 'Host': 'kiosk-prod.bytefoods.com'}
      */
      req.Header.Set("Content-Type", "application/json; charset=UTF-8");
      req.Header.Set("Host", "kiosk-prod.bytefoods.com")
      req.Header.Set("Cookie", cookie)
      req.Header.Set("User-Agent", "okhttp/3.4.0")
      req.Header.Set("If-None-Match", "f15da484dc5fea60514e529de30af8800523e7ec")
      req.Header.Set("Connection", "Keep-Alive")
      req.Header.Set("Content-Length", fmt.Sprintf("%d",len(req_body)))
      fmt.Printf("Body Length=%s\n",fmt.Sprintf("%d",len(req_body)))

      resp, err2 := http.DefaultClient.Do(req)
      if err2 != nil {
        return "",err2
      }
      defer resp.Body.Close()
      body, rerr :=ioutil.ReadAll(resp.Body)
      out_body:=string(body)
      fmt.Printf("TransactionBody%s\n",out_body)
      return out_body, rerr
/*
      out_body:=req_body
      return out_body, err
*/

}
