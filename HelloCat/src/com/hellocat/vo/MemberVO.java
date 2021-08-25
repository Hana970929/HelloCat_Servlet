package com.hellocat.vo;

public class MemberVO {
	private String name;
	private String phone;
	private String mail;
	private String add_num;
	private String add_short;
	private String add_long;
	public MemberVO(String name, String phone, String mail) {
		this.name = name;
		this.phone = phone;
		this.mail = mail;
	}
	public MemberVO(String name, String phone, String mail, String add_num, String add_short, String add_long) {
		super();
		this.name = name;
		this.phone = phone;
		this.mail = mail;
		this.add_num = add_num;
		this.add_short = add_short;
		this.add_long = add_long;
	}
	public String getAdd_num() {
		return add_num;
	}
	public void setAdd_num(String add_num) {
		this.add_num = add_num;
	}
	public String getAdd_short() {
		return add_short;
	}
	public void setAdd_short(String add_short) {
		this.add_short = add_short;
	}
	public String getAdd_long() {
		return add_long;
	}
	public void setAdd_long(String add_long) {
		this.add_long = add_long;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getMail() {
		return mail;
	}
	public void setMail(String mail) {
		this.mail = mail;
	}
	
}
