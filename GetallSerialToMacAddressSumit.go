


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
    "time"
    //"flag" could be used to input KIOSKS to Skip
    "strings"
    "database/sql"
    _ "github.com/lib/pq" // here
    "io/ioutil"
    "net/http"
    "encoding/json"


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


type PendingTransactions struct {
  StoreID string `json:"storeID"`
  Time string `json:timeOfLastStatus`
  PendingTrans int64 `json:ctPending`
  WarnCT int64 `json:numberOfWarnings`
}


func main() {

  InitDB();
//  var PT map[string]PendingTransactions
  GetMAC_FromDB();
  return ;
  ct:=0
  for {
    ct ++
     fmt.Println("Infinite Loop ",ct)
  //   PT=GetPendingTransactions(PT)
     time.Sleep(11 *time.Minute)
  }

}

func GetMAC_FromDB()(map[string]string){

    //log.Println("\nWorking on",id)
    sql:=`SELECT k."id",k.components::json->>'hardware',k.archived
FROM pantry.kiosk k
WHERE k.components::json->>'hardware' IS NOT NULL`
  //log.Printf("SQL2=%s\n",sql2)

  rows, err := DbR.Query(sql)
  if err != nil {
    log.Println("in GetPendingTransactions Query error",err)
    //return "", "", err
  }
  defer rows.Close()
  var serialList  map[string]string
  hardware := "";
  kid :=""
  archived:=""



  for rows.Next() {
//    pt := new(PendingTransactions)
    err := rows.Scan(&kid,&hardware,&archived)
    fmt.Println(kid,hardware,archived)
    if err != nil {
      fmt.Println("Error in Scan GetMAC_FromDB Query error",err)
      return serialList
    }
    var data {}interface[]

    fmt.Println("\n\n","HERE", kid,hardware,archived)
    json.Unmarshal([]byte(hardware), &data)
    fetchValue(data)

  }

    return serialList
}
/*
  Function to push content to SLACK
*/
func WarnOnSlack(message string){
  log.Println("Sending Slack Warn", message)
  mesg := `{"text":"`+message+`"}`
  // curl -X POST -H 'Content-type: '
  // --data '{"text":"Hello, World!"}'
  // https://hooks.slack.com/services/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

  req, err := http.NewRequest("POST", "https://hooks.slack.com/services/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",strings.NewReader(mesg))
  if err != nil {
    log.Println("ERROR Creating Request to POST to slack",err)
    return
  }

  req.Header.Set("Content-type", "application/json")

  resp, err2 := http.DefaultClient.Do(req)
  if err2 != nil {
    log.Println("ERROR in POST to slack",err)
    return
  }
  defer resp.Body.Close()
  body, _ :=ioutil.ReadAll(resp.Body)
  log.Println("Results from POST to slack",string(body))

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
//      fmt.Println(fmt.Sprintf("V=%v",uri))

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

  func fetchValue(value interface{}) {
      //fmt.Printf("IN interface \n ")


        switch value.(type) {
        case string:
            fmt.Printf("%v is an string \n ", value)
        case bool:
            fmt.Printf("%v is bool \n ", value)
        case float64:
            fmt.Printf("%v is float64 \n ", value)
        case []interface{}:
            fmt.Printf("\n%v is a slice of interface \n", value)
            for _, v := range value.([]interface{}) { // use type assertion to loop over []interface{}
                fetchValue(v)
            }
        case map[string]interface{}:
            fmt.Printf("%v is a map \n ", value)
            for _, v := range value.(map[string]interface{}) { // use type assertion to loop over map[string]interface{}
                fetchValue(v)
            }
        default:
            fmt.Printf("%v is unknown \n ", value)
        }
    }
