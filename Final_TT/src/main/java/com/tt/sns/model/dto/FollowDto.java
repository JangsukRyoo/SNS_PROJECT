package com.tt.sns.model.dto;

public class FollowDto {
	private String follow_id;
	private String follow_target;
	
	public FollowDto() {
		super();
	}
	public FollowDto(String follow_id, String follow_target) {
		super();
		this.follow_id = follow_id;
		this.follow_target = follow_target;
	}
	public String getFollow_id() {
		return follow_id;
	}
	public void setFollow_id(String follow_id) {
		this.follow_id = follow_id;
	}
	public String getFollow_target() {
		return follow_target;
	}
	public void setFollow_target(String follow_target) {
		this.follow_target = follow_target;
	}
	@Override
	public String toString() {
		return "FollowDto [follow_id=" + follow_id + ", follow_target=" + follow_target + "]";
	}
	
	

}
