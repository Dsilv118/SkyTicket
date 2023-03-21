package com.lec.skyticket.dto;

import java.sql.Timestamp;

public class ATicketDto {
	private int atid;
	private String actname;
	private String dctname;
	private int plnum;
	private int atprice;
	private Timestamp atatime;
	private Timestamp atdtime;
	private String atphoto;
	private String actcode;
	private String dctcode;
	private String plcom;
	private String plcomcode;
	private String plname;
	private int plseat;
	
	public ATicketDto() {}
	public ATicketDto(int atid, String actname, String dctname, int plnum, int atprice, Timestamp atatime,
			Timestamp atdtime, String atphoto, String actcode, String dctcode, String plcom, String plcomcode,
			String plname, int plseat) {
		this.atid = atid;
		this.actname = actname;
		this.dctname = dctname;
		this.plnum = plnum;
		this.atprice = atprice;
		this.atatime = atatime;
		this.atdtime = atdtime;
		this.atphoto = atphoto;
		this.actcode = actcode;
		this.dctcode = dctcode;
		this.plcom = plcom;
		this.plcomcode = plcomcode;
		this.plname = plname;
		this.plseat = plseat;
	}
	public ATicketDto(int atid, String actname, String dctname, int plnum, int atprice, Timestamp atatime,
			Timestamp atdtime, String atphoto, String plcom, String plcomcode, String plname, int plseat) {
		super();
		this.atid = atid;
		this.actname = actname;
		this.dctname = dctname;
		this.plnum = plnum;
		this.atprice = atprice;
		this.atatime = atatime;
		this.atdtime = atdtime;
		this.atphoto = atphoto;
		this.plcom = plcom;
		this.plcomcode = plcomcode;
		this.plname = plname;
		this.plseat = plseat;
	}
	public ATicketDto(int atid, String actname, String dctname, int plnum, int atprice, Timestamp atatime,
			Timestamp atdtime, String atphoto) {
		super();
		this.atid = atid;
		this.actname = actname;
		this.dctname = dctname;
		this.plnum = plnum;
		this.atprice = atprice;
		this.atatime = atatime;
		this.atdtime = atdtime;
		this.atphoto = atphoto;
	}
	
	@Override
	public String toString() {
		return "ATicketDto [atid=" + atid + ", actname=" + actname + ", dctname=" + dctname + ", plnum=" + plnum
				+ ", atprice=" + atprice + ", atatime=" + atatime + ", atdtime=" + atdtime + ", atphoto=" + atphoto
				+ ", actcode=" + actcode + ", dctcode=" + dctcode + ", plcom=" + plcom + ", plcomcode=" + plcomcode
				+ ", plname=" + plname + ", plseat=" + plseat + "]";
	}	
	
	public int getAtid() {
		return atid;
	}
	public void setAtid(int atid) {
		this.atid = atid;
	}
	public String getActname() {
		return actname;
	}
	public void setActname(String actname) {
		this.actname = actname;
	}
	public String getDctname() {
		return dctname;
	}
	public void setDctname(String dctname) {
		this.dctname = dctname;
	}
	public int getPlnum() {
		return plnum;
	}
	public void setPlnum(int plnum) {
		this.plnum = plnum;
	}
	public int getAtprice() {
		return atprice;
	}
	public void setAtprice(int atprice) {
		this.atprice = atprice;
	}
	public Timestamp getAtatime() {
		return atatime;
	}
	public void setAtatime(Timestamp atatime) {
		this.atatime = atatime;
	}
	public Timestamp getAtdtime() {
		return atdtime;
	}
	public void setAtdtime(Timestamp atdtime) {
		this.atdtime = atdtime;
	}
	public String getAtphoto() {
		return atphoto;
	}
	public void setAtphoto(String atphoto) {
		this.atphoto = atphoto;
	}
	public String getActcode() {
		return actcode;
	}
	public void setActcode(String actcode) {
		this.actcode = actcode;
	}
	public String getDctcode() {
		return dctcode;
	}
	public void setDctcode(String dctcode) {
		this.dctcode = dctcode;
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
	public String getPlname() {
		return plname;
	}
	public void setPlname(String plname) {
		this.plname = plname;
	}
	public int getPlseat() {
		return plseat;
	}
	public void setPlseat(int plseat) {
		this.plseat = plseat;
	}
	
}
