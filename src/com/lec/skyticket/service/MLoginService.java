package com.lec.skyticket.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lec.skyticket.dao.MemberDao;

public class MLoginService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String mid = request.getParameter("mid");
		String mpw = request.getParameter("mpw");
		MemberDao mDao = MemberDao.getInstance();
		int result = mDao.loginChk(mid, mpw);
		if(result==mDao.SUCCESS) {
			HttpSession session = request.getSession();
			session.setAttribute("member", mDao.getMember(mid));
			request.setAttribute("mid", mid);
		} else {
			request.setAttribute("loginErrorMsg", "IP와 PW를 다시 확인해주세요");
		}
	}

}
