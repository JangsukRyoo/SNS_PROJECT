package com.tt.sns.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.tt.sns.model.dto.UsersDto;

@Repository
public class LoginDaoImpl implements LoginDao {
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSessionTemplate sqlSession;

	private Logger logger = LoggerFactory.getLogger(LoginDao.class);

	@Override
	public UsersDto login(UsersDto dto) {
		logger.info("LOGIN DAO");
		UsersDto res = null;

		try {
			res = sqlSession.selectOne(NAMESPACE + "login", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return res;
	}

	@Override
	public int insert(UsersDto dto) {
		logger.info("INSERT DAO");

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
		logger.info("INSERT2 DAO");
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
	public UsersDto userinfo(String users_id) {
		UsersDto dto = null;

		try {
			dto = sqlSession.selectOne(NAMESPACE + "userinfo", users_id);
		} catch (Exception e) {
			System.out.println("[ERROR : userinfodaoimpl]");
			e.printStackTrace();
		}

		return dto;
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
	public UsersDto findId(UsersDto dto) {
		UsersDto res = null;
		try {
			res = sqlSession.selectOne(NAMESPACE + "findId", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public UsersDto findPw(UsersDto dto) {
		UsersDto res = null;
		try {
			res = sqlSession.selectOne(NAMESPACE + "findPw", dto);
		} catch (Exception e) {
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
	public UsersDto phoneChk(String users_phone) {
		UsersDto res = null;
		try {
			res = sqlSession.selectOne(NAMESPACE+"phoneChk",users_phone);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public List<UsersDto> userList(String users_id) {
		List<UsersDto> res = null;
		try {
			res = sqlSession.selectList(NAMESPACE+"userList",users_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}
	
}
