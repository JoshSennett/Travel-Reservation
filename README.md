# Travel-Reservation
Group project on an MySQL database that was managed with JSP

The goal of this project was to create a database that allowed a variety of user types to interact with depending on their status. Customers could search for flights and purchase their tickets, round trip included. Customer representatives could create and edit reservations for guests and also edit information on aircrafts, airports, flights, and response to questions from guests. The admins would be able to compile reports on revenue, create, edit, and delete users, and summarize data collected such as highest yielding customer and most popular flights.

**The code that was written by me was the portion of the customer representatives jobs. It is located in WebContent folder.
This provided functionality for:**
  - Adding editting and deleting aircrafts, airlines, and flights which also recursively deleted other objects that depended on their existence such as tickets.
  - Retrieving the list of passengers on a waiting list for a given flight number and the list of active flights at an airport
  - Making and editting flight reservations for customers that includes dealing with the availability for more seats for people on the waiting list.

Admin Credentials:
	ID: admin
	Password: password

Customer Representative Credentials:
	ID: cusrep
	Password: password

Requirements
  Latest Version of mySQL server
  Latest version of JDK (recommended)

**Additional IMPORTANT information:**
Our group uses an array list, which requires the use of the ‘<‘ and ‘>’ symbol. This can cause issues in eclipse, which can be fixed by changing the eclipse preferences.

Basically, you have to right click on your project, click on properties, select java compiler.
In the java compiler section, the Compiler Compliance level should be set to at least 1.7 (When changing the compliance level, make sure you have a compatible JRE installed and activated).

EQUAL CONTRIBUTION

video link: https://drive.google.com/file/d/1tCNIv0OSV_TU2gjSlar0YlXcMogr8-xe/view?usp=sharing
