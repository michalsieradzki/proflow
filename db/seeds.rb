# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Stwórz pierwszego super admina
admin = User.create!(
  email: 'admin@proflow.local',
  password: 'password123',
  password_confirmation: 'password123',
  first_name: 'Super',
  last_name: 'Admin',
  role: :super_admin,
  theme: :dark
)

puts "Created super admin: #{admin.email}"

# Stwórz kilku testowych userów
5.times do |i|
  User.create!(
    email: "user#{i+1}@proflow.local",
    password: 'password123',
    password_confirmation: 'password123',
    first_name: "User",
    last_name: "#{i+1}",
    role: 'user'
  )
end

puts "Created 5 test users"

# Stwórz przykładową static page
StaticPage.create!(
  title: 'Welcome',
  slug: 'welcome',
  content: '<h1>Welcome to PROFLOW</h1><p>This is a sample static page.</p>',
  published: true
)

puts "Created sample static page"
