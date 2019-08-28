package main

import (
  "fmt"
  "flag"
  "strings"
)



func main() {

  flag.Parse()
  listener := flag.Arg(0)
  fmt.Println("->",listener,"<- Results in",CalcRN(listener))

}

func CalcRN (rn string) (int){
  var RN = map[string]int{
    "M": 1000,
    "D": 500,
    "C": 100,
    "L": 50,
    "X": 10,
    "V": 5,
    "I": 1,
  }
  num := 0
  prv := "M"
  s := strings.Split(rn,"");
  for _, v := range s {
    num =num + RN[v]
    if(RN[v]>RN[prv]){
      num= num - 2*RN[prv]
    }
    prv = v
  }
  return num

}
