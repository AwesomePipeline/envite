# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.new
admin.fullname = "Administrator"
admin.handle = "admin"
admin.email = "admin@example.com"
admin.admin = true
admin.password = "12345678"
admin.password_confirmation = "12345678"
admin.save!