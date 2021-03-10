package main

import (
    "fmt"
    "os"
    "log"
    "bufio"
    "io/ioutil"
  	"net/http"
    "flag"
    //"crypto/tls"
    "encoding/json"
    "github.com/tealeg/xlsx"
    "database/sql"
    _ "github.com/lib/pq"
    //"bytes"
    //"os/exec"
  //"time"
  //  "regexp"
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

//"Store ID","ProductsFound","Categories","HappyHour","TimeStamp"

type Category struct{
    icon string
    name string
    no_image_placeholder string
    //sub_categories  []map[string]string
    sub_categories  map[string]bool
}
type Products struct{
  list_price float64
  price float64
  calories float64
  category string
  description string
  description_long string
  description_medium string
  description_small string
  description_tiny string
  featured bool
  image_url string
  ingredients string
  last_update float64
  num_servings float64
  nutrition_facts []map[string]string
  nutrition_filters []float64
  photos map[string]interface{}
  producer map[string]string
  sku string
  sub_category string
  title string
  total_cal float64
}

type PaP_Obj struct {
  storeId string
  ProductsFound []*Products
  Categories []*Category
  HappyHour float64
  TimeStamp string
  ImageBaseURL string
  NutritionFilterOrder map[int]map[string]string
}


func main() {
  fmt.Println("Starting Application")
  //  Warn if DB attributes are not established in Bash
  if(whost ==""){
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

  time,err := GetDBTime();

  if (err != nil){
    fmt.Println("ERRROR ",err)
    return
  }
  fmt.Println("Start Time =", time)


  Xfile  := xlsx.NewFile()
  sheet, _ := Xfile.AddSheet("Results")

//  fmt.Println("Row1->",WriteRow([]string{"","","1.0","","1.1","","","1.2",""},sheet))
  fmt.Println("Row1->",WriteRow([]string{"Store ID","ProductsFound","Categories","HappyHour","TimeStamp"},sheet))

  // Grab input file name
  flag.Parse()
  inputf := flag.Arg(0)
  fmt.Println(inputf)
  file, err := os.Open(inputf)
  if err != nil {
      log.Fatal(err)
  }
  defer file.Close()

  // Parse file line by line read and process
  scanner := bufio.NewScanner(file)
  for scanner.Scan() {             // internally, it advances token based on sperator
    storeID:=scanner.Text();

    fmt.Printf("->%s<-",storeID)  // token in unicode-char

    // Send FCM request.
    pap := RunPaPStage(storeID)
    fmt.Println(pap)
    pap2 := RunPaPProd(storeID)
    fmt.Println(pap2)

    fmt.Println("Showing COMPARE\n",Compare(pap,pap2))

  } // End of for scanner.Scan()


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

////"Store ID","ProductsFound","Categories","HappyHour","TimeStamp"
/*
*/
func Compare(pap *PaP_Obj,pap2 *PaP_Obj)(string){
  var retString="";
  if(pap.storeId != pap2.storeId){
    retString += fmt.Sprintf("StorIDs Don't Match p1=%s pap2=%s\n",pap.storeId,pap2.storeId)
  }

  if(pap.HappyHour != pap2.HappyHour){
    retString += fmt.Sprintf("StorIHappyHourDs Don't Match p1=%v pap2=%v\n",pap.HappyHour,pap2.HappyHour)
  }

  if(pap.ImageBaseURL != pap2.ImageBaseURL){
    retString += fmt.Sprintf("ImageBaseURL Don't Match p1=%s pap2=%s\n",pap.ImageBaseURL,pap2.ImageBaseURL)
  }

  retString += CompareProduct(pap.ProductsFound,pap2.ProductsFound)

  //  Categories []*Category
  //`  NutritionFilterOrder map[int]map[string]string

  return retString;
}

func RunPaPStage(storeID string) (*PaP_Obj){

    req_head,req_body,err2 := KioskLoginFromProd(storeID)
    x := new(PaP_Obj)
    x.ImageBaseURL="ERROR getting Products"
    x.storeId=storeID

    //fmt.Printf("head=%s\nbody=%s\n",req_head,req_body)
    if(err2 != nil){
      fmt.Println("ERROR getting ",storeID,"Error=",err2)

      return x
    }
    cookie := GetLoginCookie (req_head,req_body)

    //fmt.Printf("ACookie=>%s<=\n",cookie)
    body, err3 := GetPnpBody(cookie)
    if err3 != nil {
      x.ImageBaseURL="ERROR getting Products"
      return x
    }

    var result map[string]interface{}
    json.Unmarshal([]byte(body), &result)

    x.HappyHour=result["happy_hour_discount"].(float64)
    x.ImageBaseURL=result["image_base_url"].(string)

    x.Categories=GetCategories(result["category_order"])
//    fmt.Printf("\nPrint CategoryObj->%v\n%v\n\n",x.Categories,x.Categories[2])
    fmt.Println("AFTER Categories")

    x.ProductsFound=GetProducts(result["products"])
    fmt.Printf("\nPrint ProductsFound->%v\n%v\n\n",x.ProductsFound,x.ProductsFound[2])
    fmt.Println("AFTER Product")

    //GetNutFilters(result["nutrition_filter_order"])
    x.NutritionFilterOrder=GetNutFilters(result["nutrition_filter_order"])
    fmt.Printf("\nPrint NutritionFilterOrder->%v\n%v\n\n",x.NutritionFilterOrder,x.NutritionFilterOrder[2])

    fmt.Println("AT THE END")


    time, rerr := GetDBTime()
    if rerr != nil {
      // return error for problem getting time.
      x.TimeStamp="error for problem getting time."
      return x
    }

    fmt.Println(time)

    return x
}

func RunPaPProd(storeID string) (*PaP_Obj){
  x := new(PaP_Obj)
  x.ImageBaseURL="ERROR getting Products"
  x.storeId=storeID

  body, err3 := KioskLastPnPFromProd(storeID)
  if err3 != nil {
    x.ImageBaseURL="ERROR getting Products"
    return x
  }

  var result map[string]interface{}
  json.Unmarshal([]byte(body), &result)

  x.HappyHour=result["happy_hour_discount"].(float64)
  x.ImageBaseURL=result["image_base_url"].(string)

  x.Categories=GetCategories(result["category_order"])
//    fmt.Printf("\nPrint CategoryObj->%v\n%v\n\n",x.Categories,x.Categories[2])
  fmt.Println("AFTER Categories")

  x.ProductsFound=GetProducts(result["products"])
  fmt.Printf("\nPrint ProductsFound->%v\n%v\n\n",x.ProductsFound,x.ProductsFound[2])
  fmt.Println("AFTER Product")

  //GetNutFilters(result["nutrition_filter_order"])
  x.NutritionFilterOrder=GetNutFilters(result["nutrition_filter_order"])
  fmt.Printf("\nPrint NutritionFilterOrder->%v\n%v\n\n",x.NutritionFilterOrder,x.NutritionFilterOrder[2])

  fmt.Println("AT THE END")


  time, rerr := GetDBTime()
  if rerr != nil {
    // return error for problem getting time.
    x.TimeStamp="error for problem getting time."
    return x
  }

  fmt.Println(time)

  return x
}

func CompareProduct(p1 []*Products,p2 []*Products)(string){
  rs:="";


  for i, p1v := range p1 { // use type assertion to loop over []interface{}
    p2v := new(Products)
    for _, v := range p2 { // use type assertion to loop over []interface{}
      if(p1v.sku==v.sku ) {
        p2v=v
        break
      }

    }

    if(p1v.sku!=p2v.sku){
      rs +=fmt.Sprintf("On Row %d Could not find p1 sku in p2--Don't Match new=%s legacy=%s\n",i,p1v.sku,p2v.sku)
      break
    }

    if(p1v.list_price!=p2v.list_price){
      rs +=fmt.Sprintf("On Row %d list_price p1 does not for sku %s match p2--Don't Match new=%g legacy=%g\n",i,p1v.sku,p1v.list_price,p2v.list_price)
    }

    if(p1v.price!=p2v.price){
      rs +=fmt.Sprintf("On Row %d for %s price p1 does not match p2--Don't Match new=%g legacy=%g\n",i,p1v.sku,p1v.price,p2v.price)
    }

    if(p1v.calories!=p2v.calories){
      rs +=fmt.Sprintf("On Row %d calories p1 does not match p2--Don't Match new=%g legacy=%g\n",i,p1v.calories,p2v.calories)
    }
    if(p1v.category!=p2v.category){
      rs +=fmt.Sprintf("On Row %d category p1 does not match p2--Don't Match new=%s legacy=%s\n",i,p1v.category,p2v.category)
    }

    if(p1v.description!=p2v.description){
      rs +=fmt.Sprintf("On Row %d list_price p1 does not match p2--Don't Match new=%s legacy=%s\n",i,p1v.description,p2v.description)
    }

    if(p1v.description_long!=p2v.description_long){
      rs +=fmt.Sprintf("On Row %d description_long p1 does not match p2--Don't Match new=%s legacy=%s\n",i,p1v.description_long,p2v.description_long)
    }

    if(p1v.description_medium!=p2v.description_medium){
      rs +=fmt.Sprintf("On Row %d description_medium p1 does not match p2--Don't Match new=%s legacy=%s\n",i,p1v.description_medium,p2v.description_medium)
    }

    if(p1v.description_small!=p2v.description_small){
      rs +=fmt.Sprintf("On Row %d description_small p1 does not match p2--Don't Match new=%s legacy=%s\n",i,p1v.description_small,p2v.description_small)
    }

    if(p1v.description_tiny!=p2v.description_tiny){
      rs +=fmt.Sprintf("On Row %d description_long p1 does not match p2--Don't Match new=%s legacy=%s\n",i,p1v.description_tiny,p2v.description_tiny)
    }

    if(p1v.featured!=p2v.featured){
      rs +=fmt.Sprintf("On Row %d featured p1 does not match p2--Don't Match new=%t legacy=%t\n",i,p1v.featured,p2v.featured)
    }

    if(p1v.image_url!=p2v.image_url){
      rs +=fmt.Sprintf("On Row %d image_url p1 does not match p2--Don't Match new=%s legacy=%s\n",i,p1v.image_url,p2v.image_url)
    }

    if(p1v.ingredients!=p2v.ingredients){
      rs +=fmt.Sprintf("On Row %d ingredients p1 does not match p2--Don't Match new=%s legacy=%s\n",i,p1v.ingredients,p2v.ingredients)
    }

    if(p1v.last_update!=p2v.last_update){
      rs +=fmt.Sprintf("On Row %d last_update p1 does not match p2--Don't Match new=%g legacy=%g\n",i,p1v.last_update,p2v.last_update)
    }

    if(p1v.num_servings!=p2v.num_servings){
      rs +=fmt.Sprintf("On Row %d num_servings p1 does not match p2--Don't Match new=%g legacy=%g\n",i,p1v.num_servings,p2v.num_servings)
    }

    if(p1v.sub_category!=p2v.sub_category){
      rs +=fmt.Sprintf("On Row %d sub_category p1 does not match p2--Don't Match new=%s legacy=%s\n",i,p1v.sub_category,p2v.sub_category)
    }

    if(p1v.title!=p2v.title){
      rs +=fmt.Sprintf("On Row %d title p1 does not match p2--Don't Match new=%s legacy=%s\n",i,p1v.title,p2v.title)
    }

    if(p1v.total_cal!=p2v.total_cal){
      rs +=fmt.Sprintf("On Row %d total_cal p1 does not match p2--Don't Match new=%g legacy=%g\n",i,p1v.total_cal,p2v.total_cal)
    }


/*
nutrition_facts []map[string]string
nutrition_filters []float64
photos map[string]interface{}
producer map[string]string


*/


  }// End of for loop
  return rs
}

func GetCategories(cat interface{})([]*Category){

    //cat :=result["category_order"]
    //var cArray map[int]*Category
    var cArray []*Category
    for _, v := range cat.([]interface{}) { // use type assertion to loop over []interface{}
      c := new(Category)
        for i2, v2 := range v.(map[string]interface{}) { // use type assertion to loop over map[string]interface{}
          if i2=="icon" {
            c.icon = fmt.Sprintf("%s",v2)
          }else if(i2=="name"){
            c.name = fmt.Sprintf("%s",v2)
          }else if(i2=="no_image_placeholder"){
            c.no_image_placeholder = fmt.Sprintf("%s",v2)
          }else if(i2=="sub_categories"){
            //c.sub_categories =[]string
            c.sub_categories = make(map[string]bool)

            for _, v3 := range v2.([]interface{}) { // use type assertion to loop over map[string]interface{}
               //c.sub_categories =append(c.sub_categories,v3)
               //fmt.Printf("\n\nHERE I=%v,%v,s=%s",i3,v3,v3)
               for _, v4 := range v3.(map[string]interface{}) {
              //   fmt.Printf("\n\nHERE I=%v,%v,i4=%s,v4=%s\n",i3,v3,i4,v4)
                 c.sub_categories[fmt.Sprintf("%s",v4)]=true;
                 //append(c.sub_categories,fmt.Sprintf("%s:%s",i4,v4))
               }//v4 for loop
            }//v3 for loop
          }// i2 if statement
        } // v2 for loop
        cArray=append(cArray,c)
        //cArray[i]=c
        //fmt.Println("c=",c)
    }//End of v for loop

    return cArray
}// End of GetCategories

func GetProducts(pros interface{})([]*Products){
    //var pArray map[int]*Products
    var pArray []*Products
    //for i, v := range pros.([]interface{}) { // use type assertion to loop over []interface{}
    for _, v := range pros.([]interface{}) { // use type assertion to loop over []interface{}
      p := new(Products)
        for i2, v2 := range v.(map[string]interface{}) { // use type assertion to loop over map[string]interface{}
          //fmt.Printf("\n%d HERE2 I=%v,V=%v,Is=%s,Vs=%s\n",i2,v2,i2,v2)

    			if i2=="list_price" {
    				p.list_price=v2.(float64)
    			} else	if i2=="price" {
    				p.price=v2.(float64)
    			} else	if i2=="calories" {
    				p.calories=v2.(float64)
    			} else	if i2=="category" {
            if(v2 ==nil){
              p.category=""
            }else{
              p.category=v2.(string)
            }
    			} else	if i2=="description" {
            if(v2 ==nil){
              p.description=""
            }else{
              p.description=v2.(string)
            }
    			} else	if i2=="description_long" {
            if(v2 ==nil){
              p.description_long=""
            }else{
              p.description_long=v2.(string)
            }
    			} else	if i2=="description_medium" {
            if(v2 ==nil){
              p.description_medium=""
            }else{
              p.description_medium=v2.(string)
            }
    			} else	if i2=="description_small" {
            if(v2 ==nil){
              p.description_small=""
            }else{
              p.description_small=v2.(string)
            }
    			} else	if i2=="description_tiny" {
            if(v2 ==nil){
              p.description_tiny=""
            }else{
              p.description_tiny=v2.(string)
            }
    			} else	if i2=="featured" {
    				p.featured=v2.(bool)
    			} else	if i2=="image_url" {
            if(v2 ==nil){
              p.image_url=""
            }else{
              p.image_url=v2.(string)
            }
    			} else	if i2=="ingredients" {
            if(v2 ==nil){
              p.ingredients=""
            }else{
              p.ingredients=v2.(string)
            }
    			} else	if i2=="last_update" {
    				p.last_update=v2.(float64)
    			} else	if i2=="num_servings" {
    				p.num_servings=v2.(float64)
    			} else if i2=="sku" {
            if(v2 ==nil){
              p.sku=""
            }else{
              p.sku=v2.(string)
            }
    			} else  if i2=="sub_category" {
            if(v2 ==nil){
                p.sub_category=""
            }else{
              p.sub_category=v2.(string)
            }
    			} else  if i2=="title" {
            if(v2 ==nil){
              p.title=""
            }else{
              p.title=v2.(string)
            }
    			} else if i2=="total_cal" {
    				p.total_cal=v2.(float64)
    			} else if(i2=="nutrition_facts"){
            for _, v3 := range v2.([]interface{}) {
              nf := make(map[string]string)
              for i4, v4 := range v3.(map[string]interface{}) { // use type assertion to loop over map[string]interface{}
                //fmt.Printf("\n\nHERE I=%T,%T,i4=%s,v4=%v\n",i4,v4,i4,v4)
                nf[fmt.Sprintf("%s",i4)]=fmt.Sprintf("%v",v4);
              }
              p.nutrition_facts=append(p.nutrition_facts,nf)
            }//v3 for loop
          }else if(i2=="nutrition_filters"){
            for _, v3 := range v2.([]interface{}) {
              p.nutrition_filters=append(p.nutrition_filters,v3.(float64))
            }
          }else if(i2=="photos"){
            //fmt.Printf("\n\nWORKING ON %s\n",i2)
            p.photos=make(map[string]interface{})
//            fetchValue(v2)
            if v2!=nil {
              for i3, v3 := range v2.(map[string]interface{}) { // use type assertion to loop over map[string]interface{}
                switch v3.(type) {
                case string:
                  p.photos[i3]=v3.(string)
                case []interface{}:
                  var image []map[string]string
                  for _, v4 := range v3.([]interface{}) { // use type assertion to loop over []interface{}
                    img :=make(map[string]string)
                    for i5, v5 := range v4.(map[string]interface {}) { // use type assertion to loop over []interface{}
                      if(v5 ==nil){
                        img[i5]=""
                      }else{
                        img[i5]=v5.(string)
                      }
                    }
                    image = append(image,img)
                  }
                  p.photos[i3]=image
                }// end of switch
              }
            }//if v2!=nil
          }else if(i2=="producer"){
//            fmt.Printf("\n\nWORKING ON %s\n",i2)
            p.producer=make(map[string]string)
            for i3, v3 := range v2.(map[string]interface{}) { // use type assertion to loop over map[string]interface{}
                //fetchValue(v)
                //fmt.Printf("HERE3 I=%T,%T,i3=%v,v3=%v\n",i3,v3,i3,v3)
                if(v3 ==nil){
                  p.producer[i3]=""
                }else{
                  p.producer[i3]=v3.(string)
                }
            }

            //fmt.Printf("DONE WORKING ON %s\n\n\n",i2)
          }else{
            fmt.Printf("\n\n\t\tMISSED DATA OBJECT %s\n\n",i2)
          }
        } // v2 for loop
        //pArray[i]=p
        pArray=append(pArray,p)
//        fmt.Println("p=",p)

    }//End of v for loop
    fmt.Printf("\n\tLoaded CT Products %d\n",len(pArray))

    return pArray
}// End of GetProducts


func GetNutFilters(gnf interface{}) (map[int]map[string]string){
  retgnf := make(map[int]map[string]string)
  for i, v := range gnf.([]interface{}) {
    g:=make(map[string]string)
    for i2, v2 := range v.(map[string]interface{}) {
      //fmt.Printf("\n HERE2 I=%T,V=%T,Iv=%v,Vv=%v\n",i2,v2,i2,v2)
      g[i2]=fmt.Sprintf("%v",v2)
    }
    //retgnf=append(retgnf,g)
    retgnf[i]=g
    //fetchValue(v)
  }
//  fmt.Printf("\nPRINTING OUT GET NUT-> %v\n\n%T",retgnf,retgnf)
    return retgnf
}// End of GetNutFilters


func GetDBTime() (string,error){
  // Get DB time
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
  // pull rows returned
  // Assign first value time var
  rows.Next()
  var time string

  err = rows.Scan(&time)
  // return time and err
  return time,err
}

func GetLoginCookie (req_head string,req_body string)(string){

      req, err := http.NewRequest("POST", "http://kiosk-stg.bytefoods.com/login", strings.NewReader(req_body))
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
//      fmt.Printf("\nhead=%s\n",head,"\nheadcookie=%s ->",head["Set-Cookie"][0],"<-\n")
      c ,_ :=json.Marshal(head["Set-Cookie"][0])
      return strings.Replace(string(c),"\"","", -1)
}
func GetPnpBody(cookie string)(string,error){


      req, err := http.NewRequest("GET", "http://kiosk-stg.bytefoods.com/products_and_promotions",nil)
      if err != nil {
        return "",err
      }
      fmt.Printf("Cookie=>%s<=\n",cookie)

      req.Header.Set("Host", "kiosk-stg.bytefoods.com")
      req.Header.Set("Cookie", cookie)
      req.Header.Set("User-Agent", "okhttp/3.4.0")
      req.Header.Set("If-None-Match", "f15da484dc5fea60514e529de30af8800523e7ec")
      req.Header.Set("Connection", "Keep-Alive")

      resp, err2 := http.DefaultClient.Do(req)
      if err2 != nil {
        return "",err2
      }
      defer resp.Body.Close()
      body, rerr :=ioutil.ReadAll(resp.Body)
      rbody:=string(body)
      return rbody, rerr

}

func KioskLoginFromProd(storeID string) (string,string,error){

//  sql := `SELECT rl.start_ts,rl.request_headers,rl.cookie,rl.request_body
  sql := `
  SELECT rl.request_headers,rl.request_body
  FROM mixalot.request_log rl
  WHERE rl.start_ts >=  NOW()- interval '7 days'
    AND rl.endpoint='/login' AND rl.kiosk_id = '`+storeID+"'"+`
  ORDER by rl.start_ts DESC LIMIT 1; `

  //fmt.Printf("%s\n->%s<-\n",sql,storeID)

  //return "","",nil
  rows, err := DbR.Query(sql)
  if err != nil {
    fmt.Println("in GetkioskFCM error",err)
    return "", "", err
  }
  defer rows.Close()

  rows.Next()
  var req_head string
  var req_body string
  err = rows.Scan(&req_head,&req_body)
  // Adjust to work on stage
  req_head = strings.Replace(req_head,"kiosk-prod","kiosk-stg", -1)
/*  req_body = strings.Replace(req_body,"kiosk-prod","kiosk-stg", -1)

  req_head = strings.Replace(req_head,"production","stage", -1)
  req_body = strings.Replace(req_body,"production","stage", -1)
*/
  //fmt.Printf("head=%s\n\nbody=%s\n\n",req_head,req_body)
  return req_head,req_body,err

}

func KioskLastPnPFromProd(storeID string) (string,error){

//  sql := `SELECT rl.start_ts,rl.request_headers,rl.cookie,rl.request_body
  sql := `
  SELECT rl.response_body
FROM mixalot.request_log rl
WHERE rl.kiosk_id='`+storeID+`' AND rl.endpoint='/products_and_promotions' AND rl.status_code=200
ORDER BY rl.start_ts DESC LIMIT 1;`
  fmt.Println(sql)
  //return "","",nil
  rows, err := DbR.Query(sql)
  if err != nil {
    fmt.Println("in KioskLastPnPFromProd error",err)
    return "", err
  }
  defer rows.Close()

  rows.Next()
  //var req_head string
  var req_body string
  err = rows.Scan(&req_body)
  // Adjust to work on stage
//  req_head = strings.Replace(req_head,"kiosk-prod","kiosk-stg", -1)
/*  req_body = strings.Replace(req_body,"kiosk-prod","kiosk-stg", -1)

  req_head = strings.Replace(req_head,"production","stage", -1)
  req_body = strings.Replace(req_body,"production","stage", -1)
*/
  //fmt.Printf("head=%s\n\nbody=%s\n\n",req_head,req_body)
  return req_body,err

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
