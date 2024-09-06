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

import com.example.demo.entity.UserMango;
import com.example.demo.service.impl.UserServiceImplMongo;
@RestController
@RequestMapping("/User")
public class AppController {
	@Autowired
	private UserServiceImplMongo userServiceMongo;
	@PostMapping("/SaveUser")
	public ResponseEntity<?> saveUser(@RequestBody UserMango user){
		UserMango response = userServiceMongo.createUser(user);
		return ResponseEntity.status(HttpStatus.CREATED).body(response);
		
	}
	@GetMapping("/GetAllUsers")
	public ResponseEntity<?> getAllUser(){
		List<UserMango> response =userServiceMongo.getAllUser();
		return ResponseEntity.status(HttpStatus.OK).body(response);
	}
	@GetMapping("/GetByUsername/{Username}")
	public ResponseEntity<?> getByUserName(@PathVariable String Username){
		UserMango response = userServiceMongo.getByUsername(Username);
		return ResponseEntity.status(HttpStatus.OK).body(response);
	}
	@PostMapping("/login")
	public ResponseEntity<?> loginUser(@RequestBody UserMango loginRequest){
		UserMango response = userServiceMongo.authenticateUser(loginRequest.getUsername(), loginRequest.getPassword());
		if(response != null) {
			return ResponseEntity.ok(response);
		}
		else {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid ussername or password");
		}
	}
}
