package com.tt.sns.model.dto;

import java.util.Date;

public class OpenchatsubDto {
	private String chat_room;
	private String chat_writer;
	private String chat_substance;
	private String chat_people;
	private String chat_status;
	private Date chat_time;
	
	public OpenchatsubDto() {
		super();
	}

	public OpenchatsubDto(String chat_room, String chat_writer, String chat_substance, String chat_people,
			String chat_status, Date chat_time) {
		super();
		this.chat_room = chat_room;
		this.chat_writer = chat_writer;
		this.chat_substance = chat_substance;
		this.chat_people = chat_people;
		this.chat_status = chat_status;
		this.chat_time = chat_time;
	}

	public String getChat_room() {
		return chat_room;
	}

	public void setChat_room(String chat_room) {
		this.chat_room = chat_room;
	}

	public String getChat_writer() {
		return chat_writer;
	}

	public void setChat_writer(String chat_writer) {
		this.chat_writer = chat_writer;
	}

	public String getChat_substance() {
		return chat_substance;
	}

	public void setChat_substance(String chat_substance) {
		this.chat_substance = chat_substance;
	}

	public String getChat_people() {
		return chat_people;
	}

	public void setChat_people(String chat_people) {
		this.chat_people = chat_people;
	}

	public String getChat_status() {
		return chat_status;
	}

	public void setChat_status(String chat_status) {
		this.chat_status = chat_status;
	}

	public Date getChat_time() {
		return chat_time;
	}

	public void setChat_time(Date chat_time) {
		this.chat_time = chat_time;
	}

	
	
	
}
