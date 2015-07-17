# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.new
admin.fullname = "Administrator"
admin.user = "admin"
admin.admin = true
admin.password = "12345678"
admin.password_confirmation = "12345678"
admin.save!

tester1 = User.new
tester1.fullname = "Tester 1"
tester1.user = "tester1"
tester1.admin = false
tester1.password = "12345678"
tester1.password_confirmation = "12345678"
tester1.save!

tester2 = User.new
tester2.fullname = "Tester 2"
tester2.user = "tester2"
tester2.admin = false
tester2.password = "12345678"
tester2.password_confirmation = "12345678"
tester2.save!

tester3 = User.new
tester3.fullname = "Tester 3"
tester3.user = "tester3"
tester3.admin = false
tester3.password = "12345678"
tester3.password_confirmation = "12345678"
tester3.save!