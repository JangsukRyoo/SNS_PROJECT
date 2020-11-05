package com.tt.sns.model.biz;

import java.util.List;

import com.tt.sns.model.dto.UsersDto;

public interface LoginBiz {
	public UsersDto login(UsersDto dto);
	public int insert(UsersDto dto);
	public int insert2(UsersDto dto);
	public UsersDto userinfo(String users_id);
	public int profileupdate(UsersDto dto);
	public int profileupdate2(UsersDto dto);
	public UsersDto findAccount(UsersDto dto);
	public int editPw(UsersDto dto);
	public UsersDto phoneChk(String users_phone);
	public List<UsersDto> userList(String users_id);
}
