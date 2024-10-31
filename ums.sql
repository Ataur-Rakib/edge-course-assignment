-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Oct 31, 2024 at 12:20 PM
-- Server version: 10.4.6-MariaDB
-- PHP Version: 7.3.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ums`
--

-- --------------------------------------------------------

--
-- Table structure for table `administrators`
--

CREATE TABLE `administrators` (
  `id` int(11) NOT NULL,
  `first_name` varchar(15) NOT NULL,
  `middle_name` varchar(15) NOT NULL,
  `last_name` varchar(15) NOT NULL,
  `dob` date NOT NULL,
  `status` enum('active','resigned','dissmissed','retired','suspended') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `id` int(11) NOT NULL,
  `title` varchar(50) NOT NULL,
  `syllabus` varchar(100) NOT NULL,
  `department` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `course_allocation`
--

CREATE TABLE `course_allocation` (
  `id` int(11) NOT NULL,
  `teacher` int(11) NOT NULL,
  `course` int(11) NOT NULL,
  `session` varchar(8) NOT NULL,
  `status` bit(1) DEFAULT NULL,
  `comment` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `course_enrollment`
--

CREATE TABLE `course_enrollment` (
  `id` int(11) NOT NULL,
  `student` int(11) NOT NULL,
  `course` int(11) NOT NULL,
  `session` varchar(7) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` int(11) NOT NULL,
  `name` varchar(40) NOT NULL,
  `chairman` int(11) DEFAULT NULL,
  `student_advisor_1` int(11) DEFAULT NULL,
  `student_advisor_2` int(11) DEFAULT NULL,
  `faculty` enum('science and engineering','business administration','law','social science','arts') NOT NULL,
  `location` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`id`, `name`, `chairman`, `student_advisor_1`, `student_advisor_2`, `faculty`, `location`) VALUES
(1, 'Matthematics', NULL, NULL, NULL, 'science and engineering', 'Academic Building 1, 2nd floor');

-- --------------------------------------------------------

--
-- Table structure for table `departments_admins_history`
--

