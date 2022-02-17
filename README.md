# Student Enrollment System

This repo is for a Student Enrollment System that can be used in schools. It provides the following features:
- Student, Instructor log in
- Students can enroll in, drop courses
- Instructors can create and delete courses
- Instructors can view the students enrolled and waitlisted in their course.
- Students can be added to the waitlist for a course if there is space on the waitlist(provided instructor has enabled waitlist).
- Students are automatically enrolled from the waitlist into the course if another enrolled student drops the course.

### Team members
Ankur Mundra (amundra@ncsu.edu)

Shruti Satish Magai (smagai@ncsu.edu)

Sri Athithya Kruth Babu (sbabu@ncsu.edu)

## Admin Credentials
These are the admin credentials provided by default when the application is launched.

**Email**: admin@example.com

**Password**: admin123

## How to Test Features

Please create instructors first by clicking on "Instructor" on the top of the web app. Using the instructor, you can create courses for the application.

Then please create students who can be enrolled in the courses, and dropped later depending on the requirements.

## Edge-cases 
- Admin deletes course taken by several students.
Cascading delete will remove all of the students from the course in question. The course will of course be deleted.

- Instructor deletes course taken by several students.
Cascading delete will remove all of the students from the course in question. The course will of course be deleted.

- Admin deletes an Instructor with courses taken by several students.
Cascading delete will remove all of the students from all of the courses created by the instructor in question, and the courses will also be deleted.

- Students can only be added to the waitlist for a course when the capacity of the course has been fully used. 

- If a student who is enrolled in a course drops the course, the student who joined the waitlist first will be enrolled in their place.

- If the capacity of the course is full i.e all the seats have been taken by students, then the status of the course changes to "WAITLIST" if the instructor has allowed a waitlist for the course. 

- If the capacity of the course is full and there is not waitlist capcaity allocated for the course, the course is moved to the "CLOSED" state.

- If an enrolled student drops a course with a waitlist, then the earliest student on the waitlist is enrolled.

- Student cannot see the instructor profiles, or the profiles of other students.

- Students cannot enroll in courses, or drop courses without being authenticated. 

- Instructors can see only the courses they have created, and cannot see the courses created by other instructors. They also cannot view the lists of students of courses from other instructors.

- Admin email cannot be edited.
