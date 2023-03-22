package com.lec.skyticket.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.skyticket.dao.MemberDao;

public class MemailConfirmService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String memail = request.getParameter("memail");
		MemberDao mDao = MemberDao.getInstance();
		int result = mDao.memailConfirm(memail);
		if(result == MemberDao.DUPLI) {
			request.setAttribute("memailConfirmResult", "<b>중복된 E-Mail입니다</b>");
		} else {
			request.setAttribute("memailConfirmResult", "사용 가능한 E-Mail입니다");
		}
	}

}
