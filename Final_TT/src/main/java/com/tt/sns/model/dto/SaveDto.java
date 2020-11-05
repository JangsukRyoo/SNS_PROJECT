package com.tt.sns.model.dto;

import java.util.Date;

public class SaveDto {
	private int save_content_no;
	private String save_content_photo;
	private String save_content_substance;
	private String save_content_place_name;
	private String save_content_place_lat;
	private String save_content_place_lon;
	private String save_content_users_id;
	private String save_content_hashtag;
	private Date save_content_date;
	private String save_user_id;
	
	public SaveDto() {
		super();
		// TODO Auto-generated constructor stub
	}

	public SaveDto(int save_content_no, String save_content_photo, String save_content_substance,
			String save_content_place_name, String save_content_place_lat, String save_content_place_lon,
			String save_content_users_id, String save_content_hashtag, Date save_content_date, String save_user_id) {
		super();
		this.save_content_no = save_content_no;
		this.save_content_photo = save_content_photo;
		this.save_content_substance = save_content_substance;
		this.save_content_place_name = save_content_place_name;
		this.save_content_place_lat = save_content_place_lat;
		this.save_content_place_lon = save_content_place_lon;
		this.save_content_users_id = save_content_users_id;
		this.save_content_hashtag = save_content_hashtag;
		this.save_content_date = save_content_date;
		this.save_user_id = save_user_id;
	}

	public int getSave_content_no() {
		return save_content_no;
	}

	public void setSave_content_no(int save_content_no) {
		this.save_content_no = save_content_no;
	}

	public String getSave_content_photo() {
		return save_content_photo;
	}

	public void setSave_content_photo(String save_content_photo) {
		this.save_content_photo = save_content_photo;
	}

	public String getSave_content_substance() {
		return save_content_substance;
	}

	public void setSave_content_substance(String save_content_substance) {
		this.save_content_substance = save_content_substance;
	}

	public String getSave_content_place_name() {
		return save_content_place_name;
	}

	public void setSave_content_place_name(String save_content_place_name) {
		this.save_content_place_name = save_content_place_name;
	}

	public String getSave_content_place_lat() {
		return save_content_place_lat;
	}

	public void setSave_content_place_lat(String save_content_place_lat) {
		this.save_content_place_lat = save_content_place_lat;
	}

	public String getSave_content_place_lon() {
		return save_content_place_lon;
	}

	public void setSave_content_place_lon(String save_content_place_lon) {
		this.save_content_place_lon = save_content_place_lon;
	}

	public String getSave_content_users_id() {
		return save_content_users_id;
	}

	public void setSave_content_users_id(String save_content_users_id) {
		this.save_content_users_id = save_content_users_id;
	}

	public String getSave_content_hashtag() {
		return save_content_hashtag;
	}

	public void setSave_content_hashtag(String save_content_hashtag) {
		this.save_content_hashtag = save_content_hashtag;
	}

	public Date getSave_content_date() {
		return save_content_date;
	}

	public void setSave_content_date(Date save_content_date) {
		this.save_content_date = save_content_date;
	}

	public String getSave_user_id() {
		return save_user_id;
	}

	public void setSave_user_id(String save_user_id) {
		this.save_user_id = save_user_id;
	}
	
	
	
	
	
}
