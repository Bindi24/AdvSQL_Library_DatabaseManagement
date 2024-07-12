
/*****************************************************ADVANCE SQL PROJECT *****************************************************************************************/
---------------------------------------------------LIBRARY DATABASE MANAGEMENT-------------------------------------------------------------------------------------

/*==============Created database==============================*/

CREATE DATABASE db_librarymanagement
GO

USE db_librarymanagement
GO

DROP DATABASE db_librarymanagement
GO


/*===============Created tables===============================*/

/*•	tbl_publisher
•	tbl_book
•	tbl_library_branch
•	tbl_borrower
•	tbl_book_loans
•	tbl_book_copies
•	tbl_book_authors*/

CREATE TABLE tbl_publisher (
    publisher_PublisherName VARCHAR(100),
    publisher_PublisherAddress VARCHAR(200),
    publisher_PublisherPhone VARCHAR(50),
    CONSTRAINT PK_PublisherName PRIMARY KEY (publisher_PublisherName)
)
GO

CREATE TABLE tbl_book (
    book_BookID INT IDENTITY,
    book_Title VARCHAR(100),
    book_PublisherName VARCHAR(100),
    CONSTRAINT PK_BookID PRIMARY KEY (book_BookID),
    CONSTRAINT FK_PublisherName FOREIGN KEY (book_PublisherName) REFERENCES tbl_publisher(publisher_PublisherName) ON UPDATE CASCADE ON DELETE CASCADE
)
GO

CREATE TABLE tbl_book_authors (
    book_authors_AuthorID INT IDENTITY,
    book_authors_BookID INT,
    book_authors_AuthorName VARCHAR(50),
    CONSTRAINT PK_AuthorID PRIMARY KEY (book_authors_AuthorID),
    CONSTRAINT FK_Author_BookID FOREIGN KEY (book_authors_BookID) REFERENCES tbl_book(book_BookID) ON UPDATE CASCADE ON DELETE CASCADE
)
GO

CREATE TABLE tbl_library_branch (
    library_branch_BranchID INT IDENTITY(1,1),
    library_branch_BranchName VARCHAR(50) NOT NULL,
    library_branch_BranchAddress VARCHAR(100) NOT NULL,
    CONSTRAINT PK_BranchID PRIMARY KEY (library_branch_BranchID)
)
GO

