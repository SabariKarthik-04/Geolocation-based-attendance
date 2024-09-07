package com.example.demo.repository;

import org.springframework.data.mongodb.repository.MongoRepository;

import com.example.demo.entity.UserDataEntity;

public interface UserDataRepo extends MongoRepository<UserDataEntity, Integer> {

}
