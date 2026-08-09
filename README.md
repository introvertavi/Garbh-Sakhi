# 🤰 Garbh Sakhi

### Pregnancy Wellness & Appointment Management System

Garbh Sakhi is a full-stack web application designed to help expecting mothers organize important aspects of their pregnancy journey in one place.

The application provides a centralized dashboard for managing **doctor appointments, medicines, lab reports, emergency contacts, notifications, and pregnancy-related information** through a clean, responsive, and easy-to-use interface.

> **Project Type:** Full-Stack Web Application
> **Status:** Active Development
> **Purpose:** Academic / Educational Project

---

## ✨ Why Garbh Sakhi?

Pregnancy involves keeping track of multiple appointments, medications, reports, and important dates. Managing all of this information across different apps or physical documents can become inconvenient.

**Garbh Sakhi aims to bring these essential activities into a single platform.**

The application focuses on:

* 📅 Appointment management
* 💊 Medication tracking
* 📄 Lab report management
* 🔔 Important notifications
* 🚨 Emergency contacts
* 👤 User profile management
* 📱 Responsive experience across desktop and mobile

---

# 🚀 Features

## 🏠 Smart Dashboard

The dashboard provides an overview of the user's current pregnancy-related activities.

* Dynamic time-based greeting
* Upcoming appointment card
* Appointment countdown timer
* Today's medication schedule
* Morning / Afternoon / Night dose tracking
* Notification summary
* Quick access to important modules
* Emergency action button

---

## 📅 Appointment Management

Manage doctor visits and other pregnancy-related appointments.

### Features

* Add appointments
* Edit appointments
* Delete appointments
* View appointment details
* Mark appointments as completed
* Automatically classify appointments as:

  * 🟢 Today
  * 🔵 Upcoming
  * 🔴 Missed
* Calendar-oriented interface
* Appointment reminders and notifications

---

## 💊 Medicine Tracking

Keep track of prescribed medicines and their daily schedules.

### Features

* Add medicines
* Specify dosage schedules
* Morning / Afternoon / Night tracking
* Mark medicines as taken
* Daily progress tracking
* Medicine status management:

  * `ACTIVE`
  * `COMPLETED`
  * `STOPPED`
* Automatic daily dose reset using `last_taken_date`

---

## 📄 Lab Report Management

Store important pregnancy-related medical reports digitally.

### Supported Files

* PDF
* JPG / JPEG
* PNG

### Features

* Upload lab reports
* Store report metadata in the database
* Server-side file storage
* View reports
* Download reports
* Delete reports
* Synchronize report deletion with database records

---

## 🔔 Notification System

Garbh Sakhi provides notifications for important activities.

### Notifications include:

* 💊 Missed medicine doses
* 📅 Upcoming appointments
* ⏰ Important reminders
* 🔴 Notification badge for unread notifications

---

## 🚨 Emergency Contacts

The application provides quick access to emergency contact information.

Users can maintain important emergency details so that they are easily accessible when needed.

---

## 👤 User & Account Management

Garbh Sakhi includes session-based user authentication and account management.

### Features

* User registration
* Login / Logout
* Session-based authentication
* User profile
* Pregnancy information
* Password change
* Secure password hashing
* Account deletion / Danger Zone

---

# 📱 Responsive UI

Garbh Sakhi is designed to work across different screen sizes.

### 🖥️ Desktop

* Fixed sidebar navigation
* Spacious dashboard layout
* Card-based interface
* Responsive content sections

### 📱 Mobile

* Bottom navigation
* Slide-out navigation drawer
* Mobile-friendly cards
* Responsive forms
* Floating emergency action

The UI follows a soft pastel visual style with rounded cards, modern typography, and responsive layouts.

---

# 🛠️ Tech Stack

| Layer              | Technology              |
| ------------------ | ----------------------- |
| Language           | Java 17                 |
| Backend            | Java Servlets           |
| View Layer         | JSP                     |
| Database Access    | JDBC                    |
| Database           | PostgreSQL              |
| Initial Database   | MySQL                   |
| Frontend           | HTML5, CSS3, JavaScript |
| UI                 | Bootstrap / Custom CSS  |
| Styling            | `modern-style.css`      |
| Authentication     | HTTP Sessions + BCrypt  |
| Application Server | Apache Tomcat 10        |
| Build Tool         | Maven                   |
| Packaging          | WAR                     |
| Containerization   | Docker                  |
| Deployment         | Render                  |
| Database Tool      | DBeaver / pgAdmin       |

---

# 🏗️ Application Architecture

Garbh Sakhi follows a traditional Java web application architecture based on **Servlets, JSP, JDBC, DAO, and Model classes**.

