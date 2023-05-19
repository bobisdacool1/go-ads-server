package ads

import (
	"github.com/valyala/fasthttp"
	"log"
)

type Server struct {
}

func NewServer() *Server {
	return &Server{}
}

func (s *Server) Listen() error {
	return fasthttp.ListenAndServe(":54", s.handleHttp)
}

func (s *Server) handleHttp(ctx *fasthttp.RequestCtx) {
	_, err := ctx.WriteString("Hello, world!")
	if err != nil {
		log.Fatal(err)
	}
}
