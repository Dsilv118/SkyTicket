package com.lec.skyticket.dto;

public class CityDto {
	private String ctNAME;
	private String ctCODE;
	
	public CityDto() {}
	public CityDto(String ctNAME, String ctCODE) {
		this.ctNAME = ctNAME;
		this.ctCODE = ctCODE;
	}
	
	@Override
	public String toString() {
		return "CityDto [ctNAME=" + ctNAME + ", ctCODE=" + ctCODE + "]";
	}
	
	public String getCtNAME() {
		return ctNAME;
	}
	public void setCtNAME(String ctNAME) {
		this.ctNAME = ctNAME;
	}
	public String getCtCODE() {
		return ctCODE;
	}
	public void setCtCODE(String ctCODE) {
		this.ctCODE = ctCODE;
	}
}
