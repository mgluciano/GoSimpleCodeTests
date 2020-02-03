


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

//    "net/http/cookiejar"

)

const  (
  NumCol = 6
)



func main() {
  Xfile  := xlsx.NewFile()
  sheet, _ := Xfile.AddSheet("Results")

  fmt.Println("Row1->",WriteRow([NumCol]string{"","","1.0","","1.1",""},sheet))
  fmt.Println("Row2->",WriteRow([NumCol]string{"order_id","QTY","EPC","QTY","EPC","Comments"},sheet))


  tr := &http.Transport{
      TLSClientConfig: &tls.Config{InsecureSkipVerify: true},
  }

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

      aurl0 := "https://finalize-testing.bytetech.co/finalize_test?version=1.0&order_id="+orderId
      fmt.Println(aurl0)  // token in unicode-char
      //jar, _ := cookiejar.New(nil)
      client := &http.Client{Transport: tr}

      a0req, err := http.NewRequest("GET", aurl0, nil)

      if err != nil {
        fmt.Println("ERROR",err)  // token in unicode-char
      }

      a0req.Header.Add("Authorization", "KALSDFIO9RWR02JFOWEFJ20JIWEFOI")


      a0res,err1 := client.Do(a0req)
//      fmt.Println("BERROR2",err1)  // token in unicode-char
      if err != nil {
        fmt.Println("ERROR2",err1)  // token in unicode-char
      }

      defer a0res.Body.Close()

  		body, err2 :=  ioutil.ReadAll(a0res.Body)
      if err2 != nil {
        fmt.Println("ERROR3",err2)  // token in unicode-char
      }


	    //fmt.Printf("\nRAW0\n%s\n",string(body))
      var result map[string]map[string][]map[string]interface{}
      json.Unmarshal([]byte(body),&result)
//      fmt.Printf("\n\n\nJSON0\n%v\n\n\n",result)
//      fmt.Printf("\n\n\nJSONA\n%v\n%d\n\n",result["order_info"]["initial_items"],len(result["order_info"]["initial_items"]))
//      fmt.Printf("\n\n\nJSONB\n%v\n\n\n",result["run_results"]["post_run_items"])




//      fmt.Println("LN",result)

      aurl1 := "https://finalize-testing.bytetech.co/finalize_test?version=1.1&order_id="+orderId
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
      var result2 map[string]map[string][]map[string]string
      json.Unmarshal([]byte(body),&result2)

      if(len(result["run_results"]["post_run_items"])!=len(result2["run_results"]["post_run_items"])){
        fmt.Printf("\nLength is Different\nv1.0 %d\n1.1 %d\n",len(result["run_results"]["post_run_items"]),len(result2["run_results"]["post_run_items"]))
        v1string :="";
        v2string :="";
        for i:=0; i<len(result["run_results"]["post_run_items"]);i++ {
          fmt.Printf("%d\t%s\n",i,result["run_results"]["post_run_items"][i]["epc"])
          v1string=fmt.Sprintf("%s\n%s\n",result["run_results"]["post_run_items"][i]["epc"],v1string)
        }
        fmt.Println("\nv1.1\n")
        for i:=0; i<len(result2["run_results"]["post_run_items"]);i++ {
          fmt.Printf("%d\t%s",i,result2["run_results"]["post_run_items"][i]["epc"])
          v2string=fmt.Sprintf("%s\n%s",result2["run_results"]["post_run_items"][i]["epc"],v2string)
        }
        _ = WriteRow([NumCol]string{orderId,string(len(result["run_results"]["post_run_items"])),v1string,string(len(result2["run_results"]["post_run_items"])),v2string,"Length is Different"},sheet)

      }else{
        v1string :="";
        v2string :="";
        no_match := false;
        for j:=0; j<len(result["run_results"]["post_run_items"]);j++ {

            v1string=fmt.Sprintf("%s\n%s",result["run_results"]["post_run_items"][j]["epc"],v1string)
            v2string=fmt.Sprintf("%s\n%s",result2["run_results"]["post_run_items"][j]["epc"],v2string)
            if( result["run_results"]["post_run_items"][j]["epc"] != result2["run_results"]["post_run_items"][j]["epc"]) {
              fmt.Printf("\nValues Don't Match\n%s\n%s\n",result["run_results"]["post_run_items"][j],result["run_results"]["post_run_items"][j])
              no_match=true
            }
        }
        if (no_match){
          WriteRow([NumCol]string{orderId,string(len(result["run_results"]["post_run_items"])),v1string,string(len(result2["run_results"]["post_run_items"])),v2string,"Values Don't Match"},sheet)
        }else{
          WriteRow([NumCol]string{orderId,string(len(result["run_results"]["post_run_items"])),v1string,string(len(result2["run_results"]["post_run_items"])),v2string,"Match"},sheet)
        }



      }
      // HANDLE


    } // End of for scanner.Scan()
//    fmt.Println("Done with file Read\nNow printing Totals for\nGrades:")



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

func WriteRow (text [NumCol]string,sheet *xlsx.Sheet ) (bool){
  var row *xlsx.Row
  var cell *xlsx.Cell

  for i := 0; i < NumCol; i++ {
    fmt.Println("inWrite->",text[i])
    if i == 0 {
      row = sheet.AddRow()
    }
      cell = row.AddCell()
      cell.Value = text[i]
  }
    return true
}
