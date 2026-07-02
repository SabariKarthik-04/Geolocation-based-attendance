# 📍 Geolocation Based Attendance System

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter">
  <img src="https://img.shields.io/badge/Firebase-Backend-FFCA28?style=for-the-badge&logo=firebase">
  <img src="https://img.shields.io/badge/Google%20Maps-API-4285F4?style=for-the-badge&logo=googlemaps">
  <img src="https://img.shields.io/badge/Location-GPS-success?style=for-the-badge">
  <img src="https://img.shields.io/badge/Platform-Android-brightgreen?style=for-the-badge&logo=android">
</p>

<p align="center">
  <b>A Smart Attendance System using Geolocation and Geofencing Technology</b><br>
  Mark attendance only when users are inside the authorized location.
</p>

---

# 📖 Overview

The **Geolocation Based Attendance System** is a mobile application that allows users to mark their attendance only when they are physically present within a predefined geographical area.

Using **GPS**, **Geofencing**, **Google Maps**, and **Firebase**, the application verifies the user's live location before allowing attendance.

This eliminates proxy attendance and improves accuracy for educational institutions and organizations.

---

# ✨ Features

## 👤 User Features

- 📍 Live GPS Location Detection
- 🗺 Google Maps Integration
- 📌 Geofencing Support
- ✅ Attendance Marking
- ⏰ Real-Time Attendance
- 📅 Daily Attendance Records
- 📜 Attendance History
- 🔐 Secure User Login
- 📱 Simple & User-Friendly Interface

---

## 👨‍💼 Admin Features

- 👥 User Management
- 📍 Set Attendance Location
- 📏 Configure Geofence Radius
- 📊 View Attendance Reports
- 📅 Track Daily Attendance
- 📈 Attendance Analytics
- 📝 Monitor Employee/Student Presence

---

# 🚀 Technologies Used

| Technology | Purpose |
|------------|---------|
| Flutter | Mobile Application |
| Dart | Programming Language |
| Firebase | Backend Services |
| Cloud Firestore | Database |
| Firebase Authentication | User Authentication |
| Google Maps API | Map Services |
| Geolocator Package | GPS Location |
| Geofencing | Location Restriction |

---

# 🛠 Project Structure

```
geolocation_attendance
│
├── lib
│   ├── Screens
│   ├── Models
│   ├── Services
│   ├── Widgets
│   ├── Utils
│   └── main.dart
│
├── assets
├── android
├── ios
├── web
├── test
└── pubspec.yaml
```

---

# 📱 Application Workflow

```
User Login
      │
      ▼
Location Permission
      │
      ▼
Get Current GPS Location
      │
      ▼
Check Geofence Radius
      │
      ▼
Inside Location?
      │
 ┌────┴─────┐
 │          │
Yes         No
 │          │
 ▼          ▼
Attendance  Access Denied
Marked
```

---

# 🌟 Key Modules

### 🔐 Authentication

- User Login
- User Registration
- Secure Authentication

---

### 📍 Location Module

- Live GPS Tracking
- Google Maps
- Current Location
- Distance Calculation

---

### 📌 Geofencing

- Restricted Attendance Area
- Radius Validation
- Location Verification

---

### ✅ Attendance Module

- Check-In
- Attendance History
- Daily Records
- Timestamp Storage

---

### 📊 Reports

- Daily Report
- Monthly Attendance
- User Statistics
- Attendance Summary

---

# 📦 Required Flutter Packages

```
firebase_core
firebase_auth
cloud_firestore
google_maps_flutter
geolocator
geocoding
permission_handler
provider
intl
```

---

# ⚙ Installation

## Clone Repository

```bash
git clone https://github.com/yourusername/Geolocation-based-attendance.git
```

---

## Navigate to Project

```bash
cd Geolocation-based-attendance
```

---

## Install Dependencies

```bash
flutter pub get
```

---

## Run Application

```bash
flutter run
```

---

# 📍 Permissions Required

### Android

- Fine Location
- Coarse Location
- Internet

### iOS

- Location When In Use
- Location Always (Optional)

---

# 📸 Screenshots

You can add screenshots here.

```
screenshots/
│
├── Login.png
├── Home.png
├── GoogleMap.png
├── Attendance.png
├── History.png
```

---

# 🔒 Security Features

- Firebase Authentication
- Secure User Login
- GPS Verification
- Geofence Validation
- Proxy Attendance Prevention

---

# 🎯 Future Enhancements

- 🌐 Face Recognition
- 😊 Face Detection
- 📷 QR Code Attendance
- ☁ Cloud Backup
- 📧 Email Notifications
- 🔔 Push Notifications
- 📊 Admin Dashboard
- 📍 Multiple Attendance Locations
- 📈 Analytics Dashboard

---

# 💡 Advantages

- ✔ Eliminates Proxy Attendance
- ✔ Accurate GPS Tracking
- ✔ Easy to Use
- ✔ Real-Time Attendance
- ✔ Secure Authentication
- ✔ Fast Performance
- ✔ Cross-Platform Support
- ✔ Reliable Attendance Records

---

# 👨‍💻 Contributors

- **Sabari Karthik S**
- **Saravanakumar S**
- **Vasanthageethan P S**

---

# 🤝 Contributing

Contributions are always welcome!

1. Fork the repository
2. Create a new branch

```bash
git checkout -b feature-name
```

3. Commit your changes

```bash
git commit -m "Added new feature"
```

4. Push to GitHub

```bash
git push origin feature-name
```

5. Create a Pull Request

---

# ⭐ Support

If you like this project, please give it a ⭐ on GitHub.

Your support motivates us to build more innovative projects.

---

# 📄 License

This project is licensed under the **MIT License**.

---

<p align="center">
Made with ❤️ using Flutter, Firebase, Google Maps & Geolocation
</p>
