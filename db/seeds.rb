# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
puts "Creating a admin account for first time use"
admin = User.new( :username => "admin", :password => "admin", :admin => true )
admin.save

puts "Creating a test account for first time use"
testUser = User.new( :username => "test", :password => "test", :admin => false )
testUser.save