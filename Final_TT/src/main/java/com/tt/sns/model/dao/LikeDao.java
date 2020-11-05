package com.tt.sns.model.dao;

import com.tt.sns.model.dto.ContentDto;
import com.tt.sns.model.dto.LikeDto;

public interface LikeDao {
	
	String NAMESPACE = "like.";
	
	public int like(LikeDto dto);
	public int dislike(LikeDto dto);
	public int getcount(int content);
	public int likeUpdate(ContentDto dto);
	public int dislikeUpdate(ContentDto dto);
	public String select(LikeDto dto);
	
}
