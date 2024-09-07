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

import com.example.demo.entity.UserDataEntity;
import com.example.demo.service.impl.UserDataServiceImpl;

@RestController
@RequestMapping("/UserData")
public class UserDataController {
	@Autowired
	private UserDataServiceImpl userService;
	
	@PostMapping("/SaveUserData")
	public ResponseEntity<?> saveUserData(@RequestBody UserDataEntity user){
		String response = userService.saveUser(user);
		return ResponseEntity.status(HttpStatus.ACCEPTED).body(response);
	}
	
	@GetMapping("/getUserDataById/{userId}")
	public ResponseEntity<?> getUserDataById(@PathVariable int userId){
		UserDataEntity response = userService.getUserById(userId);
		return ResponseEntity.status(HttpStatus.OK).body(response);
	}
}
