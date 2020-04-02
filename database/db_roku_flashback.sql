-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Apr 02, 2020 at 10:54 PM
-- Server version: 5.7.26
-- PHP Version: 7.3.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_roku_flashback`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_music`
--

CREATE TABLE `tbl_music` (
  `mu_id` int(11) NOT NULL,
  `mu_section` varchar(2) NOT NULL,
  `mu_name` varchar(50) NOT NULL,
  `mu_year` varchar(9) NOT NULL,
  `mu_genre` varchar(30) NOT NULL,
  `mu_artist` varchar(30) NOT NULL,
  `mu_rating` varchar(5) NOT NULL,
  `mu_img` varchar(40) NOT NULL,
  `mu_vid` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_mvtv`
--

CREATE TABLE `tbl_mvtv` (
  `mv_id` int(11) NOT NULL,
  `mv_section` varchar(2) NOT NULL,
  `mv_name` varchar(40) NOT NULL,
  `mv_year` varchar(9) NOT NULL,
  `mv_genre` varchar(30) NOT NULL,
  `mv_mpaa` varchar(5) NOT NULL,
  `mv_rating` varchar(5) NOT NULL,
  `mv_des` text NOT NULL,
  `mv_img` varchar(50) NOT NULL,
  `mv_vid` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_user`
--

CREATE TABLE `tbl_user` (
  `user_id` int(11) NOT NULL,
  `user_fname` varchar(60) NOT NULL,
  `user_name` varchar(50) DEFAULT NULL,
  `user_pass` varchar(60) NOT NULL,
  `user_email` varchar(150) NOT NULL,
  `user_lastlogin` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_currentlogin` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_ip` varchar(30) NOT NULL,
  `user_locked` varchar(3) NOT NULL,
  `user_attempts` varchar(2) NOT NULL,
  `user_fail_start` timestamp NULL DEFAULT NULL,
  `user_new` varchar(5) NOT NULL,
  `user_newstart` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_sus` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_user`
--

INSERT INTO `tbl_user` (`user_id`, `user_fname`, `user_name`, `user_pass`, `user_email`, `user_lastlogin`, `user_currentlogin`, `user_ip`, `user_locked`, `user_attempts`, `user_fail_start`, `user_new`, `user_newstart`, `user_sus`) VALUES
(1, 'Sandra', 'sandra', '$2y$10$tb17GejYMA27.4eGM9HKRehACqoxJM0SasRVzqvzzpXcyly9iante', 'Sandra3dra@gmail.com', '2020-04-02 22:41:23', '2020-04-02 22:48:09', '::1', 'NO', '0', '2020-04-02 22:48:09', 'O', '2020-03-07 23:02:14', 'NO'),
(2, 'tester', 'test', '$2y$10$0nApKJp791jaED67N.GgxOloqO0G429mxL4t29KF6xfiJp/RSAtLq', 'Sandra3dra@gmail.com', '2020-03-08 02:45:08', '2020-03-08 03:43:10', '::1', 'NO', '0', '2020-03-08 03:43:10', 'O', '2020-03-08 02:45:08', 'NO'),
(3, 'tester2', 'test2', '$2y$10$tb17GejYMA27.4eGM9HKRehACqoxJM0SasRVzqvzzpXcyly9iante', 'Sandra3dra@gmail.com', '2020-03-08 02:54:55', '2020-03-08 02:54:55', '::1', 'NO', '0', NULL, 'N', '2020-03-02 02:54:55', 'SUSPENDED'),
(4, 'tester3', 'test3', '$2y$10$S/1dGaAcwDnuuNKqNePXdebIr66YaLzrbLu8zf7jpKBB1d/KFqOmm', 'Sandra3dra@gmail.com', '2020-03-08 03:05:02', '2020-03-08 03:44:54', '::1', 'NO', '0', '2020-03-08 03:44:54', 'O', '2020-03-08 03:05:02', 'NO');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_music`
--
ALTER TABLE `tbl_music`
  ADD PRIMARY KEY (`mu_id`);

--
-- Indexes for table `tbl_mvtv`
--
ALTER TABLE `tbl_mvtv`
  ADD PRIMARY KEY (`mv_id`);

--
-- Indexes for table `tbl_user`
--
ALTER TABLE `tbl_user`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_music`
--
ALTER TABLE `tbl_music`
  MODIFY `mu_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_mvtv`
--
ALTER TABLE `tbl_mvtv`
  MODIFY `mv_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_user`
--
ALTER TABLE `tbl_user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
