


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
    //"bufio"
    "io/ioutil"
  	 "net/http"
    "flag"
    // "crypto/tls"
    "encoding/json"
    "github.com/tealeg/xlsx"
    "strings"
    //"strconv"
    "database/sql"
    _ "github.com/lib/pq"
    "time"
    "regexp"

//    "net/http/cookiejar"

)

const  (
  NumCol = 3
)
var (
  TOTAL = 0.0;
)

// Defaults
var (
  // mysql Local DB Settings
  stageWhost = os.Getenv("Stage_DB_W_Host")
  stageUser = os.Getenv("Stage_DB_User")
  stagePassword  = os.Getenv("Stage_DB_Password")

  //stageRhost = os.Getenv("Stage_DB_R_Host")
  rhost = os.Getenv("DB_R_Host")
  user = os.Getenv("DB_User")
  password  = os.Getenv("DB_Password")
  db_name  = os.Getenv("DB_Name")
  port = os.Getenv("DB_Port")

  //  mysql database core package Variables
  StageDB *sql.DB
  DbR *sql.DB

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

type Products struct {
    Epc string `json:"epc"`
    Price float64 `json"price"`
    ProductID string `json"product_id"`
    ProductName string `json"product_id"`
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

  //Purchased_products string    `json:"purchased_products"`

  Stamp int64   `json:"stamp"`
  //Card_type string  `json:"card_type"`
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

  flag.Parse()
  //
  // out:=`{"coupon":"","created":1615252196,"currency":"USD","email":"Tester4573@tester.com","order_id":"790X12Y84P10","payment":{"card_pan":"3512405837","card_type":"","first_name":"Joe954","ksn":"9011880B29A9A6003216","last_name":"Tester4573","magne_print":"FED69FA72D9E6E8E185E10801DF482E05BF946A10E121071CE5B9CA299A980D021BE1DFFCE8F3651EF6F5CBCA3A7897641E102FB3DAE4220","magne_print_status":"61403000","track2":"D3CADAA5A685929BD03E7AD96D08D115464A6E8E4062684DB54B6FE29B94C31B9B7FF3B003B7347","validate":1},"payment_system":"Express","purchased_products":null,"stamp":1,"card_type":"unknown","tablet_processing_done":0,"time":1615252206,"time_capture":1615252202,"time_closed":1615252202,"time_door_closed":1615252202,"time_door_opened":1615252199,"time_opened":1615252199,"time_preauth":1615252205}`;
  //
  // fmt.Println(strings.Replace(string(out),`"purchased_products":null,`,`"purchased_products":[],`,-1))
  //
  // return


  currentTime := time.Now()
  fmt.Println("Current Time in String: ", currentTime.String())
  fmt.Println("MM-DD-YYYY : ", currentTime.Format("01-02-2006"))
  storeID := flag.Arg(0)
  Time:= fmt.Sprintf("%v",currentTime.Format("20060102"))
  fmt.Printf("MM-DD-YYYY : ->%s<- For kiosk ->%s<-", Time,storeID)


  InitDB();


/*
  Initiate Stage Kiosk
*/

  head,body,err := KioskLoginFromProd(storeID);
  if (err !=nil){
    // try again
    head,body,err = KioskLoginFromProd(storeID);
    if (err !=nil){
      fmt.Println("Could Not Get Production Login For store",storeID,"\nERROR=>",err)
      return
    }
  }
  cookie,err2 := GetStgLoginCookie(head,body)
  //fmt.Println("cookie->",cookie,"\nERROR=>",err2)
  if (err2 !=nil){
    // try again
    cookie,err2 = GetStgLoginCookie(head,body)
    if (err2 !=nil){
      fmt.Println("Failed to Get Cookie cookie->",cookie,"\nERROR=>",err2)
      return
    }
  }

  inv := GetCurrentInventory(storeID)

  //fmt.Println("Current Inventory Length->",len(inv),"\nINV=>",inv)

  if(len(inv) < 15){
    ni:=AddItemsToInventory(cookie,storeID)
    for i:=0;i<len(ni);i++ {
      inv = append(inv,ni[i])
    }
  }
  err=SendInventoryCall(cookie,inv)

  _,sbody,err := KioskStatusFromProd(storeID)
  if (err !=nil){
    fmt.Printf("ERROR Can't get recent Status Try 1 for store ID %s \n\tERROR=%v\n ",storeID, err)
    _,sbody,err = KioskStatusFromProd(storeID)
    if (err !=nil){
      fmt.Printf("ERROR Can't get recent Status Try 2 for store ID %s \n\tERROR=%v\n ",storeID, err)
      return
    }
  }
//  END OF Initiate Stage Kiosk
  ct :=0
  for {
    ct ++

    log.Println("Infinite Loop ",ct)
    inv = GetCurrentInventory(storeID)
    if((ct %3) ==0){
      err=SendInventoryCall(cookie,inv)
    }

    err=SendStatusMessage(cookie,sbody)
    if (err !=nil){
      fmt.Printf("ERROR Sending Status for %d iteration Store ID %s\n\tERROR=%v\n ",ct,storeID,err)
      err=SendStatusMessage(cookie,sbody)
      if (err !=nil){
        fmt.Printf("ERROR2 Sending Status for %d iteration Store ID %s\n\tERROR=%v\n",ct,storeID,err)
      }
    }

    err= SendOrder(cookie ,storeID ,inv,false)
    if (err !=nil){
      fmt.Printf("ERROR Sending Order for %d iteration Store ID %s\n\tERROR=%v\n ",ct,storeID,err)
    }



    time.Sleep(33 *time.Second)
    //fmt.Println("Current Inventory Length->",len(inv),"\nINV=>",inv)
    inv = GetCurrentInventory(storeID)

    if(len(inv) < 15){
      //fmt.Println("Current Inventory Length->",len(inv)
      SendOrder(cookie ,storeID ,inv,true)
      time.Sleep(1 *time.Minute)
      ni:=AddItemsToInventory(cookie,storeID)
      for i:=0;i<len(ni);i++ {
        inv = append(inv,ni[i])
      }
      time.Sleep(8 *time.Minute)
    }else{
      time.Sleep(9 *time.Minute)
    }



  }

  return

}
func SendOrder(cookie string,storeID string,inv []Products,restock bool)(error){

  //fmt.Println("In SendOrder Function")
  sql := `  SELECT (EXTRACT(EPOCH FROM NOW())::bigint) as epoch,
    CONCAT((((floor(1 + random() * 3))+2)::text),((floor(100 + random() * 899))::text),((floor(100000 + random() * 899999))::text)) as "card_pan"
    ,CONCAT('Joe',((floor(100 + random() * 899))::text)) as first_name
    ,CONCAT('Tester',((floor(1000 + random() * 4899))::text))as last_name
    ,CONCAT('9011880B29A9A600',((floor(1000 + random() * 4899))::text)) as ksn
    ,CONCAT('FED69FA72D9E6E8E185E10801DF482E05BF946A10E121071CE5B9CA299A980D021BE1DFFCE8F3651EF6F5CBCA3A7897641E102FB3DAE',((floor(1000 + random() * 8999))::text)) as magne_print
    ,'61403000' as magne_print_status
    ,CONCAT('D3CADAA5A685929BD03E7AD96D08D115464A6E8E4062684DB54B6FE29B94C31B9B7FF3B003B',((floor(1000 + random() * 8999))::text)) as track2
    ,1 as validate
    ,(floor(1 + random() * 4)) as num_items
    ,(floor(0 + random() * 15)) as item1
    ,(floor(0 + random() * 15)) as item2
    ,(floor(0 + random() * 15)) as item3
    ,(floor(0 + random() * 15)) as item4
    `

    rows, err := StageDB.Query(sql)
    if err != nil {
      fmt.Println("in CreateTestOrder error",err)
      return err
    }


    defer rows.Close()

    p := new(Payment)
    sync :=new(SyncTrasact)

    var create,num,a,b,c,d int64

    rows.Next()
    err = rows.Scan(&create,&p.Card_pan,&p.First_name,&p.Last_name,&p.Ksn,&p.Magne_print,&p.Magne_print_status,&p.Track2,&p.Validate,&num,&a,&b,&c,&d)
    p.Card_type="unknown"
    if (err != nil){
      fmt.Println("ERROR IN Inventory Scan->",err)
    }
    p.Track2="CA420C6C23BE60AB2FFD6EB5AD13E75F4F47525E403D8734D1D05D242A0C22E30888276ED2DF4D70"
    p.Magne_print="EF31DD9395FECCF81D523161376A9D02749921BA7E74B6F7ADB8AEC276EB05392D1309620DC4EF00F2091C900F9B94205DBAB81A751E7597"
    p.Ksn="9011880B4D28B100027A";
    //pp:=new(P_products)
    //sync.Purchased_products= append(sync.Purchased_products,*pp)

    fmt.Printf("ALL Vals->num=%d,a=%d,b=%d,c=%d,d=%d,create=%d\n",num,a,b,c,d,create)
    sync.Payment=*p
    sync.Email =fmt.Sprintf("%s@tester.com",p.Last_name)
    if restock {
      sync.Order_id = fmt.Sprintf("RE%sX%d%dY%d%dP%d",storeID,num,a,b,c,d)
      num = num+d+c;
    }else{
      sync.Order_id = fmt.Sprintf("%sX%d%dY%d%dP%d",storeID,num,a,b,c,d)
    }

    sync.Created=create-10



    sync.Time=create;
    sync.Time_capture=create-4
    sync.Time_closed=create-4
    sync.Time_door_closed=create-4
    sync.Time_door_opened=create-7
    sync.Time_opened=create-7
    sync.Time_preauth=create-1
    sync.Stamp=1
    sync.Payment_system="Express"
    sync.Currency="USD"
    sync.Coupon=""

    out, _ := json.Marshal(sync)
    //fmt.Println("\nMARSHAL3->",string(out))
    //fmt.Println(strings.Replace(string(out),"\"purchased_products\":null, ","\"purchased_products\":[],",-1))
    _,err =ProcessTransactions(cookie,strings.Replace(string(out),`"purchased_products":null,`,`"purchased_products": [],`,-1))

    sync.Payment.Validate=0
    sync.Stamp=10

    tpp:="[\n"
    var i int64
    time.Sleep(30 *time.Second)

    for i=0;i < num;i++{
      pp:=new(P_products)
      x:=i
      if (i>0){
        tpp=fmt.Sprintf("%s,\n",tpp)
      }
      if(i==0){
        x=a
      }else if(i==1){
        x=b
      }else  if(i==2){
        x=c
      }else if(i==3){
        x=d
      }
      if( int64(len(inv))>(x+16) ){
        x=x+15
      }
      //fmt.Printf("WTF x=%d,x=%v,epc=%s,Price=%s,len=%d\n",x,x,inv[x].Epc,inv[x].Price,len(inv))
      pp.Epc=inv[x].Epc
      pp.Price=inv[x].Price
      sync.Purchased_products= append(sync.Purchased_products,*pp)
      err=SendAddToOrderItemCall(cookie,pp.Epc,sync.Order_id)
      if(err !=nil){
        err=SendAddToOrderItemCall(cookie,pp.Epc,sync.Order_id)
      }
    }

    fmt.Printf("%s Has Purchased_products  %v\n",sync.Order_id,sync.Purchased_products)

    out, _ = json.Marshal(sync)
    //fmt.Println("\nMARSHAL3->",string(out))


    _,err =ProcessTransactions(cookie,string(out))

    return err
}

func SendStatusMessage(cookie string,req_body string)(error){
  fmt.Println("In SendStatusMessage Updating Time")
  now := time.Now()
  secs := now.Unix()
  fmt.Println("In SendStatusMessage Call EPOCH=",secs,cookie)
  //  "time":1615310598
  r, _ := regexp.Compile(`"time":\d+`)

  req_body=r.ReplaceAllString(req_body,fmt.Sprintf(`"time":%v`,secs))
  fmt.Println(req_body)
  //strings.Replace(req_body,`"purchased_products":null,`,`"purchased_products": [],`,-1)

  req, err := http.NewRequest("POST", "http://kiosk-stg.bytetech.co/status", strings.NewReader(req_body))

  req.Header.Set("Cookie", cookie)

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
    fmt.Println("ERROR 2B IN GetStgLoginCookie=",err)
    return err;
  }
  fmt.Println("HERE 3 IN GetStgLoginCookie")
  defer resp.Body.Close()

  body, err3 :=ioutil.ReadAll(resp.Body)
  if err3 != nil {
    fmt.Println("ERROR Getting Login Body C IN GetStgLoginCookie=",err3)
    return err3
  }
  out_body:=string(body)
  fmt.Printf("LoginBody%s\n",out_body)


  return err3

}

