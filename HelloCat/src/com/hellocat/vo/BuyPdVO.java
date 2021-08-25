package com.hellocat.vo;

public class BuyPdVO {
	private String name;
	private String thePrice;
	private int quantity;
	private String photo;
	private int price;
	
	public BuyPdVO(String name, String thePrice, int price, int quantity, String photo) {
		super();
		this.name = name;
		this.thePrice = thePrice;
		this.quantity = quantity;
		this.photo = photo;
		this.price = price;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getThePrice() {
		return thePrice;
	}

	public void setThePrice(String thePrice) {
		this.thePrice = thePrice;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}
	
}
