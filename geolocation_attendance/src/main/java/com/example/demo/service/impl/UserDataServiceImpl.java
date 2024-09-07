package com.example.demo.service.impl;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.entity.UserDataEntity;
import com.example.demo.repository.UserDataRepo;

@Service
public class UserDataServiceImpl {
	@Autowired
	private UserDataRepo userRepo;
	public boolean checkUserIsPresentInDB(int userId) {
		Optional<UserDataEntity> user = userRepo.findById(userId);
		return user.isPresent();
	}
	
	public String saveUser(UserDataEntity user) {
		if(checkUserIsPresentInDB(user.getUserId())) {
			return "Please Give Correct UserID";
		}
		else {
			userRepo.save(user);
			return "User Added Successfully";
		}
	}
	
	public UserDataEntity getUserById(int userId) {
		Optional<UserDataEntity> user = userRepo.findById(userId);
		return user.orElse(null);
	}
}
