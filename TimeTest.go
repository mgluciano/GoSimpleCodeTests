package main

import (
  "fmt"
  "flag"
//  "strings"
  "time"
  "strconv"
  //"math"
)


func main() {

  flag.Parse()
  listener := flag.Arg(0)
  arabic,err := strconv.Atoi(listener)
  if(err !=nil){
    fmt.Println("Please enter a interger",listener);
    return;
  }
  fmt.Println("Waiting ->",arabic,"<- Miliseconds")


  t := time.Now();
  fmt.Println("Start ",t,"->",t.Format())
  time.Sleep(time.Duration(arabic) * time.Millisecond)
  fmt.Println("End")

  if(checkAuthTime(t)){
    fmt.Println("True")
  }else{
    fmt.Println("False")
  }
}



func checkAuthTime(ts time.Time) (bool){
  t := time.Now();
  elapsed := t.Sub(ts)
  fmt.Println(elapsed)
  // More than 15 minutes
  if(elapsed <900000) {
    return false
  }
  return true
}
