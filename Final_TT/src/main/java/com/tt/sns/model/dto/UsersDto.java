package com.tt.sns.model.dto;

import org.springframework.web.multipart.MultipartFile;

public class UsersDto {
	private int users_no;
	private String users_id;
	private String users_nickname;
	private String users_pw;
	private String users_name;
	private String users_phone;
	private String users_profile;
	private String user_info;
	private MultipartFile mpfile;
	public UsersDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public UsersDto(int users_no, String users_id, String users_nickname, String users_pw, String users_name,
			String users_phone, String users_profile, String user_info, MultipartFile mpfile) {
		super();
		this.users_no = users_no;
		this.users_id = users_id;
		this.users_nickname = users_nickname;
		this.users_pw = users_pw;
		this.users_name = users_name;
		this.users_phone = users_phone;
		this.users_profile = users_profile;
		this.user_info = user_info;
		this.mpfile = mpfile;
	}
	public int getUsers_no() {
		return users_no;
	}
	public void setUsers_no(int users_no) {
		this.users_no = users_no;
	}
	public String getUsers_id() {
		return users_id;
	}
	public void setUsers_id(String users_id) {
		this.users_id = users_id;
	}
	public String getUsers_nickname() {
		return users_nickname;
	}
	public void setUsers_nickname(String users_nickname) {
		this.users_nickname = users_nickname;
	}
	public String getUsers_pw() {
		return users_pw;
	}
	public void setUsers_pw(String users_pw) {
		this.users_pw = users_pw;
	}
	public String getUsers_name() {
		return users_name;
	}
	public void setUsers_name(String users_name) {
		this.users_name = users_name;
	}
	public String getUsers_phone() {
		return users_phone;
	}
	public void setUsers_phone(String users_phone) {
		this.users_phone = users_phone;
	}
	public String getUsers_profile() {
		return users_profile;
	}
	public void setUsers_profile(String users_profile) {
		this.users_profile = users_profile;
	}
	public String getUser_info() {
		return user_info;
	}
	public void setUser_info(String user_info) {
		this.user_info = user_info;
	}
	public MultipartFile getMpfile() {
		return mpfile;
	}
	public void setMpfile(MultipartFile mpfile) {
		this.mpfile = mpfile;
	}
	
	
	
}