package com.hellocat.vo;

public class BoardPhotoVO {
	private int bno;
	private String content ;
	private String writer ;
	private String board_date ;
	private String photo ;
	private int count2;
	private int like_count;
	public int getLike_count() {
		return like_count;
	}
	public void setLike_count(int like_count) {
		this.like_count = like_count;
	}
	public int getCount2() {
		return count2;
	}
	public void setCount2(int count2) {
		this.count2 = count2;
	}
	public BoardPhotoVO() {}
	public BoardPhotoVO(int bno, String content, String writer, String photo, String board_date,int count2,int like_count) {
		super();
		this.bno = bno;
		this.content = content;
		this.writer = writer;
		this.board_date = board_date;
		this.photo = photo;
		this.count2 = count2;
		this.like_count = like_count;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
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
}
