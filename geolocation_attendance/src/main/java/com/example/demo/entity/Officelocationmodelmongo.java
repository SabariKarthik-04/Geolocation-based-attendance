package com.example.demo.entity;

import org.springframework.data.mongodb.core.mapping.Document;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
@Document(collection = "Officelocation")
public class Officelocationmodelmongo {
	@Id
	private int branchId;
	private float latitude;
	private float longitude;
	private String branchName;
	public int getBranchId() {
		return branchId;
	}
	public void setBranchId(int branchId) {
		this.branchId = branchId;
	}
	public float getLatitude() {
		return latitude;
	}
	public void setLatitude(float latitude) {
		this.latitude = latitude;
	}
	public float getLongitude() {
		return longitude;
	}
	public void setLongitude(float longitude) {
		this.longitude = longitude;
	}
	public String getBranchName() {
		return branchName;
	}
	public void setBranchName(String branchName) {
		this.branchName = branchName;
	}
	@Override
	public String toString() {
		return "Officelocationmodelmongo [branchId=" + branchId + ", latitude=" + latitude + ", longitude=" + longitude
				+ ", branchName=" + branchName + "]";
	}
}
