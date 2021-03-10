package main

import (
  "github.com/machinebox/graphql"
  "context"
  "flag"
  "fmt"

  "log"
)


func main() {
  flag.Parse()
  inputf := flag.Arg(0)
  fmt.Println(inputf)
  // make a request
  client := graphql.NewClient("https://api.prd.bytetech.co/")

  req := graphql.NewRequest(inputf)
  req.Header.Set("Content-Type", "application/json")
  req.Header.Set("Authorization", "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiIxMjMiLCJjbGllbnRJZCI6IjEiLCJhYmlsaXRpZXMiOlt7ImFjdGlvbiI6Im1hbmFnZSIsInN1YmplY3QiOiJhbGwifV19.tPO_psERJiWu3ZV5YiegoH7rRkx-3HeCJCyERWDmlWg")

  ctx := context.Background()

// run it and capture the response
  var respData interface{}
  if err := client.Run(ctx, req, &respData); err != nil {
    log.Fatal(err)
  }
  fmt.Println(respData)
  fetchValue(respData)
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
          for i, v := range value.([]interface{}) { // use type assertion to loop over []interface{}
              fmt.Println("i=",i)
              fetchValue(v)
          }
      case map[string]interface{}:
          fmt.Printf("%v is a map \n ", value)
          for i, v := range value.(map[string]interface{}) { // use type assertion to loop over map[string]interface{}
            fmt.Println("i=",i)
              fetchValue(v)
          }
      default:
          fmt.Printf("%v is unknown \n ", value)
      }
  }
