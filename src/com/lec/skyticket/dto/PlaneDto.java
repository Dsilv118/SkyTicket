package com.lec.skyticket.dto;

public class PlaneDto {
	private int plnum;
	private String plname;
	private String plcom;
	private String plcomcode;
	private int plseat;
	
	public PlaneDto() {}
	public PlaneDto(int plnum, String plname, String plcom, String plcomcode, int plseat) {
		this.plnum = plnum;
		this.plname = plname;
		this.plcom = plcom;
		this.plcomcode = plcomcode;
		this.plseat = plseat;
	}
	
	@Override
	public String toString() {
		return "PlaneDto [plnum=" + plnum + ", plname=" + plname + ", plcom=" + plcom + ", plcomcode=" + plcomcode
				+ ", plseat=" + plseat + "]";
	}
	
	public int getPlnum() {
		return plnum;
	}
	public void setPlnum(int plnum) {
		this.plnum = plnum;
	}
	public String getPlname() {
		return plname;
	}
	public void setPlname(String plname) {
		this.plname = plname;
	}
	public String getPlcom() {
		return plcom;
	}
	public void setPlcom(String plcom) {
		this.plcom = plcom;
	}
	public String getPlcomcode() {
		return plcomcode;
	}
	public void setPlcomcode(String plcomcode) {
		this.plcomcode = plcomcode;
	}
	public int getPlseat() {
		return plseat;
	}
	public void setPlseat(int plseat) {
		this.plseat = plseat;
	}
}
