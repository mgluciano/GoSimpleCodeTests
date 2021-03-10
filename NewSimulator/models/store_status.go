
package models


import (
  "fmt"
  "time"
  "encoding/json"
  "net/http"
  "strings"
  "io/ioutil"

)

type Status struct {
  Rfid4                      int64    `json:"rfid_4"`
  SystemUptime               int64    `json:"system_uptime"`
  Rfid2                      int64    `json:"rfid_2"`
  RetryQueueLength           int64    `json:"retry_queue_length"`
  Rfid6                      int64    `json:"rfid_6"`
  IsLocked                   bool   `json:"is_locked"`
  Rfid5                      int64    `json:"rfid_5"`
  KitTemperature             int64    `json:"kit_temperature"`
  RetryCount                 int64    `json:"retry_count"`
  Rfid1                      int64    `json:"rfid_1"`
  GcmID                      string `json:"gcm_id"`
  BatteryLevel               int64    `json:"battery_level"`
  Rfid0                      int64    `json:"rfid_0"`
  Rfid7                      int64    `json:"rfid_7"`
  Time                       int64    `json:"time"`
  Power                      int64    `json:"power"`
  AppUptime                  int64    `json:"app_uptime"`
  Rfid3                      int64    `json:"rfid_3"`
  NumTransactionsPendingSync int64    `json:"num_transactions_pending_sync"`
  KioskID                    int64    `json:"kiosk_id"`
  KioskTemperature           int64    `json:"kiosk_temperature"`
  HappyHour                  int64    `json:"happy_hour"`
  KioskTemperatureCount      int64    `json:"kiosk_temperature_count"`
  TemperatureTags            []struct {
    ReadCount int64     `json:"read_count"`
    Epc       string  `json:"epc"`
    ReadAvg   float64 `json:"read_avg"`
  } `json:"temperature_tags"`

}

func UpdateStatus(eType string, status Status)(Status){

  if (eType =="RFID"){
    status.Rfid5=0
    status.Rfid0=0
  }else if eType =="Temp"{
    for i:=0;i<len(status.TemperatureTags)-1;i++  {
      status.TemperatureTags[i].ReadAvg=20
    }

  }else if eType =="Locked" {
    status.IsLocked=true
  }
  return status

}


func SendStatusMessage(cookie string,status Status)(error){
  //fmt.Println("In SendStatusMessage Updating Time")
  now := time.Now()
  secs := now.Unix()

  // Update Time
  status.Time=secs

  req_body, _ := json.Marshal(status)


  //req_body=r.ReplaceAllString(req_body,fmt.Sprintf(`"time":%v`,secs))
  fmt.Println("REQ BODY",string(req_body))
  //strings.Replace(req_body,`"purchased_products":null,`,`"purchased_products": [],`,-1)

  req, err := http.NewRequest("POST", "http://kiosk-stg.bytetech.co/status", strings.NewReader(string(req_body)))

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
    fmt.Println("ERROR 2B IN SendStatusMessage=",err)
    return err;
  }
  //fmt.Println("HERE 3 IN GetStgLoginCookie")
  defer resp.Body.Close()

  body, err3 :=ioutil.ReadAll(resp.Body)
  if err3 != nil {
    fmt.Println("ERROR Getting SendStatusMessage Body C IN SendStatusMessage=",err3)
    return err3
  }
  out_body:=string(body)
  fmt.Printf("SendStatusMessage%s\n",out_body)


  return err3

}

func KioskStatusFromProd(storeID string) (Status,error){

//  sql := `SELECT rl.start_ts,rl.request_headers,rl.cookie,rl.request_body
  sql := `
  SELECT rl.request_headers,rl.request_body
  FROM mixalot.request_log rl
  WHERE rl.start_ts >=  NOW()- interval '30 minutes'
    AND rl.endpoint='/status' AND rl.kiosk_id = '`+storeID+"'"+`
  ORDER by rl.start_ts DESC LIMIT 1; `

  fmt.Printf("%s\n->%s<-\n",sql,storeID)
  status:=Status{}
  //return "","",nil
  rows, err := DbR.Query(sql)
  if err != nil {
    fmt.Println("in models.KioskStatusFromProd error",err)
    return status, err
  }
  defer rows.Close()

  rows.Next()
  var req_head string
  var req_body string
  err = rows.Scan(&req_head,&req_body)
  // Adjust to work on stage
  req_head = strings.Replace(req_head,"kiosk-prod","kiosk-stg", -1)
  req_body = strings.Replace(req_body,"kiosk-prod","kiosk-stg", -1)

  req_head = strings.Replace(req_head,"production","stage", -1)
  req_body = strings.Replace(req_body,"production","stage", -1)

//  fmt.Printf("\n\nbody=%s\n",req_head,req_body)

  json.Unmarshal([]byte(req_body), &status)

  //  out, _ := json.Marshal(status)
  //fmt.Println("Status Status\n->", string(out),"<-\n\n")

  return status,err

}
