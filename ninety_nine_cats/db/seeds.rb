# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# t.date "birthdate", null: false
# t.string "color"
# t.string "name", null: false
# t.string "sex", limit: 1, null: false
# t.text "description"
    
Cat.destroy_all

a = Cat.create!(birthdate: "18th Feb 2000", color: "black" , name: 'Porsche', sex: "F", description: "Black cat, lived a nice long life")
b = Cat.create!(birthdate: "18th Feb 2000", color: "black" , name: 'Ferrari', sex: "M", description: "Black cat, got eaten by neighbors dog.")
c = Cat.create!(birthdate: "3rd April 2009", color: "grey" , name: 'Georgie', sex: "F", description: "Black and white cat who enjoys the sun")
d = Cat.create!(birthdate: "19th June 2019", color: "purple" , name: 'Cat 4', sex: "F", description: "unique purple cat, angry")