package com.hellocat.vo;

public class ProductVO {
	private String id;
	private String name;
	private int price;
	private int sales;
	private String explain;
	private String photo;
	private String s_price;
	private double score;
	private int reviewcnt;
	
	public ProductVO() { }
	
	public ProductVO(String id, String name, int price, int sales, String explain, String photo, String s_price,
			double score, int reviewcnt) {
		super();
		this.id = id;
		this.name = name;
		this.price = price;
		this.sales = sales;
		this.explain = explain;
		this.photo = photo;
		this.s_price = s_price;
		this.score = score;
		this.reviewcnt = reviewcnt;
	}
	
	public double getScore() {
		return score;
	}

	public void setScore(double score) {
		this.score = score;
	}

	public int getReviewcnt() {
		return reviewcnt;
	}

	public void setReviewcnt(int reviewcnt) {
		this.reviewcnt = reviewcnt;
	}

	public String getS_price() {
		return s_price;
	}

	public void setS_price(String s_price) {
		this.s_price = s_price;
	}

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getSales() {
		return sales;
	}
	public void setSales(int sales) {
		this.sales = sales;
	}
	public String getExplain() {
		return explain;
	}
	public void setExplain(String explain) {
		this.explain = explain;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	
}
