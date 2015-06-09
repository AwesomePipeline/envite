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

admin = User.new
admin.fullname = "Tester 1"
admin.handle = "tester1"
admin.email = "tester1@example.com"
admin.admin = false
admin.password = "12345678"
admin.password_confirmation = "12345678"
admin.save!

admin = User.new
admin.fullname = "Tester 2"
admin.handle = "tester2"
admin.email = "tester2@example.com"
admin.admin = false
admin.password = "12345678"
admin.password_confirmation = "12345678"
admin.save!

admin = User.new
admin.fullname = "Tester 3"
admin.handle = "tester3"
admin.email = "tester3@example.com"
admin.admin = false
admin.password = "12345678"
admin.password_confirmation = "12345678"
admin.save!