func GetCurrentInventory(storeID string)([]Products){
  fmt.Println("In GetCurrentInventoryRestock Function")
  sql := `SELECT l.epc,l.price,l.product_id,p.title
  FROM pantry.label l, pantry.product p
  WHERE p."id"=l.product_id AND l.status='ok'
    AND l.kiosk_id=`+storeID+`;`

  var Inventory []Products
  //fmt.Println("In HERE")

  rows, err := StageDB.Query(sql)
  if err != nil {
    fmt.Println("in GetCurrentInventory SQL error",err)
    return Inventory
  }
  defer rows.Close()

  p:=new(Products)

  for rows.Next() {
//    pt := new(PendingTransactions)
    err := rows.Scan(&p.Epc,&p.Price,&p.ProductID,&p.ProductName)
    if (err != nil){
      fmt.Println("ERROR IN Inventory Scan->",err)
    }else{
        // if no error add item to inventory
        //fmt.Println("Recording Current INventory",p.Epc,p.Price,p.ProductID,p.ProductName,err)
        Inventory=append(Inventory,*p)
    }

  }
  fmt.Println("Current Inventory Length->",len(Inventory))
  return Inventory
}

func AddItemsToInventory(cookie string,storeID string)([]Products){
  fmt.Println("In AddItemsToInventory Function")
  sql := `SELECT CONCAT(LPAD(p."id"::text,8,'0'),'01',((EXTRACT(EPOCH FROM NOW())::bigint)::text),((floor(1000 + random() * 8999))::text)) as epc,p.price,p.id,p.title
FROM pantry.kiosk k, pantry.product p
WHERE k.campus_id=p.campus_id AND p.archived!=1
AND k.id=`+storeID+`
LIMIT 25;`

  var Inventory []Products

  rows, err := StageDB.Query(sql)
  if err != nil {
    fmt.Println("in AddItemsToInventory error",err)
    return Inventory
  }
  defer rows.Close()

  p:=new(Products)

  for rows.Next() {
//    pt := new(PendingTransactions)
    err := rows.Scan(&p.Epc,&p.Price,&p.ProductID,&p.ProductName)
    if (err != nil){
      fmt.Println("ERROR IN Inventory Scan->",err)
    }else{
      err =SendAddItemCall(cookie, p.Epc)
      if(err == nil){  // if no error add item to inventory
        fmt.Println("Adding Item To INventory",p.Epc,p.Price,p.ProductID,p.ProductName,err)
        Inventory=append(Inventory,*p)
      }
    }

  }

  return Inventory

}
func SendAddToOrderItemCall(cookie string,epc string,order_id string)(error){
  now := time.Now()
  secs := now.Unix()
  fmt.Println("In Send Item Call EPOCH=",secs,cookie,epc)

  req_body:= fmt.Sprintf(`{"retry_count":0,"time":%v,"epc":"%s","reading_cycle":101732,"order_id":"%s","reason":"add_to_order","direction":"out"} `,secs,epc,order_id)

  fmt.Println("In Send Item Call req body=",req_body)


  req, err := http.NewRequest("POST", "http://kiosk-stg.bytetech.co/item", strings.NewReader(req_body))

  req.Header.Set("Cookie", cookie)

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
    fmt.Println("ERROR 2B IN GetStgLoginCookie=",err)
    return err;
  }
  fmt.Println("HERE 3 IN GetStgLoginCookie")
  defer resp.Body.Close()

  body, err3 :=ioutil.ReadAll(resp.Body)
  if err3 != nil {
    fmt.Println("ERROR Getting Login Body C IN GetStgLoginCookie=",err3)
    return err3
  }
  out_body:=string(body)
  fmt.Printf("LoginBody%s\n",out_body)


  return err3

}
func SendAddItemCall(cookie string,epc string)(error){
  now := time.Now()
  secs := now.Unix()
  fmt.Println("In Send Item Call EPOCH=",secs,cookie,epc)

  req_body:= fmt.Sprintf(`{"retry_count":0,"time":%v,"epc":"%s","reading_cycle":101732,"reason":"new_item","direction":"in"} `,secs,epc)

  fmt.Println("In Send Item Call req body=",req_body)


  req, err := http.NewRequest("POST", "http://kiosk-stg.bytetech.co/item", strings.NewReader(req_body))

  req.Header.Set("Cookie", cookie)

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
    fmt.Println("ERROR 2B IN GetStgLoginCookie=",err)
    return err;
  }
  fmt.Println("HERE 3 IN GetStgLoginCookie")
  defer resp.Body.Close()

  body, err3 :=ioutil.ReadAll(resp.Body)
  if err3 != nil {
    fmt.Println("ERROR Getting Login Body C IN GetStgLoginCookie=",err3)
    return err3
  }
  out_body:=string(body)
  fmt.Printf("LoginBody%s\n",out_body)


  return err3

}

