-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 29, 2020 at 11:35 AM
-- Server version: 10.4.13-MariaDB
-- PHP Version: 7.4.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `notto`
--

-- --------------------------------------------------------

--
-- Table structure for table `notes`
--

CREATE TABLE `notes` (
  `id` int(11) NOT NULL,
  `title` varchar(15) NOT NULL,
  `notes` varchar(100) NOT NULL,
  `email` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `notes`
--

INSERT INTO `notes` (`id`, `title`, `notes`, `email`) VALUES
(1, 'note 1', 'nkshdfkjsdkfjhskdjfhksdfhj sduhfshfdhiusfiuhsdfiu', 'shak@mail.com'),
(5, 'note 5', 'botetsadsdasdasd', 'shak@mail.com'),
(6, 'note 1', 'paan', 'shuukron@mail.com'),
(7, 'note 2', 'nodfs', 'shuukron@mail.com'),
(8, 'oke', 'oke', 'shuukron@mail.com'),
(10, 'haha', 'uxx', 'shuukron@mail.com'),
(11, 'haha', 'uxx', 'shuukron@mail.com'),
(15, 'jsjsj', 'jsjsj', 'shuukron@mail.com'),
(16, 'yye', 'cjcjcj', 'shak@mail.com'),
(17, 'ddhfiu	', 'jojsdf', 'woe@mail.com	');

-- --------------------------------------------------------

--
-- Table structure for table `userlogin`
--

CREATE TABLE `userlogin` (
  `id` int(11) NOT NULL,
  `fullname` varchar(30) NOT NULL,
  `email` varchar(25) NOT NULL,
  `password` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `userlogin`
--

INSERT INTO `userlogin` (`id`, `fullname`, `email`, `password`) VALUES
(1, 'shak', 'shak@mail.com', '460daff46d060c7e200f758176ce7fe9cf39b632'),
(2, 'shak', 'shaki@mail.com', 'c9dfab0ce996d20ad1477a1ee4a58a4e91bd3850'),
(3, 'shik', 'shik@mail.com', 'b7ed6b6e4ace61625434ed6e50c32e94a017ccdb'),
(4, 'shukron', 'shukron@mail.com', '92d6c07c1ce6371a7b6adb8c1db97f81614569c1'),
(5, 'shukron', 'shukron@mail.com', '92d6c07c1ce6371a7b6adb8c1db97f81614569c1'),
(6, 'shukron', 'shukron@mail.com', '92d6c07c1ce6371a7b6adb8c1db97f81614569c1'),
(7, 'shukron', 'shukron@mail.com', '92d6c07c1ce6371a7b6adb8c1db97f81614569c1'),
(8, 'shukron', 'shukron@mail.com', '92d6c07c1ce6371a7b6adb8c1db97f81614569c1'),
(9, 'shukron', 'shukron@mail.com', '92d6c07c1ce6371a7b6adb8c1db97f81614569c1'),
(10, 'shukron', 'shukron@mail.com', '92d6c07c1ce6371a7b6adb8c1db97f81614569c1'),
(11, 'shukron', 'shukron@mail.com', '92d6c07c1ce6371a7b6adb8c1db97f81614569c1'),
(12, 'shukron', 'shuukron@mail.com', '92d6c07c1ce6371a7b6adb8c1db97f81614569c1'),
(13, 'suk', 'suk@mail.com', '64dbae655ecb82368bad3761a467622bbb1f237c'),
(14, 'woe	', 'woe@mail.com	', '35d2fbcc9748ee5911dbf3469a1f27a72e7bb201');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `notes`
--
ALTER TABLE `notes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `userlogin`
--
ALTER TABLE `userlogin`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `notes`
--
ALTER TABLE `notes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `userlogin`
--
ALTER TABLE `userlogin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
