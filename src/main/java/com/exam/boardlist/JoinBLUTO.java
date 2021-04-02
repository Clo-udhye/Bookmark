package com.exam.boardlist;

public class JoinBLUTO {
	//useq, id, nickname, mail, sum(Lcount) Lcount, count(bnltable.useq) Bcount
	private String useq;
	private String id;
	private String nickname;
	private String mail;
	private String keywords;
	private String introduction;
	private String profile_filename;
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
	public String getKeywords() {
		return keywords;
	}
	public void setKeywords(String keywords) {
		this.keywords = keywords;
	}
	public String getIntroduction() {
		return introduction;
	}
	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}
	public String getProfile_filename() {
		return profile_filename;
	}
	public void setProfile_filename(String profile_filename) {
		this.profile_filename = profile_filename;
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
