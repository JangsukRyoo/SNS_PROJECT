package com.tt.sns.model.dto;

import java.util.Date;

public class DmsubDto {
	private String dm_room;
	private String dm_writer;
	private String dm_receiver;
	private String dm_substance;
	private String dm_status;
	private Date dm_date;
	
	public DmsubDto() {
		super();
	}

	public DmsubDto(String dm_room, String dm_writer, String dm_receiver, String dm_substance, String dm_status,
			Date dm_date) {
		super();
		this.dm_room = dm_room;
		this.dm_writer = dm_writer;
		this.dm_receiver = dm_receiver;
		this.dm_substance = dm_substance;
		this.dm_status = dm_status;
		this.dm_date = dm_date;
	}

	public String getDm_room() {
		return dm_room;
	}

	public void setDm_room(String dm_room) {
		this.dm_room = dm_room;
	}

	public String getDm_writer() {
		return dm_writer;
	}

	public void setDm_writer(String dm_writer) {
		this.dm_writer = dm_writer;
	}

	public String getDm_receiver() {
		return dm_receiver;
	}

	public void setDm_receiver(String dm_receiver) {
		this.dm_receiver = dm_receiver;
	}

	public String getDm_substance() {
		return dm_substance;
	}

	public void setDm_substance(String dm_substance) {
		this.dm_substance = dm_substance;
	}

	public String getDm_status() {
		return dm_status;
	}

	public void setDm_status(String dm_status) {
		this.dm_status = dm_status;
	}

	public Date getDm_date() {
		return dm_date;
	}

	public void setDm_date(Date dm_date) {
		this.dm_date = dm_date;
	}

	@Override
	public String toString() {
		return "DmsubDto [dm_room=" + dm_room + ", dm_writer=" + dm_writer + ", dm_receiver=" + dm_receiver
				+ ", dm_substance=" + dm_substance + ", dm_status=" + dm_status + ", dm_date=" + dm_date + "]";
	}

	
	
}
