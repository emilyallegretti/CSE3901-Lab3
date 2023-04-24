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
  - Student Home Page and Actions
  - Instructor Home Page and Actions 
  - Admins/Instructors That Are Pending Approval
  - Editing Your Account/Resetting Your Password

4. File and Folder Descriptions

5. References

## 1. Overview
This is a Ruby on Rails web application that allows registered users at Ohio State University to browse (and manipulate, as an admin user) a catalog of courses (along with their corresponding sections) offered by OSU's Computer Science and Engineering department and facilitate student grader applicationa and assignments. The application uses the OSU Course Catalog API available at https://classes.osu.edu/class-search/#/ to parse in CSE course data for Undergraduate and Graduate courses, and displays this data to the user, allowing them to search and interact with it. 

Users are able to sign up for the app as Students, Instructors, or Administrators. Students can browse the course catalog and submit student grader applications. Instructors can browse the course catalog and submit student grader recomendations. Admins have elevated privelages in the application and can edit, delete, or add new courses and sections to the catalog (instructors will also have certain elevated permissions in Project 3.) as well as approve student grader applications and assign student graders to course sections. 


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
2. Choose the campus(es) and term(s) you want to load into the catalog or enter a term code
3. Click "Load Courses". This will redirect you to the list of courses you've just loaded in 

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

<img width="1435" alt="Screen Shot 2023-04-23 at 6 37 45 PM" src="https://user-images.githubusercontent.com/122934723/233869851-3635db9b-022c-4129-b931-ad0aa43e62ab.png">

Approved admins are able to browse and manipulate the course catalog, approve requests from new instructors and admins, reload the database, and approve and assign student graders. The navigation bar in the top-right corner also allows the user to return to this home page from any other page on the website ("Home" button), edit their account ("Edit Account"), or sign out ("Sign Out")

**Browsing and Manipulating the Catalog:**

Clicking "Browse Catalog" from the home screen will bring you to a paginated list of CSE courses that are currently in the database. Relevant information about each course will be displayed:


<img width="1438" alt="Screen Shot 2023-04-23 at 6 39 07 PM" src="https://user-images.githubusercontent.com/122934723/233869889-47fa782c-856d-4611-a14a-9ee454f9bffc.png">


You can view a specific course's information by clicking "Show" in that course's row in the list:

<img width="1440" alt="Screen Shot 2023-04-23 at 6 39 52 PM" src="https://user-images.githubusercontent.com/122934723/233869916-89629028-bfe7-4f2d-9cff-98785bf64dff.png">


You can also see the list of sections available for each course by clicking "Sections" in that course's row in the list or clicking "Course Sections" while viewing information about that course:


<img width="1442" alt="Screen Shot 2023-04-23 at 6 42 40 PM" src="https://user-images.githubusercontent.com/122934723/233870027-bb2c244c-4ac7-4696-84f6-b835a29917b9.png">


You are also able to search for courses across all pages in the catalog using the search bar at the top of the catalog list. You can search by course number, name, term, or campus. Enter your search query in the search bar and either hit ENTER or click "Search" to bring up the results of your query.

For example, here is the result of entering "systems" in the search bar and hitting ENTER:

<img width="1495" alt="Screen Shot 2023-04-23 at 6 55 03 PM" src="https://user-images.githubusercontent.com/122934723/233870525-b6f07f8a-4815-4bc8-b49e-80f2fde0402e.png">

All courses with "systems" in their name will be shown.

Here is the result of entering "autumn" in the search bar:

<img width="1481" alt="Screen Shot 2023-04-23 at 6 55 37 PM" src="https://user-images.githubusercontent.com/122934723/233870549-baba7d72-ced1-4a1f-8d39-022eea9f298c.png">


All courses under the Autumn 2023 term will be shown.

To clear your search filters and get the full list of courses back in your view, simply click "Clear Search" under the search bar.

As an Admin, you are not only able to browse the catalog, but you are also able to edit and delete courses and sections, and create new courses and sections.

