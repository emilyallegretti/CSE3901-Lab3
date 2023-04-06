# Ohio State University CSE Course Catalog

###### CSE 3901 Lab 2 Team 1 - Sharks

#### Table of Contents:
1. Overview

2. Installation and App Setup Instructions
  - Prerequisites
  - Installation and Database Configuration
  - Creating the Pre-Approved Admin
  - Launching the Server and Signing In
  - Loading in Course Data
  - Conclusion

3. User Guide
  - Signing up
  - Signing in
  - Administrator Home Page and Actions
  - Student/Instructor Home Page and Actions
  - Admins/Instructors That Are Pending Approval
  - Editing Your Account/Resetting Your Password

4. File and Folder Descriptions

5. References

## 1. Overview
This is a Ruby on Rails web application that allows registered users at Ohio State University to browse (and manipulate, as an admin user) a catalog of courses (along with their corresponding sections) offered by OSU's Computer Science and Engineering department. The application uses the OSU Course Catalog API available at https://classes.osu.edu/class-search/#/ to parse in CSE course data for Undergraduate and Graduate courses, and displays this data to the user, allowing them to search it and interact with it. 

Users are able to sign up for the app as Students, Instructors, or Administrators. While students and instructors are only able to browse the list of courses and sections, administrators have elevated privileges in the application and can edit, delete, or add new courses and sections to the catalog (instructors will also have certain elevated permissions in Project 3.). 


## 2. Installation and App Setup Instructions

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
- Email: admin.1@osu.edu
- Password: password


### Loading in Course Data

Since administrators have total control over what course data is present in this catalog, this also means the first pre-approved admin must initially load course data into the database on startup of the app in order for other users to browse it. At this point, there are currently no courses in the database until this step is completed.

1. Once signed in as the admin, Click "Reload Database" on the top menu bar 
2. Choose the campus(es) and term(s) you want to load into the catalog
3. Click "Load Courses". This will redirect you to the list of courses you've just loaded in. 

See the "Reloading the Database" section below for more info.

### Conclusion
The catalog is now ready for other OSU admins, students, and instructors to access!

## 3. User Guide 

### Signing Up
- If you are a new user, you will have to sign up for the app. Click "Sign Up" from the login landing page to get a new sign-up form.
- Enter in the requested credentials, and specify the role you are signing up as: an Admin, Student, or Instructor.
- Click "Sign Up" to create your account.

