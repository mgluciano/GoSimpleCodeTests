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
type DB_DUMP struct {
  dbName string
  Views map[string]map[string]string
  Tables map[string]map[string]string
  Functions map[string]map[string]string
  Schema  map[string]map[string]string
  Set map[string]map[string]string
  Other map[string]map[string]string
  Trigger map[string]map[string]string
}//{Set: make(map[string]map[string]string)}



func main() {
  flag.Parse()
  sqlFile1 := flag.Arg(0)
  name1 := flag.Arg(1)

  sqlFile2 := flag.Arg(2)
  name2 := flag.Arg(3)

/*
  fmt.Print("insert y value here: ")
  input := bufio.NewScanner(os.Stdin)
  input.Scan()
  fmt.Println(input.Text())
*/
  fmt.Println("->",sqlFile1,"<- Results in")
  fmt.Println("->",sqlFile2,"<- Results in")

  ct,iot :=CreateDB_Struct(name1,sqlFile1)
  fmt.Printf("Done with file for %s Read $d number of lines\n",name1,ct)

  ct,erp :=CreateDB_Struct(name2,sqlFile2)
  fmt.Printf("Done with file for %s Read $d number of lines\n",name2,ct)



// END OF FOR LOOP
  fmt.Println("Done with file Read\n",ct," number of lines")
  /*
  fmt.Println("Views:")
  PrintHash(iot.Views)
  fmt.Println("Tables:")
  PrintHash(iot.Tables)
  fmt.Println("Functions:")
  PrintHash(iot.Functions)
  fmt.Println("Other:")
  PrintHash(iot.Other)
  fmt.Println("Schemas:")
  PrintHash(iot.Schema)
  fmt.Println("Set:")
  PrintHash(iot.Set)

  fmt.Println("E Set:")
  PrintHash(erp.Set)
*/
  f1 :=""
  f2 :=""
  //   Schema
  f1,f2 = CompareHash(iot.Schema,iot.dbName,erp.Schema,erp.dbName)
  _ = WriteToFile(fmt.Sprintf("%s-%s-To-%s.sql","Schema",iot.dbName,erp.dbName),f1)
  _ = WriteToFile(fmt.Sprintf("%s-%s-To-%s.sql","Schema",erp.dbName,iot.dbName),f2)
  //   Tables
  f1,f2 = CompareHash(iot.Tables,iot.dbName,erp.Tables,erp.dbName)
  _ = WriteToFile(fmt.Sprintf("%s-%s-To-%s.sql","Tables",iot.dbName,erp.dbName),f1)
  _ = WriteToFile(fmt.Sprintf("%s-%s-To-%s.sql","Tables",erp.dbName,iot.dbName),f2)
  //   Views
  f1,f2 = CompareHash(iot.Views,iot.dbName,erp.Views,erp.dbName)
  _ = WriteToFile(fmt.Sprintf("%s-%s-To-%s.sql","Views",iot.dbName,erp.dbName),f1)
  _ = WriteToFile(fmt.Sprintf("%s-%s-To-%s.sql","Views",erp.dbName,iot.dbName),f2)
  //   Other
  f1,f2 = CompareHash(iot.Other,iot.dbName,erp.Other,erp.dbName)
  _ = WriteToFile(fmt.Sprintf("%s-%s-To-%s.sql","Other",iot.dbName,erp.dbName),f1)
  _ = WriteToFile(fmt.Sprintf("%s-%s-To-%s.sql","Other",erp.dbName,iot.dbName),f2)

  //   Set
  f1,f2 = CompareHash(iot.Set,iot.dbName,erp.Set,erp.dbName)
  _ = WriteToFile(fmt.Sprintf("%s-%s-To-%s.sql","Set",iot.dbName,erp.dbName),f1)
  _ = WriteToFile(fmt.Sprintf("%s-%s-To-%s.sql","Set",erp.dbName,iot.dbName),f2)

  //   Functions
  f1,f2 = CompareHash(iot.Functions,iot.dbName,erp.Functions,erp.dbName)
  _ = WriteToFile(fmt.Sprintf("%s-%s-To-%s.sql","Functions",iot.dbName,erp.dbName),f1)
  _ = WriteToFile(fmt.Sprintf("%s-%s-To-%s.sql","Functions",erp.dbName,iot.dbName),f2)

  f1,f2 = CompareHash(iot.Trigger,iot.dbName,erp.Trigger,erp.dbName)
  _ = WriteToFile(fmt.Sprintf("%s-%s-To-%s.sql","Trigger",iot.dbName,erp.dbName),f1)
  _ = WriteToFile(fmt.Sprintf("%s-%s-To-%s.sql","Trigger",erp.dbName,iot.dbName),f2)


}

