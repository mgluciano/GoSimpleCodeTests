package models


import (
  "fmt"
  "time"
  "net/http"
  "strings"
  "io/ioutil"

)



func SendAddToOrderItemCall(cookie string,epc string,order_id string)(error){
  now := time.Now()
  secs := now.Unix()
  //fmt.Println("In Send Item Call EPOCH=",secs,cookie,epc)

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
    fmt.Println("ERROR 2B IN SendAddToOrderItemCall=",err)
    return err;
  }
  //fmt.Println("HERE 3 IN GetStgLoginCookie")
  defer resp.Body.Close()

  _, err3 :=ioutil.ReadAll(resp.Body)
  if err3 != nil {
    fmt.Println("ERROR Getting Order Item Body C IN SendAddToOrderItemCall=",err3)
    return err3
  }
  //out_body:=string(body)
  //fmt.Printf("LoginBody%s\n",out_body)


  return err3

}
func SendAddItemCall(cookie string,epc string)(error){
  now := time.Now()
  secs := now.Unix()
  //fmt.Println("In Send Item Call EPOCH=",secs,cookie,epc)

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
    fmt.Println("ERROR 2B IN SendAddItemCall=",err)
    return err;
  }
  //fmt.Println("HERE 3 IN SendAddItemCall")
  defer resp.Body.Close()

  _, err3 :=ioutil.ReadAll(resp.Body)
  if err3 != nil {
    fmt.Println("ERROR Getting Login Body C IN SendAddItemCall=",err3)
    return err3
  }
  //out_body:=string(body)
  //fmt.Printf("AddItemCallBody%s\n",out_body)


  return err3

}
