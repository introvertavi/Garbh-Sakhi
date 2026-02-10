# Garbh Sakhi – Pregnancy Wellness App
Garbh Sakhi is a full-stack web application designed to help pregnant women organize, track, and manage their pregnancy journey through a single, user-controlled platform.

The application focuses on simplifying day-to-day pregnancy management by bringing appointments, medicines, lab reports, emergency access, and personal health information into one secure and responsive system.

🎯 Problem Statement

During pregnancy, users often manage important health details using notebooks, messages, or multiple apps. This scattered approach can lead to:
Missed doctor appointments
Forgotten medicines or supplements
Poor organization of medical reports
Increased stress and confusion
Garbh Sakhi solves this problem by centralizing all pregnancy-related information into one structured, easy-to-use web application.

✨ Core Features
🏠 Dashboard
Overview of pregnancy-related activities
Quick access to key modules
Clean and calm pastel-themed UI

🗓 Appointments Management
Add and view doctor appointments
Calendar-based appointment display
Automatic appointment status handling (Upcoming)

Reminder notifications:
1 day before
A few hours before the appointment

💊 Medicines Management
Add prescribed medicines and supplements
Track dosage and timing

Reminder notifications:
1 hour before
15 minutes before
5 minutes before medicine time

🧾 Lab Reports
Upload and manage medical reports
Secure storage and easy access

👤 Profile
Manage personal and pregnancy-related information
User-controlled data updates

🚨 Emergency
Quick access to emergency contacts
Designed for fast response in critical situations

⚙️ Settings
App preferences
Account management
Secure logout and account actions

📱 User-Controlled & Responsive Design
Fully user-operated system (no automated medical decisions)
Responsive layout for both desktop and mobile devices
Mobile-friendly navigation with bottom navigation bar
Calm pastel UI designed for comfort and clarity

🛠️ Tech Stack
Backend
Java 17
Java Servlets & JSP
JDBC
PostgreSQL

Frontend:
HTML5
CSS3 (Pastel theme)
JavaScript
Server & Build
Apache Tomcat 10
Maven (WAR packaging)
Deployment
Docker-based deployment
Cloud hosting (Render)
External PostgreSQL database

🧱 Application Architecture
Follows MVC (Model-View-Controller) architecture
Clear separation of concerns:
Servlets → Controllers
DAO layer → Database operations
JSP → View layer
Secure session-based authentication using User objects

🔐 Security & Reliability
Password hashing and validation
Session-based access control
Server-side validation
Database constraints and permission management
Clean error handling and redirects

🚀 Current Status
✅ Authentication system stabilized
✅ Dashboard, Profile, Settings completed
✅ Appointments module with reminders implemented
✅ Medicines module with reminder support
✅ Lab reports and emergency pages functional
🔄 Notification system enhancement in progress

🌱 Future Scope
Advanced notification customization
Emergency alert automation
Doctor-side dashboard
Multi-language support

❤️ Project Vision
Garbh Sakhi aims to reduce stress, improve medical adherence, and provide a calm, organized pregnancy experience by giving users full control over their health information in one reliable system
