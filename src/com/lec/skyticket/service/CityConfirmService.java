package com.lec.skyticket.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.skyticket.dao.ATicketDao;
import com.lec.skyticket.dao.MemberDao;

public class CityConfirmService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String ctname = request.getParameter("ctname");
		ATicketDao aDao = ATicketDao.getInstance();
		int result = aDao.cityConfirm(ctname);
		if(result != MemberDao.DUPLI) {
			request.setAttribute("cityConfirmResult", "<b>도시 이름을 확인해 주세요</b>");
		} else {
			request.setAttribute("cityConfirmResult", "도시 이름이 확인되었습니다");
		}
	}

}