*Editing a course*: click "Edit" for the course you'd like to edit. This will bring up a form for that course that you can edit and update: 

<img width="1440" alt="Screen Shot 2023-04-23 at 6 45 26 PM" src="https://user-images.githubusercontent.com/122934723/233870162-dc064015-b8af-4933-a003-c929d8b8aa3f.png">


*Deleting a course*: click "Delete" for the course you'd like to delete. You'll be asked to confirm before deleting:  

<img width="1442" alt="Screen Shot 2023-04-23 at 6 45 56 PM" src="https://user-images.githubusercontent.com/122934723/233870183-99c28e2f-fcfe-4e3f-a619-b8c7dd86b53d.png">


*Creating a course*: click "New Course" at the bottom of the courses list page. This will bring up a form that you can fill in new course data for:


<img width="1431" alt="Screen Shot 2023-04-23 at 6 46 40 PM" src="https://user-images.githubusercontent.com/122934723/233870216-f7e25766-33bd-4365-ac96-5d5b2812ff25.png">


You can view, edit, create, and delete sections in the same way by navigating to the "Sections" page for a specific course.

**Approving Requests:**

Existing, approved admins can view the list of other instructors and admins that are currently pending approval, and approve these requests. Click the "Status Requests" button from the menu bar to view the list:

<img width="1447" alt="Screen Shot 2023-04-23 at 6 48 16 PM" src="https://user-images.githubusercontent.com/122934723/233870286-55196822-a4e9-4209-bf7d-7f10d0db8951.png">


Clicking "Approve" next to that user's name will approve their signup request.

**Reloading the Database:**

As mentioned in the App Setup section, the admin has control over what type of course data is present in the catalog. At any time, the admin can reload the database from the API by clicking "Reload Database" from the menu bar. This will take you to a form page where you can choose the term and OSU campus to filter courses by. Clicking "Load Courses" will clear all the courses currently in the catalog, and re-scrape the API using the specified filters, re-loading this course data back into the database.

NOTE: Choosing "All Campuses" will default to the Columbus campus (since this is what the API does when specifying "All Campuses" in the initial search).

<img width="1442" alt="Screen Shot 2023-04-23 at 6 51 21 PM" src="https://user-images.githubusercontent.com/122934723/233870399-e44c5691-93e2-4d96-a01b-17452cb37be3.png">



**Managing Student Grader Applications:**
Admins have the ability to approve and reject applications for student graders. They can view a paginated list of pending grader applications by selecting "Grader Applications" from the menu bar. For each pending application in the list, the applicant's name, term and campus applied to, and options to show, approve, and reject the application will be displayed. Next to the pending applications, there will be a list of all approved student applications. Each application in this list will display the applicant's name, email, campus and term applied for, as well as a "Show" option.

<img width="1506" alt="Screen Shot 2023-04-23 at 6 59 16 PM" src="https://user-images.githubusercontent.com/122934723/233870739-7c34b6d2-fa42-4ddc-b59c-882a5cdc1ef0.png">


If "Show" is clicked for an application, the admin will be directed to a page which displays all the information submitted in the specified application. It will display the applicants personal information, the campus and term they applied for, their availability, the courses they are qualified to grade, the courses they prefer to grade, and the sections they are qualified for which are in need of graders. They will also be able to see information about possible instructor reccomendations as well. It will list, instructor's name and email as well as the reccomended course, reccomended section, and the message submitted in the reccomenedation form. Admins will have the ability to approve the application and return to the "Grader Application" page by clicking the appropriate options at the bottom of the page.

<img width="1512" alt="Screen Shot 2023-04-23 at 7 02 51 PM" src="https://user-images.githubusercontent.com/122934723/233870835-b7a38b01-b927-43b9-ba2d-db8cf887254b.png">


If the admin selects "Approve" for the application, the aplication will be removed from the list, and a message will be displayed saying the aplication was approved.

