
/*
This Application Requires At Least Two Parameters
  Store ID
  loginID // Index / ID of Last Login Record
Also can take in a Third Argument
  Error Type, Possible Values:
    RFID
    Temp
    Locked
    SkipStatus

*/
package main

import (
    "fmt"
    "log"
    "flag"

    _ "github.com/lib/pq"
    "time"
    "github.com/byte/GoSimpleCodeTests/NewSimulator/models"
    //"./models"

)





func main() {

  flag.Parse()
  //
  // out:=`{"coupon":"","created":1615252196,"currency":"USD","email":"Tester4573@tester.com","order_id":"790X12Y84P10","payment":{"card_pan":"3512405837","card_type":"","first_name":"Joe954","ksn":"9011880B29A9A6003216","last_name":"Tester4573","magne_print":"FED69FA72D9E6E8E185E10801DF482E05BF946A10E121071CE5B9CA299A980D021BE1DFFCE8F3651EF6F5CBCA3A7897641E102FB3DAE4220","magne_print_status":"61403000","track2":"D3CADAA5A685929BD03E7AD96D08D115464A6E8E4062684DB54B6FE29B94C31B9B7FF3B003B7347","validate":1},"payment_system":"Express","purchased_products":null,"stamp":1,"card_type":"unknown","tablet_processing_done":0,"time":1615252206,"time_capture":1615252202,"time_closed":1615252202,"time_door_closed":1615252202,"time_door_opened":1615252199,"time_opened":1615252199,"time_preauth":1615252205}`;
  //
  // fmt.Println(strings.Replace(string(out),`"purchased_products":null,`,`"purchased_products":[],`,-1))
  //
  // return

  currentTime := time.Now()

  storeID := flag.Arg(0)
  if storeID<"1" {
    //str:=
    fmt.Println(`This Application Requires At Least One Parameter
      Store ID
    This process can also can take in a second Argument
      Error Type
    Error Type Possible Values:
        RFID
        Temp
        Locked
        SkipStatus
    `);
    //fmt.Println(str);
    return

  }
  loginID:=flag.Arg(1)
  errorType := flag.Arg(2)  // Options RFID, Temp, Locked, SkipStatus
  Time:= fmt.Sprintf("%v",currentTime.Format("20060102"))
  fmt.Printf("MM-DD-YYYY : ->%s<- \nFor kiosk ->%s<-\nError Type=>%s<=\nLoginID=>%s<=\n\n", Time,storeID,loginID,errorType)


  models.InitDB();

  fmt.Println("Login=",string(CreateLogin(storeID)));

/*
  Initiate Stage Kiosk
*/

  head,body,err := models.KioskLoginFromProd(storeID);
  if (err !=nil){
    // try again
    head,body,err = models.KioskLoginFromProd(storeID);
    if (err !=nil){
      fmt.Println("Could Not Get Production Login For store",storeID,"\nERROR=>",err)
      return
    }
  }
  cookie,err2 := models.GetStgLoginCookie(head,body)
  //fmt.Println("cookie->",cookie,"\nERROR=>",err2)
  if (err2 !=nil){
    // try again
    cookie,err2 = models.GetStgLoginCookie(head,body)
    if (err2 !=nil){
      fmt.Println("Failed to Get Cookie cookie->",cookie,"\nERROR=>",err2)
      return
    }
  }

  inv := GetCurrentInventory(storeID)

  fmt.Println("Current Inventory Length->",len(inv),"\nINV=>",inv)

  if(len(inv) < 15){
    ni:=AddItemsToInventory(cookie,storeID)
    for i:=0;i<len(ni);i++ {
      inv = append(inv,ni[i])
    }
  }
  err=SendInventoryCall(cookie,inv)

  status,err := models.KioskStatusFromProd(storeID)
  if (err !=nil){
    fmt.Printf("ERROR Can't get recent Status Try 1 for store ID %s \n\tERROR=%v\n ",storeID, err)
    status,err = models.KioskStatusFromProd(storeID)
    if (err !=nil){
      fmt.Printf("ERROR Can't get recent Status Try 2 for store ID %s \n\tERROR=%v\n ",storeID, err)
      return
    }
  }
  status=models.UpdateStatus(errorType, status)


//  END OF Initiate Stage Kiosk

  ct :=0
  for {
    ct ++

    if( (errorType=="SkipStatus") && ((ct%2)==0) ) {
      time.Sleep(10 *time.Minute)
    }

    log.Println("Infinite Loop ",ct)
    inv = GetCurrentInventory(storeID)
    if((ct %3) ==0){
      err=SendInventoryCall(cookie,inv)
    }

    err=models.SendStatusMessage(cookie,status)
    if (err !=nil){
      fmt.Printf("ERROR Sending Status for %d iteration Store ID %s\n\tERROR=%v\n ",ct,storeID,err)
      err=modelsSendStatusMessage(cookie,status)
      if (err !=nil){
        fmt.Printf("ERROR2 Sending Status for %d iteration Store ID %s\n\tERROR=%v\n",ct,storeID,err)
      }
    }

    err= SendOrder(cookie ,storeID ,inv,false)
    if (err !=nil){
      fmt.Printf("ERROR Sending Order for %d iteration Store ID %s\n\tERROR=%v\n ",ct,storeID,err)
    }



    time.Sleep(33 *time.Second)
    //fmt.Println("Current Inventory Length->",len(inv),"\nINV=>",inv)
    inv = GetCurrentInventory(storeID)

    if(len(inv) < 15){
      fmt.Println("Current Inventory Length->",len(inv))

      SendOrder(cookie ,storeID ,inv,true)
      time.Sleep(1 *time.Minute)

      ni:=AddItemsToInventory(cookie,storeID)

      fmt.Printf("\n\nAdding %d Items to Inventory->\n\n",len(ni))
      for i:=0;i<(len(ni)-1);i++ {
        inv = append(inv,ni[i])
      }
    }else{
      time.Sleep(1 *time.Minute)
    }
    fmt.Println("Done With Loop",ct)
    time.Sleep(8 *time.Minute)


  }

  return

}

/*
  RFID
  Temp
  Locked
  SkipStatus
*/
