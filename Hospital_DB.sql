Create database hospital_db;
use hospital_db;


CREATE TABLE user (
    userID VARCHAR(20) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phoneNumber VARCHAR(15) UNIQUE,
    password VARCHAR(100) NOT NULL,
    address VARCHAR(255),
    age INT CHECK (age >= 0),
    gender ENUM('Male', 'Female', 'Other'),
    accountStatus BOOLEAN DEFAULT TRUE
);
use hospital_db;
ALTER TABLE user 
ADD COLUMN role enum('Doctor', 'Patient', 'Admin');

CREATE TABLE Patients (
    patientID VARCHAR(50) PRIMARY KEY,
    bloodGroup VARCHAR(10),
    appointmentDate DATETIME,
    assignedDoctorID VARCHAR(50),
    FOREIGN KEY (assignedDoctorID) REFERENCES Doctors(doctorID)
);
CREATE TABLE PatientAllergies (
    patientID VARCHAR(50),
    allergyType ENUM('DUST', 'POLLEN', 'PEANUTS', 'SHELLFISH', 'DAIRY', 'GLUTEN', 'EGG', 'SOY', 'MEDICATIONS', 'INSECT_STINGS'),
    PRIMARY KEY (patientID, allergyType),
    FOREIGN KEY (patientID) REFERENCES Patients(patientID)
);
CREATE TABLE PatientDiseases (
    patientID VARCHAR(50),
    diseaseType ENUM('DIABETES', 'HYPERTENSION', 'ASTHMA', 'CANCER', 'HEART_DISEASE', 'KIDNEY_DISEASE', 'ARTHRITIS', 'LIVER_DISEASE'),
    PRIMARY KEY (patientID, diseaseType),
    FOREIGN KEY (patientID) REFERENCES Patients(patientID)
);
CREATE TABLE Doctors (
    doctorID VARCHAR(50) PRIMARY KEY,
    specialization ENUM('CARDIOLOGIST', 'NEUROLOGIST', 'ORTHOPEDIC_SURGEON', 'PEDIATRICIAN', 'DERMATOLOGIST', 
                        'PSYCHIATRIST', 'GENERAL_PHYSICIAN', 'ENT_SPECIALIST', 'RADIOLOGIST', 'OPHTHALMOLOGIST'),
    licenseNumber VARCHAR(50) UNIQUE NOT NULL,
    hospitalName VARCHAR(100),
    availableTime VARCHAR(50),
    experienceYears INT,
    consultationFee DOUBLE,
    startTime VARCHAR(10),
    endTime VARCHAR(10)
);
CREATE TABLE DoctorAvailableDays (
    doctorID VARCHAR(50),
    availableDay ENUM('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'),
    PRIMARY KEY (doctorID, availableDay),
    FOREIGN KEY (doctorID) REFERENCES Doctors(doctorID)
);
CREATE TABLE DoctorAppointmentDates (
    doctorID VARCHAR(50),
    appointmentDate DATETIME,
    PRIMARY KEY (doctorID, appointmentDate),
    FOREIGN KEY (doctorID) REFERENCES Doctors(doctorID)
);
CREATE TABLE DoctorAssignedPatients (
    doctorID VARCHAR(50),
    patientID VARCHAR(50),
    PRIMARY KEY (doctorID, patientID),
    FOREIGN KEY (doctorID) REFERENCES Doctors(doctorID),
    FOREIGN KEY (patientID) REFERENCES Patients(patientID)
);


