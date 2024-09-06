package com.example.demo.repository;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import com.example.demo.entity.Officelocationmodelmongo;

@Repository
public interface OfficelocationRepomongo extends MongoRepository<Officelocationmodelmongo, String>{
	Officelocationmodelmongo findByBranchId(int branchId);

}
