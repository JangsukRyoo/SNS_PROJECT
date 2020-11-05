package com.tt.sns.model.biz;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tt.sns.model.dao.LoginDao;
import com.tt.sns.model.dto.UsersDto;

@Service
public class LoginBIzImpl implements LoginBiz {
	private Logger logger = LoggerFactory.getLogger(LoginBiz.class);

	@Autowired
	private LoginDao dao;

	@Override
	public UsersDto login(UsersDto dto) {
		logger.info("LOGIN BIZ");
		return dao.login(dto);
	}

	@Transactional
	@Override
	public int insert(UsersDto dto) {
		logger.info("INSERT BIZ");
		return dao.insert(dto);
	}
	
	@Override
	public UsersDto userinfo(String users_id) {
		return dao.userinfo(users_id);
	}
	
	@Override
	public int insert2(UsersDto dto) {
		return dao.insert2(dto);
	}

	@Override
	public int profileupdate(UsersDto dto) {
		// TODO Auto-generated method stub
		return dao.profileupdate(dto);
	}

	@Override
	public int profileupdate2(UsersDto dto) {
		// TODO Auto-generated method stub
		return dao.profileupdate2(dto);
	}
	@Override
	public UsersDto findAccount(UsersDto dto) {
		UsersDto res = null;
		if(dto.getUsers_id()==null || dto.getUsers_id()=="") {
			res = dao.findId(dto);
		}else {
			res = dao.findPw(dto);
		}
		return res;
	}

	@Override
	public int editPw(UsersDto dto) {
		return dao.editPw(dto);
	}
	@Override
	public UsersDto phoneChk(String users_phone) {
		return dao.phoneChk(users_phone);
	}

	@Override
	public List<UsersDto> userList(String users_id) {
		return dao.userList(users_id);
	}
	
}
