package storages

import (
	"context"
	"go-ads-server/internal/ads"
	"go-ads-server/internal/db"
	"log"
	"math"
	"strconv"
	"strings"
)

type (
	CampaignStorage struct {
	}
)

const getAllCampaignsWithTargetingsSql = `
select campaigns.id,
       price,
       redirect_url,
       string_agg(COALESCE(lower(browser), ''), ',')      as browsers,
       string_agg(COALESCE(lower(country_code), ''), ',') as country_codes
from campaigns
         left join campaigns_targetings ct on campaigns.id = ct.campaign_id
         left join targetings t on t.id = ct.targeting_id
group by campaigns.id
`

func NewCampaignsStorage() *CampaignStorage {
	return &CampaignStorage{}
}

func (cs CampaignStorage) GetCampaigns() []*ads.Campaign {
	dbConn := db.GetInstance()

	var (
		id, redirectUrl, browsers, countryCodes, price string
	)

	out := make([]*ads.Campaign, 0, 8)

	rows, err := dbConn.Conn.Query(context.Background(), getAllCampaignsWithTargetingsSql)
	if err != nil {
		log.Fatal(err)
	}

	for rows.Next() {
		err = rows.Scan(&id, &price, &redirectUrl, &browsers, &countryCodes)
		if err != nil {
			log.Fatal(err)
		}

		browserList := strings.Split(browsers, ",")
		countryCodesList := strings.Split(countryCodes, ",")

		length := int(math.Max(float64(len(browserList)), float64(len(countryCodesList))))

		targetings := make([]*ads.Targeting, length)

		for i := 0; i < length; i++ {
			targetings[i] = ads.NewTargetings(countryCodesList[i], browserList[i])
		}

		floatPrice, _ := strconv.ParseFloat(price, 64)

		out = append(out, &ads.Campaign{
			ClickUrl:   redirectUrl,
			Price:      floatPrice,
			Targetings: targetings,
		})
	}

	return out
}
