# Ohio State University CSE Course Catalog

###### CSE 3901 Lab 2 Team 1 - Sharks

#### Table of Contents:
1. Overview

2. Installation and App Setup

3. File and Folder Descriptions
- Folder Descriptions
- File Descriptions

4. References/Other Notes

5. Testing

## 1. Overview
This is a Ruby on Rails web application that allows registered users at Ohio State University to browse (and manipulate, as an admin user) a catalog of courses (along with their corresponding sections) offered by OSU's Computer Science and Engineering department. The application uses the OSU Course Catalog API available at https://classes.osu.edu/class-search/#/ to parse in CSE course data, and displays this data to the user, allowing them to search it and interact with it. 

Users are able to sign up for the app as Students, Instructors, or Administrators. While students and instructors are only able to browse the list of courses and sections, administrators have elevated privileges in the application and can edit, delete, or add new courses and sections to the catalog (instructors will also have certain elevated permissions in Project 3.). 


## 2. Installation and App Setup

### Prerequisites
Installed on your machine:
- Ruby 3.2.0
- Rails 7.0.4
- Bundler 2.3.7

### Installation and Database Configuration
1. Go to https://github.com/cse-3901-sharkey/Team-1-Lab-2 and clone the repository into your local file system
2. From a terminal window, navigate to the Team-1-Lab-2 project directory
3. Run `cd Project2` from the command line to navigate into the inner Rails project folder
4. Run the `bundle install` command to install the necessary gems
5. Run `rails db:drop` and then `rails db:migrate` to initialize the database 

### Creating the Pre-Approved Admin
When a user specifies that they are an admin or an instructor on signup, that user must be approved for elevated privileges by a pre-existing admin. So, a pre-approved admin must be created on startup of the app. 

- Run `rails db:seed` to populate the database with the first pre-approved admin. This command will also populate some example users (see `db/seeds.rb`)

### Launching the Server and Signing In

1. Run `bundle exec rails server` in the command line to launch the server. It will list this link in the output:

`Listening on http://127.0.0.1:3000`

Click this link to open the server in a web browser. You will be presented with the login screen.

2. Log in with the pre-approved admin credentials:
email: admin.1@osu.edu
password: password


### Loading in Course Data

Since administrators have total control over what course data is present in this catalog, this also means the first pre-approved admin must initially load the course data into the database on startup of the app.

1. Once signed in as the admin, Click "Reload Database" on the top menu bar 
2. Choose the campus(es) and term(s) you want to load into the catalog
3. Click "Load Courses". This will redirect you to the list of courses you've just loaded in. 

### Conclusion
The catalog is now ready for other OSU admins, students, and instructors to access!

## Using the App




## 3. File and Folder Descriptions

### **Folder Descriptions**



### **File Descriptions**


## 4. References/Other Notes

**Game of Set Wikipedia**: https://en.wikipedia.org/wiki/Set_(card_game) 


