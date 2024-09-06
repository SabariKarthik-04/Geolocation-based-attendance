package com.example.demo.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.entity.UserMango;
import com.example.demo.repository.UserRepoMongo;

@Service
public class UserServiceImplMongo {
	@Autowired
	private UserRepoMongo UserRepo;
	
	public UserMango createUser(UserMango User) {
		return UserRepo.save(User);
	}
	
	public List<UserMango> getAllUser(){
		return UserRepo.findAll();
	}
	public UserMango getByUsername(String Username) {
		return UserRepo.findByUsername(Username);
	}
	
	public UserMango authenticateUser(String username,String password) {
		UserMango user = UserRepo.findByUsername(username);
		if(user != null && user.getPassword().equals(password)) {
			return user;
		}
		else {
			return null;
		}
	}
}
