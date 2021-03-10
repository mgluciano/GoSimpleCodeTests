package main

import (
    "fmt"
    "os"
    "log"
    "bufio"
    "strings"
    "strconv"
    "flag"
    "encoding/json"
  //  "database/sql"

)
/*
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
*/
type ActiveDays struct {
  StartTime string  `json:"startTime"`
  EndTime string  `json:"endTime"`
  DayOfWeek int64 `json:"dayOfWeek"`
}

type HappyHour struct {
  Message string  `json:"message"`
  ActiveDays []ActiveDays  `json:"activeDays"`

}

type Discount struct {
  //ClientId string  `json:"clientId"`
  ClientId int64  `json:"clientId"`
  //  Value float64  `json:"value"`
  Value int64  `json:"value"`
  Name string  `json:"name"`
  ValueType string  `json:"valueType"`
  HappyHour string   `json:"happyHour"`
  //StoreIds []string `json:"storeIds"`
  StoreIds []int64 `json:"storeIds"`
  //StoreIds string `json:"storeIds"`

}//{Set: make(map[string]map[string]string)}


/*

  mutation createHappyHour {
    addDiscount(
      discount: {
        clientId:1234,
        value: 15,
        name: "Cool Discount3"
        valueType: percent,
        happyHour:{
          message: "a new message",
          activeDays: [
            {
            startTime: "11:20",
            endTime:"12:20",
            dayOfWeek:1
            },
            {
            startTime: "11:20",
            endTime:"12:20",
            dayOfWeek:2
            },
            {
            startTime: "11:20",
            endTime:"12:20",
            dayOfWeek:3
            },
            {
            startTime: "11:20",
            endTime:"12:25",
            dayOfWeek:5
            },
          ]
        }
      }
    ){
      id
    }
  }
*/




func main() {
  flag.Parse()
  HHFile := flag.Arg(0)
  name1 := flag.Arg(1)
  fmt.Println("->",HHFile,"<- Results in")
  fmt.Println("->",name1,"<- Results in")

  ct,darray :=CreateHappyHourMutations(name1,HHFile)


  out,_ := json.Marshal(darray)
  myText :=string(out)


//  fmt.Printf("Done with file for %s\n Read %d number of lines\n",myText,ct)


  /*
    ct,erp :=CreateDB_Struct(name2,sqlFile2)
    fmt.Printf("Done with file for %s Read $d number of lines\n",name2,ct)

  */

  fmt.Println("Done with file Read\n",ct," number of lines")
  WriteToFile(name1,myText)
  fmt.Println("Done Writing to file Read\n")


}

func WriteToFile(fName string,fContent string)(error){
  f, err := os.Create(fName)
  if (err != nil){
    fmt.Println("ERROR Opening to File",fName)
    return err
  }
  defer f.Close()
  n3, err := f.WriteString(fContent)

  if (err != nil){
    fmt.Println("ERROR Writing to File",fName)
    return err
  }
  fmt.Printf("wrote %d bytes\n", n3)
  f.Sync()
  f.Close()
  return nil
}


