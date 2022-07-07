# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Tree.destroy_all
Park.destroy_all

turtle = Park.create!(name: "Turtle Park", affluent: true, year: 1950)
holbrook = Park.create!(name: "Holbrook Park", affluent: false, year: 1984)
cheesman = Park.create!(name: "Cheesman Park", affluent: true, year: 1969)
crown = Park.create!(name: "Crown Hill", affluent: false, year: 1973)

turtle.trees.create!(species: "Blue Spruce", healthy: true, diameter: 32)
turtle.trees.create!(species: "American Elm", healthy: true, diameter: 28)

holbrook.trees.create!(species: "Cottonwood", healthy: true, diameter: 45)
holbrook.trees.create!(species: "Norway Maple", healthy: false, diameter: 38)

cheesman.trees.create!(species: "Blue Spruce", healthy: true, diameter: 30)
cheesman.trees.create!(species: "Honey Locust", healthy: true, diameter: 33)
cheesman.trees.create!(species: "Austrian Pine", healthy: false, diameter: 34)

crown.trees.create!(species: "Aspen", healthy: false, diameter: 16)
crown.trees.create!(species: "Catalpa", healthy: true, diameter: 25)
crown.trees.create!(species: "English Oak", healthy: true, diameter: 18)