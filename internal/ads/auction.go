package ads

type (
	Targeting struct {
		Country string
		Browser string
	}

	filterCampaign func(in []*Campaign, u *User) (out []*Campaign)
)

var (
	filters = []filterCampaign{filterByBrowser, filterByCountry}
)

func NewTargetings(country string, browser string) *Targeting {
	return &Targeting{
		Country: country,
		Browser: browser,
	}
}

func MakeAuction(in []*Campaign, u *User) (winner *Campaign) {
	campaigns := make([]*Campaign, len(in))
	copy(campaigns, in)

	for _, f := range filters {
		campaigns = f(campaigns, u)
	}

	if len(campaigns) == 0 {
		return nil
	}

	maxPriceC := campaigns[0]

	for _, c := range campaigns {
		if c.Price > maxPriceC.Price {
			maxPriceC = c
		}
	}

	return maxPriceC
}

func filterByBrowser(inCampaigns []*Campaign, u *User) []*Campaign {
	for i := len(inCampaigns) - 1; i >= 0; i-- {

		hasMatchingTargeting := false
		for j := len(inCampaigns[i].Targetings) - 1; j >= 0; j-- {

			if len(inCampaigns[i].Targetings[j].Browser) == 0 {
				hasMatchingTargeting = true
				break
			}

			if inCampaigns[i].Targetings[j].Browser == u.Browser {
				hasMatchingTargeting = true
				break
			}
		}
		if !hasMatchingTargeting {
			inCampaigns[i] = inCampaigns[0]
			inCampaigns = inCampaigns[1:]
		}
	}

	return inCampaigns
}

func filterByCountry(inCampaigns []*Campaign, u *User) []*Campaign {
	for i := len(inCampaigns) - 1; i >= 0; i-- {

		hasMatchingTargeting := false
		for j := len(inCampaigns[i].Targetings) - 1; j >= 0; j-- {

			if len(inCampaigns[i].Targetings[j].Country) == 0 {
				hasMatchingTargeting = true
				break
			}

			if inCampaigns[i].Targetings[j].Country == u.Country {
				hasMatchingTargeting = true
				break
			}
		}
		if !hasMatchingTargeting {
			inCampaigns[i] = inCampaigns[0]
			inCampaigns = inCampaigns[1:]
		}
	}

	return inCampaigns
}
