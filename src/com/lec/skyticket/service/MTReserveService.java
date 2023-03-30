package com.lec.skyticket.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.skyticket.dao.MTicketDao;
import com.lec.skyticket.dto.MTicketDto;

public class MTReserveService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String atid      = request.getParameter("atid");
		String mid       = request.getParameter("mid");
		int mtseat       = Integer.parseInt(request.getParameter("mtseat"));
		String mtservice = request.getParameter("mtservice");
		MTicketDto mtDto = new MTicketDto(0, atid, mid, mtseat, mtservice);
		MTicketDao mtDao = MTicketDao.getInstance();
		int result = mtDao.insertTicket(mtDto);
		if(result == mtDao.SUCCESS) {
			request.setAttribute("insertTicketResult", "예매 성공하였습니다");
			result = mtDao.modifyMember(mtseat, atid);
		} else {
			request.setAttribute("insertTicketResult", "예매 실패하였습니다 다시 확인해주세요");
		}
	}

}
