# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Tree.destroy_all
Park.destroy_all

turtle = Park.create!(name: 'Turtle Park', affluent: true, year: 1952)
turtle.trees.create!(species: 'Blue Spruce', healthy: true, diameter: 32)
turtle.trees.create!(species: 'American Elm', healthy: true, diameter: 28)

holbrook = Park.create!(name: 'Holbrook Park', affluent: false, year: 1984)
holbrook.trees.create!(species: 'Cottonwood', healthy: true, diameter: 45)
holbrook.trees.create!(species: 'Norway Maple', healthy: false, diameter: 38)
holbrook.trees.create!(species: 'Kentucky Coffee', healthy: false, diameter: 16)

cheesman = Park.create!(name: 'Cheesman Park', affluent: true, year: 1969)
cheesman.trees.create!(species: 'Blue Spruce', healthy: true, diameter: 30)
cheesman.trees.create!(species: 'Blue Spruce', healthy: false, diameter: 26)
cheesman.trees.create!(species: 'Honey Locust', healthy: true, diameter: 33)
cheesman.trees.create!(species: 'Austrian Pine', healthy: false, diameter: 34)
cheesman.trees.create!(species: 'Hackberry', healthy: false, diameter: 19)

crown = Park.create!(name: 'Crown Hill', affluent: false, year: 1973)
crown.trees.create!(species: 'Aspen', healthy: false, diameter: 16)
crown.trees.create!(species: 'Catalpa', healthy: true, diameter: 25)
crown.trees.create!(species: 'English Oak', healthy: true, diameter: 18)
crown.trees.create!(species: 'White Oak', healthy: true, diameter: 25)

sloans = Park.create!(name: 'Sloans Lake', affluent: true, year: 1935)
sloans.trees.create!(species: 'Blue Spruce', healthy: true, diameter: 27)
sloans.trees.create!(species: 'Scotch Pine', healthy: true, diameter: 28)

wash = Park.create!(name: 'Wash Park', affluent: true, year: 1903)
wash.trees.create!(species: 'Cottonwood', healthy: true, diameter: 44)
wash.trees.create!(species: 'Cottonwood', healthy: false, diameter: 38)

ruby = Park.create!(name: 'Ruby Hill', affluent: false, year: 1949)
ruby.trees.create!(species: 'Austrian Pine', healthy: false, diameter: 24)

city = Park.create!(name: 'City Park', affluent: true, year: 1915)
city.trees.create!(species: 'Cottonwood', healthy: true, diameter: 40)
