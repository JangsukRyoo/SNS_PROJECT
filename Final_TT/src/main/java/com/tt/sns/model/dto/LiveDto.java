package com.tt.sns.model.dto;

public class LiveDto {
	private String live_user_id;
	private String live_start_time;
	private String live_user_profile;
	

	public LiveDto() {
	}
	
	

	public String getLive_user_profile() {
		return live_user_profile;
	}



	public void setLive_user_profile(String live_user_profile) {
		this.live_user_profile = live_user_profile;
	}



	public LiveDto(String live_user_id, String live_start_time, String live_user_profile) {
		super();
		this.live_user_id = live_user_id;
		this.live_start_time = live_start_time;
		this.live_user_profile = live_user_profile;
	}



	public String getLive_user_id() {
		return live_user_id;
	}

	public void setLive_user_id(String live_user_id) {
		this.live_user_id = live_user_id;
	}

	public String getLive_start_time() {
		return live_start_time;
	}

	public void setLive_start_time(String live_start_time) {
		this.live_start_time = live_start_time;
	}

	
	
}
