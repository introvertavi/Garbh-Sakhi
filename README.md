# Garbh Sakhi – Pregnancy Wellness App
# 🤰 Garbh Sakhi – Pregnancy Wellness & Appointment Tracker

Garbh Sakhi is a full-stack web application designed to assist pregnant women in managing their health, appointments, medications, and wellness throughout pregnancy.

It provides a centralized platform for tracking daily activities, receiving reminders, and accessing important health insights — all with a clean, responsive UI.

---

## 🚀 Features

### 🏠 Dashboard
- Dynamic greeting based on time
- Next appointment smart card
- Live countdown timer
- Today's medicines section (Morning / Afternoon / Night)
- Notifications (appointments + medicines)

### 📅 Appointments Module
- Add, view, and manage appointments
- Automatic classification:
  - Today
  - Upcoming
  - Missed
- Mark appointments as completed
- Calendar-based UI

### 💊 Medicines Module
- Add medicines with dosage schedules
- Track doses (Morning / Afternoon / Night)
- Status system:
  - ACTIVE
  - COMPLETED
  - STOPPED
- Daily progress tracker
- Auto reset using last_taken_date

### 📄 Lab Reports
- Upload reports (PDF/Image)
- Secure server-side storage
- View/download reports
- Delete functionality synced with database

### 🔔 Notifications System
- Missed dose alerts
- Upcoming appointment alerts
- Notification bell with badge counter

### ⚙️ Settings
- App Preferences
- Account settings
- Secure password system
- Separate Danger Zone (Delete Account)

### 📱 Responsive Design
- Desktop: Sidebar layout
- Mobile: Bottom navigation + slide drawer
- Pastel-themed UI

---

## 🛠️ Tech Stack

### Backend
- Java 17
- Java Servlets & JSP
- JDBC

### Frontend
- HTML5
- CSS3 (Pastel UI - modern-style.css)
- JavaScript

### Database
- PostgreSQL (Production)
- MySQL (Initial Development)

### Server & Deployment
- Apache Tomcat 10
- Maven (WAR build)
- Docker (for deployment)
- Render (Cloud Hosting)

---

## 📂 Project Structure


Garbh-Sakhi/
│
├── src/
│ ├── main/
│ │ ├── java/ # Servlets, DAO, Models
│ │ ├── webapp/ # JSP, CSS, JS
│ │ └── resources/
│
├── target/ # Compiled WAR file
├── pom.xml # Maven configuration
└── README.md


---

## ⚙️ Setup Instructions (Run Locally)

### 🔧 Prerequisites

Make sure you have the following installed:

- Java 17
- Apache Tomcat 10+
- Maven
- PostgreSQL (or MySQL for local testing)
- Git (optional)

---

### 📥 Step 1: Clone the Repository

git clone https://github.com/your-username/garbh-sakhi.git
cd garbh-sakhi
🛢️ Step 2: Setup Database (PostgreSQL)
Create database:
CREATE DATABASE garbh_sakhi;
Create user:
CREATE USER garbh_sakhi_user WITH PASSWORD 'your_password';
GRANT ALL PRIVILEGES ON DATABASE garbh_sakhi TO garbh_sakhi_user;
Create required tables (users, appointments, medicines, lab_reports, etc.)

👉 Use tools like pgAdmin or DBeaver to run SQL scripts.

🔐 Step 3: Configure Database Connection

Update your database configuration in the project:

DB_URL=jdbc:postgresql://localhost:5432/garbh_sakhi
DB_USER=garbh_sakhi_user
DB_PASSWORD=your_password

🏗️ Step 4: Build the Project
mvn clean install

This will generate a .war file in the target/ directory.

🚀 Step 5: Deploy on Tomcat
Copy the WAR file:
target/garbh-sakhi.war
Paste it into:
<TOMCAT_HOME>/webapps/
Start Tomcat server
🌐 Step 6: Run the Application

Open your browser and go to:

http://localhost:8080/garbh-sakhi
🐳 Docker Deployment (Optional)
docker build -t garbh-sakhi .
docker run -p 8080:8080 garbh-sakhi
☁️ Production Deployment (Render)
Use Dockerfile
Set environment variables in Render dashboard
Attach PostgreSQL database
Deploy as a Web Service
🔒 Security Features
Password hashing
Session-based authentication
Input validation
File type & size validation for uploads
📸 Screenshots

(Add screenshots here: Dashboard, Appointments, Medicines, Lab Reports)

🧠 Future Enhancements
AI chatbot for pregnancy guidance
SMS/Email notifications
Doctor integration
Cloud file storage (AWS S3)
🤝 Contributing
Fork the repository
Create a new branch
Commit your changes
Push to your branch
Create a Pull Request
📜 License

This project is for educational purposes.

👨‍💻 Author

Avinash Vishwakarma

💡 Motivation

Pregnancy requires continuous care, tracking, and support.
Garbh Sakhi aims to simplify this journey by providing a smart, reliable, and easy-to-use digital companion.
