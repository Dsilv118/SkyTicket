package com.lec.skyticket.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.skyticket.dao.MTicketDao;

public class MTDeleteService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int rvnum = Integer.parseInt(request.getParameter("rvnum"));
		int mtseat = Integer.parseInt(request.getParameter("mtseat"));
		String mid = request.getParameter("mid");
		String atid = request.getParameter("atid");
		String deleteResult = null;
		MTicketDao mtDao = MTicketDao.getInstance();
		int result = mtDao.modifySeat(rvnum, mtseat, atid);
		if(result == mtDao.SUCCESS) {
			result  = mtDao.deleteMemberTicket(rvnum);
			if(result == mtDao.SUCCESS) {
				deleteResult = "예매가 취소되었습니다";
			} else {
				deleteResult = "자리 증가 성공, 예매 내역 삭제 실패";
			}
		} else {
			deleteResult = "예매 취소 실패";
		}
		request.setAttribute("deleteResult", deleteResult);
		request.setAttribute("mid", mid);
	}
}