<img width="1494" alt="Screen Shot 2023-04-23 at 7 03 50 PM" src="https://user-images.githubusercontent.com/122934723/233870866-edfd55c2-452c-44db-92e4-ed305d66b8e3.png">

If the admin selects "Reject" for the application, a popup will confirm the intention for rejection. They will have the option to "Cancel" which will refrain from rejection, or "OK" which will reject the application. If the application is rejected, it will disappear from the student grader applications list and the student's list of submitted applications.

<img width="1510" alt="Screen Shot 2023-04-23 at 7 04 58 PM" src="https://user-images.githubusercontent.com/122934723/233870904-94b59cfd-287e-4115-91d1-1c636c1d7224.png">


**Managing Student Grader Assignments:**
Admins also have tha ability to assign student graders to sections. To do this, they can select "Section Grader Assignments" from the menu bar which will direct them to the student grader assignment dashboard. The dashboard displays a paginated list of course sections in need of graders and a list of approved grader applications. They can specify the term to view both lists by selecting the name of the term from the drop down above the list headings. When they click "Apply term," all the appropriate course and grader application information will be displayed. For example, this is an admin view after selecting "Spring 2023".

<img width="1498" alt="Screen Shot 2023-04-23 at 7 09 03 PM" src="https://user-images.githubusercontent.com/122934723/233871065-7438d0aa-1701-45a9-8397-d487385df38e.png">

Each section in need of a grader will be displayed as a row in the list with its course number, campus, section number, start time, end time, days of the week, number of graders requires, and rhe graders assigned. If any of the information is not currently available from the API, those fields will be left blank for that course. The approved applications will be displayed in another list where each application will be in a row with the student's name, email, term applied for, campus applied for, qualified courses, and the option to "Show" the application. If they select "Show," they will be directed to the same "Show" page feasrued in the grader application list. 

<img width="1512" alt="Screen Shot 2023-04-23 at 7 25 03 PM" src="https://user-images.githubusercontent.com/122934723/233871752-6d995cd2-c98b-4877-b1c9-9b938499a995.png">

In order to assign a grader to a section, the admin will need to select the student's email from the drop down of the associated section then click "Assign." If the grader is assigned successfully, a success message will be displayed, the number of graders for the course will decrease by 1, the student will appear in the "Assigned Graders" section of the course in the list, and their application information will dissappear from the "Approved Applications" list. If there are no graders left with approved applications, the ability to assign graders to course sections will will be revoked and the drop down with the "Approve" button will dissappear.

<img width="1512" alt="Screen Shot 2023-04-23 at 7 33 59 PM" src="https://user-images.githubusercontent.com/122934723/233872272-a228f95e-f712-4c91-af21-023ede664c53.png">


### Student Home Page and Actions

If you are an existing student, your home page will look like this:
<img width="1511" alt="Screen Shot 2023-04-23 at 7 47 22 PM" src="https://user-images.githubusercontent.com/122934723/233872999-320ab5a5-9811-455b-be4c-31dfba89eaf5.png">


As a student, you are able to browse the course catalog, viewing courses and sections, as well as apply to become a grader. The navigation bar in the top-right corner also allows the user to return to this home page from any other page on the website ("Home" button), edit their account ("Edit Account"), or sign out ("Sign Out").

**Browsing the Catalog:**

Clicking "Browse Catalog" from the home screen will bring you to a paginated list of CSE courses that are currently in the database. As descrived above, the admin has complete control over the courses in the database, so students will only be able see the courses as specified by the last admin's database reload.Relevant information about each course will be displayed:

<img width="1512" alt="Screen Shot 2023-04-23 at 7 49 30 PM" src="https://user-images.githubusercontent.com/122934723/233873122-2ea712cd-a30a-4eef-b212-55002bb86475.png">


You can view a specific course's information by clicking "Show" in that course's row in the list:

<img width="1512" alt="Screen Shot 2023-04-23 at 7 51 09 PM" src="https://user-images.githubusercontent.com/122934723/233873187-b6abb134-dcf4-4cca-b9c5-cff0646daab5.png">


