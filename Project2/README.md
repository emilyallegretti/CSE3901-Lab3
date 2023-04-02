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
5. Run  `rails db:create` and then `rails db:migrate` to create and initialize the database with the current schema 

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

## User Guide 

### Signing Up
- If you are a new user, you will have to sign up for the app. Click "Sign Up" from the login landing page to get a new sign-up form.
- Enter in the requested credentials, and specify the role you are signing up as: an Admin, Student, or Instructor.
- Click "Sign Up" to create your account.

![signup](signup.PNG)

**NOTE:**
- Only users with Ohio State University emails are able to sign up for the application. That is, the email you sign up with must be in name.#@osu.edu format.
- At the very least, you must enter an email and password in order to sign up, otherwise you will get an error. If you leave the First Name and Last Name fields blank, these credentials will be defaulted to "" on signup. If you do not specify a Role when signing up, your Role will be defaulted to Student. You can change these credentials after signup on the "Edit Account" page (see section below).
- New Admins and Instructors will be pending approval from an existing admin on signup. While awaiting approval, they have the same privileges as a Student (that is, browsing the database only). 


### Signing In 
- If you already have an account registered, you can sign into the app from the landing page.
- IF the application detects you are already signed in from an already-existing session, you will be automatically authenticated and brought to the user home page.
- Otherwise, you only need your email and password to sign in:

![signin](signin.PNG)

- Click "Remember Me" if you want your browser to remember your credentials.

### Administrator Home Page and Actions
Here is what your home page will look like after signing in as an approved admin:

![adminhome](adminhome.PNG)

Approved admins are able to browse and manipulate the course catalog, approve requests from new instructors and admins, and reload the database. The navigation bar in the top-right corner also allows the user to return to this home page from any other page on the website ("Home" button), edit their account ("Edit Account"), or sign out ("Sign Out")

**Browsing and Manipulating the Catalog:**

Clicking "Browse Catalog" from the home screen will bring you to a paginated list of CSE courses that are currently in the database. Relevant information about each course will be displayed:

![admincatalog](admincatalog.PNG)

You can view a specific course's information by clicking "Show" in that course's row in the list:

![adminshow](adminshow.PNG)

You can also see the list of sections available for each course by clicking "Sections" in that course's row in the list:

![adminsections](adminsections.PNG)

As an Admin, you are not only able to browse the catalog, but you are also able to edit and delete courses and sections, and create new courses and sections.

Editing a course: click "Edit" for the course you'd like to edit. This will bring up a form for that course that you can edit and update: 
![adminedit](adminedit.PNG)

Deleting a course: click "Delete" for the course you'd like to delete. You'll be asked to confirm before deleting: 
![deletecourse](deletecourse.PNG)

Creating a course: click "Create Course" at the bottom of the courses list page. This will bring up a form that you can fill in new course data for:
![newcourse](newcourse.PNG) 

You can edit, create, and delete sections in the same way by navigating to the "Sections" page for a specific course.

**Approving Requests:**

Existing, approved admins can view the list of other instructors and admins that are currently pending approval, and approve these requests. Click the "Status Requests" button from the menu bar to view the list:

![requests](requests.PNG)

Clicking "Approve" next to that user's name will approve their signup request.

**Reloading the Database:**

As mentioned in the App Setup section, the admin has control over what type of course data is present in the catalog. At any time, the admin can reload the database from the API by clicking "Reload Database" from the menu bar. This will take you to a form page where you can choose the term and OSU campus to filter courses by. Clicking "Load Courses" will clear all the courses currently in the catalog, and re-scrape the API using the specified filters, re-loading this course data back into the database.

NOTE: Choosing "All Campuses" will default to the Columbus campus (since this is what the API does when specifying "All Campuses" in the initial search).

### Student/Instructor Home Page and Actions


### Admins and Instructors That Are Pending 


### Editing Your Account/Resetting your Password



