# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.create([{
    :email => "admin.1@osu.edu",
    :password => "password",
    :fname => "Initial Admin",
    :lname => "",
    :pending_approval => false,
    :role => "admin"

}])
User.create([{
    :email => "instructor.2@osu.edu",
    :password => "password",
    :fname => "Scott",
    :lname => "Sharkey",
    :pending_approval => true,
    :role => "instructor"

}])
User.create([{
    :email => "student.2@osu.edu",
    :password => "password",
    :fname => "Emily",
    :lname => "Allegretti",
    :role => "student"

}])
User.create([{
    :email => "instructor.3@osu.edu",
    :password => "password",
    :fname => "Emily",
    :lname => "Allegretti",
    :role => "instructor",
    :pending_approval => true

}])
User.create([{
    :email => "admin.4@osu.edu",
    :password => "password",
    :fname => "Emily",
    :lname => "Allegretti",
    :pending_approval => true,
    :role => "admin"

}])
