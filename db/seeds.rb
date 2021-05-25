# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

(1..10).to_a.each do |sequence|
  %w[user team stock].each do |type|
    email = "#{type}#{sequence}@example.com"
    klass = type.camelize.safe_constantize
    next if klass.find_by(email: email).present?

    klass.create!(email: email, password: 'password', password_confirmation: 'password')
  end
end
