package main

import (
  "fmt"
  "flag"
//  "strings"
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
  fmt.Println("->",listener,"<- Results in",CalcRN(arabic))

}

func CalcRN (arabic int) (string){
  var RN = map[int]string{
    1000:"M" ,
    900:"CM" ,
    500:"D" ,
    100:"C" ,
    90:"XC" ,
    50: "L",
    10:"X" ,
    9:"IX" ,
    5: "V",
    1: "I",
  }
  Nums := []int{1000,900,500,100,90,50,10,9,5,1}
  rn :=""
  //prv := "M"
//  x:=arabic % 1000
  for i:=0;i<len(Nums);i++ {
    v:=int(arabic/Nums[i]);
    fmt.Println(i,",",RN[Nums[i]],"mod=",arabic%Nums[i],v );
    arabic -= v*Nums[i]
    if(v>0){
      if (v<4 || i==0){  //if working on M or 4 of a kind meaning you can subtract one
          for f:=0;f<v;f++{
            fmt.Println(f,i,Nums[i],RN[Nums[i]])
            rn += RN[Nums[i]]
          }
      }else{
        rn += RN[Nums[i]]+RN[Nums[i-1]]
        i-=1
      }

    }

  }

  return rn
}
