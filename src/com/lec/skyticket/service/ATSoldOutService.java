package com.lec.skyticket.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.skyticket.dao.ATicketDao;

public class ATSoldOutService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int plnum = Integer.parseInt(request.getParameter("plnum"));
		ATicketDao aDao = ATicketDao.getInstance();
		int totSeat = aDao.seatChk(plnum);
		if(totSeat == 0) {
			request.setAttribute("soldOutConfirmResult", "예약매진");
		} else {
			request.setAttribute("soldOutConfirmResult", totSeat);
		}
	}

}
