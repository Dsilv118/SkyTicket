package com.lec.skyticket.dto;

import java.sql.Date;

public class MemberDto {
	private String mid;
	private String mpw;
	private String mkname;
	private String mename;
	private String mtel;
	private String memail;
	private Date mbirth;
	private String mgender;
	private String mnation;
	public MemberDto() {}
	public MemberDto(String mid, String mpw, String mkname, String mename, String mtel, String memail, Date mbirth,
			String mgender, String mnation) {
		this.mid = mid;
		this.mpw = mpw;
		this.mkname = mkname;
		this.mename = mename;
		this.mtel = mtel;
		this.memail = memail;
		this.mbirth = mbirth;
		this.mgender = mgender;
		this.mnation = mnation;
	}
	@Override
	public String toString() {
		return "MemberDto [mid=" + mid + ", mpw=" + mpw + ", mkname=" + mkname + ", mename=" + mename + ", mtel=" + mtel
				+ ", memail=" + memail + ", mbirth=" + mbirth + ", mgender=" + mgender + ", mnation=" + mnation + "]";
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getMpw() {
		return mpw;
	}
	public void setMpw(String mpw) {
		this.mpw = mpw;
	}
	public String getMkname() {
		return mkname;
	}
	public void setMkname(String mkname) {
		this.mkname = mkname;
	}
	public String getMename() {
		return mename;
	}
	public void setMename(String mename) {
		this.mename = mename;
	}
	public String getMtel() {
		return mtel;
	}
	public void setMtel(String mtel) {
		this.mtel = mtel;
	}
	public String getMemail() {
		return memail;
	}
	public void setMemail(String memail) {
		this.memail = memail;
	}
	public Date getMbirth() {
		return mbirth;
	}
	public void setMbirth(Date mbirth) {
		this.mbirth = mbirth;
	}
	public String getMgender() {
		return mgender;
	}
	public void setMgender(String mgender) {
		this.mgender = mgender;
	}
	public String getMnation() {
		return mnation;
	}
	public void setMnation(String mnation) {
		this.mnation = mnation;
	}

}
