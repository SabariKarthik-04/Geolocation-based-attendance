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
public class AttendanceDBController {
    
    @Autowired
    private AttendanceDBServiceImpl AttService;
    
    @PostMapping("/SaveUserAttendance")
    public ResponseEntity<String> saveUserAttendance(@RequestBody AttendanceDBModel attendance) {
        String response = AttService.saveAttendance(attendance);
        if ("Attendance saved successfully.".equals(response)) {
            return ResponseEntity.status(HttpStatus.CREATED).body(response);
        }
        else if("Attendance Updated Sucessfully".equals(response)) {
        	return ResponseEntity.status(HttpStatus.OK).body(response);
        }
        else if("Attendance already marked or no changes detected.".equals(response)) {
        	return ResponseEntity.status(HttpStatus.ALREADY_REPORTED).body(response);
        }
        else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
        }
    }
    

    @GetMapping("/GetAllByUserID/{userId}")
    public ResponseEntity<?> getAllUserById(@PathVariable int userId) {
        List<AttendanceDBModel> response = AttService.getAttendancesByUserId(userId);
        if (response != null && !response.isEmpty()) {
            return ResponseEntity.status(HttpStatus.OK).body(response);
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("No attendance records found for userId: " + userId);
        }
    }
}
