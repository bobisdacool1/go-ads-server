package main

import (
	"go-ads-server/internal/ads"
	"log"
)

func main() {
	s := ads.NewServer()

	if err := s.Listen(); err != nil {
		log.Fatal(err)
	}
}
