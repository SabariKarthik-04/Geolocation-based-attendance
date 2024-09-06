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

import com.example.demo.entity.Officelocationmodelmongo;
import com.example.demo.service.impl.OfficelocationServiceImplMongo;

@RestController
@RequestMapping("/OfficeLocation")
public class OfficeLoactionController {
	@Autowired
	private OfficelocationServiceImplMongo locationService;
	
	@PostMapping("/SaveLocation")
	public ResponseEntity<?> SaveLocation(@RequestBody Officelocationmodelmongo location){
		Officelocationmodelmongo response = locationService.createLocation(location);
		return ResponseEntity.status(HttpStatus.CREATED).body(response);
		
	}
	@GetMapping("/getByBranchId/{branchId}")
	public ResponseEntity<?> GetByBranchID(@PathVariable int branchId){
		Officelocationmodelmongo respone = locationService.getByBranchId(branchId);
		return ResponseEntity.status(HttpStatus.OK).body(respone);
		
	}
}
