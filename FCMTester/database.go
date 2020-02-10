package core

import (
    "fmt"
    "log"
    "database/sql"
    "os"
    _ "github.com/go-sql-driver/mysql"
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


  func InitDB() {
      var err error
      //sql.Open("mysql", "<username>:<pw>@tcp(<HOST>:<port>)/<dbname>")
      uri := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s", user, password, whost, port, db_name)

      if(Debug =="true"){
        fmt.Println(fmt.Sprintf("V=%v",uri))
      }

      db, err := sql.Open("mysql", uri)
//      db, err := sql.Open("mysql", fmt.Sprintf("%v:%v@/%v%v",host,user,password,db_name))
      if err != nil {
          if(Debug =="true"){log.Println("Here in Error InitDB",err)}
          db, err = sql.Open("mysql", uri)
          if err != nil {
              if(Debug =="true"){log.Println("Here in Error 2 in InitDB",err)}

          }
          //log.Panic(err)
      }

      if err = db.Ping(); err != nil {
        if(Debug =="true"){log.Println("Bad Ping Here in Error InitDB",err)}
        db, err = sql.Open("mysql", uri)
        if err = db.Ping(); err != nil {
            if(Debug =="true"){log.Println("Bad 2 Ping Here in Error InitDB",err)}
        }else{
          if(Debug =="true"){log.Print("Successfuly Connected to -->"+whost+"<--\n")}
          Db=db
        }
      }else{
        if(Debug =="true"){log.Print("Successfuly Connected to -->"+whost+"<--\n")}
        Db=db
      }

      uriR := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s", user, password, rhost, port, db_name)

      if(Debug =="true"){fmt.Println(fmt.Sprintf("V=%v",uriR))}

      dbR, err2 := sql.Open("mysql", uriR)
//      db, err := sql.Open("mysql", fmt.Sprintf("%v:%v@/%v%v",host,user,password,db_name))
      if err2 != nil {
        if(Debug =="true"){log.Println("Here in Error InitDB dbR",err)}
      }

      if err2 = dbR.Ping(); err != nil {
        if(Debug =="true"){log.Println("Bad Ping Here in Error  dbR InitDB",err)}
        dbR, err2 = sql.Open("mysql", uriR)
        if err2 = dbR.Ping(); err != nil {
            if(Debug =="true"){log.Println("Bad 2 Ping Here in Error  dbR InitDB",err)}
            return
        }
      }
      if(Debug =="true"){log.Print("Successfuly Connected to -->"+rhost+"<--\n")}
      DbR=db

  }
