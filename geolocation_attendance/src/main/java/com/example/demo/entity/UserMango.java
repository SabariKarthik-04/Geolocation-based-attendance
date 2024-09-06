package com.example.demo.entity;

import org.springframework.data.mongodb.core.mapping.Document;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
@Document(collection = "Users")
public class UserMango {
	@Id
	private int userId;
	private String username;
	private String password;
	private boolean admin;
	private int branchId;
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public boolean isAdmin() {
		return admin;
	}
	public void setAdmin(boolean admin) {
		this.admin = admin;
	}
	public int getBranchId() {
		return branchId;
	}
	public void setBranchId(int branchId) {
		this.branchId = branchId;
	}
	@Override
	public String toString() {
		return "UserMango [userId=" + userId + ", username=" + username + ", password=" + password + ", admin=" + admin
				+ ", branchId=" + branchId + "]";
	}

	
	
	
}