CREATE TABLE `departments_admins_history` (
  `id` int(11) NOT NULL,
  `admin` int(11) NOT NULL,
  `department` int(11) NOT NULL,
  `designation` varchar(30) NOT NULL,
  `join_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` enum('active','inactive') NOT NULL,
  `end_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `exam_committee`
--

CREATE TABLE `exam_committee` (
  `teacher` int(11) NOT NULL,
  `department` int(11) NOT NULL,
  `designation` enum('president','member') NOT NULL COMMENT 'committee_designation',
  `session` varchar(9) NOT NULL,
  `year` enum('1st','2nd','3rd','4th','masters') NOT NULL,
  `admission_session` varchar(9) NOT NULL,
  `join_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `end_date` datetime DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `comment` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `offices`
--

CREATE TABLE `offices` (
  `id` int(11) NOT NULL,
  `office_name` varchar(50) NOT NULL,
  `location` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `id` int(11) NOT NULL,
  `first_name` varchar(15) NOT NULL,
  `middle_name` varchar(15) NOT NULL,
  `last_name` varchar(15) NOT NULL,
  `registration_no` varchar(10) DEFAULT NULL,
  `department` int(11) NOT NULL,
  `status` enum('active','passed','suspended','dropped') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `students_address`
--

CREATE TABLE `students_address` (
  `id` int(11) NOT NULL,
  `student` int(11) NOT NULL,
  `address_type` enum('permanent','presnt') NOT NULL,
  `city` enum('Dhaka','Khulna','Rajshahi','Rangpur','Barishal','Sylhet','Cittagong','Mymensingh') NOT NULL,
  `district` varchar(15) NOT NULL,
  `thana` varchar(15) NOT NULL,
  `zipcode` int(11) NOT NULL,
  `status` enum('staying','changed') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `students_contact_info`
--

CREATE TABLE `students_contact_info` (
  `id` int(11) NOT NULL,
  `student` int(11) NOT NULL,
  `info_type` enum('email','phone') NOT NULL,
  `information` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `student_advisors`
--

CREATE TABLE `student_advisors` (
  `id` int(11) NOT NULL,
  `department` int(11) NOT NULL,
  `teacher` int(11) NOT NULL,
  `join_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `end_date` timestamp NULL DEFAULT NULL,
  `status` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `teacher's_history`
--

CREATE TABLE `teacher's_history` (
  `id` int(11) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  `department` int(11) NOT NULL,
  `designation` enum('lecturer','assistant professore','associate professore','professore') NOT NULL,
  `salary` decimal(9,2) NOT NULL,
  `join_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `end_date` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `status` bit(1) NOT NULL,
  `comment` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `teachers`
--

CREATE TABLE `teachers` (
  `id` int(11) NOT NULL,
  `name_prefix` varchar(15) DEFAULT NULL,
  `first_name` varchar(15) NOT NULL,
  `middle_name` varchar(15) DEFAULT NULL,
  `last_name` varchar(15) DEFAULT NULL,
  `designation` enum('Lecturer','Assistant Professore','Associate Professore','Professore') NOT NULL,
  `department` int(11) NOT NULL,
  `office_room` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `teachers`
--

INSERT INTO `teachers` (`id`, `name_prefix`, `first_name`, `middle_name`, `last_name`, `designation`, `department`, `office_room`) VALUES
(1, 'Dr.', 'Md. Shakhawat', 'Hossain', NULL, 'Lecturer', 1, 1310);

-- --------------------------------------------------------

--
-- Table structure for table `teachers_address`
--

CREATE TABLE `teachers_address` (
  `teacher_id` int(11) NOT NULL,
  `address_type` enum('permanent','current') NOT NULL,
  `city` enum('dhaka','khulna','rajshahi','rangpur','chattogram','mymensingh') NOT NULL,
  `district` varchar(40) NOT NULL,
  `thana` varchar(40) NOT NULL,
  `zipcode` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `teachers_contact_info`
--

CREATE TABLE `teachers_contact_info` (
  `teacher_id` int(11) NOT NULL,
  `info_type` enum('mobile','telephone','email') NOT NULL,
  `value` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `administrators`
--
ALTER TABLE `administrators`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_courses_departments` (`department`);

--
-- Indexes for table `course_allocation`
--
ALTER TABLE `course_allocation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_course_allocation_teachers` (`teacher`),
  ADD KEY `fk_course_allocation_courses` (`course`);

--
-- Indexes for table `course_enrollment`
--
ALTER TABLE `course_enrollment`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_departments_students_chairman` (`chairman`),
  ADD KEY `fk_departments_teachers_sa1` (`student_advisor_1`),
  ADD KEY `fk_departments_students_sa2` (`student_advisor_2`);

--
-- Indexes for table `departments_admins_history`
--
ALTER TABLE `departments_admins_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_departments_admins_history_admins` (`admin`),
  ADD KEY `fk_department_admins_history_departments` (`department`);

--
-- Indexes for table `offices`
--
ALTER TABLE `offices`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `registration_no` (`registration_no`),
  ADD KEY `fk_students_departments` (`department`);

--
-- Indexes for table `students_contact_info`
--
ALTER TABLE `students_contact_info`
  ADD KEY `fk_students_contact_info_student` (`student`);

--
-- Indexes for table `student_advisors`
--
ALTER TABLE `student_advisors`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_student_advisors_departments` (`department`),
  ADD KEY `fk_student_advisors_teachers` (`teacher`);

--
-- Indexes for table `teacher's_history`
--
ALTER TABLE `teacher's_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_teacher's_history_departments` (`department`),
  ADD KEY `fk_teacher's_history_teachers` (`teacher_id`);

--
-- Indexes for table `teachers`
--
ALTER TABLE `teachers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_teachers_departments` (`department`);

--
-- Indexes for table `teachers_address`
--
ALTER TABLE `teachers_address`
  ADD KEY `fk_teacher_address_teachers` (`teacher_id`);

--
-- Indexes for table `teachers_contact_info`
--
ALTER TABLE `teachers_contact_info`
  ADD KEY `fk_teachers_info_teachers` (`teacher_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `administrators`
--
ALTER TABLE `administrators`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `course_allocation`
--
ALTER TABLE `course_allocation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `course_enrollment`
--
ALTER TABLE `course_enrollment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `departments_admins_history`
--
ALTER TABLE `departments_admins_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `offices`
--
ALTER TABLE `offices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `student_advisors`
--
ALTER TABLE `student_advisors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `teacher's_history`
--
ALTER TABLE `teacher's_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `teachers`
--
ALTER TABLE `teachers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `courses`
--
ALTER TABLE `courses`
  ADD CONSTRAINT `fk_courses_departments` FOREIGN KEY (`department`) REFERENCES `departments` (`id`);

--
-- Constraints for table `course_allocation`
--
ALTER TABLE `course_allocation`
  ADD CONSTRAINT `fk_course_allocation_courses` FOREIGN KEY (`course`) REFERENCES `courses` (`id`),
  ADD CONSTRAINT `fk_course_allocation_teachers` FOREIGN KEY (`teacher`) REFERENCES `teachers` (`id`);

--
-- Constraints for table `departments_admins_history`
--
ALTER TABLE `departments_admins_history`
  ADD CONSTRAINT `fk_department_admins_history_departments` FOREIGN KEY (`department`) REFERENCES `departments` (`id`),
  ADD CONSTRAINT `fk_departments_admins_history_admins` FOREIGN KEY (`admin`) REFERENCES `administrators` (`id`);

--
-- Constraints for table `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `fk_students_departments` FOREIGN KEY (`department`) REFERENCES `departments` (`id`);

--
-- Constraints for table `students_contact_info`
--
ALTER TABLE `students_contact_info`
  ADD CONSTRAINT `fk_students_contact_info_student` FOREIGN KEY (`student`) REFERENCES `students` (`id`);

--
-- Constraints for table `student_advisors`
--
ALTER TABLE `student_advisors`
  ADD CONSTRAINT `fk_student_advisors_departments` FOREIGN KEY (`department`) REFERENCES `departments` (`id`),
  ADD CONSTRAINT `fk_student_advisors_teachers` FOREIGN KEY (`teacher`) REFERENCES `teachers` (`id`);

--
-- Constraints for table `teacher's_history`
--
ALTER TABLE `teacher's_history`
  ADD CONSTRAINT `fk_teacher's_history_departments` FOREIGN KEY (`department`) REFERENCES `departments` (`id`),
  ADD CONSTRAINT `fk_teacher's_history_teachers` FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`id`);

--
-- Constraints for table `teachers`
--
ALTER TABLE `teachers`
  ADD CONSTRAINT `fk_teachers_departments` FOREIGN KEY (`department`) REFERENCES `departments` (`id`);

--
-- Constraints for table `teachers_address`
--
ALTER TABLE `teachers_address`
  ADD CONSTRAINT `fk_teacher_address_teachers` FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`id`);

--
-- Constraints for table `teachers_contact_info`
--
ALTER TABLE `teachers_contact_info`
  ADD CONSTRAINT `fk_teachers_info_teachers` FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
