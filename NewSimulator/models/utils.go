
package models

import (
    "fmt"

    _ "github.com/lib/pq"
//    "time"
  //"/Login"
  "os"
  "log"

  "github.com/tealeg/xlsx"

  "database/sql"
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
  //storeID = os.Getenv("Store_ID")
  //  mysql database core package Variables
  StageDB *sql.DB
  DbR *sql.DB

  errorType=""
)


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
