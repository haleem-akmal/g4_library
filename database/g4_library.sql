-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 04, 2025 at 05:13 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `g4_library`
--

-- --------------------------------------------------------

--
-- Table structure for table `authors`
--

CREATE TABLE `authors` (
  `author_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `biography` text DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `authors`
--

INSERT INTO `authors` (`author_id`, `name`, `biography`, `date_of_birth`) VALUES
(1, 'Paulo Coelho', 'Brazilian lyricist and novelist, best known for \"The Alchemist\".', '1947-08-24'),
(2, 'Harper Lee', 'American novelist widely known for \"To Kill a Mockingbird\".', '1926-04-28'),
(3, 'George Orwell', 'English novelist and essayist, famous for \"1984\" and \"Animal Farm\".', '1903-06-25'),
(4, 'Jane Austen', 'English novelist known for romantic fiction set among the British landed gentry.', '1775-12-16'),
(5, 'F. Scott Fitzgerald', 'American novelist known for \"The Great Gatsby\".', '1896-09-24'),
(6, 'J.K. Rowling', 'British author, best known for the Harry Potter series.', '1965-07-31'),
(7, 'J.R.R. Tolkien', 'English writer, poet, and philologist, author of \"The Hobbit\" and \"The Lord of the Rings\".', '1892-01-03'),
(8, 'Mark Twain', 'American writer, humorist, and lecturer known for \"Adventures of Huckleberry Finn\".', '1835-11-30'),
(9, 'Leo Tolstoy', 'Russian writer best known for \"War and Peace\" and \"Anna Karenina\".', '1828-09-09'),
(10, 'Markus Zusak', 'Australian writer known for \"The Book Thief\".', '1975-06-23');

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

CREATE TABLE `books` (
  `book_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `isbn` varchar(20) DEFAULT NULL,
  `publisher` varchar(100) DEFAULT NULL,
  `publication_year` year(4) DEFAULT NULL,
  `total_copies` int(11) NOT NULL DEFAULT 1,
  `available_copies` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `books`
--

INSERT INTO `books` (`book_id`, `title`, `isbn`, `publisher`, `publication_year`, `total_copies`, `available_copies`) VALUES
(1, 'The Alchemist', '9780061122415', 'HarperOne', '2006', 5, 3),
(2, 'To Kill a Mockingbird', '9780060935467', 'Harper Perennial', '2002', 4, 2),
(3, '1984', '9780451524935', 'Signet Classics', '1950', 6, 6),
(4, 'Pride and Prejudice', '9780141439518', 'Penguin Classics', '2003', 3, 1),
(5, 'The Great Gatsby', '9780743273565', 'Scribner', '2004', 7, 5),
(6, 'Harry Potter and the Sorcerer\'s Stone', '9780439554930', 'Scholastic', '1998', 10, 7),
(7, 'The Hobbit', '9780547928227', 'Houghton Mifflin', '2012', 4, 4),
(8, 'Moby Dick', '9781503280786', 'CreateSpace', '2014', 2, 0),
(9, 'The Catcher in the Rye', '9780316769488', 'Little, Brown and Company', '2001', 5, 2),
(10, 'The Book Thief', '9780375842207', 'Knopf Books', '2007', 6, 6);

-- --------------------------------------------------------

--
-- Table structure for table `book_authors`
--

CREATE TABLE `book_authors` (
  `book_id` int(11) NOT NULL,
  `author_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `book_authors`
--

INSERT INTO `book_authors` (`book_id`, `author_id`) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 3),
(9, 2),
(10, 1);

-- --------------------------------------------------------

--
-- Table structure for table `borrowings`
--

CREATE TABLE `borrowings` (
  `borrowing_id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `borrower_id` int(11) NOT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `borrow_date` date NOT NULL,
  `due_date` date NOT NULL,
  `return_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `borrowings`
--

INSERT INTO `borrowings` (`borrowing_id`, `book_id`, `borrower_id`, `staff_id`, `borrow_date`, `due_date`, `return_date`) VALUES
(1, 1, 1, 2, '2025-04-01', '2025-04-15', '2025-04-10'),
(2, 2, 2, 3, '2025-04-05', '2025-04-19', NULL),
(3, 3, 3, 2, '2025-03-20', '2025-04-03', '2025-04-02'),
(4, 4, 4, 4, '2025-04-10', '2025-04-24', NULL),
(5, 5, 5, 2, '2025-04-12', '2025-04-26', '2025-04-20'),
(6, 6, 6, 3, '2025-04-15', '2025-04-29', NULL),
(7, 7, 7, 4, '2025-03-28', '2025-04-11', '2025-04-09'),
(8, 8, 8, 2, '2025-04-02', '2025-04-16', NULL),
(9, 9, 9, 3, '2025-04-06', '2025-04-20', '2025-04-18'),
(10, 10, 10, 2, '2025-04-09', '2025-04-23', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `fines`
--

CREATE TABLE `fines` (
  `fine_id` int(11) NOT NULL,
  `borrowing_id` int(11) NOT NULL,
  `fine_amount` decimal(10,2) NOT NULL,
  `paid` tinyint(1) DEFAULT 0,
  `paid_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fines`
--

INSERT INTO `fines` (`fine_id`, `borrowing_id`, `fine_amount`, `paid`, `paid_date`) VALUES
(1, 2, 150.00, 0, NULL),
(2, 4, 100.00, 1, '2025-04-26'),
(3, 6, 200.00, 0, NULL),
(4, 8, 75.00, 1, '2025-04-20'),
(5, 10, 50.00, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `reservations`
--

CREATE TABLE `reservations` (
  `reservation_id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `reservation_date` date NOT NULL,
  `status` enum('active','cancelled','fulfilled') DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reservations`
--

INSERT INTO `reservations` (`reservation_id`, `book_id`, `user_id`, `reservation_date`, `status`) VALUES
(1, 3, 1, '2025-04-10', 'active'),
(2, 5, 2, '2025-04-08', 'fulfilled'),
(3, 7, 3, '2025-04-09', 'cancelled'),
(4, 2, 4, '2025-04-11', 'active'),
(5, 6, 5, '2025-04-05', 'fulfilled');

-- --------------------------------------------------------

--
-- Table structure for table `return_history`
--

CREATE TABLE `return_history` (
  `history_id` int(11) NOT NULL,
  `borrowing_id` int(11) NOT NULL,
  `return_date` date NOT NULL,
  `returned_by_staff_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `return_history`
--

INSERT INTO `return_history` (`history_id`, `borrowing_id`, `return_date`, `returned_by_staff_id`) VALUES
(16, 1, '2025-05-04', 3),
(19, 3, '2025-05-04', 3);

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `staff_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('librarian','admin') DEFAULT 'librarian',
  `contact_number` varchar(15) DEFAULT NULL,
  `date_joined` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`staff_id`, `name`, `email`, `password_hash`, `role`, `contact_number`, `date_joined`) VALUES
(1, 'Sathya Kumar', 'sathyakumar@example.com', 'admin123', 'admin', '0771234567', '2023-01-10'),
(2, 'Meena Rani', 'meenarani@example.com', 'lib456', 'librarian', '0789876543', '2023-03-15'),
(3, 'Ragul Raj', 'ragulraj@example.com', 'libpass789', 'librarian', '0756677889', '2023-06-20'),
(4, 'Divya Sri', 'divyasri@example.com', 'divya321', 'librarian', '0773344556', '2024-01-05'),
(5, 'Kishore Balan', 'kishorebalan@example.com', 'kishore@1', 'admin', '0769988776', '2024-04-01');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `contact_number` varchar(15) DEFAULT NULL,
  `registered_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `name`, `email`, `contact_number`, `registered_date`) VALUES
(1, 'Ameer Khan', 'ameerkhan@example.com', '0771234567', '2024-12-01'),
(2, 'Banu Priya', 'banupriya@example.com', '0779876543', '2025-01-15'),
(3, 'Charles David', 'charlesdavid@example.com', '0781122334', '2025-02-20'),
(4, 'Deepika Suresh', 'deepikasuresh@example.com', '0759988776', '2025-03-10'),
(5, 'Elango Raj', 'elangoraj@example.com', '0765566778', '2025-04-25'),
(6, 'Farzana Beevi', 'farzanabeevi@example.com', '0773344556', '2025-01-28'),
(7, 'Gopi Nath', 'gopinath@example.com', '0787654321', '2025-02-14'),
(8, 'Harini Selva', 'hariniselva@example.com', '0754433221', '2025-03-19'),
(9, 'Irfan Majeed', 'irfanmajeed@example.com', '0767788990', '2025-04-05'),
(10, 'Jeya Lakshmi', 'jeyalakshmi@example.com', '0771122445', '2025-04-30');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `authors`
--
ALTER TABLE `authors`
  ADD PRIMARY KEY (`author_id`);

--
-- Indexes for table `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`book_id`),
  ADD UNIQUE KEY `isbn` (`isbn`);

--
-- Indexes for table `book_authors`
--
ALTER TABLE `book_authors`
  ADD PRIMARY KEY (`book_id`,`author_id`),
  ADD KEY `author_id` (`author_id`);

--
-- Indexes for table `borrowings`
--
ALTER TABLE `borrowings`
  ADD PRIMARY KEY (`borrowing_id`),
  ADD KEY `book_id` (`book_id`),
  ADD KEY `borrower_id` (`borrower_id`),
  ADD KEY `staff_id` (`staff_id`);

--
-- Indexes for table `fines`
--
ALTER TABLE `fines`
  ADD PRIMARY KEY (`fine_id`),
  ADD KEY `borrowing_id` (`borrowing_id`);

--
-- Indexes for table `reservations`
--
ALTER TABLE `reservations`
  ADD PRIMARY KEY (`reservation_id`),
  ADD KEY `book_id` (`book_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `return_history`
--
ALTER TABLE `return_history`
  ADD PRIMARY KEY (`history_id`),
  ADD KEY `borrowing_id` (`borrowing_id`),
  ADD KEY `returned_by_staff_id` (`returned_by_staff_id`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`staff_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `authors`
--
ALTER TABLE `authors`
  MODIFY `author_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `books`
--
ALTER TABLE `books`
  MODIFY `book_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `borrowings`
--
ALTER TABLE `borrowings`
  MODIFY `borrowing_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `fines`
--
ALTER TABLE `fines`
  MODIFY `fine_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `reservations`
--
ALTER TABLE `reservations`
  MODIFY `reservation_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `return_history`
--
ALTER TABLE `return_history`
  MODIFY `history_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `staff_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `book_authors`
--
ALTER TABLE `book_authors`
  ADD CONSTRAINT `book_authors_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`),
  ADD CONSTRAINT `book_authors_ibfk_2` FOREIGN KEY (`author_id`) REFERENCES `authors` (`author_id`);

--
-- Constraints for table `borrowings`
--
ALTER TABLE `borrowings`
  ADD CONSTRAINT `borrowings_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`),
  ADD CONSTRAINT `borrowings_ibfk_2` FOREIGN KEY (`borrower_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `borrowings_ibfk_3` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`);

--
-- Constraints for table `fines`
--
ALTER TABLE `fines`
  ADD CONSTRAINT `fines_ibfk_1` FOREIGN KEY (`borrowing_id`) REFERENCES `borrowings` (`borrowing_id`);

--
-- Constraints for table `reservations`
--
ALTER TABLE `reservations`
  ADD CONSTRAINT `reservations_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`),
  ADD CONSTRAINT `reservations_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `return_history`
--
ALTER TABLE `return_history`
  ADD CONSTRAINT `return_history_ibfk_1` FOREIGN KEY (`borrowing_id`) REFERENCES `borrowings` (`borrowing_id`),
  ADD CONSTRAINT `return_history_ibfk_2` FOREIGN KEY (`returned_by_staff_id`) REFERENCES `staff` (`staff_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
