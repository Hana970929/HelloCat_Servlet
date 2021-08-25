package com.hellocat.vo;

public class ReviewVO {
	private String pd_id;
	private String writer;
	private String writedate;
	private String content;
	private int bno;
	private int score;
	
	public ReviewVO() {	}
	
	public ReviewVO(String pd_id, String writer, String writedate, String content, int bno, int score) {
		this.pd_id = pd_id;
		this.writer = writer;
		this.writedate = writedate;
		this.content = content;
		this.bno = bno;
		this.score = score;
	}

	public String getPd_id() {
		return pd_id;
	}

	public void setPd_id(String pd_id) {
		this.pd_id = pd_id;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getWritedate() {
		return writedate;
	}

	public void setWritedate(String writedate) {
		this.writedate = writedate;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getBno() {
		return bno;
	}

	public void setBno(int bno) {
		this.bno = bno;
	}

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}
	
}
