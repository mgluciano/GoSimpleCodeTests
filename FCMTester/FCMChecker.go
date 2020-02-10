


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
    "crypto/tls"
    "encoding/json"
    "github.com/tealeg/xlsx"
    "database/sql"
    _ "github.com/lib/pq"
    "bytes"
    "regexp"
    "strings"
//    "errors"
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
  )

const  (
  NumCol = 3
)



func main() {
  fmt.Println("HERE")
  InitDB()

  time,err := GetDBTime();
  fmt.Println("HERE2")

  if (err != nil){
    fmt.Println("ERRROR ",err)
    return
  }
  fmt.Println("Time =", time)


  Xfile  := xlsx.NewFile()
  sheet, _ := Xfile.AddSheet("Results")

//  fmt.Println("Row1->",WriteRow([]string{"","","1.0","","1.1","","","1.2",""},sheet))
  fmt.Println("Row1->",WriteRow([]string{"Store ID","TimeStamp","FCM","ErrorLoginFound"},sheet))

  flag.Parse()
  inputf := flag.Arg(0)
  fmt.Println(inputf)
    file, err := os.Open(inputf)
    if err != nil {
        log.Fatal(err)
    }
    defer file.Close()

    scanner := bufio.NewScanner(file)
    for scanner.Scan() {             // internally, it advances token based on sperator
      s := strings.Split(scanner.Text(),"\t");
      fmt.Printf("->%s<-,->%s<-\n",s[0],s[1])  // token in unicode-char
      //success,time,error := RunFCM(storeID)

       r1,r2 := GetRecentLoginsCheckDB(s[1], s[0])
       fmt.Printf("id=%s,Time=%s,DBFound=%s,Error=%s",s[0],s[1],r1,r2)
      _ = WriteRow([]string{s[0],s[1],r1,r2},sheet)


    } // End of for scanner.Scan()


    err = Xfile.Save(inputf+".xlsx")
    if err != nil {
      fmt.Printf(err.Error())
    }

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


func RunFCM(storeID string) (string,string,string){

    tr := &http.Transport{
        TLSClientConfig: &tls.Config{InsecureSkipVerify: true},
    }

    serialID,fcmID,err2 := GetkioskFCM(storeID)
    if(err2 != nil){
      fmt.Println("ERROR getting ",storeID,"Error=",err2)
      return storeID,"",fmt.Sprintf("ERROR getting FCM ",err2)
;
    }


    client := &http.Client{Transport: tr}
    header :=`key=AAAATKW7t-w:APA91bF_vibuFDT-3tquKuANxZfAFTIUBxSC_RGHUgqopcRgHryUXiKcv_BmmukTLo_tYUd7ZhodBJ1sLO4UjiV77wjoXf0k7qGbqNrmghiJS_LrHTgEXJHlVB-ni2Pp22nXeWF7FUFE`
    var Jsonbody = []byte(`{
      "registration_ids": ["`+fcmID+`"],
      "data": {
          "serial": "`+serialID+`",
          "message": "send_status"
      }
    }`)

    aurl1 := "https://fcm.googleapis.com/fcm/send"
    fmt.Println(aurl1,string(Jsonbody))  // token in unicode-char

    req, err01 := http.NewRequest("POST", aurl1, bytes.NewBuffer(Jsonbody))
//        req, err01 := http.NewRequest("POST", aurl1, body)

    if err01 != nil {
      fmt.Println("ERROR",err01)  // token in unicode-char
      return storeID,"",fmt.Sprintf("ERROR getting FCM ",err01)

    }

    req.Header.Add("Authorization", header)
    req.Header.Add("Content-Type", "application/json")


    res,err1 := client.Do(req)
  //      fmt.Println("BERROR2",err1)  // token in unicode-char
    if err1 != nil {
      fmt.Println("ERROR2",err1)  // token in unicode-char
    }

    defer res.Body.Close()

    body, err3 :=  ioutil.ReadAll(res.Body)
    if err3 != nil {
      fmt.Println("ERROR3",err3)  // token in unicode-char
      return storeID,"",fmt.Sprintf("ERROR getting FCM ",err3)

    }
    var ret string
    json.Unmarshal(body,&ret)
    fmt.Printf("RES=\nret=%s\nres=%s\nbody=%s\n",ret,res,string(body))

    expected := regexp.MustCompile(`^\{"multicast_id"\:\d+,"success"\:1,"failure":0,"canonical_ids"\:0,"results"\:\[\{"message_id"\:"[^"]+"\}\]\}$`)
    if !expected.MatchString(string(body)) {
      return storeID,"","FCM Did Not Succeed "
    }

    time, rerr := GetDBTime()
    if rerr != nil {
      return ret, time, fmt.Sprintf("ErrorGettingTime=%v",rerr)

    }
    return "Success", time, "No Error"

}

func GetDBTime() (string,error){


  sql := `SELECT NOW()`
  rows, err := DbR.Query(sql)
  if err != nil {
      log.Print("in Get Time error")
      return "", err
  }
  defer rows.Close()
  if err != nil {
    fmt.Printf("ERROR in GetDBTime SELECT %v\n",err)
    return "",err
  }

  rows.Next()
  var time string
  err = rows.Scan(&time)

  return time,err
}

func GetkioskFCM(storeID string) (string,string,error){


  sql := `select pk.serial,pk.gcm_id
    FROM pantry.kiosk pk where pk."id" =`+storeID
  rows, err := DbR.Query(sql)
  if err != nil {
    fmt.Println("in GetkioskFCM error",err)
    return "", "", err
  }
  defer rows.Close()

  rows.Next()
  var serialID string
  var fcmID string
  err = rows.Scan(&serialID,&fcmID)

  return serialID,fcmID,err
}

func GetRecentLoginsCheckDB(time string,store string) (string, string){

  sql := `select count(1)
FROM mixalot.request_log mrl
WHERE mrl.kiosk_id='` + store +`' AND mrl.start_ts>'`+ time +
`' AND mrl.endpoint='/status'`
//`' AND mrl.endpoint='/login'`//
    rows, err := DbR.Query(sql)
    if err != nil {
        return "false", fmt.Sprintf("%v",err)
        log.Print("in GetRecentLoginsCheckDB error")
    }
    defer rows.Close()
    rows.Next()
    var val string
    err = rows.Scan(&val)

    if (val !="0"){
      return "true", fmt.Sprintf("val=%v,err=%v",val,err)
    }
    return "false",fmt.Sprintf("val=%v,err=%v",val,err)
}


  func InitDB() {
      fmt.Println("In IntiDB")
      var err error
      //sql.Open("mysql", "<username>:<pw>@tcp(<HOST>:<port>)/<dbname>")
      uri := fmt.Sprintf("host=%s port=%s user=%s "+
    "password=%s dbname=%s sslmode=disable",
    whost, port, user, password, db_name)

      fmt.Println(fmt.Sprintf("V=%v",uri))


      db, err := sql.Open("postgres", uri)
//      db, err := sql.Open("mysql", fmt.Sprintf("%v:%v@/%v%v",host,user,password,db_name))
      if err != nil {
          log.Println("Here in Error InitDB",err)
          db, err = sql.Open("postgres", uri)
          if err != nil {
              log.Println("Here in Error 2 in InitDB",err)

          }
          //log.Panic(err)
      }

      if err = db.Ping(); err != nil {
        log.Println("Bad Ping Here in Error InitDB",err)
        db, err = sql.Open("postgres", uri)
        if err = db.Ping(); err != nil {
            log.Println("Bad 2 Ping Here in Error InitDB",err)
        }else{
          log.Print("Successfuly Connected to -->"+whost+"<--\n")
          Db=db
        }
      }else{
        log.Print("Successfuly Connected to -->"+whost+"<--\n")
        Db=db
      }
      uriR := fmt.Sprintf("host=%s port=%d user=%s "+
    "password=%s dbname=%s sslmode=disable",
    rhost, port, user, password, db_name)

      fmt.Println(fmt.Sprintf("V=%v",uriR))

      dbR, err2 := sql.Open("postgres", uriR)
//      db, err := sql.Open("mysql", fmt.Sprintf("%v:%v@/%v%v",host,user,password,db_name))
      if err2 != nil {
        log.Println("Here in Error InitDB dbR",err)
      }

      if err2 = dbR.Ping(); err != nil {
        log.Println("Bad Ping Here in Error  dbR InitDB",err)
        dbR, err2 = sql.Open("postgres", uriR)
        if err2 = dbR.Ping(); err != nil {
            log.Println("Bad 2 Ping Here in Error  dbR InitDB",err)
            return
        }
      }
      log.Print("Successfuly Connected to -->"+rhost+"<--\n")
      DbR=db

  }
