package com.hellocat.vo;

public class CommentPhotoVO {
	private int comment_bno;
	private String comment_date;
	private String comment_content;
	private String comment_writer;
	private int comment_cno;
	public CommentPhotoVO(){}
	public CommentPhotoVO(int comment_bno, String comment_date, String comment_content, String comment_writer,
			int comment_cno) {
		super();
		this.comment_bno = comment_bno;
		this.comment_date = comment_date;
		this.comment_content = comment_content;
		this.comment_writer = comment_writer;
		this.comment_cno = comment_cno;
	}
	public int getComment_bno() {
		return comment_bno;
	}
	public void setComment_bno(int comment_bno) {
		this.comment_bno = comment_bno;
	}
	public String getComment_date() {
		return comment_date;
	}
	public void setComment_date(String comment_date) {
		this.comment_date = comment_date;
	}
	public String getComment_content() {
		return comment_content;
	}
	public void setComment_content(String comment_content) {
		this.comment_content = comment_content;
	}
	public String getComment_writer() {
		return comment_writer;
	}
	public void setComment_writer(String comment_writer) {
		this.comment_writer = comment_writer;
	}
	public int getComment_cno() {
		return comment_cno;
	}
	public void setComment_cno(int comment_cno) {
		this.comment_cno = comment_cno;
	}
}