func SendInventoryCall (cookie string,cInv []Products)(error){
  now := time.Now()
  secs := now.Unix()
  req_body:= "{\n\t\"epc\": [\n"
  for i:=0;i<len(cInv);i++ {
    //fmt.Println("adding EPC",cInv[i].Epc)
    if(i<1){
      req_body= fmt.Sprintf("%s\n\t\t\"%s\"",req_body,cInv[i].Epc)
    }else{
      req_body= fmt.Sprintf("%s,\n\t\t\"%s\"",req_body,cInv[i].Epc)
    }

  }
  req_body= fmt.Sprintf("%s\n],\n\t\"time\":%v,\n\t\"retry_count\": 0\n}" ,req_body,secs)
  //fmt.Println("\n\nIn Send inventory Call EPOCH=",req_body,secs,)

//  return nil

  fmt.Println("In Send Item Call req body=",req_body)


  req, err := http.NewRequest("POST", "http://kiosk-stg.bytetech.co/inventory", strings.NewReader(req_body))

  req.Header.Set("Cookie", cookie)

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
    fmt.Println("ERROR 2B IN GetStgLoginCookie=",err)
    return err;
  }
  fmt.Println("HERE 3 IN GetStgLoginCookie")
  defer resp.Body.Close()

  body, err3 :=ioutil.ReadAll(resp.Body)
  if err3 != nil {
    fmt.Println("ERROR Getting Login Body C IN GetStgLoginCookie=",err3)
    return err3
  }
  out_body:=string(body)
  fmt.Printf("LoginBody%s\n",out_body)


  return err3

}


