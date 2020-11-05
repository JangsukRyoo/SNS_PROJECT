package com.tt.sns.model.dto;

public class LikeDto {
	private int content;
	private String users;
	private String like_liked;
	
	public LikeDto() {
		super();
	}

	public LikeDto(int content, String users, String like_liked) {
		super();
		this.content = content;
		this.users = users;
		this.like_liked = like_liked;
	}

	public int getContent() {
		return content;
	}

	public void setContent(int content) {
		this.content = content;
	}

	public String getUsers() {
		return users;
	}

	public void setUsers(String users) {
		this.users = users;
	}

	public String getLike_liked() {
		return like_liked;
	}

	public void setLike_liked(String like_liked) {
		this.like_liked = like_liked;
	}

	@Override
	public String toString() {
		return "LikeDto [content=" + content + ", users=" + users + ", like_liked=" + like_liked + "]";
	}

	
	
	

	
	
	
	
	
}
