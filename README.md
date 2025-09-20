# Library-Management-Database

📚 Library Management Database
📖 Project Overview

This project implements a Library Management System database using MySQL. The goal is to design and build a relational database that can handle essential operations of a library, including managing members, storing books and their authors, handling loans (borrowing and returning books), and enforcing relationships and integrity constraints. This database can be extended into a full application for real-world library systems.

🏗️ Database Schema

The database contains five core tables:

Members 👥

Stores information about library members.

Fields: MemberID, FullName, Email, Phone, JoinDate.

Books 📘

Contains details about books in the library.

Fields: BookID, Title, ISBN, PublishedYear, CopiesAvailable.

Authors ✍️

Stores information about book authors.

Fields: AuthorID, FullName, BirthYear.

BookAuthors 🔗

A many-to-many join table between books and authors.

Fields: BookID, AuthorID.

Loans 📅

Tracks borrowing and returning of books.

Fields: LoanID, MemberID, BookID, LoanDate, ReturnDate, created_at.

🔑 Key Features

✅ Primary keys for unique identification.

✅ Foreign keys for data integrity.

✅ Unique constraints (e.g., email and ISBN must be unique).

✅ Timestamps for tracking join and loan dates.

✅ Sample data inserted for quick testing.

📂 File Structure
Library-Management-Database/
│── librarydb.sql   # SQL script with schema and sample data
│── README.md       # Documentation (this file)

⚙️ How to Run

Open MySQL on your computer (Workbench, CLI, or phpMyAdmin).

Run the SQL script:

mysql -u root -p < librarydb.sql


Switch to the database:

USE LibraryDB;


Verify sample data:

SELECT * FROM Members;
SELECT * FROM Books;
SELECT * FROM Authors;
SELECT * FROM Loans;

📊 Sample Queries
Find all books borrowed by Alice Johnson
SELECT b.Title, l.LoanDate, l.ReturnDate
FROM Loans l
JOIN Members m ON l.MemberID = m.MemberID
JOIN Books b ON l.BookID = b.BookID
WHERE m.FullName = 'Alice Johnson';

List authors and their books
SELECT a.FullName AS Author, b.Title AS Book
FROM Authors a
JOIN BookAuthors ba ON a.AuthorID = ba.AuthorID
JOIN Books b ON ba.BookID = b.BookID;

Count how many books are available
SELECT SUM(CopiesAvailable) AS TotalBooks
FROM Books;

🚀 Future Enhancements

Add fines for overdue loans.

Add staff and admin roles.

Track reservations for unavailable books.

Build a frontend app (React, Vue, or Angular) with this DB.