func WriteToFile(fName string,fContent string)(error){
  f, err := os.Create(fName)
  fmt.Println("Writing file:",fName)
  if (err != nil){
    fmt.Println("ERROR Opening to File",fName)
    return err
  }
  defer f.Close()
  n3, err := f.WriteString(fContent)

  if (err != nil){
    fmt.Println("ERROR Writing to File",fName)
    return err
  }
  fmt.Printf("wrote %d bytes\n", n3)
  f.Sync()
  f.Close()
  return nil
}

func CreateDB_Struct(name string,sqlFile string)(int,*DB_DUMP){
  db := new(DB_DUMP)
  db.dbName=name

  db.Views = make(map[string]map[string]string)
  db.Tables = make(map[string]map[string]string)
  db.Functions = make(map[string]map[string]string)
  db.Schema  = make(map[string]map[string]string)
  db.Set = make(map[string]map[string]string)
  db.Other = make(map[string]map[string]string)
  db.Trigger =make(map[string]map[string]string)

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
  //  TRIGGER := regexp.MustCompile(`CREATE FUNCTION`)
    checkParan := regexp.MustCompile(`\(`)
    OtherCommands :=regexp.MustCompile(`(COMMENT|GRANT|ALTER)`)
    for scanner.Scan() {             // internally, it advances token based on sperator
        fmt.Println(scanner.Text())  // token in unicode-char
        line :=scanner.Text()
        s := strings.Split(line," ");


        // Remove blank lines
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
            _, ok:=db.Set[commandKey]
           if !ok {  // if val, ok := dict["foo"]; ok {
             fmt.Printf("%v %s\n",ok,commandKey)
             db.Set[commandKey]=map[string]string{
               s[1]:line,
             }
             fmt.Printf("HERE %v %s\n",ok,commandKey)
             fmt.Println("HERE",db.Set[commandKey])
           }else{
             db.Set[commandKey][s[1]]= line;
           }

//            fmt.Printf("SETLINE-\tmapType=%s\tkey=%s\t->%s<--\n",commandKey,s[1],db.Set[mapType][s[1]])
            continue
          }else if (s[0] == "CREATE" && s[1] == "TRIGGER"){
            mapType = s[1]
            commandKey=mapType
            _, ok:=db.Trigger[commandKey]
            if !ok {  // if val, ok := dict["foo"]; ok {
              fmt.Printf("%v %s\n",ok,commandKey)
              db.Trigger[commandKey]=map[string]string{
                s[2]:line,
              }
              fmt.Printf("HERE %v %s\n",ok,commandKey)
              fmt.Println("HERE",db.Trigger[commandKey])
            }else{
              db.Trigger[commandKey][s[2]]= line;
            }
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

               _, ok:=db.Functions[commandKey]
              if !ok {  // if val, ok := dict["foo"]; ok {
                db.Functions[commandKey]=map[string]string{
                  entity:line,
                }
              }else{
                db.Functions[commandKey][entity]= fmt.Sprintf("%s",line);
              }

              //endChar ="$$;"

            }else if (mapType == "SCHEMA"){ //  IN OTHER
              _, ok:=db.Schema[commandKey]
             if !ok {  // if val, ok := dict["foo"]; ok {
               db.Schema[commandKey]=map[string]string{
                 entity:line,
               }
             }else{
               db.Schema[commandKey][entity]= fmt.Sprintf("%s",line);
             }
            }else if (mapType == "TABLE"){ //  IN OTHER
              _, ok:=db.Tables[commandKey]
             if !ok {  // if val, ok := dict["foo"]; ok {
               db.Tables[commandKey]=map[string]string{
                 entity:line,
               }
             }else{
               db.Tables[commandKey][entity]= fmt.Sprintf("%s",line);
             }
            }else if (mapType == "VIEW"){ //  IN OTHER
              _, ok:=db.Views[commandKey]
             if !ok {  // if val, ok := dict["foo"]; ok {
               db.Views[commandKey]=map[string]string{
                 entity:line,
               }
             }else{
               db.Views[commandKey][entity]= fmt.Sprintf("%s",line);
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
              _, ok:=db.Other[commandKey]
              if !ok {  // if val, ok := dict["foo"]; ok {
                 db.Other[commandKey]=map[string]string{
                   entity:line,
                 }
              }else{
                db.Other[commandKey][entity]= fmt.Sprintf("%s",line);
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
            db.Functions[commandKey][entity]= fmt.Sprintf("%s\n%s",db.Functions[commandKey][entity],line)
            //fmt.Println("RESULTS IN",Functions[commandKey][entity])
          }else if (mapType == "SCHEMA"){ //  IN OTHER
             db.Schema[commandKey][entity]= fmt.Sprintf("%s\n%s",db.Schema[commandKey][entity],line);
          }else if (mapType == "TABLE"){ //  IN OTHER
             db.Tables[commandKey][entity]= fmt.Sprintf("%s\n%s",db.Tables[commandKey][entity],line);
          }else if (mapType == "VIEW"){ //  IN OTHER
             db.Views[commandKey][entity]= fmt.Sprintf("%s\n%s",db.Views[commandKey][entity],line);
          }else{
            //fmt.Println("HERE",Other[commandKey][entity])
            db.Other[commandKey][entity]= fmt.Sprintf("%s\n%s",db.Other[commandKey][entity],line)
            //fmt.Println("RESULTS IN",Other[commandKey][entity])
          }
        }

         ct++;
    }
    return ct, db
}


