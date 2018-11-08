# Coordinator API

Coordinator is a mobile app for concurrent editing of To-Do lists. Users can add friends and invite them to collaborate on lists, where each can mark tasks as claimed or completed with real-time updates to all other list collaborators. This is a personal project developed for the purpose of learning React Native. It is not intended for any commerical use.

This is the backend API for the App, hosted at https://github.com/sjweil9/coordinator_app / https://expo.io/@sjweil9/coordinator_app

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
