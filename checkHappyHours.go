


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
    "time"
    "flag"
    "github.com/machinebox/graphql"
    "context"
    "encoding/json"
    "github.com/tealeg/xlsx"
    "strings"
    "strconv"
    "database/sql"
    _ "github.com/lib/pq"
    // "io/ioutil"
  	//  "net/http"


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
)

type Item struct {
  Sku string `json:"sku"`
  CategoryId string `json:"categoryId"`
  Price float64 `json:"price"`
  DiscountedPrice float64 `json:"discountedPrice"`
  ShelfLifeDays int64 `json:"shelfLifeDays"`
  ExpiresInDays int64 `json:"expiresInDays"`
}



type CalcDiscount struct {
  //ClientId string  `json:"clientId"`
  OrderID string `json:"orderId"`
  Items  []Item  `json:"items"`
  Time string   `json:"time"`
  StoreID string `json:"storeId"`
  ClientId string `json:"clientId"`
  CouponCodes string `json:"couponCodes"`

}


func main() {

  InitDB();

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
    fmt.Println("STARTING\n\n")
    for scanner.Scan() {             // internally, it advances token based on sperator
      line:=scanner.Text();

//      fmt.Printf("->%s<-",line)  // token in unicode-char
      if ct == 0 {

      }else{
        c := ProcessLine(line)
        if(c.ClientId != ""){
          c=calculateDiscount(c)
          out, _ := json.Marshal(c)
          fmt.Println("MARSHAL3->",string(out),"\n\n")
        }else{
          fmt.Println("\nCould not find ORDER",c.OrderID)
        }
//        return

      }
      ct++
    } // End of for scanner.Scan()

    fmt.Println("TOTAL -> ",TOTAL)
}


func ProcessLine(text string)(* CalcDiscount){

  calc := new(CalcDiscount)

  //oldP := new(Payment)
  s := strings.Split(text,"\t");

  var ord  map[string]interface{}
  json.Unmarshal([]byte(s[1]), &ord)


  calc.OrderID=fmt.Sprintf("%v",ord["orderId"])

  for _, val := range ord["items"].([]interface{}) { // use type assertion to loop over []interface{}
    it := new(Item)

    //for i, v := range val.([]interface{}) { // use type assertion to loop over []interface{}
    for i, v := range val.(map[string]interface{}) {

       if(i == "sku"){
         it.Sku =fmt.Sprintf("%v",v)
       }else if i == "price" {
          it.Price,_=strconv.ParseFloat(fmt.Sprintf("%v",v),64)
       }else if i == "categoryId" {
         it.CategoryId=fmt.Sprintf("%v",v)
       }else if i == "shelfLifeDays" {
         it.ShelfLifeDays,_=strconv.ParseInt(fmt.Sprintf("%v",v),10,64)
       }else if i == "expiresInDays" {
         it.ExpiresInDays,_=strconv.ParseInt(fmt.Sprintf("%v",v),10,64)
       }else if i == "discountedPrice" {
         fmt.Println("discounted Price", it.Price,fmt.Sprintf("%v",v))
         it.DiscountedPrice,_=strconv.ParseFloat(fmt.Sprintf("%v",v),64)
       }
    } // End for item creation
    calc.Items=append(calc.Items,*it)
  }// creating Items


  calc = GetOrder(calc.OrderID ,calc)

  return calc;
}

