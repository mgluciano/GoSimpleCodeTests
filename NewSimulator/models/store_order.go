
package models


import (
  "fmt"
  "time"
  "encoding/json"
  "net/http"
  "strings"
  "io/ioutil"

)


type Payment struct {
    Card_pan string `json:"card_pan"`
    Card_type string `json:"card_type"`
    First_name string `json:"first_name"`
    Ksn string `json:"ksn"`
    Last_name string `json:"last_name"`
    Magne_print string `json:"magne_print"`
    Magne_print_status string `json:"magne_print_status"`
    Track2 string `json:"track2"`
    Validate int64 `json:"validate"`
}

type Products struct {
    Epc string `json:"epc"`
    Price float64 `json"price"`
    ProductID string `json"product_id"`
    ProductName string `json"product_id"`
}
type P_products struct {
    Epc string `json:"epc"`
    Price float64 `json"price"`
}


type SyncTrasact struct {
  //ClientId string  `json:"clientId"`
  Coupon string  `json:"coupon"`
  //  Value float64  `json:"value"`
  Created int64  `json:"created"`
  Currency string  `json:"currency"`
  Email string  `json:"email"`
  Order_id string   `json:"order_id"`

  Payment Payment   `json:"payment"`

  Payment_system string   `json:"payment_system"`
  Purchased_products []P_products   `json:"purchased_products"`

  //Purchased_products string    `json:"purchased_products"`

  Stamp int64   `json:"stamp"`
  //Card_type string  `json:"card_type"`
  Tablet_processing_done int64   `json:"tablet_processing_done"`
  Time int64   `json:"time"`
  Time_capture int64   `json:"time_capture"`
  Time_closed int64   `json:"time_closed"`
  Time_door_closed int64   `json:"time_door_closed"`
  Time_door_opened int64   `json:"time_door_opened"`
  Time_opened int64   `json:"time_opened"`
  Time_preauth int64   `json:"time_preauth"`

}


func ProcessOrders(cookie string,req_body string)(string,error){
  fmt.Println("Body=>",req_body)
      req, err := http.NewRequest("POST", "http://kiosk-stg.bytefoods.com/sync_transact", strings.NewReader(req_body))
//      req, err := http.NewRequest("POST", "http://kiosk-prod.bytefoods.com/sync_transact",strings.NewReader(req_body))
      if err != nil {
        return "",err
      }

      //fmt.Printf("Cookie=>%s<=\n",cookie)
      /*
       {'Cookie': 'pantry-sid=eyJpYXQiOjE1OTMxNTcyNDQsImV4cCI6MTU5NDE5NzY0NCwiYWxnIjoiSFMyNTYifQ.eyJzZXJpYWwiOiIwMDAwMWIzMWFjMTMifQ.RS3PqVmMx2NfDcV0wnJeh7Riuao8O-SH4GUnsbsbwwY',
      'Connection': 'Keep-Alive',
      'Content-Type': 'application/json; charset=UTF-8', 'Host': 'kiosk-prod.bytefoods.com', 'User-Agent': 'okhttp/3.12.4',
      'Content-Length': '729'}
      {'User-Agent': 'okhttp/3.12.4', 'Connection': 'Keep-Alive', 'Content-Type': 'application/json; charset=UTF-8', 'Content-Length': '670', 'Cookie': 'pantry-sid=eyJpYXQiOjE1OTMxNTcyNDQsImV4cCI6MTU5NDE5NzY0NCwiYWxnIjoiSFMyNTYifQ.eyJzZXJpYWwiOiIwMDAwMWIzMWFjMTMifQ.RS3PqVmMx2NfDcV0wnJeh7Riuao8O-SH4GUnsbsbwwY', 'Host': 'kiosk-prod.bytefoods.com'}
      */
      req.Header.Set("Content-Type", "application/json; charset=UTF-8");
      req.Header.Set("Host", "kiosk-prod.bytefoods.com")
      req.Header.Set("Cookie", cookie)
      req.Header.Set("User-Agent", "okhttp/3.4.0")
      req.Header.Set("If-None-Match", "f15da484dc5fea60514e529de30af8800523e7ec")
      req.Header.Set("Connection", "Keep-Alive")
      req.Header.Set("Content-Length", fmt.Sprintf("%d",len(req_body)))
      //fmt.Printf("Body Length=%s\n",fmt.Sprintf("%d",len(req_body)))

      resp, err2 := http.DefaultClient.Do(req)
      if err2 != nil {
        return "",err2
      }
      defer resp.Body.Close()
      body, rerr :=ioutil.ReadAll(resp.Body)
      out_body:=string(body)
      fmt.Printf("TransactionBody%s\n",out_body)
      return out_body, rerr
/*
      out_body:=req_body
      return out_body, err
*/

}

