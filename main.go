package main

import (
	"io"
	"log"
	"net/http"
)

func hello(w http.ResponseWriter, r *http.Request) {
	log.Printf("Handling request - Remote Addr: %s - UA: %s", r.RemoteAddr, r.UserAgent())
	io.WriteString(w, "Hello world!")
}

func main() {
	log.Println("starting server")
	http.HandleFunc("/", hello)
	log.Fatal(http.ListenAndServe(":8080", nil))
}