CREATE TABLE Administrators (
    adminID VARCHAR(50) PRIMARY KEY,
    role ENUM('SYSTEM_ADMIN', 'HOSPITAL_ADMIN', 'MEDICAL_RECORD_ADMIN'),
    department VARCHAR(100),
    FOREIGN KEY (department) REFERENCES Departments(departmentName) -- assuming a "Departments" table exists
);
CREATE TABLE AdminManagedDoctors (
    adminID VARCHAR(50),
    doctorID VARCHAR(50),
    PRIMARY KEY (adminID, doctorID),
    FOREIGN KEY (adminID) REFERENCES Administrators(adminID),
    FOREIGN KEY (doctorID) REFERENCES Doctors(doctorID)
);
CREATE TABLE AdminManagedPatients (
    adminID VARCHAR(50),
    patientID VARCHAR(50),
    PRIMARY KEY (adminID, patientID),
    FOREIGN KEY (adminID) REFERENCES Administrators(adminID),
    FOREIGN KEY (patientID) REFERENCES Patients(patientID)
);
CREATE TABLE Departments (
    departmentName VARCHAR(100) PRIMARY KEY,
    description TEXT
);


CREATE TABLE VitalSigns (
    recordID VARCHAR(50) PRIMARY KEY,
    patientID VARCHAR(50),
    heartRate INT,
    oxygenLevel INT,
    bloodPressure INT,
    temperature DOUBLE,
    respiratoryRate INT,
    glucoseLevel DOUBLE,
    cholesterolLevel DOUBLE,
    bmi DOUBLE,
    hydrationLevel DOUBLE,
    stressLevel INT,
    recordDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patientID) REFERENCES Patients(patientID)
);

ALTER TABLE VitalSigns 
ADD column doctorID varchar(50);

ALTER TABLE VitalSigns 
ADD constraint fk_vitalsigns_doctors
FOREIGN KEY (doctorID) REFERENCES Doctors(doctorID);

CREATE TABLE Appointments (
    appointmentID VARCHAR(50) PRIMARY KEY,
    patientID VARCHAR(50),
    doctorID VARCHAR(50),
    appointmentDateTime DATETIME,
    notes TEXT,
    reason VARCHAR(255),
    appointmentStatus ENUM('SCHEDULED', 'CANCELED', 'PENDING', 'RESCHEDULED', 'COMPLETED'),
    FOREIGN KEY (patientID) REFERENCES Patients(patientID),
    FOREIGN KEY (doctorID) REFERENCES Doctors(doctorID)
);
CREATE TABLE Feedbacks (
    feedbackID VARCHAR(50) PRIMARY KEY,
    doctorID VARCHAR(50),
    patientID VARCHAR(50),
    rating INT,
    comments TEXT,
    feedbackDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('PENDING', 'APPROVED', 'REJECTED'),
    isAnonymous BOOLEAN,
    FOREIGN KEY (doctorID) REFERENCES Doctors(doctorID),
    FOREIGN KEY (patientID) REFERENCES Patients(patientID)
);
CREATE TABLE MedicalHistory (
    medicalHistoryID VARCHAR(50) PRIMARY KEY,
    patientID VARCHAR(50),
    createdDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    surgeries TEXT,
    familyHistory TEXT,
    FOREIGN KEY (patientID) REFERENCES Patients(patientID)
);
CREATE TABLE MedicalHistoryPrescriptions (
    medicalHistoryID VARCHAR(50),
    prescriptionID VARCHAR(50),
    PRIMARY KEY (medicalHistoryID, prescriptionID),
    FOREIGN KEY (medicalHistoryID) REFERENCES MedicalHistory(medicalHistoryID),
    FOREIGN KEY (prescriptionID) REFERENCES Prescriptions(prescriptionID)
);
CREATE TABLE MedicalHistoryFeedbacks (
    medicalHistoryID VARCHAR(50),
    feedbackID VARCHAR(50),
    PRIMARY KEY (medicalHistoryID, feedbackID),
    FOREIGN KEY (medicalHistoryID) REFERENCES MedicalHistory(medicalHistoryID),
    FOREIGN KEY (feedbackID) REFERENCES Feedbacks(feedbackID)
);
CREATE TABLE MedicalHistoryAllergies (
    medicalHistoryID VARCHAR(50),
    allergyType ENUM('DUST', 'POLLEN', 'PEANUTS', 'SHELLFISH', 'DAIRY', 'GLUTEN', 'EGG', 'SOY', 'MEDICATIONS', 'INSECT_STINGS'),
    PRIMARY KEY (medicalHistoryID, allergyType),
    FOREIGN KEY (medicalHistoryID) REFERENCES MedicalHistory(medicalHistoryID)
);
CREATE TABLE Prescriptions (
    prescriptionID VARCHAR(50) PRIMARY KEY,
    patientID VARCHAR(50),
    doctorID VARCHAR(50),
    dosageInstructions TEXT,
    startDate DATETIME,
    endDate DATETIME,
    dosageSchedule VARCHAR(255),
    createdDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    quantity INT,
    FOREIGN KEY (patientID) REFERENCES Patients(patientID),
    FOREIGN KEY (doctorID) REFERENCES Doctors(doctorID)
);
CREATE TABLE ChatMessages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sender_id VARCHAR(50) NOT NULL,
    receiver_id VARCHAR(50) NOT NULL,
    message_text TEXT NOT NULL,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    is_read BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (sender_id) REFERENCES user(userID),
    FOREIGN KEY (receiver_id) REFERENCES user(userID)
);



