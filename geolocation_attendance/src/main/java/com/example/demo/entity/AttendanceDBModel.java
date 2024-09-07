package com.example.demo.entity;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.annotation.Id;

@Document(collection = "UserAttendance")
public class AttendanceDBModel {

    
    private int userId;
    private String userName;
    private String date;
    
    private AutomatedGeoAttendance autoGeoAttendance;
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

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
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
		return "AttendanceDBModel [userId=" + userId + ", userName=" + userName + ", date=" + date
				+ ", autoGeoAttendance=" + autoGeoAttendance + ", manualGeoAttendance=" + manualGeoAttendance + "]";
	}


	public static class AutomatedGeoAttendance {
        private String geoCheckIn;
        private String geoCheckOut;
        private double geoTotalHours;

        public String getGeoCheckIn() {
            return geoCheckIn;
        }

        public void setGeoCheckIn(String geoCheckIn) {
            this.geoCheckIn = geoCheckIn;
        }

        public String getGeoCheckOut() {
            return geoCheckOut;
        }

        public void setGeoCheckOut(String geoCheckOut) {
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

    public static class ManualAttendance {
        private String manualCheckIn;
        private String manualCheckOut;
        private double manualTotalHours;

        public String getManualCheckIn() {
            return manualCheckIn;
        }

        public void setManualCheckIn(String manualCheckIn) {
            this.manualCheckIn = manualCheckIn;
        }

        public String getManualCheckOut() {
            return manualCheckOut;
        }

        public void setManualCheckOut(String manualCheckOut) {
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