![signup](https://user-images.githubusercontent.com/105804647/229328660-a1f05689-b1b8-4b5c-ad30-16ad02152e6f.PNG)

**NOTE:**
- Only users with Ohio State University emails are able to sign up for the application. That is, the email you sign up with must be in name.#@osu.edu format.
- At the very least, you must enter an email and password in order to sign up, otherwise you will get an error. If you leave the First Name and Last Name fields blank, these credentials will be defaulted to "" on signup. If you do not specify a Role when signing up, your Role will be defaulted to Student. You can change these credentials after signup on the "Edit Account" page (see section below).
- New Admins and Instructors will be pending approval from an existing admin on signup. While awaiting approval, they have the same privileges as a Student (that is, browsing the database only). 


### Signing In 
- If you already have an account registered, you can sign into the app from the landing page.
- IF the application detects you are already signed in from an already-existing session, you will be automatically authenticated and brought to the user home page.
- Otherwise, you only need your email and password to sign in:

!![signin](https://user-images.githubusercontent.com/105804647/229328675-bdb20194-40df-44a1-96ec-bce88f1d1149.PNG)

- Click "Remember Me" if you want your browser to remember your credentials.

### Administrator Home Page and Actions
Here is what your home page will look like after signing in as an approved admin:

<img width="1443" alt="Screen Shot 2023-04-02 at 7 50 19 PM" src="https://user-images.githubusercontent.com/122934723/229387606-c2c79668-7bdb-41a7-ab74-e64932afa398.png">

Approved admins are able to browse and manipulate the course catalog, approve requests from new instructors and admins, and reload the database. The navigation bar in the top-right corner also allows the user to return to this home page from any other page on the website ("Home" button), edit their account ("Edit Account"), or sign out ("Sign Out")

**Browsing and Manipulating the Catalog:**

Clicking "Browse Catalog" from the home screen will bring you to a paginated list of CSE courses that are currently in the database. Relevant information about each course will be displayed:

<img width="1441" alt="Screen Shot 2023-04-02 at 7 48 48 PM" src="https://user-images.githubusercontent.com/122934723/229387738-8c1b7bb2-5e28-4bfe-97b9-3a22f1f59474.png">



You can view a specific course's information by clicking "Show" in that course's row in the list:

<img width="1432" alt="Screen Shot 2023-04-02 at 8 32 43 PM" src="https://user-images.githubusercontent.com/122934723/229387915-fa7365fb-0ecd-4620-8c0e-d55c500536b4.png">



You can also see the list of sections available for each course by clicking "Sections" in that course's row in the list or clicking "Course Sections" while viewing information about that course:

<img width="1444" alt="Screen Shot 2023-04-02 at 7 51 18 PM" src="https://user-images.githubusercontent.com/122934723/229387885-2592531c-579d-4b4f-9181-c4718ea40c95.png">



You are also able to search for courses across all pages in the catalog using the search bar at the top of the catalog list. You can search by course number, name, term, or campus. Enter your search query in the search bar and either hit ENTER or click "Search" to bring up the results of your query.

For example, here is the result of entering "systems" in the search bar and hitting ENTER:


<img width="1446" alt="Screen Shot 2023-04-02 at 8 11 54 PM" src="https://user-images.githubusercontent.com/122934723/229388039-83fb4e88-0ab2-44e9-8f95-af1f7d25d9a9.png">
All courses with "systems" in their name will be shown.

Here is the result of entering "autumn" in the search bar:

<img width="1439" alt="Screen Shot 2023-04-02 at 8 12 32 PM" src="https://user-images.githubusercontent.com/122934723/229388072-20ba4863-4f7e-4686-b323-b350d44e4bd8.png">


All courses under the Autumn 2023 term will be shown.

To clear your search filters and get the full list of courses back in your view, simply click "Clear Search" under the search bar.

As an Admin, you are not only able to browse the catalog, but you are also able to edit and delete courses and sections, and create new courses and sections.

*Editing a course*: click "Edit" for the course you'd like to edit. This will bring up a form for that course that you can edit and update: 

<img width="1512" alt="Screen Shot 2023-04-02 at 7 52 35 PM" src="https://user-images.githubusercontent.com/122934723/229388181-79503e46-5dad-4cea-84d2-d665389d7117.png">


*Deleting a course*: click "Delete" for the course you'd like to delete. You'll be asked to confirm before deleting:  

<img width="1428" alt="Screen Shot 2023-04-02 at 7 53 13 PM" src="https://user-images.githubusercontent.com/122934723/229388200-ad75d249-8783-4bd9-b1ba-bd19006be20f.png">


*Creating a course*: click "Create Course" at the bottom of the courses list page. This will bring up a form that you can fill in new course data for:

<img width="1438" alt="Screen Shot 2023-04-02 at 7 54 04 PM" src="https://user-images.githubusercontent.com/122934723/229388212-e12c8a34-5a79-4a64-8a60-47ead933332b.png">


You can view, edit, create, and delete sections in the same way by navigating to the "Sections" page for a specific course.

**Approving Requests:**

Existing, approved admins can view the list of other instructors and admins that are currently pending approval, and approve these requests. Click the "Status Requests" button from the menu bar to view the list:

<img width="1446" alt="Screen Shot 2023-04-02 at 8 01 27 PM" src="https://user-images.githubusercontent.com/122934723/229388232-4d9a8394-1775-4208-ab0f-8b2566960bd6.png">


Clicking "Approve" next to that user's name will approve their signup request.

**Reloading the Database:**

As mentioned in the App Setup section, the admin has control over what type of course data is present in the catalog. At any time, the admin can reload the database from the API by clicking "Reload Database" from the menu bar. This will take you to a form page where you can choose the term and OSU campus to filter courses by. Clicking "Load Courses" will clear all the courses currently in the catalog, and re-scrape the API using the specified filters, re-loading this course data back into the database.

NOTE: Choosing "All Campuses" will default to the Columbus campus (since this is what the API does when specifying "All Campuses" in the initial search).

<img width="1447" alt="Screen Shot 2023-04-02 at 7 59 49 PM" src="https://user-images.githubusercontent.com/122934723/229388252-98b4d408-3a59-405c-888f-e6306d83a857.png">



### Student/Instructor Home Page and Actions

If you are an existing, approved instructor or a student, your home page will look like this:
<img width="1438" alt="Screen Shot 2023-04-02 at 8 02 35 PM" src="https://user-images.githubusercontent.com/122934723/229388297-8546433f-e3b4-474a-ae8e-1a3b444a7196.png">


As a student or instructor, you are able to browse the course catalog, viewing courses and sections (Instructors will have more actions available to them in Project 3). The navigation bar in the top-right corner also allows the user to return to this home page from any other page on the website ("Home" button), edit their account ("Edit Account"), or sign out ("Sign Out").

**Browsing the Catalog:**

Clicking "Browse Catalog" from the home screen will bring you to a paginated list of CSE courses that are currently in the database. Relevant information about each course will be displayed:

<img width="1446" alt="Screen Shot 2023-04-02 at 8 04 48 PM" src="https://user-images.githubusercontent.com/122934723/229388329-d6de147e-8491-4547-93f6-dacb08ec4c61.png">


You can view a specific course's information by clicking "Show" in that course's row in the list:

<img width="1437" alt="Screen Shot 2023-04-02 at 8 09 34 PM" src="https://user-images.githubusercontent.com/122934723/229388379-ac2522ec-7a3f-495a-89e7-98dc2b6fbd99.png">


You can also see the list of sections available for each course by clicking "Sections" in that course's row in the list or clicking "Course Sections" while viewing information about that course:

<img width="1449" alt="Screen Shot 2023-04-02 at 8 09 59 PM" src="https://user-images.githubusercontent.com/122934723/229388429-11296211-b8cf-4cb9-bba4-ce7bdb43239c.png">




You can view specific sections in the same way by navigating to the "Sections" page for a specific course.

You are also able to search for courses across all pages in the catalog using the search bar at the top of the catalog list. You can search by course number, name, term, or campus. Enter your search query in the search bar and either hit ENTER or click "Search" to bring up the results of your query.

For example, here is the result of entering "systems" in the search bar and hitting ENTER:

<img width="1446" alt="Screen Shot 2023-04-02 at 8 11 54 PM" src="https://user-images.githubusercontent.com/122934723/229388490-54336654-b8ed-48b6-be9a-3c5441ff5f3a.png">


All courses with "systems" in their name will be shown.

Here is the result of entering "autumn" in the search bar:
<img width="1439" alt="Screen Shot 2023-04-02 at 8 12 32 PM" src="https://user-images.githubusercontent.com/122934723/229388518-c796b72e-b52b-43fb-8dee-c6c3219e1c88.png">



All courses under the Autumn 2023 term will be shown.

To clear your search filters and get the full list of courses back in your view, simply click "Clear Search" under the search bar.


**NOTE ABOUT REPEATING COURSE ENTRIES:** For certain 5000 level courses such as Capstones, as well as 499X classes, there are seemingly repeated entries of the same course number and term listed in our catalog (although they have different section listings). This is because the API itself lists these courses that way--some of its 5000 level courses have two listings under the same number and term, one for undergaduates and one for graduates. 499X classes have one listing for Honors students and one for non-Honors students. Thus, although they are separate, unique entries in the API and in our database, they appear to be duplicates from our course list view because we have not specified the course career. We plan to make this distinction more clear on the next iteration of the project.



### Admins and Instructors That Are Pending Approval

**Admins:**

If you are still pending approval as an admin, your home page will look like this:

<img width="1436" alt="Screen Shot 2023-04-02 at 8 23 41 PM" src="https://user-images.githubusercontent.com/122934723/229388542-3c33c939-abb9-4484-9588-4062961c14b9.png">


You will be unable to approve other requests or reload the database until your signup request is approved.

Your course catalog view will look like this:

<img width="1447" alt="Screen Shot 2023-04-02 at 8 24 01 PM" src="https://user-images.githubusercontent.com/122934723/229388555-0b0e1fae-239c-4da2-a320-5d74930fa8e0.png">


You are also unable to edit, delete, or create courses and sections if you are still pending approval as an admin. You are only able to view courses and sections, as a student would.

**Instructors:**

If you are still pending approval as an instructor, your home page will look like this:

<img width="1446" alt="Screen Shot 2023-04-02 at 8 22 29 PM" src="https://user-images.githubusercontent.com/122934723/229388588-80ccf6b1-9d19-4e3c-bbf0-7804374bf7b1.png">


At this point in development, instructors that are pending approval have the same privileges that they do after they are approved: they can only browse the catalog, and view courses and sections. Instructors will have more actions available to them in the catalog for Lab 3 that they will be unable to perform if pending approval. 


### Editing Your Account/Resetting your Password

Clicking "Edit Account" in your top-right navigation bar will take you to a page where you are able to edit your profile and change your password:

![image](https://user-images.githubusercontent.com/105804647/229330293-3dafc677-d330-4b68-8cd0-4903b9ab18fc.png)

As described in the form, if you would like to reset your password, enter the new password in the "Password" field and again in the "Password confirmation" field. If you are not resetting your password, leave these "Password" fields blank.

You can also edit your role, first name, and last name on this page.

You must enter your current password in the "Current password" field before clicking "Update" in order to make any changes to your account.

If you'd like to delete your account, you can also click "Cancel My Account" at the bottom of the page. This will sign you out and destroy your user record in the database, and you cannot sign in with these credentials again (unless you create a new account with them).

## 4. File and Folder Descriptions

There are a few main folders in the Project2 directory where our work is done:

1. app
  - controllers
  - models
  - views
2. config
  - routes.rb
3. db
  - migrate
  - schema.rb
  - seeds.rb
4. lib/services
  - parsing.rb
  
**app/controllers**: This folder holds all of the controller files for the website, organized and named by the type of actions they are handling. users/registrations_controller and users/sessions_controller are devise-generated controllers that handle signup and login requests, respectively. courses_controller handles all actions related to viewing and manipulating courses in the catalog. home_controller handles all requests to the user's home page after signin. reload_controller handles all actions related to reloading the database. requests_controller handles all actions related to getting and approving signup requests from new instructors/admins. Finally, sections_controller handles all actions relating to viewing and manipulating course sections in the catalog. 

**app/models**: This folder holds all the Rails class objects corresponding to their table in the underlying database. Creating/manipulating any of these Model objects in the controllers will also manipulate that table in the database by adding/editing rows. Each model filename corresponds to the name of the database table it is abstracting.

**app/views**: This folder holds all the view sub-folders corresponding to the controller under the same name (with the exception of layouts). Each of these sub-folders contains the HTML-Embedded Ruby files that are rendered by the controller they are associated with. For example, views/courses contains all the views associated with courses: index, which shows the collection of courses in the catalog, new, which shows a form for creating a new course, edit, which shows a form for editing a specific course, and show, which shows data for a specific course. The other view folders are organizaed in a similar way. devise/registrations contains devise-generated forms for signing up and editing your account, while devise/sessions contains the sign-in form view. 

views/layouts contains the universal layouts and partial used across the website. application.html.erb is the default layout, which determines the role of the user signed in (admin, student, or instructor) and displays a menu bar of actions custom to that type of user. _navbar.html.erb is rendered in application.html.erb and contains the navigation bar displayed at the top-right corner of any page on the site, containing actions relating to the user account itself (editing account, returning to the home page, and signing out).

**config/routes.rb**: This file contains all the routes connecting views to controllers.

**db/migrate**: This folder contains all the migration files that are necessary for creating the app's database schema. Running rails db:migrate performs these migrations in order of oldest to most recent.

**db/schema.rb**: This file contains the resulting schema for the app's database after running rails db:migrate.

**db/seeds.rb**: This file contains initial seed data for the database. Seeding the database with this file's data on startup of the app (with rails db:seed) is necessary in order to load in the pre-approved admin.

**lib/services/parsing.rb**: This file is where the API scraping class, Parsing, resides. Parsing.load is called from the reload_controller when a database reload is triggered, in order to get JSON data from the API with the help of HTTParty, and it parses this data into the "Course" and "Section" tables in the database.

## 5. Other References:

Ruby on Rails Guides: https://guides.rubyonrails.org/

Ruby on Rails API: https://apidock.com/rails/browse

Digital Ocean Tutorials:
https://www.digitalocean.com/community/tutorials/how-to-set-up-user-authentication-with-devise-in-a-rails-7-application

https://www.digitalocean.com/community/tutorials/how-to-create-nested-resources-for-a-ruby-on-rails-application




