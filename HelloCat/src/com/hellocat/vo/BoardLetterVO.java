package com.hellocat.vo;

public class BoardLetterVO {
	private int bno;
	private String title;
	private String content;
	private String writer;
	private String board_date;
	private String photo;
	private int hitcount;
	private int comment_count;
	public BoardLetterVO(){}
	public BoardLetterVO(int comment_count,int bno, String title, String content, String writer, String board_date, String photo,
			int hitcount) {
		super();
		this.bno = bno;
		this.title = title;
		this.content = content;
		this.writer = writer;
		this.board_date = board_date;
		this.photo = photo;
		this.hitcount = hitcount;
		this.comment_count = comment_count;
	}
	public int getComment_count() {
		return comment_count;
	}
	public void setComment_count(int comment_count) {
		this.comment_count = comment_count;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getBoard_date() {
		return board_date;
	}
	public void setBoard_date(String board_date) {
		this.board_date = board_date;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public int getHitcount() {
		return hitcount;
	}
	public void setHitcount(int hitcount) {
		this.hitcount = hitcount;
	}

}
