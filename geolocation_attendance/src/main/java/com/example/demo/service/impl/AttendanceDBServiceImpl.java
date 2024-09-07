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
            Optional<AttendanceDBModel> existingAttendance = AttRepo.findByUserIdAndDate(newAttendance.getUserId(), newAttendance.getDate());
            if (existingAttendance.isPresent()) {
                return "Attendance for this date already exists for this user.";
            }

            AttRepo.save(newAttendance);
            return "Attendance saved successfully.";
    }


    public List<AttendanceDBModel> getAttendancesByUserId(int userId) {
        List<AttendanceDBModel> attendances = AttRepo.findAllByUserId(userId);
        System.out.println("Retrieved attendances: " + attendances);
        return attendances;
    }
}
