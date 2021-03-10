package models


import (
  "fmt"
  "time"
  "net/http"
  "strings"
  "io/ioutil"

)

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
LIMIT 55;`

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
  //fmt.Println("HERE 3 IN GetStgLoginCookie")
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
