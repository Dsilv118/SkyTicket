package com.lec.skyticket.service;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.skyticket.dao.ATicketDao;
import com.lec.skyticket.dto.ATicketDto;

public class ATInsertService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		System.out.println(request.getParameter("atatime"));
		System.out.println(request.getParameter("atdtime"));
		int result = 0;
		ATicketDao aDao = ATicketDao.getInstance();
		String atid = request.getParameter("plcomcode");
		String plcom = request.getParameter("plcom");
		String plname = request.getParameter("plname");
		String plcomcode = request.getParameter("plcomcode");
		int plseat = Integer.parseInt(request.getParameter("plseat"));
		String actname = request.getParameter("actname");
		String dctname = request.getParameter("dctname");
		int atprice = Integer.parseInt(request.getParameter("atprice"));
		Timestamp atatime = Timestamp.valueOf(request.getParameter("atatime")+':'+00);
		Timestamp atdtime = Timestamp.valueOf(request.getParameter("atdtime")+':'+00);
		ATicketDto aDto = new ATicketDto(atid, actname, dctname, 0, atprice, atatime, atdtime, plcom, plcomcode, plname, plseat);
		result = aDao.insertTicket(aDto);
		request.setAttribute("joinResult", result);
	}

}



























