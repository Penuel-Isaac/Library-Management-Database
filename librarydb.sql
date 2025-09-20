-- Safe reset: remove existing DB then recreate (avoids "database exists" warnings)
DROP DATABASE IF EXISTS LibraryDB;
CREATE DATABASE LibraryDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE LibraryDB;

-- Members: use TIMESTAMP for join date (CURRENT_TIMESTAMP is valid)
CREATE TABLE IF NOT EXISTS Members (
    MemberID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(20),
    JoinDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Books
CREATE TABLE IF NOT EXISTS Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(200) NOT NULL,
    ISBN VARCHAR(20) UNIQUE NOT NULL,
    PublishedYear INT,
    CopiesAvailable INT DEFAULT 1
) ENGINE=InnoDB;

-- Authors
CREATE TABLE IF NOT EXISTS Authors (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    BirthYear INT
) ENGINE=InnoDB;

-- BookAuthors (many-to-many)
CREATE TABLE IF NOT EXISTS BookAuthors (
    BookID INT NOT NULL,
    AuthorID INT NOT NULL,
    PRIMARY KEY (BookID, AuthorID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE CASCADE,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Loans: use DATETIME for LoanDate (avoid DATE DEFAULT CURRENT_DATE syntax issues)
CREATE TABLE IF NOT EXISTS Loans (
    LoanID INT AUTO_INCREMENT PRIMARY KEY,
    MemberID INT NOT NULL,
    BookID INT NOT NULL,
    LoanDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ReturnDate DATETIME NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID) ON DELETE CASCADE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Sample data
INSERT INTO Members (FullName, Email, Phone) VALUES
('Alice Johnson', 'alice@example.com', '08012345678'),
('Bob Smith', 'bob@example.com', '08098765432');

INSERT INTO Authors (FullName, BirthYear) VALUES
('Chinua Achebe', 1930),
('Wole Soyinka', 1934);

INSERT INTO Books (Title, ISBN, PublishedYear, CopiesAvailable) VALUES
('Things Fall Apart', '9781234567890', 1958, 5),
('The Man Died', '9780987654321', 1972, 3);

INSERT INTO BookAuthors (BookID, AuthorID) VALUES
(1, 1),
(2, 2);

-- Loan entries (LoanDate can be a date or full datetime; here we use simple dates which MySQL will coerce)
INSERT INTO Loans (MemberID, BookID, LoanDate) VALUES
(1, 1, '2025-09-20 10:00:00'),
(2, 2, '2025-09-19 14:30:00');

-- Quick checks (optional)
SELECT COUNT(*) AS MembersCount FROM Members;
SELECT COUNT(*) AS BooksCount FROM Books;
SELECT COUNT(*) AS AuthorsCount FROM Authors;
SELECT * FROM Loans LIMIT 10;
