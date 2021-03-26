package com.exam.boardlist;

public class JoinBLUTO {
	//useq, id, nickname, mail, sum(Lcount) Lcount, count(bnltable.useq) Bcount
	private String useq;
	private String id;
	private String nickname;
	private String mail;
	private String Lcount;
	private String Bcount;
	
	public String getUseq() {
		return useq;
	}
	public void setUseq(String useq) {
		this.useq = useq;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getMail() {
		return mail;
	}
	public void setMail(String mail) {
		this.mail = mail;
	}
	public String getLcount() {
		return Lcount;
	}
	public void setLcount(String lcount) {
		Lcount = lcount;
	}
	public String getBcount() {
		return Bcount;
	}
	public void setBcount(String bcount) {
		Bcount = bcount;
	}

}
