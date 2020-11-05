package com.tt.sns.model.dao;

import java.util.List;

import com.tt.sns.model.dto.UsersDto;

public interface LoginDao {
	String NAMESPACE = "users.";
	public UsersDto login(UsersDto dto);
	public int insert(UsersDto dto);
	public int insert2(UsersDto dto);
	public UsersDto userinfo(String users_id);
	public int profileupdate(UsersDto dto);
	public int profileupdate2(UsersDto dto);
	public UsersDto findId(UsersDto dto);
	public UsersDto findPw(UsersDto dto);
	public int editPw(UsersDto dto);
	public UsersDto phoneChk(String users_phone);
	public List<UsersDto> userList(String users_id);
}
