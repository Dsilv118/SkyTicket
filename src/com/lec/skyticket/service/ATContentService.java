package com.lec.skyticket.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.skyticket.dao.ATicketDao;

public class ATContentService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String atid = request.getParameter("atid");
		ATicketDao aDao = ATicketDao.getInstance();
		request.setAttribute("ATicketContent", aDao.getATicket(atid));
	}
}
