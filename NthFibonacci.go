package main

import (
    "fmt"
    "strconv"
    "flag"
)




func main() {

  flag.Parse()
  listener := flag.Arg(0)

  fmt.Println("->",listener,"<- Results in")
  ct,err := strconv.Atoi(listener)
  if(err !=nil){
    fmt.Println("Please enter a interger",ct);
    return;
  }

    fmt.Println(" The",ct,"Fibonaccin Number is",FibonacciNth(ct))
    _,new :=RecFibonacciNthBetter(0,ct)
    fmt.Println("BetR\nThe",ct,"Fibonaccin Number is",new)

    if (ct <=45){
      fmt.Println(" Rec\nThe",ct,"Fibonaccin Number is",RecFibonacciNth(0,ct))
    }else{
      fmt.Println("Can't run Bad Recursive Solution on ct > 45 as it will Take too Long");
    }

}

func FibonacciNth ( nth int ) (int){
    first :=0
    second :=1
    if (nth <=0){
        return 0
    }else if(nth==1){
        return 1
    }
    cur := 0
    for i := 2; i <=nth;i++ {
      cur = first+second
      fmt.Println(i,cur)
      first=second;
      second=cur;
    }
    return cur;
}
/*
  BAD cause it does .5n squared calculations Not good
*/
func RecFibonacciNth (cur int,ct int ) (int){
    //fmt.Println(ct,cur)
    if (ct<=0) {
      return 0
    }else if (ct ==1) {
      return 1
    }else{
      return  RecFibonacciNth(cur,ct-1) + RecFibonacciNth(cur,ct-2)
    }
}

func RecFibonacciNthBetter (cur int,ct int ) (int,int){
    //fmt.Println(ct,cur)
    if (ct<=0) {
      return 0,0
    }else if (ct ==1) {
      return 0,1
    }else{
      f,s := RecFibonacciNthBetter(cur,ct-1)
      return  s,f+s
    }
}
