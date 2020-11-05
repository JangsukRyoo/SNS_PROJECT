package com.tt.sns.model.biz;

import java.util.List;

import com.tt.sns.model.dto.DmDto;
import com.tt.sns.model.dto.DmsubDto;
import com.tt.sns.model.dto.MyOpenchatDto;
import com.tt.sns.model.dto.OpenchatsubDto;
import com.tt.sns.model.dto.UsersDto;

public interface MariaBiz {
	public int insert(UsersDto dto);
	public int insert2(UsersDto dto);
	public int editPw(UsersDto dto);
	public int profileupdate(UsersDto dto);
	public int profileupdate2(UsersDto dto);
	public List<OpenchatsubDto> openchatsub(String openname);
	public List<DmsubDto> dmsub(DmDto dto);
}
