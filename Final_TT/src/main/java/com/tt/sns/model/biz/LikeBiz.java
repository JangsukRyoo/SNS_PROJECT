package com.tt.sns.model.biz;

import com.tt.sns.model.dto.ContentDto;
import com.tt.sns.model.dto.LikeDto;

public interface LikeBiz {
	public int like(LikeDto dto);
	public int dislike(LikeDto dto);
	public int getcount(int content);
	public int likeUpdate(ContentDto cdto);
	public int dislikeUpdate(ContentDto cdto);
	public String select(LikeDto dto);
}