func KioskStatusFromProd(storeID string) (string,string,error){

//  sql := `SELECT rl.start_ts,rl.request_headers,rl.cookie,rl.request_body
  sql := `
  SELECT rl.request_headers,rl.request_body
  FROM mixalot.request_log rl
  WHERE rl.start_ts >=  NOW()- interval '30 minutes'
    AND rl.endpoint='/status' AND rl.kiosk_id = '`+storeID+"'"+`
  ORDER by rl.start_ts DESC LIMIT 1; `

  fmt.Printf("%s\n->%s<-\n",sql,storeID)

  //return "","",nil
  rows, err := DbR.Query(sql)
  if err != nil {
    fmt.Println("in KioskStatusFromProd error",err)
    return "", "", err
  }
  defer rows.Close()

  rows.Next()
  var req_head string
  var req_body string
  err = rows.Scan(&req_head,&req_body)
  // Adjust to work on stage
  req_head = strings.Replace(req_head,"kiosk-prod","kiosk-stg", -1)
  req_body = strings.Replace(req_body,"kiosk-prod","kiosk-stg", -1)

  req_head = strings.Replace(req_head,"production","stage", -1)
  req_body = strings.Replace(req_body,"production","stage", -1)

  //fmt.Printf("head=%s\n\nbody=%s\n\n",req_head,req_body)

  return req_head,req_body,err

}



