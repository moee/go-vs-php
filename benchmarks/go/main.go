package main

import (
	"github.com/emicklei/go-restful"
	"io"
	"net/http"
)

func main() {
	ws := new(restful.WebService)
	ws.Route(ws.GET("/").To(hello))
	restful.Add(ws)
	http.ListenAndServe(":80", nil)
}

func hello(req *restful.Request, resp *restful.Response) {
	io.WriteString(resp, "Hello World")
}
