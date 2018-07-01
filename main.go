package main

import (
	"os"
	"net/http"
	"log"
	"github.com/urfave/cli"
	"fmt"
)

// go build -ldflags "-X main.VERSION=1.0.0 -X 'main.BuildTime=`date`' -X 'main.GoVersion=`go version`' -X 'main.AUTHOR=`whoami`'"

var VERSION = "1.0.0"
var BuildTime = ""
var GoVersion = ""
var AUTHOR = "{AUTHOR}"



func main() {
	log.SetFlags(log.Ldate | log.Ltime | log.Lshortfile)

	app := cli.NewApp()
	app.Name = "{APP}"
	app.Version = VERSION
	app.Author = AUTHOR

	app.Usage = "Usage of this app."

	app.Action = func(c *cli.Context) {
		log.Printf(`
======================================================================================================
version: %v, author: %v, built_at: %v, %v
======================================================================================================`,
			VERSION, AUTHOR, BuildTime, GoVersion)

		go runServer()


		select {}
	}
	err := app.Run(os.Args)
	log.Fatal(err)
}


func runServer(){
	http.HandleFunc("/",indexHandler)
	log.Println("Http.listenAndServe: 9091")
	log.Println(http.ListenAndServe(":9091",nil))
}

func indexHandler(res http.ResponseWriter, req *http.Request){
	res.Header().Set("Content-Type","text/plain")
	res.Write([]byte("Just a demo http server.\n"))
	res.Write([]byte(fmt.Sprintf("version: %v \n", VERSION)))
	res.Write([]byte(fmt.Sprintf("built_at: %v \n", BuildTime)))
	res.Write([]byte(fmt.Sprintf("created_by: %v \n", AUTHOR)))
}