# Hospital Management System

## Introduction

The Hospital Management System is a comprehensive desktop application designed to streamline hospital operations. It allows administrators, doctors, and patients to manage appointments, medical records, feedback, and more through an intuitive graphical interface.

## Features

- User authentication for Admin, Doctor, and Patient roles
- Appointment scheduling and management
- Patient medical history and vital signs tracking
- Doctor feedback and prescription management
- Emergency alert system for critical patient vitals
- Email notifications and reminders

## Technologies Used

- **Backend:** Java
- **Frontend:** JavaFX (Java)
- **Database:** MySQL

---

## How to Run the Application

### 1. Database Setup

1. Open the provided MySQL file (`Hospital_DB.sql`) in **MySQL Workbench**.
2. Run the SQL statements **one by one** to create all required tables and set up the database.

### 2. Configure Database Connection

1. Go to:  
   `src/main/java/com/example/project/DATABASE/DBConnection.java`
2. Open the `DBConnection` class and provide your:
   - `DB_URL`
   - Database name
   - Username
   - Password

### 3. JavaFX Setup

- **Recommended IDE:** Use **IntelliJ IDEA** for the easiest JavaFX integration.
- **Install JavaFX:**  
  Download JavaFX SDK from [https://gluonhq.com/products/javafx/](https://gluonhq.com/products/javafx/).
- **Add JavaFX to Environment Variables:**  
  Add the JavaFX `lib` folder path to your system’s environment variables.
- **Sync Maven:**  
  After setting up, make sure to **sync the `pom.xml` file** in your IDE to download all dependencies.

### 4. Running the Application

1. Open the project in IntelliJ IDEA.
2. Navigate to:  
   `src/main/java/com/example/project/Login_Home/HomePage.java`
3. Right-click `HomePage.java` and select **Run**.
4. **Important:**  
   - First, create an **Admin account**. The admin must approve and manage all other accounts.
   - After admin setup, you can create Doctor and Patient accounts.

---

## Video Demo

https://youtu.be/h0j-5VbIQCI

---

**Enjoy using the Hospital Management System!**