func CompareHash (hash1 map[string]map[string]string,n1 string,hash2 map[string]map[string]string,n2 string )(string,string){
  fmt.Println(n1,n2)
    tot :=0
    commandTot :=0
    missingv :=0
    missingv2 :=0
    f1ToF2 :=""
    f2ToF1 :=""
    for v, h := range hash1 {
      commandTot =0
      //_, ok:=db.Schema[commandKey]
//      _, ok:=hash2[v]
//      if (!ok){
//        fmt.Printf("%s is missing from %s\n",v,n2)
//        missingv++
//      }
//      fmt.Printf("%s",v)
//      for v2, i := range h {
      for v2,sql := range h {
        _, ok:=hash2[v][v2]
        if (!ok){
          fmt.Printf("%s is missing from %s->%s<-\n",v2,n2,v)
          missingv2++
          f1ToF2 =fmt.Sprintf("%s\n%s",f1ToF2,sql)
        }
        commandTot ++
        tot++
      }
      fmt.Printf("\t%s : %d\n",v,commandTot)
//      fmt.Println("\t",v,"has",i,"red heads")

    }
    fmt.Printf("%s->%s\n\tmissing v1: %d\n\tmissing v2: %d\n\tTotaling : %d\n\n\n",n1,n2,missingv,missingv2,tot)
    tot =0
    commandTot =0
    missingv =0
    missingv2 =0
    for v, h := range hash2 {
      commandTot =0
      //_, ok:=db.Schema[commandKey]
//      _, ok:=hash1[v]
//      if (!ok){
//        fmt.Printf("%s is missing from %s\n",v,n1)
//        missingv++
//      }
//      fmt.Printf("%s",v)
//      for v2, i := range h {
      for v2,sql:= range h {
        _, ok:=hash1[v][v2]
        if (!ok){
          fmt.Printf("%s is missing from %s->%s<-\n",v2,n1,v)
          missingv2++
          f2ToF1 =fmt.Sprintf("%s\n%s",f2ToF1,sql)
        }
        commandTot ++
        tot++
      }
      fmt.Printf("\t%s : %d\n",v,commandTot)
//      fmt.Println("\t",v,"has",i,"red heads")

    }
    fmt.Printf("%s->%s\n\tmissing v1: %d\n\tmissing v2: %d\n\tTotaling : %d\n\n",n2,n1,missingv,missingv2,tot)
    return f1ToF2,f2ToF1

}

func PrintHash (hash map[string]map[string]string ){
    tot :=0
    commandTot :=0
    for v, h := range hash {
      commandTot =0
//      fmt.Printf("%s",v)
//      for v2, i := range h {
      for range h {
        commandTot ++
        tot++
      }
      fmt.Printf("\t%s : %d\n",v,commandTot)
//      fmt.Println("\t",v,"has",i,"red heads")

    }
    fmt.Println("Totaling : ",tot)
}
