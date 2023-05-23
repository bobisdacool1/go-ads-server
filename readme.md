# Go ads server


## What is this project about
- Docker for infrastructure
- Postgresql database
- Fasthttp
- Ads rotation
- Application design

## Installation
1. `go mod download`
2. `docker compose up -d`
3. `go run .\cmd\server\server.go`
4. Go to https://localhost:54  
Tadaaaa, you have done this

## How it works  
1. User go to page.
2. App noticing this. 
3. App parses user information, such as browser and geo.
4. App is getting campaigns, satisfy its targetings. 
5. The campaign with highest price wins auction. 
6. App redirects on campaign click url