


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
    "io/ioutil"
  	"net/http"
    "flag"
    "crypto/tls"
    "encoding/json"
    "github.com/tealeg/xlsx"
    "github.com/GoSimpleCodeTests/FCMTester/database"

//    "net/http/cookiejar"

)

const  (
  NumCol = 3
)



func main() {
  GetCurrentStatusCheckDB();
  return 1;


  Xfile  := xlsx.NewFile()
  sheet, _ := Xfile.AddSheet("Results")

  fmt.Println("Row1->",WriteRow([]string{"","","1.0","","1.1","","","1.2",""},sheet))
  fmt.Println("Row2->",WriteRow([]string{"order_id","QTY","EPC","QTY","EPC","Comments","QTY","EPC","Comments"},sheet))



  flag.Parse()
  inputf := flag.Arg(0)
  fmt.Println(inputf)
    file, err := os.Open(inputf)
    if err != nil {
        log.Fatal(err)
    }
    defer file.Close()

    scanner := bufio.NewScanner(file)
    for scanner.Scan() {             // internally, it advances token based on sperator
      orderId:=scanner.Text();
      fmt.Printf("->%s<-",orderId)  // token in unicode-char

      result:=ProcessRequest("1.0",orderId)
      result2:=ProcessRequest("1.1",orderId)
      result3:=ProcessRequest("1.2",orderId)
      r1, r2 := compare(orderId,result,result2)
      _, r3 := compare(orderId,result,result3)

//      fmt.Println(append(append(r1,r2...),r3...))
      _ = WriteRow(append(append(r1,r2...),r3...),sheet)


    } // End of for scanner.Scan()


    err = Xfile.Save(inputf+".xlsx")
    if err != nil {
      fmt.Printf(err.Error())
    }

}
/*
                1.0	1.1
0          1    2  3   4
order_id	QTY	EPC	QTY	EPC
*/

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


func ProcessRequest(ver string,orderId string) (map[string]map[string][]map[string]string){

    tr := &http.Transport{
        TLSClientConfig: &tls.Config{InsecureSkipVerify: true},
    }

    client := &http.Client{Transport: tr}

    aurl1 := "https://finalize-testing.bytetech.co/finalize_test?version="+ver+"&order_id="+orderId
    fmt.Println(aurl1)  // token in unicode-char

    a1req, err01 := http.NewRequest("GET", aurl1, nil)

    if err01 != nil {
      fmt.Println("ERROR",err01)  // token in unicode-char
    }

    a1req.Header.Add("Authorization", "KALSDFIO9RWR02JFOWEFJ20JIWEFOI")


    a1res,err11 := client.Do(a1req)
  //      fmt.Println("BERROR2",err1)  // token in unicode-char
    if err11 != nil {
      fmt.Println("ERROR2",err11)  // token in unicode-char
    }

    defer a1res.Body.Close()

    body, err12 :=  ioutil.ReadAll(a1res.Body)
    if err12 != nil {
      fmt.Println("ERROR3",err12)  // token in unicode-char
    }
    var res map[string]map[string][]map[string]string
    json.Unmarshal([]byte(body),&res)

    return res
}

func compare (orderId string ,result map[string]map[string][]map[string]string, result2 map[string]map[string][]map[string]string) ([]string,[]string){
  res_len :=len(result["run_results"]["post_run_items"])
  res2_len :=len(result2["run_results"]["post_run_items"])

  if(res_len !=res2_len){
    fmt.Printf("\nLength is Different\nv1.0 %d\n1.1 %d\n",res_len,res2_len)
    v1string :="";
    v2string :="";
    for i:=0; i<res_len;i++ {
      fmt.Printf("%d\t%s\n",i,result["run_results"]["post_run_items"][i]["epc"])
      v1string=fmt.Sprintf("%s\n%s\n",result["run_results"]["post_run_items"][i]["epc"],v1string)
    }
    fmt.Println("\nv1.1\n")
    for i:=0; i<res2_len;i++ {
      fmt.Printf("%d\t%s",i,result2["run_results"]["post_run_items"][i]["epc"])
      v2string=fmt.Sprintf("%s\n%s",result2["run_results"]["post_run_items"][i]["epc"],v2string)
    }
    return []string{orderId,fmt.Sprintf("%d",res_len),v1string}, []string{fmt.Sprintf("%d",res2_len),v2string,"Length is Different"}

  }else{
    v1string :="";
    v2string :="";
    no_match := false;
    for j:=0; j<res_len;j++ {

        v1string=fmt.Sprintf("%s\n%s",result["run_results"]["post_run_items"][j]["epc"],v1string)
        v2string=fmt.Sprintf("%s\n%s",result2["run_results"]["post_run_items"][j]["epc"],v2string)
        if( result["run_results"]["post_run_items"][j]["epc"] != result2["run_results"]["post_run_items"][j]["epc"]) {
          fmt.Printf("\nValues Don't Match\n%s\n%s\n",result["run_results"]["post_run_items"][j],result["run_results"]["post_run_items"][j])
          no_match=true
        }
    }
    if (no_match){
      return []string{orderId,fmt.Sprintf("%d",res_len),v1string},[]string{fmt.Sprintf("%d",res2_len),v2string,"Values Don't Match"}
    }else{
      return []string{orderId,fmt.Sprintf("%d",res_len),v1string},[]string{fmt.Sprintf("%d",res2_len),v2string,"Match"}
    }

  }
}

func GetCurrentStatusCheckDB(){
  InitDB()


}