You can also see the list of sections available for each course by clicking "Sections" in that course's row in the list or clicking "Course Sections" while viewing information about that course:

<img width="1511" alt="Screen Shot 2023-04-23 at 7 51 54 PM" src="https://user-images.githubusercontent.com/122934723/233873228-49dfaf04-f179-434d-90d8-23378a0cf664.png">


You can view specific sections in the same way by navigating to the "Sections" page for a specific course.

You are also able to search for courses across all pages in the catalog using the search bar at the top of the catalog list. You can search by course number, name, term, or campus. Enter your search query in the search bar and either hit ENTER or click "Search" to bring up the results of your query.

For example, here is the result of entering "systems" in the search bar and hitting ENTER:

<img width="1512" alt="Screen Shot 2023-04-23 at 7 53 11 PM" src="https://user-images.githubusercontent.com/122934723/233873316-63a9dfdd-b7c2-4bb1-829d-b4722f5e436f.png">


All courses with "systems" in their name will be shown.

Here is the result of entering "autumn" in the search bar:

<img width="1512" alt="Screen Shot 2023-04-23 at 7 53 41 PM" src="https://user-images.githubusercontent.com/122934723/233873339-03d53ae7-da85-4a1c-9a8f-c67894f0fdc5.png">



All courses under the Autumn 2023 term will be shown.

To clear your search filters and get the full list of courses back in your view, simply click "Clear Search" under the search bar.


**NOTE ABOUT REPEATING COURSE ENTRIES:** For certain 5000 level courses such as Capstones, as well as 499X classes, there are seemingly repeated entries of the same course number and term listed in our catalog (although they have different section listings). This is because the API itself lists these courses that way--some of its 5000 level courses have two listings under the same number and term, one for undergaduates and one for graduates. 499X classes have one listing for Honors students and one for non-Honors students. Thus, although they are separate, unique entries in the API and in our database, they appear to be duplicates from our course list view because we have not specified the course career. We plan to make this distinction more clear on the next iteration of the project.

**Grader Applications:**

Students have the ability to submit applications to become graders for course sections. They will be directed to the application dashboard by clicking "Grader Applications" in the menu bar. Students who have not submitted any grader applications for any terms will see a message telling them they have no applications on record. They will also see a link for a "New Application" that will direct them to the application form when clicked. 
Their home page will look like this: 

<img width="1512" alt="Screen Shot 2023-04-23 at 7 55 37 PM" src="https://user-images.githubusercontent.com/122934723/233873446-8c70d6d2-7503-44a6-9d68-03f4bad5471d.png">

Students who have submitted applications previously will see a message with details about their applications. Additionally, a paginated list of previously submitted applications will be displayed. The applicant's name, term applied for, campus applied for, action options to show and delete an application, and the application's status will be listed for each application submitted. They will also see a link for a "New Application" which will direct them to the application form when clicked. 
Their home page will look like this: 

<img width="1512" alt="Screen Shot 2023-04-23 at 7 56 09 PM" src="https://user-images.githubusercontent.com/122934723/233873470-db6629f0-1506-4f15-9403-26eba866b4eb.png">

When a student clicks "Show" for an application, they will be directed to a page which displays all the information submitted in the specified application. It will display the applicants peraonal information, the campus and term the applied for, their availability, the courses they are qualified to grade, and the courses they prefer to grade. They can return to the grader application by selecting "Back to Grader Applications" at the bottom of the page or "Grader Applications" in the menu bar.
The application information page looks like this:

<img width="1512" alt="Screen Shot 2023-04-23 at 7 57 34 PM" src="https://user-images.githubusercontent.com/122934723/233873550-930a5f2d-6809-4145-93ed-2dc27bc7515e.png">

When a student selects "Delete" for an application, they will be prompted with a popup message confirming they are about to delete an application with an option to cancel and an "OK" option to delete the application. Students are not permitted to delete their application after it has been approved and they have been assigned a section to grade. If they wish to renege their application after their application has been apprved, they must contact an administrator.

