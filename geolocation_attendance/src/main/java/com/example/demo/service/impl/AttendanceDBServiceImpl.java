package com.example.demo.service.impl;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.entity.AttendanceDBModel;
import com.example.demo.repository.AttendanceDBRepo;

@Service
public class AttendanceDBServiceImpl {
	@Autowired
	private AttendanceDBRepo AttRepo;
	
	public AttendanceDBModel saveAttendance(AttendanceDBModel NewAttendance) {
		return AttRepo.save(NewAttendance);
	}
	
	public AttendanceDBModel checkInStatus(int userId) {
		Optional<AttendanceDBModel> response = AttRepo.findById(userId);
		return response.orElse(null);
	}
}
