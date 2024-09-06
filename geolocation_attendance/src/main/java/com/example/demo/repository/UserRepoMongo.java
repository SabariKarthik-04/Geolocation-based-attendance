package com.example.demo.repository;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;
import com.example.demo.entity.UserMango;

@Repository
public interface UserRepoMongo extends MongoRepository<UserMango, Integer>{
	UserMango findByUsername(String username);
}

