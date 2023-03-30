package com.lec.skyticket.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.skyticket.dao.MTicketDao;

public class MTContentService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int rvnum = Integer.parseInt(request.getParameter("rvnum"));
		MTicketDao mtDao = MTicketDao.getInstance();
		request.setAttribute("ATicketContent", mtDao.mtContent(rvnum));
	}
}
