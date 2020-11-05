package com.tt.sns.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.tt.sns.model.dto.DmDto;
import com.tt.sns.model.dto.DmsubDto;
import com.tt.sns.model.dto.MyOpenchatDto;
import com.tt.sns.model.dto.OpenchatsubDto;
import com.tt.sns.model.dto.UsersDto;

@Repository
public class MariaDaoImpl implements MariaDao {

	@Autowired
	@Qualifier("sqlSessionTemplate2")
	private SqlSessionTemplate sqlSession;

	@Override
	public int insert(UsersDto dto) {

		int res = 0;

		try {
			res = sqlSession.insert(NAMESPACE + "insert", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int insert2(UsersDto dto) {
		int res = 0;
		try {
			res = sqlSession.insert(NAMESPACE + "insert2", dto);
		} catch (Exception e) {
			System.out.println("error insert2 daoimpl");
			e.printStackTrace();
		}

		return res;
	}

	@Override
	public int editPw(UsersDto dto) {
		int res = 0;
		try {
			res = sqlSession.update(NAMESPACE + "editPw", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}
	
	@Override
	public int profileupdate(UsersDto dto) {
		int res = 0;

		try {
			res = sqlSession.update(NAMESPACE + "profileupdate", dto);
		} catch (Exception e) {
			System.out.println("[ERROR : profileupdate dao impl]");
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int profileupdate2(UsersDto dto) {
		int res = 0;

		try {
			res = sqlSession.update(NAMESPACE + "profileupdate2", dto);
		} catch (Exception e) {
			System.out.println("[ERROR : profileupdate2 dao impl]");
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public List<OpenchatsubDto> openchatsub(String openname) {
		List<OpenchatsubDto> res = null;
		int res2 = 0;	// N을 Y로
		
		try {
			res = sqlSession.selectList(NAMESPACE +"openchatsub", openname);
			res2 = sqlSession.update(NAMESPACE + "statusupdate", openname);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return res;
	}


	@Override
	public List<DmsubDto> dmsub(DmDto dto) {
		List<DmsubDto> res = null;
		
		try {
			res = sqlSession.selectList(NAMESPACE + "dmsub", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return res;
	}

	
}