<img width="1511" alt="Screen Shot 2023-04-23 at 8 08 04 PM" src="https://user-images.githubusercontent.com/122934723/233874183-6de391de-aaaf-45ea-af00-4d2a67f77aeb.png">


If a student wishes to submit a new grader application, they will need to select "New Application" to be directed to the application form. The applicant's name and email will be populated in the form with the name and email associated with their account. Next, they will need to select the term and campus they wish to apply for. Students are only allowed to submit one application per term, so once they have applied for a term, it will not appear as an option for a term to apply for. For example, if a student submitted an application for Spring 2023 and wishes to submit a new application, they will not see Spring 2023 as a possible term to apply for. If a student wishes to make changes to their application, they should delete the previous application and submit a new one or contact an administrator. Next, they can submit information about their availability. For each day (Monday-Friday), they can specify time intervals they are available. If they need to specify more than one interval, they can click the "Add Row" button corresponding to that day. Students will also need to add information about the courses they are qualified to grade. Applicants are expected to enter one course number per text input box for which they are qualified. They can use the "Add Row" feature to input numbers for all CSE courses they have taken at Ohio State. Finally, students can input courses they would prefer to grade. They are expected to enter one course number per input text box with their perferences. They can use the "Add Row" feature to input as many courses as they desire as long as the set of course preferences is a subset of the courses they are qualified for. If an applicant leaves any of the rows blank in the application, they will not be parsed into the database.
A sample application would look as follows: 

<img width="1141" alt="Screen Shot 2023-04-23 at 8 00 38 PM" src="https://user-images.githubusercontent.com/122934723/233873722-7122db2a-d3dd-4fd9-b5fe-31e33760682a.png">

If a student wishes not to submit an application, they can choose an option in their menu bar or select "Back to Grader Applications" at the bottom of the page to be directed to the grader application dashboard. If they wish to submit their aplication, they can select "Submit" at the bottom of the page. Once they select "Submit", they will be redirected to the "Grader Applications" homepage where the submitted application will appear in the grader application list and a success message will be displayed.

<img width="1512" alt="Screen Shot 2023-04-23 at 8 07 23 PM" src="https://user-images.githubusercontent.com/122934723/233874132-b0012b2a-6df0-4a4e-98cb-4fb54122267f.png">


### Instructor Home Page and Actions

If you are an existing, approved instructor, your home page will look like this:
<img width="1512" alt="Screen Shot 2023-04-23 at 8 09 16 PM" src="https://user-images.githubusercontent.com/122934723/233874277-0474d0be-31eb-4108-b5ab-ef8deab74220.png">


As an instructor, you are able to browse the course catalog, view courses and sections, and submit grader reccomendations. The navigation bar in the top-right corner also allows the user to return to this home page from any other page on the website ("Home" button), edit their account ("Edit Account"), or sign out ("Sign Out").

**Browsing the Catalog:**

Clicking "Browse Catalog" from the home screen will bring you to a paginated list of CSE courses that are currently in the database. Relevant information about each course will be displayed:

<img width="1507" alt="Screen Shot 2023-04-23 at 8 10 45 PM" src="https://user-images.githubusercontent.com/122934723/233874366-1e4882d0-419f-4853-bdf6-e0ebe0a7220b.png">


You can view a specific course's information by clicking "Show" in that course's row in the list:

<img width="1512" alt="Screen Shot 2023-04-23 at 8 11 08 PM" src="https://user-images.githubusercontent.com/122934723/233874387-b98a9820-7819-4d09-85ec-21cd09076a68.png">


You can also see the list of sections available for each course by clicking "Sections" in that course's row in the list or clicking "Course Sections" while viewing information about that course:

<img width="1498" alt="Screen Shot 2023-04-23 at 8 12 13 PM" src="https://user-images.githubusercontent.com/122934723/233874453-dba3edb1-ceb8-4408-95ed-f98f946808b3.png">