```text
                    ┌──────────────────────┐
                    │      User / Browser  │
                    └──────────┬───────────┘
                               │
                               ▼
                    ┌──────────────────────┐
                    │       JSP / UI       │
                    │ HTML / CSS / JS      │
                    └──────────┬───────────┘
                               │
                               ▼
                    ┌──────────────────────┐
                    │    Java Servlets     │
                    │ Business / Requests  │
                    └──────────┬───────────┘
                               │
                               ▼
                    ┌──────────────────────┐
                    │        DAO Layer     │
                    │ JDBC / SQL Queries   │
                    └──────────┬───────────┘
                               │
                               ▼
                    ┌──────────────────────┐
                    │     PostgreSQL DB    │
                    └──────────────────────┘
```

### Main Layers

**Presentation Layer**

* JSP
* HTML5
* CSS3
* JavaScript
* Bootstrap

**Application Layer**

* Java Servlets
* Session management
* Validation
* Business logic

**Data Layer**

* DAO classes
* JDBC
* PostgreSQL

**Model Layer**

* User
* User Profile
* Appointment
* Medicine
* Lab Report
* Notification
* Emergency Contact

---

# 📂 Project Structure

```text
Garbh-Sakhi/
│
├── src/
│   └── main/
│       ├── java/
│       │   └── com/
│       │       └── garbhsakhi/
│       │           ├── dao/
│       │           │   ├── AppointmentDAO.java
│       │           │   ├── DatabaseConnection.java
│       │           │   ├── EmergencyDAO.java
│       │           │   ├── LabReportDAO.java
│       │           │   ├── MedicineDAO.java
│       │           │   ├── NotificationDAO.java
│       │           │   ├── UserDAO.java
│       │           │   └── UserProfileDAO.java
│       │           │
│       │           ├── model/
│       │           │   ├── Appointment.java
│       │           │   ├── EmergencyContact.java
│       │           │   ├── LabReport.java
│       │           │   ├── Medicine.java
│       │           │   ├── Notification.java
│       │           │   └── User.java
│       │           │
│       │           ├── servlets/
│       │           │   ├── LoginServlet.java
│       │           │   ├── SignupServlet.java
│       │           │   ├── DashboardServlet.java
│       │           │   ├── AppointmentListServlet.java
│       │           │   ├── MedicineServlet.java
│       │           │   ├── LabReportServlet.java
│       │           │   ├── EmergencyServlet.java
│       │           │   └── ...
│       │           │
│       │           └── util/
│       │               ├── PasswordUtil.java
│       │               ├── PregnancyUtil.java
│       │               └── DBConnectionListener.java
│       │
│       └── webapp/
│           ├── assets/
│           │   ├── css/
│           │   │   ├── style.css
│           │   │   └── modern-style.css
│           │   └── js/
│           │
│           ├── components/
│           ├── WEB-INF/
│           ├── dashboard.jsp
│           ├── appointments.jsp
│           ├── medicines.jsp
│           ├── profile.jsp
│           ├── settings.jsp
│           └── ...
│
├── Dockerfile
├── pom.xml
└── README.md
```

---

# ⚙️ Getting Started

## Prerequisites

Before running Garbh Sakhi locally, install:

* **Java 17**
* **Apache Maven**
* **Apache Tomcat 10+**
* **PostgreSQL**
* **Git**
* **DBeaver or pgAdmin** *(recommended)*

Verify the installations:

```bash
java -version
mvn -version
```

---

# 📥 Installation

## 1. Clone the Repository

```bash
git clone https://github.com/your-username/garbh-sakhi.git
cd garbh-sakhi
```

---

## 2. Create the PostgreSQL Database

Create the database:

```sql
CREATE DATABASE garbh_sakhi;
```

Create a dedicated database user:

```sql
CREATE USER garbh_sakhi_user
WITH PASSWORD 'your_password';
```

Grant access:

```sql
GRANT ALL PRIVILEGES
ON DATABASE garbh_sakhi
TO garbh_sakhi_user;
```

Then create the required application tables.

> You can use **DBeaver** or **pgAdmin** to execute the SQL commands.

---

# 🔐 3. Configure Database Connection

For local development, configure the database using environment variables.

```text
DB_URL=jdbc:postgresql://localhost:5432/garbh_sakhi
DB_USER=garbh_sakhi_user
DB_PASSWORD=your_password
```

### ⚠️ Important

Do **not** commit database passwords, API keys, or other secrets to GitHub.

For production deployment, configure these values through the hosting platform's environment-variable settings.

---

# 🏗️ 4. Build the Application

Run:

```bash
mvn clean package
```

Maven will generate the WAR file inside:

```text
target/
```

The generated file will be similar to:

```text
Garbh-Sakhi.war
```

---

# 🚀 5. Run with Apache Tomcat

Copy the generated WAR file into:

```text
<TOMCAT_HOME>/webapps/
```

Start Tomcat.

For example:

### Windows

```text
<TOMCAT_HOME>/bin/startup.bat
```

### Linux / macOS

```bash
<TOMCAT_HOME>/bin/startup.sh
```

Then open:

```text
http://localhost:8080/Garbh-Sakhi
```

---

# 🐳 Docker Deployment

Garbh Sakhi includes a Dockerfile for containerized deployment.

Build the image:

