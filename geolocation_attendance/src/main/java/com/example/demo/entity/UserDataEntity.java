package com.example.demo.entity;

import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.annotation.Id;

@Document(collection = "UserData")
public class UserDataEntity {
	@Id
	private int userId;
	private String userName;
	private String userMobileNumber;
	private String userMail;
	private String userDOB;
	private String userPosting;
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserMobileNumber() {
		return userMobileNumber;
	}
	public void setUserMobileNumber(String userMobileNumber) {
		this.userMobileNumber = userMobileNumber;
	}
	public String getUserMail() {
		return userMail;
	}
	public void setUserMail(String userMail) {
		this.userMail = userMail;
	}
	public String getUserDOB() {
		return userDOB;
	}
	public void setUserDOB(String userDOB) {
		this.userDOB = userDOB;
	}
	public String getUserPosting() {
		return userPosting;
	}
	public void setUserPosting(String userPosting) {
		this.userPosting = userPosting;
	}
	@Override
	public String toString() {
		return "UserDataEntity [userId=" + userId + ", userName=" + userName + ", userMobileNumber=" + userMobileNumber
				+ ", userMail=" + userMail + ", userDOB=" + userDOB + ", userPosting=" + userPosting + "]";
	}
	
}