func KioskLoginFromProd(storeID string) (string,string,error){

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
  // Adjust to work on stage
  req_head = strings.Replace(req_head,"kiosk-prod","kiosk-stg", -1)
  req_body = strings.Replace(req_body,"kiosk-prod","kiosk-stg", -1)

  req_head = strings.Replace(req_head,"production","stage", -1)
  req_body = strings.Replace(req_body,"production","stage", -1)

  //fmt.Printf("head=%s\n\nbody=%s\n\n",req_head,req_body)

  return req_head,req_body,err

}


// func KioskGetPaymentFromOrderID(orderID string,storeID string) (*Payment,error){
// //  sql := `SELECT rl.start_ts,rl.request_headers,rl.cookie,rl.request_body
// sql := `SELECT rl.request_body_json::json->'payment' as payment_Object
// FROM mixalot.request_log rl
// WHERE  rl.kiosk_id='`+storeID+`'
// 	AND rl.start_ts>'2020-06-14' AND rl.endpoint='/sync_transact'
// 	AND text(rl.request_body::json->'order_id')='"`+orderID+`"'
// ORDER BY rl.start_ts DESC
// LIMIT 1;`
//
//   // fmt.Println(sql)
//   //return "","",nil
//   rows, err := DbR.Query(sql)
//   pay := new(Payment)
//
//   if err != nil {
//     fmt.Println("in KioskLastPnPFromProd error",err)
//     return pay, err
//   }
//   defer rows.Close()
//
//   rows.Next()
//   //var req_head string
//   obj :="";
//   err = rows.Scan(&obj)
//   var result map[string]string
//
//   if (err != nil){
//     return pay,err
//
//   }else{
// //    iob, _ := ioutil.ReadAll(obj)
//     //json.Unmarshal([]byte(obj), &pay)
// //    json.NewDecoder(obj).Decode(pay)
//     json.Unmarshal([]byte(obj), &result)
//     pay.First_name=result["first_name"]
//     pay.Last_name=result["last_name"]
//     pay.Card_pan=result["card_pan"]
//     pay.Card_type=result["card_type"]
//     pay.Magne_print=result["magne_print"]
//     pay.Magne_print_status=result["magne_print_status"]
//     pay.Track2=result["track2"]
//     pay.Ksn=result["ksn"]
//     pay.Validate,_= strconv.ParseInt(result["validate"],10,65)
//
//   }
//
//   //fmt.Println("result=",result);
//   //fmt.Println("PAY=",pay);
//   return pay,err
//
// }

