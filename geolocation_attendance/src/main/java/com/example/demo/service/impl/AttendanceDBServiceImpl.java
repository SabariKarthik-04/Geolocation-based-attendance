package com.example.demo.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.entity.AttendanceDBModel;
import com.example.demo.repository.AttendanceDBRepo;

@Service
public class AttendanceDBServiceImpl {

    @Autowired
    private AttendanceDBRepo AttRepo;
    
    public String saveAttendance(AttendanceDBModel newAttendance) {
        if (getAttByAttId(newAttendance.getAttId())) {
            return "Please give another attendance ID.";
        } else {
            Optional<AttendanceDBModel> existingAttendance = AttRepo.findByUserIdAndDate(newAttendance.getUserId(), newAttendance.getDate());
            if (existingAttendance.isPresent()) {
                return "Attendance for this date already exists for this user.";
            }

            AttRepo.save(newAttendance);
            return "Attendance saved successfully.";
        }
    }

    public AttendanceDBModel getAttendanceById(int userId) {
        return AttRepo.findByUserId(userId);
    }

    public boolean getAttByAttId(int attId) {
        Optional<AttendanceDBModel> res = AttRepo.findById(attId);
        return res.isPresent();
    }

    public List<AttendanceDBModel> getAttendancesByUserId(int userId) {
        List<AttendanceDBModel> attendances = AttRepo.findAllByUserId(userId);
        System.out.println("Retrieved attendances: " + attendances);
        return attendances;
    }
}
