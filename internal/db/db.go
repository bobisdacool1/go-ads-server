package db

import (
	"context"
	"fmt"
	"github.com/jackc/pgx/v5"
	"log"
	"sync"
)

type (
	Conn struct {
		Conn *pgx.Conn
	}
)

var (
	lock = &sync.Mutex{}
	db   *Conn
)

func GetInstance() *Conn {
	if db == nil {
		lock.Lock()
		defer lock.Unlock()
		if db == nil {
			db = newDbDonn()
		}
	}

	return db
}

func newDbDonn() *Conn {
	// urlExample := "postgres://username:password@localhost:5432/database_name"
	uname := "postgres"
	pass := "root"
	port := "54327"
	dbName := "go_ads_server"

	dbUrl := fmt.Sprintf("postgres://%s:%s@localhost:%s/%s", uname, pass, port, dbName)

	conn, err := pgx.Connect(context.Background(), dbUrl)
	if err != nil {
		log.Fatal(err)
	}

	return &Conn{
		Conn: conn,
	}
}
