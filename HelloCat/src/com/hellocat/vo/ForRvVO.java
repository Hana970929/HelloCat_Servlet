package com.hellocat.vo;

public class ForRvVO {
	private int pagenum;
	private int allpage;
	private int startpage; 
	private int endpage;
	private String pdid;
	public ForRvVO(int pagenum, int allpage, int startpage, int endpage, String pdid) {
		super();
		this.pagenum = pagenum;
		this.allpage = allpage;
		this.startpage = startpage;
		this.endpage = endpage;
		this.pdid = pdid;
	}
	public int getPagenum() {
		return pagenum;
	}
	public void setPagenum(int pagenum) {
		this.pagenum = pagenum;
	}
	public int getAllpage() {
		return allpage;
	}
	public void setAllpage(int allpage) {
		this.allpage = allpage;
	}
	public int getStartpage() {
		return startpage;
	}
	public void setStartpage(int startpage) {
		this.startpage = startpage;
	}
	public int getEndpage() {
		return endpage;
	}
	public void setEndpage(int endpage) {
		this.endpage = endpage;
	}
	public String getPdid() {
		return pdid;
	}
	public void setPdid(String pdid) {
		this.pdid = pdid;
	}
}
