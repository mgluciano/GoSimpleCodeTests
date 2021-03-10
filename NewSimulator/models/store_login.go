
package models

import (
    "fmt"
    "io/ioutil"
  	 "net/http"

    "encoding/json"
    "strings"

    _ "github.com/lib/pq"
//    "time"
    //"/Login"

)

type Login struct {
	GcmID         string        `json:"gcm_id"`
	AppVcode      int           `json:"app_vcode"`
	Time          int           `json:"time"`
	AppVname      string        `json:"app_vname"`
	Login         string        `json:"login"`
	TimeMs        int64         `json:"time_ms"`
	Components    Components    `json:"components"`
	Configuration Configuration `json:"configuration"`
	Serial        string        `json:"serial"`
	Password      string        `json:"password"`
}
type Software struct {
	CommonName      string `json:"common_name"`
	TabletlibGitSha string `json:"tabletlib_git_sha,omitempty"`
	Environment     string `json:"environment,omitempty"`
	BuildType       string `json:"build_type,omitempty"`
	Variant         string `json:"variant,omitempty"`
	Version         string `json:"version"`
	GitSha          string `json:"git_sha,omitempty"`
	BuildID         string `json:"build_id,omitempty"`
}
type Hardware struct {
	CommonName   string `json:"common_name"`
	Version      string `json:"version"`
	SerialNumber string `json:"serial_number,omitempty"`
}
type Components struct {
	Software []Software `json:"software"`
	Hardware []Hardware `json:"hardware"`
}
type Configuration struct {
	Rfidband                              string `json:"rfidBand"`
	Maxchargeamount                       string `json:"maxChargeAmount"`
	Kiosklockeddownmessage                string `json:"kioskLockedDownMessage"`
	Gcmid                                 string `json:"gcmId"`
	Temperatureoffset                     string `json:"temperatureOffset"`
	Defaultcurrency                       string `json:"defaultCurrency"`
	Defaultpreauthamount                  string `json:"defaultPreauthAmount"`
	Kioskislockeddown                     string `json:"kioskIsLockedDown"`
	Minscansrequired                      string `json:"minScansRequired"`
	Kioskserverurl                        string `json:"kioskServerUrl"`
	Epayhosts                             string `json:"ePayHosts"`
	Simcardmode                           string `json:"simCardMode"`
	Disableofflinepayments                string `json:"disableOfflinePayments"`
	Validreadingreadingcyclescount        string `json:"validReadingReadingCyclesCount"`
	ID                                    string `json:"id"`
	Rssithresholdwhenadditemonlyinrestock string `json:"rssiThresholdWhenAddItemOnlyInRestock"`
	Rssithreshold                         string `json:"rssiThreshold"`
	Volume                                string `json:"volume"`
	Features                              string `json:"features"`
	Epayterminalid                        string `json:"ePayTerminalId"`
	Offlinemodeduration                   string `json:"offlineModeDuration"`
	Happyhourdiscount                     string `json:"happyHourDiscount"`
	Campusid                              string `json:"campusId"`
}


func CreateLogin(storeID string)(Login,error){

  var login Login
  var err error
  //login.Components:=new(Components)

  login.Components,err =getComponents(storeID)
  if(err!=nil){
    login.Components,err =getComponents(storeID)
    if(err!=nil){
      return login, err
    }
  }

  return login,nil
}

func getComponents(sID string)(Components,error){

  var comp Components


  sql := `
  SELECT type, "full" FROM pantry.kiosk_components_history ch
  WHERE ch."time" =(SELECT time FROM pantry.kiosk_components_history
  WHERE id=(SELECT MAX(id) FROM pantry.kiosk_components_history kch
  WHERE kch.kiosk_id=`+sID+`)) AND ch.kiosk_id=`+sID+`;
  `
  var soft []Software
	var hard []Hardware


  rows, err := DbR.Query(sql)
  if err != nil {
    fmt.Println("In getComponents SQL error",err)
    return comp,err
  }
  defer rows.Close()

  var tp,fl string
  for rows.Next() {

    err = rows.Scan(&tp,&fl)
    if (err != nil){
      fmt.Println("ERROR IN getComponents Scan->",err)
    }else{
      if(tp=="software"){
        sft:=new(Software)
        json.Unmarshal([]byte(fl), &sft)
        soft=append(soft,*sft)
      }else if(tp=="hardware"){
        hrd:=new(Hardware)
        json.Unmarshal([]byte(fl), &hrd)
        hard=append(hard,*hrd)
      }
    }
  }

  if err != nil {
    fmt.Println("In getComponents SQL error 2nd",err)
    return comp,err
  }

  comp.Software=soft;
  comp.Hardware=hard;

  return comp, nil


}


func KioskLoginFromProd(storeID string) (string,string,error){

//  sql := `SELECT rl.start_ts,rl.request_headers,rl.cookie,rl.request_body
  sql := `
  SELECT rl.request_headers,rl.request_body
  FROM mixalot.request_log rl
  WHERE rl.start_ts >=  NOW()- interval '6 days'
    AND rl.endpoint='/login' AND rl.kiosk_id = '`+storeID+"'"+`
  ORDER by rl.start_ts DESC LIMIT 1; `

  fmt.Printf("%s\n->%s<-\n",sql,storeID)

  //return "","",nil
  rows, err := DbR.Query(sql)
  if err != nil {
    fmt.Println("in KioskLoginFromProd error",err)
    return "", "", err
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

  //fmt.Printf("head=%s\n\nbody=%s\n\n",req_head,req_body)

  return req_head,req_body,err

}

func GetStgLoginCookie (req_head string,req_body string)(string,error){
      fmt.Println("HERE IN GetStgLoginCookie")
      //req, err := http.NewRequest("POST", "http://kiosk-stg.bytefoods.com/login", strings.NewReader(req_body))
      req, err := http.NewRequest("POST", "http://kiosk-stg.bytetech.co/login", strings.NewReader(req_body))

      if err != nil {
      	fmt.Println("ERROR A IN GetStgLoginCookie=",err)
      }
      fmt.Println("HERE 2 IN GetStgLoginCookie")
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
        return "",err;
      }
      //fmt.Println("HERE 3 IN GetStgLoginCookie")
      defer resp.Body.Close()

      body, err3 :=ioutil.ReadAll(resp.Body)
      if err3 != nil {
        fmt.Println("ERROR Getting Login Body C IN GetStgLoginCookie=",err3)
        return "",err3
      }
      out_body:=string(body)
      fmt.Printf("LoginBody%s\n",out_body)


      head :=  resp.Header;
      //fmt.Println("HERE 4a IN GetStgLoginCookie")

      fmt.Printf("\nhead=%v<-\nheadcookie= ->%v<-\n",head,"")
      //fmt.Println("HERE 4 IN GetStgLoginCookie")
      c ,err :=json.Marshal(head["Set-Cookie"][0])
      //fmt.Println("HERE 5 IN GetStgLoginCookie")
      return strings.Replace(string(c),"\"","", -1),err

}
