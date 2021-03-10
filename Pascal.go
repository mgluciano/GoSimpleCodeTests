package main

import (
    "fmt"
    "strconv"
    "flag"
)




func main() {
  //Pascal := make(map[int]string[])

  flag.Parse()
  listener := flag.Arg(0)

  //fmt.Println("->",listener,"<- Results in")
  ct,err := strconv.Atoi(listener)
  if(err !=nil){
    fmt.Println("Please enter a interger",ct);
    return;
  }

    fmt.Println("the",ct,"Pascal Row is\t",PascalNth(ct))
    if (ct <=65){
      fmt.Println("Rec\nThe",ct,"Pascal Row is\t",RecPascalNth(ct))
    }else{
      fmt.Println("Can't run Recursive Solution on ct > 65 as it will Take too Long");
    }

}
///1 2 3 4 5 6
func PascalNth ( nth int ) (string){
    str :="1";
    if(nth<=0){
        return str
    }

    var Pascal = map[int]map[int]int{
      0:map[int]int {
            0:1,
      },
    }
    for i := 1; i <nth;i++ {
      Pascal[i] = map[int]int {
        0:1,
      }
      // establishes first attribute in string as 1
      str ="1"
      d:=0;
      for ; d < (len(Pascal[i-1])-1); d++ {
        Pascal[i][d+1]=Pascal[i-1][d]+Pascal[i-1][d+1]
        str = fmt.Sprintf("%s,%d",str,Pascal[i][d+1])
      }
      // establishes first attribute in map and string as 1
      Pascal[i][d+1] = 1
      str = fmt.Sprintf("%s,%s",str,"1")
    }
//    fmt.Println("\n",Pascal,"\n\n")
    fmt.Println("\n",Pascal[nth-1],"\n\n")
    return str;

}

func RecPascalNth (ct int ) ([]int){
    //fmt.Println(ct,cur)
    if (ct<=1) {
      return []int{1}
    }else{
      prev_slice := RecPascalNth(ct-1)
      // establish first attribute as 1 in slice
      slice := []int {1}
      for i :=0; i < (len(prev_slice)-1); i++ {
        slice=append(slice,prev_slice[i]+prev_slice[i+1])
      }
      // establish last attribute as 1 in slice
      slice=append(slice,1)
      // fmt.Println("ct=",ct,"slice=",slice)
      return slice
    }
}