SELECT * FROM ChatMessages;

use hospital_db;
SELECT * FROM user;
UPDATE user 
set role = "Patient"
where userID = "Noone123445";
INSERT INTO Appointments (
    appointmentID, 
    patientID, 
    doctorID, 
    appointmentDateTime, 
    notes, 
    reason, 
    appointmentStatus
) VALUES (
    'appt001',                  -- appointmentID (you can generate this however you like)
    'Noone123445',               -- patientID
    'hamzarahmeem23',            -- doctorID
    '2025-05-02 14:30:00',       -- appointmentDateTime (example future date and time)
    'Patient reports mild headache and fatigue.', -- notes
    'General Checkup',           -- reason
    'SCHEDULED'                  -- appointmentStatus
);

INSERT INTO VitalSigns (
    recordID,
    patientID,
    doctorID,
    heartRate,
    oxygenLevel,
    bloodPressure,
    temperature,
    respiratoryRate,
    glucoseLevel,
    cholesterolLevel,
    bmi,
    hydrationLevel,
    stressLevel
) VALUES (
    'VS001',
    'Noone123445',
    'hamzarahmeem23',
    72,
    98,
    120,
    36.6,
    16,
    90.5,
    180.2,
    22.3,
    65.0,
    3
);
INSERT INTO MedicalHistory (
    medicalHistoryID,
    patientID,
    surgeries,
    familyHistory
) VALUES (
    'MH001', -- unique ID for this medical history
    'Noone123445',
    'Appendectomy, Tonsillectomy',
    'Diabetes, Hypertension in family'
);


SELECT * FROM Appointments;

INSERT INTO DoctorAssignedPatients(doctorID, patientID) Values ('hamzarahmeem23', 'aliahmed1234');
INSERT INTO DoctorAssignedPatients(doctorID, patientID) Values ('hamzarahmeem23', 'Noone123445');

SELECT * FROM user, doctors, DoctorAvailableDays d where user.userID = doctors.doctorID AND doctors.doctorID = d.doctorID ;
SELECT * FROM user WHERE userID = 'Noone123445';
SELECT * FROM Patients WHERE patientID = 'Noone123445';
UPDATE Patients 
set assignedDoctorID = "hamzarahmeem23"
where patientID = "Noone123445";
SELECT * FROM PatientAllergies WHERE patientID = 'Noone123445';
SELECT * FROM PatientDiseases WHERE patientID = 'Noone123445';
SELECT * FROM vitalsigns;

SELECT * FROM user WHERE userID = 'Ahmed1234';

SELECT * FROM Doctors WHERE doctorID = 'Ahmed1234';

SELECT * FROM user WHERE userID = 'admin24235';
SELECT * FROM Administrators WHERE adminID = 'admin24235';



