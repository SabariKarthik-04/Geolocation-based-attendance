package com.example.demo.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import com.example.demo.entity.AttendanceDBModel;

@Repository
public interface AttendanceDBRepo extends MongoRepository<AttendanceDBModel, Integer>{
	AttendanceDBModel findByUserId(int userId);
	
	List<AttendanceDBModel> findAllByUserId(int userId);
	
	Optional<AttendanceDBModel> findByUserIdAndDate(int userId, String date);
}