func InitDB() {
    // Create DB connections
      fmt.Println("In IntiDB")
      var err error

      //  Create uri for read only DB

      uriR := fmt.Sprintf("host=%s port=%s user=%s "+
    "password=%s dbname=%s sslmode=disable",
    rhost, port, user, password, db_name)

      fmt.Println(fmt.Sprintf("V=%v",uriR))

      // Establish connection
      db, err2 := sql.Open("postgres", uriR)
//      db, err := sql.Open("mysql", fmt.Sprintf("%v:%v@/%v%v",host,user,password,db_name))
      if err2 != nil {
        log.Println("Here in Error InitDB dbR",err)
      }

      if err2 = db.Ping(); err != nil {
        log.Println("Bad Ping Here in Error  dbR InitDB",err)

        // Re try read connection if it did not work.
        db, err2 = sql.Open("postgres", uriR)
        if err2 = db.Ping(); err != nil {
            log.Println("Bad 2 Ping Here in Error  dbR InitDB",err)
            return
        }
      }
      log.Print("Successfuly Connected to -->"+rhost+"<--\n")
      DbR=db

      //  Create uri for Write only DB

      //sql.Open("mysql", "<username>:<pw>@tcp(<HOST>:<port>)/<dbname>")
      uri := fmt.Sprintf("host=%s port=%s user=%s "+
    "password=%s dbname=%s sslmode=disable",
    stageWhost, port, stageUser, stagePassword, db_name)

    // DB connection
      fmt.Println(fmt.Sprintf("V=%v",uri))

      // Establish connections using the uri created above
      dbs, err2 := sql.Open("postgres", uri)

      if err2 != nil {
          log.Println("Here in Error InitDB",err)
          dbs, err = sql.Open("postgres", uri)
          if err != nil {
              log.Println("Here in Error 2 in InitDB",err)

          }
          //log.Panic(err)
      }
      // Verify connection with a Ping
      if err = dbs.Ping(); err != nil {
        log.Println("Bad Ping Here in Error InitDB",err)
        // Retry connection
        dbs, err = sql.Open("postgres", uri)
        if err = dbs.Ping(); err != nil {
            log.Println("Bad 2 Ping Here in Error InitDB",err)
            // Log Connection Error
        }else{
          // Assign Write Connection
          log.Print("Successfuly Connected to -->"+stageWhost+"<--\n")
          StageDB=dbs
        }
      }else{
        // Assign Write Connection
        log.Print("Successfuly Connected to -->"+stageWhost+"<--\n")
        StageDB=dbs
      }


  }

