package com.douzone.jblog.vo;

import org.hibernate.validator.constraints.Length;

public class UserVo {

	@Length(min=5, max=16)
	private String id;
	
	@Length(min=2, max=8)
	private String name;
	
	@Length(min=4, max=16)
	private String password;
	private String joinDate;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getJoinDate() {
		return joinDate;
	}

	public void setJoinDate(String joinDate) {
		this.joinDate = joinDate;
	}

	@Override
	public String toString() {
		return "UserVo [id=" + id + ", name=" + name + ", password=" + password + ", joinDate=" + joinDate + "]";
	}

}