func CreateHappyHourMutations(name string,hhfile string) (int,[]*Discount){
  //./discount := new(DiscountArray)

  var DArray []*Discount
  fmt.Println(DArray)
  //  fmt.Println(discount)

  file, err := os.Open(hhfile)
  if err != nil {
      log.Fatal(err)
  }
  fmt.Println(name)
  defer file.Close()

  scanner := bufio.NewScanner(file)
  ct:=0
  for scanner.Scan() {             // internally, it advances token based on sperator
    fmt.Println(scanner.Text())  // token in unicode-char
    line :=scanner.Text()
    s := strings.Split(line,"\t");
    ct++

    if (ct==1 || 8 >len(s) ) {
      fmt.Println("On Row",ct,"Length < 9",len(s))
      continue
    }

    //   hh.message = `""`;
    //var storeIds []string
    var storeIds []int64
    sids := strings.Split(s[0],",")
    for _,sid := range sids{
    //  storeIds = append(storeIds,sid)
      sdid,_ := strconv.ParseInt(sid,10,64)
      storeIds = append(storeIds,sdid)
    }

    dayOfWeek := strings.Split(s[2],",")
    eDayOfWeek := strings.Split(s[5],",")

    fmt.Println(s[2])
    var adA  []ActiveDays;
    for i,v :=range dayOfWeek{
      wd,_ := strconv.ParseInt(v,10,64)
      ed,_ := strconv.ParseInt(eDayOfWeek[i],10,64)

      st,et,twoD := FourDigitTime(s[3],s[6])
      //et := FourDigitTime(s[6])
      fmt.Printf("st=%s from %s\tet = %s from %s\n",st,s[3],et,s[6])
      if ((wd != ed) || twoD){
        ad := ActiveDays{StartTime:st,EndTime:"23:59",DayOfWeek:wd}
        adA=append(adA,ad)
        if (et !="00:00" || wd!=ed){
          ad = ActiveDays{StartTime:"00:00",EndTime:et,DayOfWeek:ed}
          adA=append(adA,ad)
        }


      }else{
        ad := ActiveDays{StartTime:st,EndTime:et,DayOfWeek:wd}
        adA=append(adA,ad)
      }


    }
    aDA ,_ :=json.Marshal(adA)

    fmt.Println(string(aDA),aDA)
    dis := new(Discount)



    hh := &HappyHour{
      Message: `Happy Hour - All items on `+s[1]+`% off`,
      ActiveDays: adA}
  // fmt.Println("ActiveDays:",hh.ActiveDays)
    hout, _:=json.Marshal(hh)
    fmt.Println("JSON-HH:",string(hout),"\n")

    dis.HappyHour=string(hout)

    val,_ :=strconv.ParseInt(s[1],10,32)
    dis.Value= val


    //dis.ClientId=s[8]
    clid,_ :=strconv.ParseInt(s[8],10,64)
    dis.ClientId=clid;

    dis.ValueType="percent"
    dis.Name = "LegacyHhDiscount-"+s[9]
    //  fmt.Println("PARSED",dis)

    // dis.StoreIds=s[0]
    dis.StoreIds=storeIds

    out,_ :=json.Marshal(dis)
    fmt.Println("JSON:",string(out),"\n\n")

    DArray = append(DArray,dis)

    ct++;
  }

    return ct, DArray
}






//      st,et,twoD := FourDigitTime(s[3],s[6])
func FourDigitTime (st string, et string) (string, string, bool){
  fmt.Println(st)

  rbool := false
  sTime,sInt := SplitTime(st)
  eTime,eInt := SplitTime(et)


  if eInt < sInt {
    rbool=true
  }
  return sTime,eTime, rbool


}

func SplitTime (iTime string) (string,int64){
  splt := strings.Split(iTime,":")
  hour := splt[0]
  min := splt[1]

  hour =strings.Replace(hour, " ", "", -1)
  min =strings.Replace(min, " ", "", -1)


  if (len(hour)<2){
    hour="0"+hour;
  }

  if (len(min)<1){
    min="00";
  }
  if (len(min)<2){
    min="0"+min;
  }



  timeint,_ := strconv.ParseInt(hour,10,64)


  rTime:=hour+":"+min
  fmt.Println(rTime)
  return rTime, timeint
}



/*
func LoadData(outfile string)(error){
  InitDB()
  SQL := `
    SELECT pc.kiosks as storeIds,
        trim(both '"' from text(pc.payload::json->'discount'))as value,
          IF(split_part(time,' ',6) != '*', split_part(time,' ',6),'0,1,2,3,4,5,6') as startDayOfWeek,
          CONCAT(IF(split_part(time,' ',3) != '*',CONCAT(split_part(time,' ',3), ':'),'00:'),
          split_part(time,' ',2) ) as startTime,
          pc.payload::json->'endTime' as endTimeRaw,
          IF(trim(both '"' from split_part((trim(both '"' from text(pc.payload::json->'endTime'))),' ',6)) != '*',
          split_part((trim(both '"' from text(pc.payload::json->'endTime'))),' ',6),'0,1,2,3,4,5,6') as endDayOfWeek,
          CONCAT(IF(split_part((trim(both '"' from text(pc.payload::json->'endTime'))),' ',3) != '*',
          CONCAT(split_part((trim(both '"' from text(pc.payload::json->'endTime'))),' ',3), ':'),'00:'),
          CONCAT(split_part((trim(both '"' from text(pc.payload::json->'endTime'))),' ',2) )) as endTime,
          text(pc.payload::json->'onetime') as "oneTime?",pk.campus_id,pc."id"
    FROM pantry.cron pc LEFT JOIN pantry.kiosk pk on TEXT(pk."id")=split_part(pc.kiosks,',',1)
    WHERE pc.command ='happy' AND pc.archived=0 AND pc.active=1
  `;


  rows, err := DbR.Query(SQL)







}



func InitDB() {
  fmt.Println("In IntiDB")
  var err error
  //sql.Open("mysql", "<username>:<pw>@tcp(<HOST>:<port>)/<dbname>")
  uri := fmt.Sprintf("host=%s port=%s user=%s "+ "password=%s dbname=%s sslmode=disable",
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

*/
