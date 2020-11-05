package com.tt.sns.model.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tt.sns.model.dao.MariaDao;
import com.tt.sns.model.dto.DmDto;
import com.tt.sns.model.dto.DmsubDto;
import com.tt.sns.model.dto.OpenchatsubDto;
import com.tt.sns.model.dto.UsersDto;

@Service
public class MariaBizImpl implements MariaBiz {

	@Autowired
	private MariaDao dao;
	
	
	@Override
	public int insert(UsersDto dto) {
		return dao.insert(dto);
	}

	@Override
	public int insert2(UsersDto dto) {
		return dao.insert2(dto);
	}

	@Override
	public int editPw(UsersDto dto) {
		return dao.editPw(dto);
	}

	@Override
	public int profileupdate(UsersDto dto) {
		return dao.profileupdate(dto);
	}

	@Override
	public int profileupdate2(UsersDto dto) {
		return dao.profileupdate2(dto);
	}

	@Override
	public List<OpenchatsubDto> openchatsub(String openname) {
		return dao.openchatsub(openname);
	}


	@Override
	public List<DmsubDto> dmsub(DmDto dto) {
		return dao.dmsub(dto);
	}


}
