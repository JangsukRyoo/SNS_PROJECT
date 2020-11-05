package com.tt.sns;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tt.sns.model.biz.LikeBiz;
import com.tt.sns.model.dto.ContentDto;
import com.tt.sns.model.dto.LikeDto;

/**
 * Handles requests for the application home page.
 */

@Controller
public class LikeController {

	private static final Logger logger = LoggerFactory.getLogger(LikeController.class);

	@Autowired
	private LikeBiz biz;

	@RequestMapping(value = "like.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Integer> like(@RequestBody LikeDto dto) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		ContentDto cdto = null;
		cdto = new ContentDto();
		
		int like = biz.like(dto);
		int count = 0;
		count = biz.getcount(dto.getContent());
		if(like > 0) {
			count = count + 1;
			cdto.setContent_no(dto.getContent());
			cdto.setContent_like_count(count);
			int update = biz.likeUpdate(cdto);
			
			System.out.println("좋아요 성공");
		}
		map.put("count", count);
		
		return map;
	}

	@RequestMapping(value = "dislike.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Integer> dislike(@RequestBody LikeDto dto) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		ContentDto cdto = null;
		cdto = new ContentDto();
		
		int dislike = biz.dislike(dto);
		int count = 0;
		count = biz.getcount(dto.getContent());
		
		if(dislike > 0) {
			count = count -1;
			cdto.setContent_no(dto.getContent());
			cdto.setContent_like_count(count);
			System.out.println("싫어요 성공");
			int update = biz.dislikeUpdate(cdto);
		}

		map.put("count", count);
		
		return map;
	}

	
}
