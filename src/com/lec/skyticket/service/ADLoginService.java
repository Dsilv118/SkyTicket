package com.lec.skyticket.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lec.skyticket.dao.AdminDao;

public class ADLoginService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String adid = request.getParameter("adid");
		String adpw = request.getParameter("adpw");
		AdminDao aDao = AdminDao.getInstance();
		int result = aDao.loginChk(adid, adpw);
		if(result==aDao.SUCCESS) {
			HttpSession session = request.getSession();
			session.setAttribute("admin", aDao.getAdmin(adid));
			request.setAttribute("loginSuccessMsg", "관리자 모드로 로그인하셨습니다");
		} else {
			request.setAttribute("loginErrorMsg", "관리자 모드입니다. 일반회원은 일반 로그인을 이용해주세요");
		}
	}
}
