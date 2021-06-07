# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
TeaType.destroy_all
TeaFacade.tea_db_flood

# Customer.create(first_name: 'Andrew', last_name: 'Johnston', email: 'andrew@email.com', address: '123 Denver St')
# Subscription.create(title: 'green', price: 7, frequency: 0, tea_type_id: 1, customer_id: 1)
