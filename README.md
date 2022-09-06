# README

## Features

### User register/login
* Validates email/password

### Parks Index
* Preset: Sort by Created At
* Sort by Tree Count
* Exact/Partial search

### Parks Show
* Park Tree Count/attributes
* Park Tree Index link

### Trees Index
* Preset: Show Healthy
* Exact/Partial search

### Park's Tree Index
* Sort Alphabetically
* Only > X Diameter

### Trees Show
* Tree's attributes

### Other Features:
* CRUD functionality
* Edit field placeholders
* Links for easy navigation
* And more...

## Stack

Ruby 2.7.4, Rails 5.2.8, PostgreSQL, ActiveRecord, RSpec w/SimpleCov, BCrypt, Rubocop

## Schema

One park has many trees

### Parks
* ID
* Name
* Affluent?
* Year

### Trees
* ID
* Park ID
* Species
* Healthy?
* Diameter