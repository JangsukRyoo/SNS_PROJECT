package com.tt.sns.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.tt.sns.model.dto.ContentDto;
import com.tt.sns.model.dto.LikeDto;

@Repository
public class LikeDaoImpl implements LikeDao {
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSessionTemplate sqlSession;

	@Override
	public int like(LikeDto dto) {
		
		int res = 0;
		try {
			res = sqlSession.insert(NAMESPACE + "like", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public int dislike(LikeDto dto) {
		
		int res = 0;
		
		try {
			res = sqlSession.delete(NAMESPACE + "dislike", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return res;
	}

	@Override
	public int getcount(int content) {
		int res = 0;
		
		try {
			res = sqlSession.selectOne(NAMESPACE + "count", content);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public int likeUpdate(ContentDto dto) {
		int res = 0;
		
		try {
			res = sqlSession.update(NAMESPACE + "likeUpdate", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return res;
	}

	@Override
	public int dislikeUpdate(ContentDto dto) {
		int res = 0;
		
		try {
			res = sqlSession.update(NAMESPACE + "dislikeUpdate", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public String select(LikeDto dto) {
		String res = null;
		
		try {
			res = sqlSession.selectOne(NAMESPACE + "selectLike", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return res;
	}

}
