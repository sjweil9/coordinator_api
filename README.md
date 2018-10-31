# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# Coordinator API

This is the backend API for https://github.com/sjweil9/coordinator_app / https://expo.io/@sjweil9/coordinator_app

It is not intended for use as a public API, the endpoints are designed specifically for required App functionality. 

## Requirements

Tested for Ruby 2.5 and Rails 5.2

Requires Redis and Postgres

## How to Run

1. Clone this repo / cd in
2. `rake secret` to generate a Rails secret key
3. Make sure Redis and Postgres are installed and running
4. `bundle install`
5. `rails db:create`
6. `rails db:migrate`
7. `rails s`

You will likely want to also clone the App, configure the API_BASE_URL to point to your local server, and then run.
