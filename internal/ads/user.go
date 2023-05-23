package ads

import (
	realip "github.com/ferluci/fast-realip"
	"github.com/mssola/useragent"
	"github.com/oschwald/geoip2-golang"
	"github.com/valyala/fasthttp"
	"log"
	"net"
	"strings"
)

type (
	User struct {
		Country string
		Browser string
	}
)

func NewUser(ctx *fasthttp.RequestCtx) *User {
	ua := useragent.New(string(ctx.Request.Header.UserAgent()))
	geoIp, err := geoip2.Open("assets/db/GeoLite2-Country.mmdb")
	if err != nil {
		log.Fatal(err)
	}

	clientIP := realip.FromRequest(ctx)

	country, err := geoIp.Country(net.ParseIP(clientIP))
	if err != nil {
		log.Fatal(err)
	}

	browserName, _ := ua.Browser()

	return &User{
		Country: strings.ToLower(country.Country.IsoCode),
		Browser: browserName,
	}
}
