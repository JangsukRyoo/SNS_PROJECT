package com.tt.sns.model.biz;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tt.sns.model.dao.LikeDao;
import com.tt.sns.model.dto.ContentDto;
import com.tt.sns.model.dto.LikeDto;

@Service
public class LikeBizImpl implements LikeBiz {
	
	@Autowired
	private LikeDao dao;
	
	@Override
	public int like(LikeDto dto) {
		return dao.like(dto);
	}

	@Override
	public int dislike(LikeDto dto) {
		return dao.dislike(dto);
	}

	@Override
	public int getcount(int content) {
		return dao.getcount(content);
	}

	@Override
	public int likeUpdate(ContentDto cdto) {
		return dao.likeUpdate(cdto);
	}

	@Override
	public int dislikeUpdate(ContentDto cdto) {
		return dao.dislikeUpdate(cdto);
	}

	@Override
	public String select(LikeDto dto) {
		return dao.select(dto);
	}

}
