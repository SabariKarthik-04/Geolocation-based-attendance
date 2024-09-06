package com.example.demo.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.entity.Officelocationmodelmongo;
import com.example.demo.repository.OfficelocationRepomongo;

@Service
public class OfficelocationServiceImplMongo {
	@Autowired
	private OfficelocationRepomongo locationRepo;
	
	public Officelocationmodelmongo createLocation(Officelocationmodelmongo location) {
		return locationRepo.save(location);
	}
	public Officelocationmodelmongo getByBranchId(int branchId) {
		return locationRepo.findByBranchId(branchId);
	}
	
}
