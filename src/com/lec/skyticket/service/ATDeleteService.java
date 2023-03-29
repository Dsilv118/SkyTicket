package com.lec.skyticket.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.skyticket.dao.ATicketDao;

public class ATDeleteService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String atid = request.getParameter("atid");
		ATicketDao aDao = ATicketDao.getInstance();
		int result  = aDao.deleteTicket(atid);
		String deleteResult = result == 1 ? atid + " 항공권 삭제 성공" : "글 삭제 실패되었습니다 해당 편명의 예약 내역을 확인해주세요";
		request.setAttribute("deleteResult", deleteResult);
	}
}
