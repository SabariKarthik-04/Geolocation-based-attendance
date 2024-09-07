package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.entity.AttendanceDBModel;
import com.example.demo.service.impl.AttendanceDBServiceImpl;

@RestController
@RequestMapping("/UserAttendance")
public class AttendanceDBcontroller {
    
    @Autowired
    private AttendanceDBServiceImpl AttService;
    
    @PostMapping("/SaveUserAttendance")
    public ResponseEntity<?> saveUserAttendance(@RequestBody AttendanceDBModel attendance) {
        String response = AttService.saveAttendance(attendance);
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }
    
    @GetMapping("/GetUserById/{userId}")
    public ResponseEntity<?> getUserById(@PathVariable int userId) {
        AttendanceDBModel response = AttService.getAttendanceById(userId);
        if (response != null) {
            return ResponseEntity.status(HttpStatus.OK).body(response);
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("No attendance record found for userId: " + userId);
        }
    }
    
    @GetMapping("/GetAllByUserID/{userId}")
    public ResponseEntity<?> getAllUserById(@PathVariable int userId) {
        List<AttendanceDBModel> response = AttService.getAttendancesByuserId(userId);
        if (response != null && !response.isEmpty()) {
            return ResponseEntity.status(HttpStatus.OK).body(response);
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("No attendance records found for userId: " + userId);
        }
    }
}
