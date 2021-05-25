# Internal Wallet

## Requirements
- [Docker CE](https://docs.docker.com/get-docker/)

## Installation
`docker-compose build`

### Create Databases
`docker-compose run --rm web rake db:create db:migrate db:seed`

## Running the App
`docker-compose up`

## Optional: Install without docker
- Ruby 3.0.1
- Postgresql 13
- Node 14.16.1