func GetStgLoginCookie (req_head string,req_body string)(string,error){
      fmt.Println("HERE IN GetStgLoginCookie")
      //req, err := http.NewRequest("POST", "http://kiosk-stg.bytefoods.com/login", strings.NewReader(req_body))
      req, err := http.NewRequest("POST", "http://kiosk-stg.bytetech.co/login", strings.NewReader(req_body))

      if err != nil {
      	fmt.Println("ERROR A IN GetStgLoginCookie=",err)
      }
      fmt.Println("HERE 2 IN GetStgLoginCookie")
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
        fmt.Println("ERROR 2B IN GetStgLoginCookie=",err)
        return "",err;
      }
      fmt.Println("HERE 3 IN GetStgLoginCookie")
      defer resp.Body.Close()

      body, err3 :=ioutil.ReadAll(resp.Body)
      if err3 != nil {
        fmt.Println("ERROR Getting Login Body C IN GetStgLoginCookie=",err3)
        return "",err3
      }
      out_body:=string(body)
      fmt.Printf("LoginBody%s\n",out_body)


      head :=  resp.Header;
      //fmt.Println("HERE 4a IN GetStgLoginCookie")

      fmt.Printf("\nhead=%v<-\nheadcookie= ->%v<-\n",head,"")
      //fmt.Println("HERE 4 IN GetStgLoginCookie")
      c ,err :=json.Marshal(head["Set-Cookie"][0])
      //fmt.Println("HERE 5 IN GetStgLoginCookie")
      return strings.Replace(string(c),"\"","", -1),err

}
func ProcessTransactions(cookie string,req_body string)(string,error){
  fmt.Println("Body=>",req_body)
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