CREATE TABLE tbl_book_copies (
    book_copies_CopiesID INT IDENTITY(1000,1),
    book_copies_BookID INT,
    book_copies_BranchID INT,
    book_copies_No_Of_Copies INT,
    CONSTRAINT PK_CopiesID PRIMARY KEY (book_copies_CopiesID),
    CONSTRAINT FK_BookID FOREIGN KEY (book_copies_BookID) REFERENCES tbl_book(book_BookID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT FK_BranchID FOREIGN KEY (book_copies_BranchID) REFERENCES tbl_library_branch(library_branch_BranchID) ON UPDATE CASCADE ON DELETE CASCADE
)
GO

CREATE TABLE tbl_borrower (
    borrower_CardNo INT IDENTITY(100,1),
    borrower_BorrowerName VARCHAR(50),
    borrower_BorrowerAddress VARCHAR(100),
    borrower_BorrowerPhone VARCHAR(15),
    CONSTRAINT PK_borrower_CardNo PRIMARY KEY (borrower_CardNo)
)
GO

CREATE TABLE tbl_book_loans (
    book_loans_LoanID INT IDENTITY(1000,1) CONSTRAINT PK_LoanID PRIMARY KEY,
    book_loans_BookID INT CONSTRAINT FK_Loans_BookID FOREIGN KEY REFERENCES tbl_book(book_BookID) ON UPDATE CASCADE ON DELETE CASCADE,
    book_loans_BranchID INT CONSTRAINT FK_loans_BranchID FOREIGN KEY REFERENCES tbl_library_branch(library_branch_BranchID) ON UPDATE CASCADE ON DELETE CASCADE,
    book_loans_CardNo INT CONSTRAINT FK_loans_CardNo FOREIGN KEY REFERENCES tbl_borrower(borrower_CardNo) ON UPDATE CASCADE ON DELETE CASCADE,
    book_loans_DateOut DATE,
    book_loans_DueDate DATE
)
GO

/*===============================================Populate Tables===================================================*/

INSERT INTO tbl_publisher
		(publisher_PublisherName, publisher_PublisherAddress, publisher_PublisherPhone)
		VALUES
		('DAW Books','375 Hudson Street, New York, NY 10014','212-366-2000'),
		('Viking','375 Hudson Street, New York, NY 10014','212-366-2000'),
		('Signet Books','375 Hudson Street, New York, NY 10014','212-366-2000'),
		('Chilton Books','Not Available','Not Available'),
		('George Allen & Unwin','83 Alexander Ln, Crows Nest NSW 2065, Australia','+61-2-8425-0100'),
		('Alfred A. Knopf','The Knopf Doubleday Group Domestic Rights, 1745 Broadway, New York, NY 10019','212-940-7390'),		
		('Bloomsbury','Bloomsbury Publishing Inc., 1385 Broadway, 5th Floor, New York, NY 10018','212-419-5300'),
		('Shinchosa','Oga Bldg. 8, 2-5-4 Sarugaku-cho, Chiyoda-ku, Tokyo 101-0064 Japan','+81-3-5577-6507'),
		('Harper and Row','HarperCollins Publishers, 195 Broadway, New York, NY 10007','212-207-7000'),
		('Pan Books','175 Fifth Avenue, New York, NY 10010','646-307-5745'),
		('Chalto & Windus','375 Hudson Street, New York, NY 10014','212-366-2000'),
		('Harcourt Brace Jovanovich','3 Park Ave, New York, NY 10016','212-420-5800'),
		('W.W. Norton',' W. W. Norton & Company, Inc., 500 Fifth Avenue, New York, New York 10110','212-354-5500'),
		('Scholastic','557 Broadway, New York, NY 10012','800-724-6527'),
		('Bantam','375 Hudson Street, New York, NY 10014','212-366-2000'),
		('Picador USA','175 Fifth Avenue, New York, NY 10010','646-307-5745')		
GO

SELECT * FROM tbl_publisher
GO

INSERT INTO tbl_book
		(book_Title, book_PublisherName)
		VALUES 
		('The Name of the Wind', 'DAW Books'),
		('It', 'Viking'),
		('The Green Mile', 'Signet Books'),
		('Dune', 'Chilton Books'),
		('The Hobbit', 'George Allen & Unwin'),
		('Eragon', 'Alfred A. Knopf'),
		('A Wise Mans Fear', 'DAW Books'),
		('Harry Potter and the Philosophers Stone', 'Bloomsbury'),
		('Hard Boiled Wonderland and The End of the World', 'Shinchosa'),
		('The Giving Tree', 'Harper and Row'),
		('The Hitchhikers Guide to the Galaxy', 'Pan Books'),
		('Brave New World', 'Chalto & Windus'),
		('The Princess Bride', 'Harcourt Brace Jovanovich'),
		('Fight Club', 'W.W. Norton'),
		('Holes', 'Scholastic'),
		('Harry Potter and the Chamber of Secrets', 'Bloomsbury'),
		('Harry Potter and the Prisoner of Azkaban', 'Bloomsbury'),
		('The Fellowship of the Ring', 'George Allen & Unwin'),
		('A Game of Thrones', 'Bantam'),
		('The Lost Tribe', 'Picador USA')
GO

SELECT * FROM tbl_book
GO

INSERT INTO tbl_book_authors 
		(book_authors_BookID,book_authors_AuthorName)
		VALUES
		('1','Patrick Rothfuss'),
		('2','Stephen King'),
		('3','Stephen King'),
		('4','Frank Herbert'),
		('5','J.R.R. Tolkien'),
		('6','Christopher Paolini'),
		('7','Patrick Rothfuss'),
		('8','J.K. Rowling'),
		('9','Haruki Murakami'),
		('10','Shel Silverstein'),
		('11','Douglas Adams'),
		('12','Aldous Huxley'),
		('13','William Goldman'),
		('14','Chuck Palahniuk'),
		('15','Louis Sachar'),
		('16','J.K. Rowling'),
		('17','J.K. Rowling'),
		('18','J.R.R. Tolkien'),
		('19','George R.R. Martin'),
		('20','Mark Lee')
GO

SELECT * FROM tbl_book_authors
GO

INSERT INTO tbl_library_branch
    (library_branch_BranchName, library_branch_BranchAddress)
	VALUES
    ('Sharpstown', '32 Corner Road, New York, NY 10012'),
    ('Central', '491 3rd Street, New York, NY 10014'),
    ('Saline', '40 State Street, Saline, MI 48176'),
    ('Ann Arbor', '101 South University, Ann Arbor, MI 48104')
GO

SELECT * FROM tbl_library_branch
GO

INSERT INTO tbl_book_copies
(book_copies_BookID, book_copies_BranchID, book_copies_No_Of_Copies)
VALUES
		('1','1','5'),
		('2','1','8'),
		('3','1','3'),
		('4','1','6'),
		('5','1','7'),
		('6','1','2'),
		('7','1','4'),
		('8','1','9'),
		('9','1','1'),
		('10','1','10'),
		('11','1','5'),
		('12','1','5'),
		('13','1','5'),
		('14','1','5'),
		('15','1','5'),
		('16','1','5'),
		('17','1','5'),
		('18','1','5'),
		('19','1','5'),
		('20','1','5'),
		('1','2','5'),
		('2','2','5'),
		('3','2','5'),
		('4','2','5'),
		('5','2','5'),
		('6','2','5'),
		('7','2','5'),
		('8','2','5'),
		('9','2','5'),
		('10','2','5'),
		('11','2','5'),
		('12','2','5'),
		('13','2','5'),
		('14','2','5'),
		('15','2','5'),
		('16','2','5'),
		('17','2','5'),
		('18','2','5'),
		('19','2','5'),
		('20','2','5'),
		('1','3','5'),
		('2','3','5'),
		('3','3','5'),
		('4','3','5'),
		('5','3','5'),
		('6','3','5'),
		('7','3','5'),
		('8','3','5'),
		('9','3','5'),
		('10','3','5'),
		('11','3','5'),
		('12','3','5'),
		('13','3','5'),
		('14','3','5'),
		('15','3','5'),
		('16','3','5'),
		('17','3','5'),
		('18','3','5'),
		('19','3','5'),
		('20','3','5'),
		('1','4','5'),
		('2','4','5'),
		('3','4','5'),
		('4','4','5'),
		('5','4','5'),
		('6','4','5'),
		('7','4','5'),
		('8','4','5'),
		('9','4','5'),
		('10','4','5'),
		('11','4','5'),
		('12','4','5'),
		('13','4','5'),
		('14','4','5'),
		('15','4','5'),
		('16','4','5'),
		('17','4','5'),
		('18','4','5'),
		('19','4','5'),
		('20','4','5')
GO

SELECT * FROM tbl_book_copies
GO

INSERT INTO tbl_borrower
		(borrower_BorrowerName, borrower_BorrowerAddress, borrower_BorrowerPhone)
		VALUES
		('Joe Smith','1321 4th Street, New York, NY 10014','212-312-1234'),
		('Jane Smith','1321 4th Street, New York, NY 10014','212-931-4124'),
		('Tom Li','981 Main Street, Ann Arbor, MI 48104','734-902-7455'),
		('Angela Thompson','2212 Green Avenue, Ann Arbor, MI 48104','313-591-2122'),
		('Harry Emnace','121 Park Drive, Ann Arbor, MI 48104','412-512-5522'),
		('Tom Haverford','23 75th Street, New York, NY 10014','212-631-3418'),
		('Haley Jackson','231 52nd Avenue New York, NY 10014','212-419-9935'),
		('Michael Horford','653 Glen Avenue, Ann Arbor, MI 48104','734-998-1513')
GO
	
SELECT * FROM tbl_borrower
GO

INSERT INTO tbl_book_loans
		(book_loans_BookID, book_loans_BranchID, book_loans_CardNo, book_loans_DateOut, book_loans_DueDate)
		VALUES
		('1','1','100','1/1/18','2/2/18'),
		('2','1','100','1/1/18','2/2/18'),
		('3','1','100','1/1/18','2/2/18'),
		('4','1','100','1/1/18','2/2/18'),
		('5','1','102','1/3/18','2/3/18'),
		('6','1','102','1/3/18','2/3/18'),
		('7','1','102','1/3/18','2/3/18'),
		('8','1','102','1/3/18','2/3/18'),
		('9','1','102','1/3/18','2/3/18'),
		('11','1','102','1/3/18','2/3/18'),
		('12','2','105','12/12/17','1/12/18'),
		('10','2','105','12/12/17','1/12/18'),
		('20','2','105','2/3/18','3/3/18'),
		('18','2','105','1/5/18','2/5/18'),
		('19','2','105','1/5/18','2/5/18'),
		('19','2','100','1/3/18','2/3/18'),
		('11','2','106','1/7/18','2/7/18'),
		('1','2','106','1/7/18','2/7/18'),
		('2','2','100','1/7/18','2/7/18'),
		('3','2','100','1/7/18','2/7/18'),
		('5','2','105','12/12/17','1/12/18'),
		('4','3','103','1/9/18','2/9/18'),
		('7','3','102','1/3/18','2/3/18'),
		('17','3','102','1/3/18','2/3/18'),
		('16','3','104','1/3/18','2/3/18'),
		('15','3','104','1/3/18','2/3/18'),
		('15','3','107','1/3/18','2/3/18'),
		('14','3','104','1/3/18','2/3/18'),
		('13','3','107','1/3/18','2/3/18'),
		('13','3','102','1/3/18','2/3/18'),
		('19','3','102','12/12/17','1/12/18'),
		('20','4','103','1/3/18','2/3/18'),
		('1','4','102','1/12/18','2/12/18'),
		('3','4','107','1/3/18','2/3/18'),
		('18','4','107','1/3/18','2/3/18'),
		('12','4','102','1/4/18','2/4/18'),
		('11','4','103','1/15/18','2/15/18'),
		('9','4','103','1/15/18','2/15/18'),
		('7','4','107','1/1/18','2/2/18'),
		('4','4','103','1/1/18','2/2/18'),
		('1','4','103','2/2/17','3/2/18'),
		('20','4','103','1/3/18','2/3/18'),
		('1','4','102','1/12/18','2/12/18'),
		('3','4','107','1/13/18','2/13/18'),
		('18','4','107','1/13/18','2/13/18'),
		('12','4','102','1/14/18','2/14/18'),
		('11','4','103','1/15/18','2/15/18'),
		('9','4','103','1/15/18','2/15/18'),
		('7','4','107','1/19/18','2/19/18'),
		('4','4','103','1/19/18','2/19/18'),
		('1','4','103','1/22/18','2/22/18')
GO
		
SELECT * FROM tbl_book_loans
GO

/*================================================================Questions and Answers========================================================*/


/*1.	Find the titles of all books published by "Bloomsbury."*/

SELECT *
FROM 
	tbl_book
WHERE 
	UPPER(book_PublisherName) = 'BLOOMSBURY'
GO
/*COMMENTS: 
This query will retrieve all rows from the tbl_book table where the book_PublisherName column contains the value 'Bloomsbury'.*/

/* 2.	List the names of borrowers whose phone numbers start with the area code "212." */

SELECT 
	borrower_BorrowerName, borrower_BorrowerPhone
FROM 
	tbl_borrower
WHERE 
	borrower_BorrowerPhone LIKE '212%'
GO
/*COMMENTS: 
This query will retrieve all rows from the tbl_borrower table where the borrower_BorrowerPhone column starts with '212'. 
The % wildcard in the LIKE operator matches any sequence of characters, so '212%' will match any phone numbers starting with '212'.*/


/* 3.	Retrieve the titles of books with more than 10 copies available.*/

SELECT * FROM tbl_book_copies;
SELECT * FROM tbl_book;

SELECT 
	book_copies_BookID, 
	book_Title, 
	SUM(book_copies_No_Of_Copies) as Total_Copies 
FROM 
	tbl_book_copies as c
JOIN 
	tbl_book as b ON c.book_copies_BookID = b.book_BookID
GROUP BY 
	book_copies_BookID, book_Title 
HAVING 
	SUM(book_copies_No_Of_Copies) > 10
GO
/*COMMENTS:
It selects book_copies_BookID, b.book_Title, and calculates the sum of book_copies_No_of_Copies as Total_Copies.
It uses an inner join between tbl_book_copies (aliased as c) and tbl_book (aliased as b) based on matching book_copies_BookID and book_BookID.
The result is grouped by book_copies_BookID and b.book_Title.
The HAVING clause filters the grouped results to only include rows where the sum of book_copies_No_of_Copies is greater than 10.*/


/* 4.	Display the names of borrowers who have borrowed books from the "Central" branch.*/
SELECT * FROM tbl_borrower
SELECT * FROM tbl_library_branch
SELECT * FROM tbl_book_loans

SELECT 
	library_branch_BranchName, 
	borrower_BorrowerName
FROM 
	tbl_library_branch AS l
JOIN 
	tbl_book_loans AS b ON l.library_branch_BranchID = b.book_loans_BranchID
JOIN 
	tbl_borrower AS br ON b.book_loans_CardNo = br.borrower_CardNo
WHERE 
	library_branch_BranchID = 2
GROUP BY 
	library_branch_BranchName, borrower_BorrowerName;
GO
/*COMMENTS:
SELECT clause:It selects library_branch_BranchName from tbl_library_branch and borrower_borrowerName from tbl_borrower.
JOINS:It performs an inner join between tbl_library_branch (aliased as l) and tbl_book_loans (aliased as b) based on library_branch_BranchID and book_loans_BranchID.
Then, it performs another inner join between tbl_book_loans (aliased as b) and tbl_borrower (aliased as br) based on book_loans_CardNo and borrower_CardNo.
WHERE clause:It filters the results to only include rows where library_branch_BranchID is equal to 2.
GROUP BY clause:It groups the results by library_branch_BranchName and borrower_borrowerName.*/


/* 5.	List the titles of books borrowed by borrower "Joe Smith."*/
SELECT * FROM tbl_borrower
SELECT * FROM tbl_book_loans
SELECT * FROM tbl_book

SELECT 
	book_Title
FROM 
	tbl_borrower AS br
JOIN 
	tbl_book_loans AS bl ON br.borrower_CardNo = bl.book_loans_CardNo
JOIN 
	tbl_book AS bo ON bl.book_loans_BookID = bo.book_BookID
WHERE 
	borrower_BorrowerName = 'Joe Smith'
GROUP BY 
	book_Title
GO
/*This SQL query retrieves borrower_BorrowerName from tbl_borrower and book_Title from tbl_book, 
with an inner join on tbl_book_loans. It's filtered to only include rows where the borrower_BorrowerName is 
'Joe Smith', and then it's grouped by borrower_BorrowerName and book_Title.*/

--OR--

SELECT 
	book_BookID,
    book_Title    
FROM 
    [dbo].[tbl_book]
WHERE 
    book_BookID IN (
        SELECT 
            bl.book_loans_BookID
        FROM 
            [dbo].[tbl_book_loans] bl
        WHERE 
            bl.book_loans_CardNo IN (
                SELECT 
                    borrower_CardNo 
                FROM 
                    [dbo].[tbl_borrower] 
                WHERE 
                    borrower_BorrowerName = 'Joe Smith'
            )
    );

/*6.	Find the names of publishers for the books authored by "J.K. Rowling."*/
SELECT * FROM tbl_book_authors
SELECT * FROM tbl_book

--METHOD 1
SELECT 
	book_authors_AuthorName, 
	book_PublisherName
FROM 
	tbl_book_authors AS a
JOIN 
	tbl_book AS b ON a.book_authors_BookID = b.book_BookID
WHERE 
	book_authors_AuthorName = 'J.K. Rowling'
GROUP BY	
	book_authors_AuthorName, 
	book_PublisherName;
/*COMMENTS:
This SQL query selects book_authors_AuthorName from tbl_book_authors and book_PublisherName from tbl_book, with an inner join on tbl_book. 
It's filtered to only include rows where the book_authors_AuthorName is 'J.K. Rowling', and then it's grouped by book_authors_AuthorName and book_PublisherName.*/

--METHOD 2
SELECT 
    b.book_PublisherName
FROM 
    [dbo].[tbl_book] b
WHERE 
    b.book_BookID IN (
        SELECT ba.book_authors_BookID
        FROM [dbo].[tbl_book_authors] ba
        WHERE UPPER(ba.book_authors_AuthorName) = 'J.K. ROWLING'
    )
GROUP BY 
	b.book_PublisherName


/*7.	Count the total number of books available in the library.*/

SELECT 
	SUM(book_copies_No_Of_Copies) AS Total_Number_of_Books
FROM 
	tbl_book_copies;

/* 8.	Calculate the average number of copies available per book across all branches.*/
SELECT * FROM tbl_book_copies

--METHOD 1
SELECT 
    distinct(book_copies_BookID),
    AVG(book_copies_No_Of_Copies) OVER (PARTITION BY[book_copies_BookID] ) AS AvgCopiesPerBook
FROM 
    [dbo].[tbl_book_copies]

--METHOD 2
SELECT 
	book_copies_BookID, 
	AVG(book_copies_No_Of_Copies) AS Average_number_of_Copies
FROM 
	tbl_book_copies
GROUP BY 
	book_copies_BookID
/*COMMENTS:
This SQL query calculates the average number of copies for each book (book_copies_BookID) by using the AVG aggregate function on the book_copies_No_Of_Copies column in the tbl_book_copies table. 
The result is grouped by book_copies_BookID, showing the average number of copies for each book.*/


/* 9.	Find the branch with the highest number of books loaned out.*/
SELECT * FROM tbl_library_branch
SELECT * FROM tbl_book_loans

SELECT 
	TOP 1 book_loans_BranchID, 
	library_branch_BranchName, 
	COUNT(*) AS Total_Books_loaned
FROM 
	tbl_book_loans AS bl
JOIN 
	tbl_library_branch AS lb ON bl.book_loans_BranchID = lb.library_branch_BranchID
GROUP BY 
	book_loans_BranchID, library_branch_BranchName
ORDER BY 
	Total_Books_loaned DESC;
/*COMMENTS:
This SQL query retrieves the branch ID (book_loans_BranchID), branch name (library_branch_BranchName), and the count of books loaned (Total_Books_loaned) 
from the tbl_book_loans table joined with the tbl_library_branch table. It groups the results by branch ID and branch name, then orders the results by the count of books loaned in descending order (DESC). 
Finally, it selects only the top 1 result, which corresponds to the branch with the highest number of books loaned*/

/* 10.	Insert a new book titled "The Catcher in the Rye" by "J.D. Salinger" into the database.*/

SET IDENTITY_INSERT tbl_book ON;-- Enable identity insert for tbl_book

INSERT INTO tbl_book (book_BookID, book_Title)-- Insert a specific value into tbl_book
VALUES (21, 'The Catcher in the Rye');

SET IDENTITY_INSERT tbl_book OFF;-- Disable identity insert for tbl_book

SELECT * FROM tbl_book;-- Select all rows from tbl_book to verify the insertion
/***********************************************/

SET IDENTITY_INSERT tbl_book_authors ON;

INSERT INTO tbl_book_authors (book_authors_AuthorID, book_authors_BookID, book_authors_AuthorName)
VALUES (21, 21, 'J.D. Salinger');

SET IDENTITY_INSERT tbl_book_authors OFF;

SELECT * FROM tbl_book_authors;


/* 11.	Update the address of the "Sharpstown" library branch to "45 West Side Avenue, New York, NY 10012."*/

SELECT * FROM tbl_library_branch;

UPDATE 
	tbl_library_branch
SET 
	library_branch_BranchAddress = '45 West Side Avenue, New York, NY 10012'
WHERE 
	library_branch_BranchName = 'Sharpstown';
/*COMMENTS:
This query updates the library_branch_BranchAddress to '45 West Side Avenue, New York, NY 10012' for the branch named 'Sharpstown' in the tbl_library_branch table.*/


/* 12.	Remove all books published by "Pan Books" from the database.*/

DELETE FROM tbl_book
WHERE book_PublisherName = 'Pan Books';

SELECT * FROM tbl_book;
SELECT * FROM tbl_book_copies;
SELECT * FROM tbl_book_loans;
/*COMMENTS:
This query deletes rows from the tbl_book table where the book_PublisherName is 'Pan Books'.
Then the delete operation on tbl_book will automatically delete related records as per foreign key constraints*/


/*13.	Retrieve the names of borrowers who have borrowed the same book more than once.*/

SELECT * FROM tbl_borrower
SELECT * FROM tbl_book_loans

SELECT 
	borrower_BorrowerName, 
	book_loans_BookID, 
	COUNT(book_loans_CardNo) as NumberOfTimes_BooksBorrowed
FROM 
	tbl_borrower AS b
JOIN 
	tbl_book_loans AS bl ON b.borrower_CardNo = bl.book_loans_CardNo
GROUP BY 
	borrower_BorrowerName, book_loans_BookID
HAVING 
	COUNT(bl.book_loans_CardNo) > 1;

--OR--

SELECT
	DISTINCT(borrower_BorrowerName)
FROM 
	tbl_borrower b
JOIN 
	tbl_book_loans AS bl ON b.borrower_CardNo = bl.book_loans_CardNo
GROUP BY 
	borrower_BorrowerName, book_loans_BookID
HAVING 
	COUNT(bl.book_loans_CardNo) > 1;
/*COMMENTS:
This query retrieves the borrower's name (borrower_BorrowerName), the book ID (book_loans_BookID), 
and the count of times the book was borrowed (NumberOfTimes_BooksBorrowed) from the tbl_borrower and tbl_book_loans tables. 
It's grouped by borrower name and book ID, and it uses the HAVING clause to filter only those records where the count of borrowed cards is greater than 1, 
indicating that the book has been borrowed multiple times by the same borrower.*/

/*14.	Find the title of the book with the earliest due date.*/

SELECT * FROM tbl_book_loans
SELECT * FROM tbl_book

SELECT
	book_Title, 
	book_loans_DueDate AS Earliest_Duedate
FROM 
	tbl_book_loans AS bl
INNER JOIN 
	tbl_book AS b ON bl.book_loans_BookID = b.book_BookID
WHERE bl.book_loans_DueDate = (
    SELECT MIN(book_loans_DueDate)
    FROM tbl_book_loans
)
GROUP BY 
	book_Title,
	book_loans_DueDate;
/*COMMENTS:
This query retrieves the book title (book_Title) and the earliest due date (Earliest_Duedate) from the tbl_book_loans and tbl_book tables. 
It uses an inner join on the book ID between the two tables and filters the results to only include records where the due date matches the minimum due date 
found in the entire tbl_book_loans table. The GROUP BY clause groups non aggregate items.*/


/*15.	List the names of borrowers who have borrowed books authored by both "Stephen King" and "J.K. Rowling."*/
SELECT * FROM tbl_borrower
SELECT * FROM tbl_book_loans
SELECT * FROM tbl_book_authors

SELECT 
	borrower_BorrowerName, 
	COUNT(bl.book_loans_BookID) as Total_books_borrowed, 
	book_authors_AuthorName
FROM 
	tbl_borrower AS b
JOIN 
	tbl_book_loans AS bl ON b.borrower_CardNo = bl.book_loans_CardNo
JOIN 
	tbl_book_authors AS ba ON bl.book_loans_BookID = ba.book_authors_BookID
WHERE 
	ba.book_authors_AuthorName ='Stephen King' AND ba.book_authors_AuthorName ='J.K. Rowling'
GROUP BY 
	borrower_BorrowerName, book_authors_AuthorName;

/* OR*/

SELECT 
	b.borrower_BorrowerName
FROM 
	tbl_borrower b
JOIN 
	tbl_book_loans bl ON b.borrower_CardNo = bl.book_loans_CardNo
JOIN 
	tbl_book_authors ba ON bl.book_loans_BookID = ba.book_authors_BookID
WHERE
	(ba.book_authors_AuthorName = 'Stephen King' AND b.borrower_CardNo IN (
        SELECT bl2.book_loans_CardNo
        FROM tbl_book_loans bl2
        INNER JOIN tbl_book_authors ba2 ON bl2.book_loans_BookID = ba2.book_authors_BookID
        WHERE ba2.book_authors_AuthorName = 'J.K. Rowling'
    ))
    AND
    (ba.book_authors_AuthorName = 'J.K. Rowling' AND b.borrower_CardNo IN (
        SELECT bl3.book_loans_CardNo
        FROM tbl_book_loans bl3
        INNER JOIN tbl_book_authors ba3 ON bl3.book_loans_BookID = ba3.book_authors_BookID
        WHERE ba3.book_authors_AuthorName = 'Stephen King'
    ));
/*COMMENTS:
This query uses two subqueries within the WHERE clause to find borrowers who have borrowed books from both 'Stephen King' and 'J.K. Rowling'.*/

/* 16.	Find the names of borrowers who have borrowed books published by "Bloomsbury.*/
SELECT * FROM  tbl_borrower
SELECT * FROM  tbl_book_loans
SELECT * FROM  tbl_book

--METHOD 1
SELECT 
	borrower_BorrowerName,
	borrower_CardNo
FROM 
	[dbo].[tbl_borrower] 
WHERE 
	borrower_CardNo IN (
	SELECT 
		book_loans_CardNo
	FROM 
		[dbo].[tbl_book_loans] 
	WHERE 
		book_loans_BookID IN (
			SELECT 
				book_BookID
			FROM
				[dbo].[tbl_book]
			WHERE
				book_PublisherName = 'Bloomsbury'
				)
			);

--METHOD 2
SELECT 
	br.borrower_BorrowerName 
FROM 
	tbl_borrower AS br
JOIN 
	tbl_book_loans AS bl ON br.borrower_CardNo = bl.book_loans_CardNo
JOIN 
	tbl_book AS bo ON bl.book_loans_BookID = bo.book_BookID
WHERE 
	bo.book_PublisherName = 'Bloomsbury'
GROUP BY 
	br.borrower_BorrowerName
/*COMMENTS:
This query retrieves the borrower's name (borrower_BorrowerName), counts the number of books borrowed (Total_books_borrowed), 
and includes the publisher's name (book_PublisherName) from the tbl_borrower, tbl_book_loans, and tbl_book tables. 
It then filters the results to only include records where the book's publisher is 'Bloomsbury' and groups the results by borrower name and publisher name.*/


/*17.	Retrieve the titles of books borrowed by borrowers located in New York.*/
SELECT * FROM  tbl_book
SELECT * FROM  tbl_book_loans
SELECT * FROM  tbl_borrower

--METHOD 1:
	
SELECT 
    book_Title,
    book_BookID
FROM 
    [dbo].[tbl_book]
WHERE
    book_BookID IN (
        SELECT 
            book_loans_BookID
        FROM 
            [dbo].[tbl_book_loans]
        WHERE 
            book_loans_CardNo IN (
                SELECT 
                    borrower_CardNo
                FROM 
                    [dbo].[tbl_borrower]
                WHERE 
                    borrower_BorrowerAddress LIKE '%NY%'
            )
    )
ORDER BY 
    book_Title;

--METHOD 2:
SELECT 
	book_Title
FROM 
	tbl_book AS bo
INNER JOIN 
	tbl_book_loans AS bl ON bo.book_BookID = bl.book_loans_BookID
INNER JOIN 
	tbl_borrower AS br ON bl.book_loans_CardNo = br.borrower_CardNo
WHERE 
	borrower_BorrowerAddress LIKE '%NY%'
GROUP BY 
	book_Title
ORDER BY 
	book_Title

/*COMMENTS:
This query retrieves the borrower's name (borrower_BorrowerName), the title of the borrowed book (book_Title), and the borrower's address (borrower_BorrowerAddress) 
from the tbl_book, tbl_book_loans, and tbl_borrower tables. It filters the results to include only addresses containing '%NY%' (indicating they are in New York), 
groups the results by book title, borrower name, and borrower address, and then orders the results by borrower name.*/

/*18.	Calculate the average number of books borrowed per borrower.*/
SELECT * FROM  tbl_borrower;
SELECT * FROM  tbl_book_loans;

/*SELECT 
    AVG(BooksBorrowed) AS AvgBooksBorrowedPerBorrower
FROM 
    (SELECT 
         book_loans_CardNo,
         COUNT(book_loans_BookID) OVER (PARTITION BY book_loans_CardNo) AS BooksBorrowed
     FROM 
         [dbo].[tbl_book_loans]
    ) AS BorrowerBookCounts;

-------------------------------------------------------
SELECT 
     DISTINCT(book_loans_CardNo),
     COUNT(book_loans_BookID) OVER (PARTITION BY book_loans_CardNo) AS BooksBorrowed
FROM 
    [dbo].[tbl_book_loans]*/

 ---------------------------------------
SELECT 
	borrower_BorrowerName, 
	AVG(Total_books_borrowed) as Average_books_borrowed
FROM (
    SELECT 
		book_loans_CardNo, 
		COUNT(book_loans_CardNo) as Total_books_borrowed
    FROM 
		tbl_book_loans bl
    GROUP BY 
		book_loans_CardNo
		) as borrower_details
JOIN 
	tbl_borrower b ON b.borrower_CardNo = borrower_details.book_loans_CardNo
GROUP BY 
	borrower_BorrowerName
ORDER BY 
	borrower_BorrowerName;
/*COMMENTS:
The inner subquery (borrower_details) calculates the total number of books borrowed (Total_books_borrowed) for each borrower (book_loans_CardNo) from the tbl_book_loans table.
The outer query joins this subquery with the tbl_borrower table based on the borrower's card number (borrower_CardNo) and calculates the average books borrowed per borrower (Average_books_borrowed) using AVG() function.
The GROUP BY clause groups the results by borrower's name (borrower_BorrowerName).*/

/*19.	Find the branch with the highest average number of books borrowed per borrower.*/
SELECT * FROM tbl_borrower
SELECT * FROM tbl_library_branch
SELECT * FROM tbl_book_loans

--METHOD 1:
SELECT 
	TOP 1 lb.library_branch_branchname, 
	AVG(borrower_loaned_books.total_books) as Average_borrowedbooks
FROM (
    SELECT 
		book_loans_BranchId, 
		borrower_BorrowerName, 
		book_loans_CardNo, 
		COUNT(book_loans_CardNo) as total_books
    FROM 
		tbl_book_loans AS bl1
    JOIN 
		tbl_borrower AS br1 ON br1.borrower_CardNo = bl1.book_loans_CardNo
    GROUP BY 
		book_loans_BranchId, 
		borrower_BorrowerName, 
		book_loans_CardNo
	) as borrower_loaned_books
JOIN 
	tbl_library_branch lb ON borrower_loaned_books.book_loans_BranchId = lb.library_branch_BranchID
GROUP BY 
	lb.library_branch_branchname
ORDER BY 
	Average_borrowedbooks DESC;
/*COMMENTS:
The inner subquery (borrower_loaned_books) calculates the total number of books borrowed (total_books) for each borrower (book_loans_CardNo) in each branch (book_loans_BranchId).
The outer query then calculates the average number of books borrowed per branch (Average_borrowedbooks) and selects the top branch with the highest average using TOP 1 and ORDER BY.
The JOIN statement connects the subquery with the tbl_library_branch table to retrieve branch names based on branch IDs.*/


/*20.	Rank library branches based on the total number of books borrowed, without grouping*/
SELECT * FROM tbl_borrower
SELECT * FROM tbl_book_loans
SELECT * FROM tbl_library_branch

/*METHOD 1*/

SELECT 
	DISTINCT lb.library_branch_branchname, 
       (SELECT 
			COUNT(*) 
        FROM 
			tbl_book_loans bl 
        WHERE 
			bl.book_loans_BranchID = lb.library_branch_BranchID) AS Total_books_borrowed,
		ROW_NUMBER() OVER (ORDER BY (SELECT COUNT(*) 
                                FROM tbl_book_loans bl 
                                WHERE bl.book_loans_BranchID = lb.library_branch_BranchID) DESC) AS BranchRank
FROM 
	tbl_library_branch lb
ORDER BY 
	Total_books_borrowed DESC;

/*METHOD 2*/

SELECT
    library_branch_BranchName,
    Total_books_borrowed,
    ROW_NUMBER() OVER (ORDER BY Total_books_borrowed DESC) as BranchRank
FROM (
    SELECT
        lb.library_branch_BranchName,
        COUNT(bl.book_loans_CardNo) as Total_books_borrowed
    FROM 
		tbl_book_loans AS bl
    JOIN 
		tbl_library_branch AS lb ON lb.library_branch_BranchID = bl.book_loans_BranchID
    GROUP BY 
		lb.library_branch_BranchName
	) AS BranchBookCounts;
/*EXPLANATION:
The inner subquery (BranchBookCounts) calculates the total number of books borrowed (Total_books_borrowed) for each branch (library_branch_BranchName) by joining tbl_book_loans and tbl_library_branch tables and using COUNT with GROUP BY.
The outer query selects the branch name, total books borrowed, and uses the RANK() OVER (ORDER BY ...) window function to assign a rank (BranchRank) based on the total books borrowed, ordered in descending order.
The ORDER BY Total_books_borrowed DESC in the window function ensures that branches with the highest number of books borrowed get a lower rank.*/


/*21.	Calculate the percentage of books borrowed from each branch relative to the total number of books borrowed across all branches.*/
SELECT * FROM tbl_book_loans;

/* METHOD 1*/

SELECT
    lb.library_branch_BranchName,
    ROUND((COUNT(bl.book_loans_CardNo) * 100.0) / SUM(COUNT(bl.book_loans_CardNo)) OVER (), 2) AS Percentage_of_books_borrowed
FROM 
	tbl_book_loans AS bl
JOIN 
	tbl_library_branch AS lb ON lb.library_branch_BranchID = bl.book_loans_BranchID
GROUP BY 
	lb.library_branch_BranchName;

/* METHOD 2*/

SELECT
    lb.library_branch_BranchName,
    ROUND((COUNT(bl.book_loans_CardNo) * 100.0) / (SELECT COUNT(*) FROM tbl_book_loans), 2) AS Percentage_of_books_borrowed
FROM 
	tbl_book_loans AS bl
JOIN 
	tbl_library_branch AS lb ON lb.library_branch_BranchID = bl.book_loans_BranchID
GROUP BY 
	lb.library_branch_BranchName;

/*OR*/

SELECT
    library_branch_BranchName,
    ROUND((books_checked_out * 100.0) / total_books_loaned, 2) AS Percentage_of_books_borrowed
FROM (
    SELECT
        lb.library_branch_BranchName,
        COUNT(bl.book_loans_CardNo) AS books_checked_out,
			(SELECT 
				COUNT(*) 
			 FROM 
				tbl_book_loans) AS total_books_loaned
    FROM 
		tbl_book_loans AS bl
    JOIN 
		tbl_library_branch AS lb ON lb.library_branch_BranchID = bl.book_loans_BranchID
    GROUP BY 
		lb.library_branch_BranchName
	) AS subquery;

/*EXPLANATION:
The subquery (SELECT COUNT(*) FROM tbl_book_loans) calculates the total count of books borrowed across all branches.
The main query then uses this total count in the calculation of the percentage of books borrowed for each branch.
ROUND() function is used to round the percentage to two decimal places.
GROUP BY lb.library_branch_BranchName groups the results by branch name to calculate the percentage for each branch individually.*/

/*22.	Find the names of borrowers who have borrowed books authored by "Stephen King" and "J.K. Rowling" from the same library branch.*/
SELECT * FROM tbl_book_loans
SELECT * FROM [dbo].[tbl_borrower]
select * from [dbo].[tbl_library_branch]
select * from [dbo].[tbl_book_authors]

SELECT
    b.borrower_BorrowerName
FROM 
	tbl_borrower AS b 
JOIN 
	tbl_book_loans AS bl ON b.borrower_CardNo = bl.book_loans_CardNo
JOIN 
	tbl_book_authors AS ba ON bl.book_loans_BookID = ba.book_authors_BookID
JOIN 
	tbl_library_branch AS lb ON lb.library_branch_BranchID = bl.book_loans_BranchID
WHERE bl.book_loans_CardNo IN (
    SELECT 
		book_loans_CardNo
    FROM 
		tbl_book_loans
    WHERE 
		book_authors_BookID = bl.book_loans_BookID
		AND book_authors_AuthorName = 'Stephen King'
					) 
	AND bl.book_loans_CardNo IN (
				SELECT 
					book_loans_CardNo
				FROM 
					tbl_book_loans
				WHERE 
					book_authors_BookID = bl.book_loans_BookID
					AND book_authors_AuthorName = 'J.K. Rowling'
			)
GROUP BY 
	b.borrower_BorrowerName 
HAVING 
	COUNT(DISTINCT bl.book_loans_BranchID) = 1 

--OR--

SELECT DISTINCT
    b.borrower_BorrowerName
FROM 
    tbl_borrower b
JOIN 
    tbl_book_loans bl ON b.borrower_CardNo = bl.book_loans_CardNo
JOIN 
    tbl_book_authors ba ON bl.book_loans_BookID = ba.book_authors_BookID
JOIN
    tbl_library_branch lb ON bl.book_loans_BranchID = lb.library_branch_BranchID
WHERE
    ba.book_authors_AuthorName IN ('Stephen King', 'J.K. Rowling')
GROUP BY
    b.borrower_BorrowerName, lb.library_branch_BranchID
HAVING
    COUNT(DISTINCT CASE WHEN ba.book_authors_AuthorName = 'Stephen King' THEN bl.book_loans_BookID END) > 0
    AND COUNT(DISTINCT CASE WHEN ba.book_authors_AuthorName = 'J.K. Rowling' THEN bl.book_loans_BookID END) > 0
    AND COUNT(DISTINCT lb.library_branch_BranchID) = 1;

/*EXPLANATION:
Joins:
The query uses inner joins (JOIN) to connect several tables:
tbl_borrower is joined with tbl_book_loans on borrower_CardNo.
tbl_book_loans is joined with tbl_book_authors on book_loans_BookID.
tbl_book_loans is joined with tbl_library_branch on book_loans_BranchID.
Filtering with Subqueries:
The WHERE clause includes subqueries to filter rows based on certain conditions:
It uses subqueries to check if the same book_loans_CardNo exists in two separate conditions:
If the borrower has a loan associated with 'Stephen King' (book_authors_AuthorName = 'Stephen King').
If the borrower has a loan associated with 'J.K. Rowling' (book_authors_AuthorName = 'J.K. Rowling').
These subqueries are used as conditions for filtering rows in the main query.
Grouping:
The GROUP BY clause groups the results by library_branch_BranchName, borrower_BorrowerName, and book_authors_AuthorName.
This grouping ensures that the output shows distinct combinations of branch name, borrower name, and author name.*/


/* 23.	Retrieve the names of borrowers who have borrowed books from branches located in New York and have more than 5 books checked out.*/
SELECT * FROM tbl_book_loans
SELECT * FROM tbl_borrower
SELECT * FROM tbl_library_branch


SELECT
    br.borrower_BorrowerName,
    lb.library_branch_branchName,
    COUNT(bl.book_loans_CardNo) as total_books_checkedout
FROM 
	tbl_book_loans bl
JOIN
	tbl_borrower br ON bl.book_loans_CardNo = br.borrower_CardNo
JOIN
	tbl_library_branch lb ON bl.book_loans_BranchID = lb.library_branch_BranchID
WHERE
	lb.library_branch_BranchAddress LIKE '%NY%'
GROUP BY 
	br.borrower_BorrowerName, lb.library_branch_branchName
HAVING 
	COUNT(bl.book_loans_CardNo) >= 5;


/*EXPLANATION:
Joins:
The query uses inner joins (JOIN) to connect three tables:
tbl_book_loans is joined with tbl_borrower on book_loans_CardNo.
tbl_book_loans is joined with tbl_library_branch on book_loans_BranchID.

Filtering:
The WHERE clause includes a condition to filter rows where the library_branch_BranchAddress is like '%NY%', which means the branch is located in New York.
This condition ensures that only book loans from branches in New York are considered.

Grouping and Aggregation:
The GROUP BY clause groups the results by borrower_BorrowerName and library_branch_branchName.
The COUNT(book_loans_CardNo) function is used to count the number of book loans for each borrower-branch combination.
The HAVING clause filters the grouped results, retaining only those groups where the count of book loans (total_books_checkedout) is greater than or equal to 5.
Overall, this query provides information about borrowers who have checked out a significant number of books (5 or more) from branches located in New York. The GROUP BY and HAVING clauses help in aggregating and filtering the data based on these criteria.*/


/*24.	How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"?*/
SELECT * FROM tbl_book
SELECT * FROM tbl_library_branch
SELECT * FROM tbl_book_copies

SELECT
    library_branch_BranchName,
    Total_BookCopies=SUM(book_copies_No_Of_Copies) OVER(PARTITION BY [library_branch_BranchName] ORDER BY [library_branch_BranchName])
FROM 
	tbl_book AS bo
JOIN
	tbl_book_copies AS bc ON bo.book_BookID = bc.book_copies_BookID
JOIN
	tbl_library_branch AS lb ON bc.book_copies_BranchID = lb.library_branch_BranchID
WHERE 
	book_title = 'The Lost Tribe' AND library_branch_BranchName = 'Sharpstown'


---OR----

SELECT
    book_Title,
    library_branch_BranchName,
    SUM(book_copies_No_Of_Copies) as Total_BookCopies
FROM 
	tbl_book AS bo
JOIN
	tbl_book_copies AS bc ON bo.book_BookID = bc.book_copies_BookID
JOIN
	tbl_library_branch AS lb ON bc.book_copies_BranchID = lb.library_branch_BranchID
WHERE 
	book_title = 'The Lost Tribe' AND library_branch_BranchName = 'Sharpstown'
GROUP BY 
	book_title, library_branch_BranchName


/*EXPLANATION:
This query retrieves the title of the book, the branch name, and the total number of copies available for the book "The Lost Tribe" at the branch named "Sharpstown". 
The SUM() function is used to calculate the total book copies, and the GROUP BY clause ensures that the aggregation is done per book title and branch name.*/

/* 25.	How many copies of the book titled "The Lost Tribe" are owned by each library branch?*/
SELECT * FROM tbl_book_copies
SELECT * FROM tbl_library_branch
SELECT * FROM tbl_book

SELECT  
	book_copies_BranchID,  
	SUM(book_copies_No_Of_Copies) as Total_BookCopies
FROM 
	tbl_book AS bo
JOIN 
	tbl_book_copies AS bc ON bo.book_BookID = bc.book_copies_BookID
JOIN 
	tbl_library_branch AS lb ON bc.book_copies_BranchID = lb.library_branch_BranchID
WHERE 
	book_title = 'The Lost Tribe'
GROUP BY 
	book_copies_BranchID


/*OR*/

SELECT  
	book_copies_BranchID, 
	library_branch_BranchName, 
	book_title, 
	SUM(book_copies_No_Of_Copies) OVER(PARTITION BY [library_branch_BranchID]) as Total_BookCopies
FROM 
	tbl_book AS bo
JOIN 
	tbl_book_copies AS bc ON bo.book_BookID = bc.book_copies_BookID
JOIN 
	tbl_library_branch AS lb ON bc.book_copies_BranchID = lb.library_branch_BranchID
WHERE 
	book_title = 'The Lost Tribe'

/*EXPLANATION:
*This query retrieves the branch ID, branch name, book title, and the total number of copies available for the book "The Lost Tribe" across different branches. 
The SUM() function calculates the total book copies, and the GROUP BY clause ensures the aggregation is done per branch and book title combination.*/

/*26.	Retrieve the names of all borrowers who do not have any books checked out.*/
SELECT * FROM tbl_book_loans 
SELECT * FROM tbl_borrower

SELECT 
	borrower_BorrowerName, 
	borrower_CardNo
FROM 
	tbl_borrower AS br
LEFT JOIN 
	tbl_book_loans AS bl ON bl.book_loans_CardNo = br.borrower_CardNo
WHERE 
	bl.book_loans_CardNo IS NULL


/*EXPLANATION:
This stored procedure NoLoans selects the borrower names from tbl_borrower where there are no corresponding records in tbl_book_loans for each borrower 
(i.e., where the book_loans_CardNo does not match with borrower_CardNo). You can execute the stored procedure using EXEC dbo.NoLoans*/


/* 27.	For each book that is loaned out from the "Sharpstown" branch and whose DueDate is today, retrieve the book title, the borrower's name, and the borrower's address. */
SELECT * FROM tbl_borrower
SELECT * FROM tbl_library_branch
SELECT * FROM tbl_book
SELECT * FROM tbl_book_loans

/* DUE DATE IS TODAY*/

CREATE FUNCTION dbo.ufnCURRENTDATE1()
RETURNS DATE
AS
BEGIN
    RETURN CAST(GETDATE() AS DATE)
END;

SELECT
    library_branch_BranchName,
    book_loans_DueDate AS Today_due_date,
    book_Title,
    borrower_BorrowerName,
    borrower_BorrowerAddress
FROM 
	tbl_borrower AS br
JOIN 
	tbl_book_loans AS bl ON br.borrower_CardNo = bl.book_loans_CardNo
JOIN 
	tbl_library_branch AS lb ON bl.book_loans_BranchID = lb.library_branch_BranchID
JOIN 
	tbl_book AS bo ON bl.book_loans_BookID = bo.book_BookID
WHERE 
	lb.library_branch_BranchName = 'Sharpstown'
	AND bl.book_loans_DueDate = dbo.ufnCURRENTDATE1();


/*OR*/

CREATE FUNCTION dbo.UFNcurrentdate()
RETURNS DATE
AS
BEGIN
    RETURN CAST(GETDATE() AS DATE)
END;


SELECT
    library_branch_BranchName,
    book_loans_DueDate AS Today_due_date,
    book_Title,
    borrower_BorrowerName,
    borrower_BorrowerAddress
FROM (
    SELECT
        bl.*,
        bo.book_Title,
        br.borrower_BorrowerName,
        br.borrower_BorrowerAddress
    FROM 
		tbl_book_loans AS bl
    JOIN 
		tbl_book AS bo ON bl.book_loans_BookID = bo.book_BookID
    JOIN 
		tbl_borrower AS br ON bl.book_loans_CardNo = br.borrower_CardNo
	) AS loan_details
JOIN 
	tbl_library_branch AS lb ON loan_details.book_loans_BranchID = lb.library_branch_BranchID
WHERE 
	lb.library_branch_BranchName = 'Sharpstown'
	and book_loans_DueDate = dbo.UFNcurrentdate()
	

/*EXPLANATION:
SELECT Clause:
library_branch_BranchName: Selects the branch name from the library branch table.
book_loans_DueDate AS Today_due_date: Renames the due date column to "Today_due_date" for clarity.
book_Title: Selects the book title from the book table.
borrower_BorrowerName: Selects the borrower's name from the borrower table.
borrower_BorrowerAddress: Selects the borrower's address from the borrower table.

FROM Clause:
FROM tbl_borrower AS br: Specifies the borrower table with an alias "br".
JOIN tbl_book_loans AS bl ON br.borrower_CardNo = bl.book_loans_CardNo: Joins the borrower table with the book loans table on the borrower card number.
JOIN tbl_library_branch AS lb ON bl.book_loans_BranchID = lb.library_branch_BranchID: Joins the book loans table with the library branch table on the branch ID.
JOIN tbl_book AS bo ON bl.book_loans_BookID = bo.book_BookID: Joins the book loans table with the book table on the book ID.

WHERE Clause:
WHERE lb.library_branch_BranchName = 'Sharpstown': Filters rows where the branch name is 'Sharpstown' in the library branch table.
AND CONVERT(date, bl.book_loans_DueDate) = CONVERT(date, GETDATE()): Converts the due date to date format and compares it with the current date (GETDATE()). This condition retrieves records where the due date matches today's date.*/


/*28.	For each library branch, retrieve the branch name and the total number of books loaned out from that branch.*/

SELECT 
	DISTINCT(library_branch_BranchName), 
    COUNT(bl.book_loans_CardNo) OVER(PARTITION BY [library_branch_BranchName] ORDER BY [library_branch_BranchName])as Total_books_loanedOut
FROM 
	tbl_book_loans as bl
JOIN 
	tbl_library_branch as lb ON lb.library_branch_BranchID = bl.book_loans_BranchID

--OR--

SELECT 
	library_branch_BranchName, 
    COUNT(bl.book_loans_CardNo) as Total_books_loanedOut
FROM 
	tbl_book_loans as bl
JOIN 
	tbl_library_branch as lb ON lb.library_branch_BranchID = bl.book_loans_BranchID
GROUP BY 
	library_branch_BranchName;

/*OR*/

SELECT 
	lb.library_branch_BranchName,
       (SELECT COUNT(*) FROM tbl_book_loans WHERE book_loans_BranchID = lb.library_branch_BranchID) AS Total_books_loanedOut
FROM 
	tbl_library_branch as lb;

/*EXPLANATION:
It calculates the count of book loans grouped by the branch name from the tbl_book_loans table joined with the tbl_library_branch table.*/


/*================================================================================THANK YOU=============================================================================*/