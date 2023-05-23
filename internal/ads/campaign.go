package ads

type (
	Campaign struct {
		ClickUrl   string
		Price      float64
		Targetings []*Targeting
	}
)
