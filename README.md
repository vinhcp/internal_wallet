# Internal Wallet

## Requirements
- [Docker CE](https://docs.docker.com/get-docker/)

## Installation
`docker-compose build`

### Create Databases
`docker-compose run --rm web rake db:create db:migrate db:seed`

## Running the App
`docker-compose up`

## Test accounts

There're 10 accounts for each entity type user/team/stock

Sample account: 

email: [type][sequence]@example.com / password: password (sequence range from 1 to 10)

## Optional: Install without docker
- Ruby 3.0.1
- Postgresql 13
- Node 14.16.1
