package main

import (
    "fmt"
    "net/http"
)

func main() {
    http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
        fmt.Fprint(w, "hellobaothanh28")
    })

    fmt.Println("Serving on port 80...")
    http.ListenAndServe(":80", nil)
}
