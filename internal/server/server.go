package server

import (
	"github.com/valyala/fasthttp"
	"go-ads-server/internal/ads"
	"go-ads-server/internal/storages"
	"net/http"
)

type Server struct {
}

func NewServer() *Server {
	return &Server{}
}

func (s *Server) Listen() error {
	return fasthttp.ListenAndServe(":54", s.handleHttp)
}

//goland:noinspection GoUnhandledErrorResult
func (s *Server) handleHttp(ctx *fasthttp.RequestCtx) {
	u := ads.NewUser(ctx)

	campaignStorage := storages.NewCampaignsStorage()
	c := campaignStorage.GetCampaigns()

	winner := ads.MakeAuction(c, u)
	if winner == nil {
		return
	}
	ctx.Redirect(winner.ClickUrl, http.StatusSeeOther)
}
