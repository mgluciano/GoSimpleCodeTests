package main

import (
    "fmt"
    "os"
    "log"
    "bufio"
    "strings"
    "strconv"
)




func main() {
  School := make(map[string]int)
  City := make(map[string]int)
  State := make(map[string]int)
  Grade := make(map[string]int)

    file, err := os.Open("schoolfile.txt")
    if err != nil {
        log.Fatal(err)
    }
    defer file.Close()

    scanner := bufio.NewScanner(file)
    for scanner.Scan() {             // internally, it advances token based on sperator
        fmt.Println(scanner.Text())  // token in unicode-char
        s := strings.Split(scanner.Text(),",");
        if (len(s) <4) {
          continue
        }
        ct,_ := strconv.Atoi(s[4])
        fmt.Println(ct)
        for i, v := range s {
          fmt.Println(v,i)
          if(i == 0){
            State[v]+=ct
          }else if (i==1){
            City[v]+=ct
          }else if (i==2){
            School[v]+=ct
          }else if (i==3){
            Grade[v]+=ct
            break
          }
        }
    }
    fmt.Println("Done with file Read\nNow printing Totals for\nGrades:")
    PrintHash(Grade)
    fmt.Println("Schools:")
    PrintHash(School)
    fmt.Println("Cities:")
    PrintHash(City)
    fmt.Println("States:")
    PrintHash(State)

}

func PrintHash (hash map[string]int ){
    tot :=0
    for v,i := range hash {
      fmt.Println("\t",v,"has",i,"red heads")
      tot+=i
    }
    fmt.Println("\tTotaling:",tot)
}