You can view specific sections in the same way by navigating to the "Sections" page for a specific course.

You are also able to search for courses across all pages in the catalog using the search bar at the top of the catalog list. You can search by course number, name, term, or campus. Enter your search query in the search bar and either hit ENTER or click "Search" to bring up the results of your query.

For example, here is the result of entering "systems" in the search bar and hitting ENTER:

<img width="1509" alt="Screen Shot 2023-04-23 at 8 13 05 PM" src="https://user-images.githubusercontent.com/122934723/233874517-bb5552b8-34fe-45cf-8ebe-8a144c270f39.png">


All courses with "systems" in their name will be shown.

Here is the result of entering "autumn" in the search bar:

<img width="1510" alt="Screen Shot 2023-04-23 at 8 13 44 PM" src="https://user-images.githubusercontent.com/122934723/233874551-cfc071e6-f1ae-49c2-af0a-35c00afa7df0.png">


All courses under the Autumn 2023 term will be shown.

To clear your search filters and get the full list of courses back in your view, simply click "Clear Search" under the search bar.


**NOTE ABOUT REPEATING COURSE ENTRIES:** For certain 5000 level courses such as Capstones, as well as 499X classes, there are seemingly repeated entries of the same course number and term listed in our catalog (although they have different section listings). This is because the API itself lists these courses that way--some of its 5000 level courses have two listings under the same number and term, one for undergaduates and one for graduates. 499X classes have one listing for Honors students and one for non-Honors students. Thus, although they are separate, unique entries in the API and in our database, they appear to be duplicates from our course list view because we have not specified the course career. We plan to make this distinction more clear on the next iteration of the project.

**Grader Reccomendations:**

Instructors also have the option to submit a grader reccomendation and a grader request. They can do this by selecting "Submit a Grader Reccomendation" from the menu bar. They will be directed to a form where they can input course and section information as well as the student to be reccomeneded's email, and a message. Once the desired information is added to the form, they can click "Create Reccomendation" to submit the form. 
An ecample reccomendation form would be:
<img width="1512" alt="Screen Shot 2023-04-23 at 8 17 22 PM" src="https://user-images.githubusercontent.com/122934723/233874775-f3ab9ae3-11ce-47e6-80f7-10f8b5af8b0e.png">

If "Create Reccomendation" is clicked without specifying a student's email or enters a student's email who is not in the database, they will be prompted with a message telling them the student's email was not found and to confirm the email is correct. If the student has not logged into the application yet, they will need to contact the student and re-submit the recomendation form once they have created an account.

<img width="1512" alt="Screen Shot 2023-04-23 at 8 18 48 PM" src="https://user-images.githubusercontent.com/122934723/233874875-c3feb768-b421-404e-9785-dbd2e93b61f1.png">

### Admins and Instructors That Are Pending Approval

**Admins:**

If you are still pending approval as an admin, your home page will look like this:

<img width="1512" alt="Screen Shot 2023-04-23 at 8 19 45 PM" src="https://user-images.githubusercontent.com/122934723/233874930-ccd2f406-e9b3-45ac-a8ba-b65b0cd25c83.png">


You will be unable to approve other requests or reload the database until your signup request is approved.

Your course catalog view will look like this:

<img width="1512" alt="Screen Shot 2023-04-23 at 8 20 07 PM" src="https://user-images.githubusercontent.com/122934723/233874966-5aca7186-4255-4846-b552-75ed8dcb643a.png">


You are also unable to edit, delete, or create courses and sections if you are still pending approval as an admin. You are only able to view courses and sections, as a student would.

**Instructors:**

If you are still pending approval as an instructor, your home page will look like this:

<img width="1512" alt="Screen Shot 2023-04-23 at 8 20 56 PM" src="https://user-images.githubusercontent.com/122934723/233875011-83098b9b-763e-4d71-a33e-15e95349a5f7.png">

Instructors will have the same privelages when browsing the catalog as they will when approved. However, they cannot submit grader reccomendations until they have been approved.


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




