package com.example.demo.controller;

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
	
	
	@PostMapping("/SaveUserLocation")
	public ResponseEntity<?> saveUserLocation(@RequestBody AttendanceDBModel attendance){
		AttendanceDBModel response = AttService.saveAttendance(attendance);
		return ResponseEntity.status(HttpStatus.CREATED).body(response);
	}
	
	@GetMapping("/CheckINStatus/{userId}")
	public ResponseEntity<?> checkInStatus(@PathVariable int userId) {
	    AttendanceDBModel response = AttService.checkInStatus(userId);
	    
	    if (response != null) {
	        if (response.getAutoGeoAttendance().getGeoCheckIn() != null) {
	            return ResponseEntity.ok("User has already checked in.");
	        } else {
	            return ResponseEntity.status(HttpStatus.ACCEPTED).body("User has not checked in.");
	        }
	    } else {
	        return ResponseEntity.status(HttpStatus.NOT_FOUND).body("No attendance record found for the user.");
	    }
	}
	
	@GetMapping("/getByID/{userId}")
	public ResponseEntity<?> getById(@PathVariable int userId){
		AttendanceDBModel response = AttService.checkInStatus(userId);
		return ResponseEntity.status(HttpStatus.OK).body(response);
	}

}
