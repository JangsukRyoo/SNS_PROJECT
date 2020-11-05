package com.tt.sns.model.dto;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class ContentDto {
	private int content_no;
	private String content_photo;
	private String content_substance;
	private String content_place_name;
	private String content_place_lat;
	private String content_place_lon;
	private List<MultipartFile> mpfile;
	private String content_users_id;
	private int content_comment_count;
	private int content_like_count;
	private Date content_date;
	private FollowDto followdto;
	private String content_hashtag;

	public ContentDto() {
		super();
	}

	public ContentDto(int content_no, String content_photo, String content_substance, String content_place_name,
			String content_place_lat, String content_place_lon, List<MultipartFile> mpfile, String content_users_id,
			int content_comment_count, int content_like_count, Date content_date, FollowDto followdto,
			String content_hashtag) {
		super();
		this.content_no = content_no;
		this.content_photo = content_photo;
		this.content_substance = content_substance;
		this.content_place_name = content_place_name;
		this.content_place_lat = content_place_lat;
		this.content_place_lon = content_place_lon;
		this.mpfile = mpfile;
		this.content_users_id = content_users_id;
		this.content_comment_count = content_comment_count;
		this.content_like_count = content_like_count;
		this.content_date = content_date;
		this.followdto = followdto;
		this.content_hashtag = content_hashtag;
	}

	public int getContent_no() {
		return content_no;
	}

	public void setContent_no(int content_no) {
		this.content_no = content_no;
	}

	public String getContent_photo() {
		return content_photo;
	}

	public void setContent_photo(String content_photo) {
		this.content_photo = content_photo;
	}

	public String getContent_substance() {
		return content_substance;
	}

	public void setContent_substance(String content_substance) {
		this.content_substance = content_substance;
	}

	public String getContent_place_name() {
		return content_place_name;
	}

	public void setContent_place_name(String content_place_name) {
		this.content_place_name = content_place_name;
	}

	public String getContent_place_lat() {
		return content_place_lat;
	}

	public void setContent_place_lat(String content_place_lat) {
		this.content_place_lat = content_place_lat;
	}

	public String getContent_place_lon() {
		return content_place_lon;
	}

	public void setContent_place_lon(String content_place_lon) {
		this.content_place_lon = content_place_lon;
	}

	public List<MultipartFile> getMpfile() {
		return mpfile;
	}

	public void setMpfile(List<MultipartFile> mpfile) {
		this.mpfile = mpfile;
	}

	public String getContent_users_id() {
		return content_users_id;
	}

	public void setContent_users_id(String content_users_id) {
		this.content_users_id = content_users_id;
	}

	public int getContent_comment_count() {
		return content_comment_count;
	}

	public void setContent_comment_count(int content_comment_count) {
		this.content_comment_count = content_comment_count;
	}

	public int getContent_like_count() {
		return content_like_count;
	}

	public void setContent_like_count(int content_like_count) {
		this.content_like_count = content_like_count;
	}

	public Date getContent_date() {
		return content_date;
	}

	public void setContent_date(Date content_date) {
		this.content_date = content_date;
	}

	public FollowDto getFollowdto() {
		return followdto;
	}

	public void setFollowdto(FollowDto followdto) {
		this.followdto = followdto;
	}

	public String getContent_hashtag() {
		return content_hashtag;
	}

	public void setContent_hashtag(String content_hashtag) {
		this.content_hashtag = content_hashtag;
	}


	
	
}
