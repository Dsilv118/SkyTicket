package com.lec.skyticket.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.skyticket.dao.ATicketDao;
import com.lec.skyticket.dao.MemberDao;

public class CityConfirmService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String ctname = request.getParameter("ctname");
		String ctcode = request.getParameter("ctcode");
		ATicketDao aDao = ATicketDao.getInstance();
		int result = aDao.cityConfirm(ctname, ctcode);
		if(result == MemberDao.DUPLI) {
			request.setAttribute("midConfirmResult", "<b>중복된 ID입니다</b>");
		} else {
			request.setAttribute("midConfirmResult", "사용 가능한 ID입니다");
		}
	}

}
