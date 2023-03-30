package com.lec.skyticket.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.skyticket.dao.ATicketDao;
import com.lec.skyticket.dao.BoardDao;

public class MTReserveViewService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String atid = request.getParameter("atid");
		ATicketDao atDao = ATicketDao.getInstance();
		request.setAttribute("TicketContent", atDao.getATicket(atid));
		request.setAttribute("atid", atid);
	}
}
