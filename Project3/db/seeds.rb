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
    :email => "admin.4@osu.edu",
    :password => "password",
    :fname => "Emily",
    :lname => "Allegretti",
    :pending_approval => true,
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
    :email => "instructor.3@osu.edu",
    :password => "password",
    :fname => "Emily",
    :lname => "Allegretti",
    :role => "instructor",
    :pending_approval => true
}])

User.create([{
    :email => "student.2@osu.edu",
    :password => "password",
    :fname => "Emily",
    :lname => "Allegretti",
    :role => "student"
}])
User.create([{
    :email => "student.5@osu.edu",
    :password => "password",
    :fname => "Mara",
    :lname => "Beam",
    :role => "student"
}])

Course.create([{
    :number => 1223,
    :name => "Java",
    :campus => "Columbus",
    :term => "Spring 2023"
}])
Course.create([{
    :number => 3901,
    :name => "Web App",
    :campus => "Columbus",
    :term => "Spring 2023"
}])

Application.create([{
    :campus => "Columbus",
    :term => "Spring 2023",
    :user_id => 5
}])
Availability.create([{
    :start_time => "9",
    :end_time => "12",
    :day_of_week => "Monday",
    :application_id => 1
}])
CoursePreference.create([{
    :course_id => 1,
    :application_id => 1
}])
CourseQualification.create([{
    :course_id => 1,
    :application_id => 1
}])
CourseQualification.create([{
    :course_id => 2,
    :application_id => 1
}])
