package main

import (
    "fmt"
    "os"
    "log"
    "bufio"
    "strings"
    //"strconv"
    "regexp"
    "flag"
)




func main() {
  flag.Parse()
  sqlFile := flag.Arg(0)

  fmt.Print("insert y value here: ")
  input := bufio.NewScanner(os.Stdin)
  input.Scan()
  fmt.Println(input.Text())

  fmt.Println("->",sqlFile,"<- Results in")
//  return;
//  Roles := make(map[string]map[string]string)
  Views := make(map[string]map[string]string)
  Tables := make(map[string]map[string]string)
  Functions := make(map[string]map[string]string)
  Schema := make(map[string]map[string]string)
  Set := make(map[string]map[string]string)
  Other := make(map[string]map[string]string)

  file, err := os.Open(sqlFile)
  if err != nil {
      log.Fatal(err)
  }
  defer file.Close()

  scanner := bufio.NewScanner(file)
  newRec := true // determines if we're inside expression or outside

  endReg := regexp.MustCompile(`;$`)
  mapType := ""
  commandKey :="";
  entity  :=""
  ct:=0

  invalidLine := regexp.MustCompile(`(^\s*--|^\s*$)`)
  CREATE_FUNCTION := regexp.MustCompile(`CREATE FUNCTION`)
  checkParan := regexp.MustCompile(`\(`)
  OtherCommands :=regexp.MustCompile(`(COMMENT|GRANT|ALTER)`)
  for scanner.Scan() {             // internally, it advances token based on sperator
      //fmt.Println(scanner.Text())  // token in unicode-char
      line :=scanner.Text()
      s := strings.Split(line," ");

//      if (len(s) <1 || s[0] =="--" ) {
      if (invalidLine.MatchString(line)){
        //fmt.Println("HERE Comment or Blank Line->",line,"<-")
        //newRec = true
        continue
      }
  //    fmt.Printf("HERE Line %s->%s<-",s[0],line)
//        fmt.Println("HERE NOT IN ...,<-")
      //re := regexp.MustCompile(``)
      if (newRec){
        //newRec = false
        if (s[0] == "SET"){
          mapType = s[0]
          commandKey=mapType
          _, ok:=Set[commandKey]
         if !ok {  // if val, ok := dict["foo"]; ok {
           Set[commandKey]=map[string]string{
             s[1]:line,
           }
         }else{
           Set[commandKey][s[1]]= line;
         }

          fmt.Printf("SETLINE-\tmapType=%s\tkey=%s\t->%s<--\n",commandKey,s[1],Set[mapType][s[1]])
          continue
        } else{
          mapType=s[1]

          if checkParan.MatchString(s[2]) {
              //fmt.Printf("Check Entity orig %s\n",s[2]);
              entity = (strings.Split(s[2],"("))[0]
              //fmt.Printf("Check Entity %s\n",entity);
          }else{
            entity = s[2]
          }
          commandKey = fmt.Sprintf("%s %s",s[0],mapType)


          if (mapType == "FUNCTION"){  //IN FUNCTION
//            fmt.Printf("HERE commandKey->%s<-\tentity->%s<-\n",commandKey,entity)

             _, ok:=Functions[commandKey]
            if !ok {  // if val, ok := dict["foo"]; ok {
              Functions[commandKey]=map[string]string{
                entity:line,
              }
            }else{
              Functions[commandKey][entity]= fmt.Sprintf("%s",line);
            }

            //endChar ="$$;"

          }else if (mapType == "SCHEMA"){ //  IN OTHER
            _, ok:=Schema[commandKey]
           if !ok {  // if val, ok := dict["foo"]; ok {
             Schema[commandKey]=map[string]string{
               entity:line,
             }
           }else{
             Schema[commandKey][entity]= fmt.Sprintf("%s",line);
           }
          }else if (mapType == "TABLE"){ //  IN OTHER
            _, ok:=Tables[commandKey]
           if !ok {  // if val, ok := dict["foo"]; ok {
             Tables[commandKey]=map[string]string{
               entity:line,
             }
           }else{
             Tables[commandKey][entity]= fmt.Sprintf("%s",line);
           }
          }else if (mapType == "VIEW"){ //  IN OTHER
            _, ok:=Views[commandKey]
           if !ok {  // if val, ok := dict["foo"]; ok {
             Views[commandKey]=map[string]string{
               entity:line,
             }
           }else{
             Views[commandKey][entity]= fmt.Sprintf("%s",line);
           }
          }else { //  IN OTHER
            if(OtherCommands.MatchString(s[0])){
              commandKey = fmt.Sprintf("%s %s",s[0],mapType)
              entity=s[3]
            }else if (len(s)>4){
              commandKey = fmt.Sprintf("%s %s %s",s[0],mapType,s[3])
              entity=s[4]
            }else if (len(s)>3){
              fmt.Println(line)
              commandKey = fmt.Sprintf("%s %s",s[0],mapType)
              entity=s[3]
            }else{
              fmt.Println(line)
              commandKey = fmt.Sprintf("%s %s",s[0],mapType)
              entity=s[2]
            }
            _, ok:=Other[commandKey]
            if !ok {  // if val, ok := dict["foo"]; ok {
               Other[commandKey]=map[string]string{
                 entity:line,
               }
            }else{
              Other[commandKey][entity]= fmt.Sprintf("%s",line);
            }

          }

        }
        if (CREATE_FUNCTION.MatchString(commandKey)){
          endReg = regexp.MustCompile(`^\$\$;$`)
        }else{
          endReg = regexp.MustCompile(`;$`)
        }

        if (endReg.MatchString(line)){
/*
          if (mapType == "FUNCTION"){
            fmt.Println("Found on line ",ct,line)
            input := bufio.NewScanner(os.Stdin)
            input.Scan()
            fmt.Println(input.Text())
          }
*/
          newRec = true
        }else{
          newRec = false
        }

        continue


      }else{

        if (endReg.MatchString(line)){
          newRec = true
        }else{
          newRec = false
        }

        if (mapType == "FUNCTION"){
          //fmt.Println("HERE",Functions[commandKey][entity])
          Functions[commandKey][entity]= fmt.Sprintf("%s\n%s",Functions[commandKey][entity],line)
          //fmt.Println("RESULTS IN",Functions[commandKey][entity])
        }else if (mapType == "SCHEMA"){ //  IN OTHER
           Schema[commandKey][entity]= fmt.Sprintf("%s\n%s",Schema[commandKey][entity],line);
        }else if (mapType == "TABLE"){ //  IN OTHER
           Tables[commandKey][entity]= fmt.Sprintf("%s\n%s",Tables[commandKey][entity],line);
        }else if (mapType == "VIEW"){ //  IN OTHER
           Views[commandKey][entity]= fmt.Sprintf("%s\n%s",Views[commandKey][entity],line);
        }else{
          //fmt.Println("HERE",Other[commandKey][entity])
          Other[commandKey][entity]= fmt.Sprintf("%s\n%s",Other[commandKey][entity],line)
          //fmt.Println("RESULTS IN",Other[commandKey][entity])
        }
      }

       ct++;
  }// END OF FOR LOOP
  fmt.Println("Done with file Read\n",ct," number of lines")
  fmt.Println("Views:")
  PrintHash(Views)
  fmt.Println("Tables:")
  PrintHash(Tables)
  fmt.Println("Functions:")
  PrintHash(Functions)
  fmt.Println("Other:")
  PrintHash(Other)
  fmt.Println("Schemas:")
  PrintHash(Schema)
  fmt.Println("Set:")
  PrintHash(Set)

}

func PrintHash (hash map[string]map[string]string ){
    tot :=0
    commandTot :=0
    for v, h := range hash {
      commandTot =0
//      fmt.Printf("%s",v)
/*
      if(v =="CREATE FUNCTION"){
        fmt.Println("HERE", h,v)
      }
*/
//      for v2, i := range h {
      for range h {
        commandTot ++
/*
        if(v =="CREATE FUNCTION"){
          fmt.Printf("%d V2=%v\n:I=%v\n ",commandTot,v2,i)
        }
*/
        tot++
      }
      fmt.Printf("\t%s : %d\n",v,commandTot)
//      fmt.Println("\t",v,"has",i,"red heads")

    }
    fmt.Println("Totaling : ",tot)
}
