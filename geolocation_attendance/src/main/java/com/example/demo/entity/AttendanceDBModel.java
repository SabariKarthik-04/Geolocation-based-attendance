package com.example.demo.entity;

import java.time.LocalDateTime;

import org.springframework.data.mongodb.core.mapping.Document;

import jakarta.persistence.Embeddable;
import jakarta.persistence.Embedded;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
@Document(collection  = "UserAttendance")
public class AttendanceDBModel {
    @Id
    private int userId;
    private String userName;
    
    @Embedded
    private AutomatedGeoAttendance autoGeoAttendance;
    
    @Embedded
    private ManualAttendance manualGeoAttendance;

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public AutomatedGeoAttendance getAutoGeoAttendance() {
        return autoGeoAttendance;
    }

    public void setAutoGeoAttendance(AutomatedGeoAttendance autoGeoAttendance) {
        this.autoGeoAttendance = autoGeoAttendance;
    }

    public ManualAttendance getManualGeoAttendance() {
        return manualGeoAttendance;
    }

    public void setManualGeoAttendance(ManualAttendance manualGeoAttendance) {
        this.manualGeoAttendance = manualGeoAttendance;
    }

    @Override
    public String toString() {
        return "AttendanceDBModel [userId=" + userId + ", userName=" + userName + ", autoGeoAttendance="
                + autoGeoAttendance + ", manualGeoAttendance=" + manualGeoAttendance + "]";
    }

    @Embeddable
    public static class AutomatedGeoAttendance {
        private LocalDateTime geoCheckIn;
        private LocalDateTime geoCheckOut;
        private double geoTotalHours;

        public LocalDateTime getGeoCheckIn() {
            return geoCheckIn;
        }

        public void setGeoCheckIn(LocalDateTime geoCheckIn) {
            this.geoCheckIn = geoCheckIn;
        }

        public LocalDateTime getGeoCheckOut() {
            return geoCheckOut;
        }

        public void setGeoCheckOut(LocalDateTime geoCheckOut) {
            this.geoCheckOut = geoCheckOut;
        }

        public double getGeoTotalHours() {
            return geoTotalHours;
        }

        public void setGeoTotalHours(double geoTotalHours) {
            this.geoTotalHours = geoTotalHours;
        }

        @Override
        public String toString() {
            return "AutomatedGeoAttendance [geoCheckIn=" + geoCheckIn + ", geoCheckOut=" + geoCheckOut
                    + ", geoTotalHours=" + geoTotalHours + "]";
        }
    }

    @Embeddable
    public static class ManualAttendance {
        private LocalDateTime manualCheckIn;
        private LocalDateTime manualCheckOut;
        private double manualTotalHours;

        public LocalDateTime getManualCheckIn() {
            return manualCheckIn;
        }

        public void setManualCheckIn(LocalDateTime manualCheckIn) {
            this.manualCheckIn = manualCheckIn;
        }

        public LocalDateTime getManualCheckOut() {
            return manualCheckOut;
        }

        public void setManualCheckOut(LocalDateTime manualCheckOut) {
            this.manualCheckOut = manualCheckOut;
        }

        public double getManualTotalHours() {
            return manualTotalHours;
        }

        public void setManualTotalHours(double manualTotalHours) {
            this.manualTotalHours = manualTotalHours;
        }

        @Override
        public String toString() {
            return "ManualAttendance [manualCheckIn=" + manualCheckIn + ", manualCheckOut=" + manualCheckOut
                    + ", manualTotalHours=" + manualTotalHours + "]";
        }
    }
}
