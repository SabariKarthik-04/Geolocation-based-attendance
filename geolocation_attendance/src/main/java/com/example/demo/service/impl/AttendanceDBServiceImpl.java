package com.example.demo.service.impl;
import java.time.Duration;
import java.time.LocalTime;
import java.util.List;
import java.util.Optional;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.data.mongodb.core.MongoTemplate;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;

import com.example.demo.entity.AttendanceDBModel;
import com.example.demo.repository.AttendanceDBRepo;

@Service
public class AttendanceDBServiceImpl {

    @Autowired
    private AttendanceDBRepo AttRepo;
    
    @Autowired
    private MongoTemplate mongoTemplate;
    
    public String saveAttendance(AttendanceDBModel newAttendance) {
        Optional<AttendanceDBModel> existingAttendance = AttRepo.findByUserIdAndDate(newAttendance.getUserId(), newAttendance.getDate());
        if (existingAttendance.isPresent()) {
            return updateCheckout(newAttendance);
        } else {
            if (newAttendance.getAutoGeoAttendance() != null) {
                if (newAttendance.getAutoGeoAttendance().getGeoCheckIn() == null) {
                    newAttendance.getAutoGeoAttendance().setGeoCheckIn("null");
                }
                if (newAttendance.getAutoGeoAttendance().getGeoCheckOut() == null) {
                    newAttendance.getAutoGeoAttendance().setGeoCheckOut("null");
                }
            }
            
            if (newAttendance.getManualGeoAttendance() != null) {
                
                if (newAttendance.getManualGeoAttendance().getManualCheckIn() == null) {
                    newAttendance.getManualGeoAttendance().setManualCheckIn("null");
                }
                if (newAttendance.getManualGeoAttendance().getManualCheckOut() == null) {
                    newAttendance.getManualGeoAttendance().setManualCheckOut("null");
                }
            }
            
            AttRepo.save(newAttendance);
            return "Attendance saved successfully.";
        }
    }

    
    public String updateCheckout(AttendanceDBModel updatedAttendance) {
        int userId = updatedAttendance.getUserId();
        String date = updatedAttendance.getDate();
        Optional<AttendanceDBModel> oldAtt = AttRepo.findByUserIdAndDate(userId, date);
        if (!oldAtt.isPresent()) {
            return "Attendance record not found.";
        }

        AttendanceDBModel existAtt = oldAtt.get();
        Query query = new Query(Criteria.where("userId").is(userId).and("date").is(date));
        Update update = new Update();
        boolean updated = false;

        if (updatedAttendance.getAutoGeoAttendance() != null) {
            if (shouldUpdateCheckIn(updatedAttendance.getAutoGeoAttendance().getGeoCheckIn(), existAtt.getAutoGeoAttendance().getGeoCheckIn())) {
                update.set("autoGeoAttendance.geoCheckIn", updatedAttendance.getAutoGeoAttendance().getGeoCheckIn());
                updated = true;
            }
            if (shouldUpdateCheckOut(updatedAttendance.getAutoGeoAttendance().getGeoCheckOut(), existAtt.getAutoGeoAttendance().getGeoCheckOut())) {
                update.set("autoGeoAttendance.geoCheckOut", updatedAttendance.getAutoGeoAttendance().getGeoCheckOut());
                double totalHours = calculateHours(existAtt.getAutoGeoAttendance().getGeoCheckIn(), updatedAttendance.getAutoGeoAttendance().getGeoCheckOut());
                update.set("autoGeoAttendance.geoTotalHours", totalHours);
                updated = true;
            }
        }

        if (updatedAttendance.getManualGeoAttendance() != null) {
            if (shouldUpdateCheckIn(updatedAttendance.getManualGeoAttendance().getManualCheckIn(), existAtt.getManualGeoAttendance().getManualCheckIn())) {
                update.set("manualGeoAttendance.manualCheckIn", updatedAttendance.getManualGeoAttendance().getManualCheckIn());
                updated = true;
            }
            if (shouldUpdateCheckOut(updatedAttendance.getManualGeoAttendance().getManualCheckOut(), existAtt.getManualGeoAttendance().getManualCheckOut())) {
                update.set("manualGeoAttendance.manualCheckOut", updatedAttendance.getManualGeoAttendance().getManualCheckOut());
                double totalHours = calculateHours(existAtt.getManualGeoAttendance().getManualCheckIn(), updatedAttendance.getManualGeoAttendance().getManualCheckOut());
                update.set("manualGeoAttendance.manualTotalHours", totalHours);
                updated = true;
            }
        }
        

        if (updated) {
            mongoTemplate.updateFirst(query, update, AttendanceDBModel.class);
            return "Attendance updated successfully.";
            
        } else {
        	
            return "Attendance already marked or no changes detected.";
            
        }
    }

    private boolean shouldUpdateCheckIn(String newCheckIn, String existingCheckIn) {
        return newCheckIn != null && !newCheckIn.equals("null") && (existingCheckIn == null || "null".equals(existingCheckIn));
    }


    private boolean shouldUpdateCheckOut(String newCheckOut, String existingCheckOut) {
        return newCheckOut != null && !newCheckOut.equals("null") && (existingCheckOut == null || "null".equals(existingCheckOut));
    }

    private double calculateHours(String inTime, String outTime) {
        LocalTime startTime = LocalTime.parse(inTime);
        LocalTime endTime = LocalTime.parse(outTime);
        Duration duration = Duration.between(startTime, endTime);
        return duration.toMinutes() / 60.0;
    }


    public List<AttendanceDBModel> getAttendancesByUserId(int userId) {
        List<AttendanceDBModel> attendances = AttRepo.findAllByUserId(userId);
        System.out.println("Retrieved attendances: " + attendances);
        return attendances;
    }
    
    
}
