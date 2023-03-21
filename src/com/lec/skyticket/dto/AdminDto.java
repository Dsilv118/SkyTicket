package com.lec.skyticket.dto;

public class AdminDto {
	private String adid;
	private String adpw;
	private String adname;
	private String adtel;
	
	public AdminDto() {}
	public AdminDto(String adid, String adpw, String adname, String adtel) {
		this.adid = adid;
		this.adpw = adpw;
		this.adname = adname;
		this.adtel = adtel;
	}
	
	@Override
	public String toString() {
		return "AdminDto [adid=" + adid + ", adpw=" + adpw + ", adname=" + adname + ", adtel=" + adtel + "]";
	}
	
	public String getAdid() {
		return adid;
	}
	public void setAdid(String adid) {
		this.adid = adid;
	}
	public String getAdpw() {
		return adpw;
	}
	public void setAdpw(String adpw) {
		this.adpw = adpw;
	}
	public String getAdname() {
		return adname;
	}
	public void setAdname(String adname) {
		this.adname = adname;
	}
	public String getAdtel() {
		return adtel;
	}
	public void setAdtel(String adtel) {
		this.adtel = adtel;
	}
	
}
