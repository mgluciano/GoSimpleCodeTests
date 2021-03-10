


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
  fmt.Println("Starting Application")
  //  Warn if DB attributes are not established in Bash
  if(DB_W_Host ==""){
    fmt.Println(`Must Define Needed DB Attributes including:
       DB_W_Host
       DB_R_Host
       DB_User
       DB_Password
       DB_Port`)
    return
  }
  // Create DB Connection
  InitDB()

  // Get Current Time also verify DB connection
  time,err := GetDBTime();


  if (err != nil){
    fmt.Println("ERRROR ",err)
    return
  }
  fmt.Println("Time =", time)


  Xfile  := xlsx.NewFile()
  sheet, _ := Xfile.AddSheet("Results")

  // Write initial Header Row To Results sheet in the New Excel Sheet
  fmt.Println("Row1->",WriteRow([]string{"Store ID","TimeStamp","FCM","ErrorLoginFound"},sheet))

  // Grab passed file name
  flag.Parse()
  inputf := flag.Arg(0)
  fmt.Println(inputf)

  // OPEN File named inputf
  file, err := os.Open(inputf)
  if err != nil {
      log.Fatal(err)
  }
  defer file.Close()

  //read and parse through file line by line
  scanner := bufio.NewScanner(file)
  for scanner.Scan() {             // internally, it advances token based on sperator
    //Split line on Tab
    s := strings.Split(scanner.Text(),"\t");
    //fmt.Printf("->%s<-,->%s<-\n",s[0],s[1])  // token in unicode-char

     r1,r2 := GetRecentLoginsCheckDB(s[1], s[0])
     fmt.Printf("id=%s,Time=%s,DBFound=%s,Error=%s",s[0],s[1],r1,r2)
    _ = WriteRow([]string{s[0],s[1],r1,r2},sheet)


  } // End of for scanner.Scan()

  /// Save Excel file from Excel object / data set
  err = Xfile.Save(inputf+".xlsx")
  if err != nil {
    fmt.Printf(err.Error())
  }

}

/*
 writes sent Slice of strings to passed Excel sheets
 Returns bool true or false
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

/*
    GetRecentLoginsCheckDB Checks DB for number of logins since the provided time timestampParser
    Inputs:
      Time FCM request was made and DB was sent From File.
      Store ID (aka Kiosk ID)

     Returns Two Strings:
      1st string indicates "true" or "false' saying if a login happened
      2nd string shows count of the number of logins and any error messages.
*/
func GetRecentLoginsCheckDB(time string,store string) (string, string){
//
  sql := `select count(1)
FROM mixalot.request_log mrl
WHERE mrl.kiosk_id='` + store +`' AND mrl.start_ts>'`+ time +
`' AND mrl.endpoint='/status'`
//`' AND mrl.endpoint='/status'`
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