func SendOrder(cookie string,storeID string,inv []Products,restock bool)(error){

  //fmt.Println("In SendOrder Function")
  sql := `  SELECT (EXTRACT(EPOCH FROM NOW())::bigint) as epoch,
    CONCAT((((floor(1 + random() * 3))+2)::text),((floor(100 + random() * 899))::text),((floor(100000 + random() * 899999))::text)) as "card_pan"
    ,CONCAT('Joe',((floor(100 + random() * 899))::text)) as first_name
    ,CONCAT('Tester',((floor(1000 + random() * 4899))::text))as last_name
    ,CONCAT('9011880B29A9A600',((floor(1000 + random() * 4899))::text)) as ksn
    ,CONCAT('FED69FA72D9E6E8E185E10801DF482E05BF946A10E121071CE5B9CA299A980D021BE1DFFCE8F3651EF6F5CBCA3A7897641E102FB3DAE',((floor(1000 + random() * 8999))::text)) as magne_print
    ,'61403000' as magne_print_status
    ,CONCAT('D3CADAA5A685929BD03E7AD96D08D115464A6E8E4062684DB54B6FE29B94C31B9B7FF3B003B',((floor(1000 + random() * 8999))::text)) as track2
    ,1 as validate
    ,(floor(1 + random() * 4)) as num_items
    ,(floor(0 + random() * 15)) as item1
    ,(floor(0 + random() * 15)) as item2
    ,(floor(0 + random() * 15)) as item3
    ,(floor(0 + random() * 15)) as item4
    `

    rows, err := StageDB.Query(sql)
    if err != nil {
      fmt.Println("in CreateTestOrder error",err)
      return err
    }


    defer rows.Close()

    p := new(Payment)
    sync :=new(SyncTrasact)

    var create,num,a,b,c,d int64

    rows.Next()
    err = rows.Scan(&create,&p.Card_pan,&p.First_name,&p.Last_name,&p.Ksn,&p.Magne_print,&p.Magne_print_status,&p.Track2,&p.Validate,&num,&a,&b,&c,&d)
    p.Card_type="unknown"
    if (err != nil){
      fmt.Println("ERROR IN Inventory Scan->",err)
    }
    p.Track2="CA420C6C23BE60AB2FFD6EB5AD13E75F4F47525E403D8734D1D05D242A0C22E30888276ED2DF4D70"
    p.Magne_print="EF31DD9395FECCF81D523161376A9D02749921BA7E74B6F7ADB8AEC276EB05392D1309620DC4EF00F2091C900F9B94205DBAB81A751E7597"
    p.Ksn="9011880B4D28B100027A";
    //pp:=new(P_products)
    //sync.Purchased_products= append(sync.Purchased_products,*pp)

    fmt.Printf("ALL Vals->num=%d,a=%d,b=%d,c=%d,d=%d,create=%d\n",num,a,b,c,d,create)
    sync.Payment=*p
    sync.Email =fmt.Sprintf("%s@tester.com",p.Last_name)
    if restock {
      sync.Order_id = fmt.Sprintf("RE%sX%d%dY%d%dP%d",storeID,num,a,b,c,d)
      num = num+d+c;
    }else{
      sync.Order_id = fmt.Sprintf("%sX%d%dY%d%dP%d",storeID,num,a,b,c,d)
    }

    sync.Created=create-10



    sync.Time=create;
    sync.Time_capture=create-4
    sync.Time_closed=create-4
    sync.Time_door_closed=create-4
    sync.Time_door_opened=create-7
    sync.Time_opened=create-7
    sync.Time_preauth=create-1
    sync.Stamp=1
    sync.Payment_system="Express"
    sync.Currency="USD"
    sync.Coupon=""

    out, _ := json.Marshal(sync)
    //fmt.Println("\nMARSHAL3->",string(out))
    //fmt.Println(strings.Replace(string(out),"\"purchased_products\":null, ","\"purchased_products\":[],",-1))
    _,err = ProcessOrders(cookie,strings.Replace(string(out),`"purchased_products":null,`,`"purchased_products": [],`,-1))

    sync.Payment.Validate=0
    sync.Stamp=10

    tpp:="[\n"
    var i int64
    time.Sleep(30 *time.Second)

    for i=0;i < num;i++{
      pp:=new(P_products)
      x:=i
      if (i>0){
        tpp=fmt.Sprintf("%s,\n",tpp)
      }
      if(i==0){
        x=a
      }else if(i==1){
        x=b
      }else  if(i==2){
        x=c
      }else if(i==3){
        x=d
      }
      if( int64(len(inv))>(x+16) ){
        x=x+15
      }
      //fmt.Printf("WTF x=%d,x=%v,epc=%s,Price=%s,len=%d\n",x,x,inv[x].Epc,inv[x].Price,len(inv))
      pp.Epc=inv[x].Epc
      pp.Price=inv[x].Price
      sync.Purchased_products= append(sync.Purchased_products,*pp)
      err=SendAddToOrderItemCall(cookie,pp.Epc,sync.Order_id)
      if(err !=nil){
        err=SendAddToOrderItemCall(cookie,pp.Epc,sync.Order_id)
      }
    }

    fmt.Printf("%s Has Purchased_products  %v\n",sync.Order_id,sync.Purchased_products)

    out, _ = json.Marshal(sync)
    //fmt.Println("\nMARSHAL3->",string(out))


    _,err = ProcessOrders(cookie,string(out))

    return err
}