```bash
docker build -t garbh-sakhi .
```

Run the container:

```bash
docker run -p 8080:8080 garbh-sakhi
```

The application will be available at:

```text
http://localhost:8080
```

---

# ☁️ Deployment on Render

Garbh Sakhi can be deployed using Docker and PostgreSQL.

### Deployment flow

```text
GitHub Repository
        │
        ▼
     Render
        │
        ├───────────────┐
        ▼               ▼
 Docker Web Service   PostgreSQL
        │               │
        └───────┬───────┘
                ▼
          Garbh Sakhi
```

### Required production configuration

Configure the required database credentials as **environment variables** in Render.

Do not hardcode production database credentials inside Java source files.

---

# 🔒 Security

Garbh Sakhi implements several security-focused features:

* 🔐 Password hashing using BCrypt
* 👤 Session-based authentication
* ✅ Server-side input validation
* 📁 File type validation
* 📦 File upload size restrictions
* 🚪 Protected application pages
* 🗑️ Account deletion functionality
* 🔑 Password change functionality

### Security Recommendation

For production use, sensitive configuration such as:

* Database passwords
* API keys
* Secret tokens

should always be stored as environment variables or secure secrets.

---

# 📸 Screenshots

## Dashboard

*Add dashboard screenshot here.*

```text
screenshots/dashboard.png
```

## Appointments

*Add appointments screenshot here.*

```text
screenshots/appointments.png
```

## Medicines

*Add medicines screenshot here.*

```text
screenshots/medicines.png
```

## Lab Reports

*Add lab reports screenshot here.*

```text
screenshots/lab-reports.png
```

## Mobile View

*Add mobile UI screenshot here.*

```text
screenshots/mobile.png
```

> Screenshots are highly recommended because Garbh Sakhi has a strong visual/UI component. They make the GitHub repository much more impressive at first glance.

---

# 🧪 Core Modules

| Module         | Purpose                                   |
| -------------- | ----------------------------------------- |
| Authentication | Registration, login and logout            |
| Dashboard      | Overview of pregnancy-related activities  |
| Appointments   | Schedule and track doctor appointments    |
| Medicines      | Track daily medication doses              |
| Lab Reports    | Upload and manage medical reports         |
| Notifications  | Display important reminders               |
| Emergency      | Manage emergency contact information      |
| Profile        | Manage pregnancy and personal information |
| Settings       | Manage account preferences and security   |

---

# 🗺️ Future Roadmap

The project can be extended with several additional features.

### 🤖 AI Pregnancy Assistant

An AI-powered assistant that can provide general pregnancy-related information and help users navigate the application.

> AI responses should be informational and should not replace professional medical advice.

### 📱 Notifications

* SMS reminders
* Email reminders
* Push notifications
* Medicine reminder scheduling

### 👨‍⚕️ Doctor Integration

Potential future functionality:

* Doctor accounts
* Doctor-patient communication
* Appointment sharing
* Prescription management

### ☁️ Cloud Storage

Move uploaded lab reports from local/server storage to cloud storage such as:

* Amazon S3
* Cloudinary
* Google Cloud Storage

### 📊 Pregnancy Analytics

Potential dashboard analytics:

* Medication adherence
* Appointment history
* Weekly pregnancy progress
* Health record timeline

---

# 🧠 What I Learned Building This Project

This project provided practical experience with:

* Java web development
* Servlet/JSP architecture
* JDBC database connectivity
* DAO design pattern
* PostgreSQL
* Authentication and sessions
* Password hashing
* File uploads
* Responsive frontend development
* Maven WAR packaging
* Apache Tomcat
* Docker
* Cloud deployment
* Database migration from MySQL to PostgreSQL
* Debugging full-stack applications

---

# 🤝 Contributing

Contributions and suggestions are welcome.

### 1. Fork the repository

```bash
git fork
```

### 2. Create a feature branch

```bash
git checkout -b feature/new-feature
```

### 3. Commit your changes

```bash
git commit -m "Add new feature"
```

### 4. Push the branch

```bash
git push origin feature/new-feature
```

### 5. Open a Pull Request

---

# ⚠️ Disclaimer

Garbh Sakhi is an **educational software project**.

It is not intended to diagnose medical conditions, prescribe medication, replace doctors, or provide emergency medical treatment.

Users should always consult qualified healthcare professionals for medical decisions.

---

# 👨‍💻 Author

## Avinash Vishwakarma

**B.E. — Data Engineering**

Interested in:

* Data Engineering
* AI Engineering
* Full-Stack Development
* Machine Learning
* Backend Development

---

# 📜 License

This project is developed for **educational purposes**.

---

# ⭐ Support the Project

If you found this project interesting or useful:

⭐ Star the repository
🍴 Fork the project
🐛 Report issues
💡 Suggest improvements

---

<div align="center">

### 🤰 Garbh Sakhi

**Making pregnancy management simpler, organized, and accessible.**

Built with ❤️ using Java, JSP, Servlets & PostgreSQL.

</div>
