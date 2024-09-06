package com.example.demo.repository;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import com.example.demo.entity.AttendanceDBModel;

@Repository
public interface AttendanceDBRepo extends MongoRepository<AttendanceDBModel, Integer>{
}
