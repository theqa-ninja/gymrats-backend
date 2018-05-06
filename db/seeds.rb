# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
u1 = User.new(name: "ash", email: "ash@catch.com", dna: "brat good", fitbit_token: "fitbit please connect")
u1.save!

u2 = User.new(name: "misty", email: "misty@catch.com", dna: "funky pairs", fitbit_token: "fitbit connected")
u2.save!

u3 = User.new(name: "john doe", email: "test@lala.com", dna: "pair says good", fitbit_token: "fitbit nil")
u3.save!

Allelean.destroy_all
a0 = Allelean.new(name: "egg", photo: "egg.svg", evolve_id: nil)
a0.save!

a3 = Allelean.new(name: "monkey boss", photo: "monkeyBoss.svg", evolve_id: nil)
a3.save!

a2 = Allelean.new(name: "monkey gremling", photo: "monkeyGremling.svg", evolve_id: a3.id)
a2.save!

a1 = Allelean.new(name: "monkey base", photo: "monkey.svg", evolve_id: a2.id)
a1.save!

Stable.new(user_id: u1.id, allelean_id: a1.id, is_active: true, level: 1, exp: 50, aquired_date: Time.now.utc).save!


Stable.new(user_id: u2.id, allelean_id: a2.id, is_active: true, exp: 100, level: 3, aquired_date: Time.now.utc).save!

Stable.new(user_id: u3.id, allelean_id: a0.id, is_active: true, exp: 10, level: 0, aquired_date: Time.now.utc).save!