func GetOrder(id string,cal *CalcDiscount) (* CalcDiscount){

    //log.Println("\nWorking on",id)
    cal.OrderID=id
    sql2:=`SELECT o.campus_id,to_timestamp(o.created), o.kiosk_id,k.timezone
FROM pantry."order" o , pantry.kiosk k
WHERE o.kiosk_id=k."id" AND o.order_id='`+id+`'`
  //log.Printf("SQL2=%s\n",sql2)

  rows, err2 := DbR.Query(sql2)
  if err2 != nil {
    fmt.Println("in Label Query error",err2)
    //return "", "", err
  }
  defer rows.Close()

  for rows.Next() {
    tme :=""
    tz :=""
    err := rows.Scan(&cal.ClientId,&tme,&cal.StoreID,&tz)
    if err != nil {
      fmt.Println("IN GET ORDER ERROR",err)
      fmt.Println(err)
      return nil

      //return "", "", err
    }
    //fmt.Println(tme)
    t, err := time.Parse("2006-01-02T15:04:05Z", tme)
  	if err != nil {
      fmt.Println("IN GET ORDER ERROR",err)
  		fmt.Println(err)
      return nil

  	}
  	loc, err := time.LoadLocation(tz)
  	if err != nil {
      fmt.Println("IN GET ORDER t=->",t,err)
  		fmt.Println(err)
      return nil
  	}
  	t = t.In(loc)
    cal.Time=t.Format("2006-01-02 15:04:05-07:00")



  }// end of for order IDs


//  return req_head,req_body,err
  return cal
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

func createDataObj(cal *CalcDiscount)(string){

  value :=`query {
	calculateDiscount(calculateQuery: {
      clientId: "`+cal.ClientId+`",
      storeId: "`+cal.StoreID+`",
      time: "`+cal.Time+`",
      couponCodes:[`+cal.CouponCodes+`],
        items: [
      `;

      for i, _ := range cal.Items {
          //fmt.Println("I=",i,"  v=",v)
          value += `{
            sku: "`+cal.Items[i].Sku+`",
            categoryId: "`+cal.Items[i].CategoryId+`",
            price: `+fmt.Sprintf("%f",cal.Items[i].Price)+`,
            shelfLifeDays: `+fmt.Sprintf("%d",cal.Items[i].ShelfLifeDays)+`,
            expiresInDays: `+fmt.Sprintf("%d",cal.Items[i].ExpiresInDays)+`,
          },
        `
      }
      value += `]
     }){
    	items{
        sku
        categoryId
        price
        shelfLifeDays
        expiresInDays
        discountedPrice
        discounts{
          id
          name
          coupon{
            prefix
            count
            maxUses
            codes{
                code
            }
          }
        }
      }
  	}
}`
  // fmt.Println(value)
  // value = strings.Replace(value,"\n","\\n", -1)
  // value = strings.Replace(value,`"`,`\"`, -1)
  //value = `{"query":"`+value+`\n"}`

  value = strings.Replace(value,`  `,` `, -1)
  value = strings.Replace(value,"\t",` `, -1)
  value = strings.Replace(value,"\n"," ", -1)
//  value = `{"query":"`+value+`" }`

  return value

}

func calculateDiscount (cal *CalcDiscount)(*CalcDiscount){

    data := createDataObj(cal)
//    fmt.Printf("data=>%s<=\n",data)

    client := graphql.NewClient("https://api.prd.bytetech.co/")
    req := graphql.NewRequest(data)

    req.Header.Set("Content-Type", "application/json")
    req.Header.Set("Authorization", "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiIxMjMiLCJjbGllbnRJZCI6IjEiLCJhYmlsaXRpZXMiOlt7ImFjdGlvbiI6Im1hbmFnZSIsInN1YmplY3QiOiJhbGwifV19.tPO_psERJiWu3ZV5YiegoH7rRkx-3HeCJCyERWDmlWg")

    ctx := context.Background()

  // run it and capture the response
    var respData interface{}
    if err := client.Run(ctx, req, &respData); err != nil {
      log.Fatal(err)
    }
    //fmt.Println(respData)
    for _, val := range respData.(map[string]interface {}) { // use type assertion to loop over []interface{}
        for _,v := range (val.(map[string]interface{})["items"]).([]interface{}) {
//          fmt.Printf("T2 i=%v\t v=%v\n",i,v.(map[string]interface{})["discounts"] )
          if len((v.(map[string]interface{})["discounts"]).([]interface {}) )!=0 {
            fmt.Printf("DISCOUNT FOUND V!=[]\t v=%v\n",v.(map[string]interface{})["discounts"] )
            fmt.Printf("Item= price=%v,discountedPrice=%v,sku=%s\n",v.(map[string]interface{})["price"] ,v.(map[string]interface{})["discountedPrice"] ,v.(map[string]interface{})["sku"] )
          }
          for i, _ := range cal.Items {
            fmt.Printf("I=%v,%v->",i,v.(map[string]interface{})["sku"])
            if cal.Items[i].Sku == fmt.Sprintf("%v",v.(map[string]interface{})["sku"]){
                fmt.Printf("HERE->%s",fmt.Sprintf("%v",v.(map[string]interface{})["sku"]))
                dp,_:=strconv.ParseFloat(fmt.Sprintf("%v",v.(map[string]interface{})["discountedPrice"]),64)
                if (cal.Items[i].DiscountedPrice != dp ){
                  fmt.Printf("NO MATCH %f has a Dprice->%f\n",cal.Items[i].DiscountedPrice,dp)
                  fmt.Println(v)
                  cal.Items[i].DiscountedPrice = dp
                }else{
                  fmt.Println(" has MATCH a Dprice->%f",cal.Items[i].DiscountedPrice)
                }
            }
          }

        }
    }
    return cal

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
          fmt.Printf("\nslice=>%v is a slice of interface \n", value)
          for i, v := range value.([]interface{}) { // use type assertion to loop over []interface{}
              fmt.Println("i=",i)
              fetchValue(v)
          }
      case map[string]interface{}:
          fmt.Printf("map=>%v is a map \n ", value)
          for i, v := range value.(map[string]interface{}) { // use type assertion to loop over map[string]interface{}
            fmt.Println("i=",i)
              fetchValue(v)
          }
      default:
          fmt.Printf("%v is unknown \n ", value)
      }
  }
