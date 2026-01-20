-- Database schema for Garbh Sakhi (garbh_sakhi_db)
-- Run this on MySQL server to create database and tables

CREATE DATABASE IF NOT EXISTS `garbh_sakhi_db` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `garbh_sakhi_db`;

-- Users table
CREATE TABLE IF NOT EXISTS `users` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `full_name` VARCHAR(200) NOT NULL,
  `email` VARCHAR(255) NOT NULL UNIQUE,
  `password` VARCHAR(255) NOT NULL,
  `age` INT NULL,
  `phone` VARCHAR(30) NULL,
  `due_date` DATE NULL,
  `pregnancy_week` INT NULL,
  `doctor_name` VARCHAR(200) NULL,
  `complications` TEXT NULL,
  `profile_complete` TINYINT DEFAULT 0,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Appointments table
CREATE TABLE IF NOT EXISTS `appointments` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `description` TEXT NULL,
  `doctor_name` VARCHAR(200) NULL,
  `appointment_date` DATETIME NOT NULL,
  `location` VARCHAR(255) NULL,
  `notes` TEXT NULL,
  `type` VARCHAR(100) NULL,
  `status` VARCHAR(50) DEFAULT 'SCHEDULED',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `idx_appointments_user` (`user_id`),
  CONSTRAINT `fk_appointments_user` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Medicines table
CREATE TABLE IF NOT EXISTS `medicines` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `medicine_name` VARCHAR(255) NOT NULL,
  `dosage` VARCHAR(100) NULL,
  `frequency` VARCHAR(100) NULL,
  `start_date` DATE NULL,
  `end_date` DATE NULL,
  `taken_status` VARCHAR(50) DEFAULT 'PENDING',
  PRIMARY KEY (`id`),
  INDEX `idx_medicines_user` (`user_id`),
  CONSTRAINT `fk_medicines_user` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Lab reports
CREATE TABLE IF NOT EXISTS `lab_reports` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `report_name` VARCHAR(255) NOT NULL,
  `report_date` DATE NULL,
  `file_path` VARCHAR(1024) NULL,
  `file_type` VARCHAR(100) NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_labreports_user` (`user_id`),
  CONSTRAINT `fk_labreports_user` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Emergency contacts
CREATE TABLE IF NOT EXISTS `emergency_contacts` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `contact_name` VARCHAR(200) NOT NULL,
  `phone_number` VARCHAR(50) NOT NULL,
  `relationship` VARCHAR(100) NULL,
  `priority` INT DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `idx_emcontacts_user` (`user_id`),
  CONSTRAINT `fk_emcontacts_user` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Notifications
CREATE TABLE IF NOT EXISTS `notifications` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `message` TEXT NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `type` VARCHAR(100) NULL,
  `status` VARCHAR(50) DEFAULT 'UNREAD',
  PRIMARY KEY (`id`),
  INDEX `idx_notifications_user` (`user_id`),
  CONSTRAINT `fk_notifications_user` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Optional: seed an admin/test user (password should be hashed by your app)
-- INSERT INTO `users` (full_name, email, password) VALUES ('Test User','test@example.com','changeme');
