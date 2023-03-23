package com.lec.skyticket.service;

import java.sql.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lec.skyticket.dao.MemberDao;
import com.lec.skyticket.dto.MemberDto;

public class JoinService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int result = 0;
		MemberDao mDao = MemberDao.getInstance();
		String mid = request.getParameter("mid");
		String mpw = request.getParameter("mpw");
		String mkname = request.getParameter("mkname");
		String mename = request.getParameter("mename");
		String mtel = request.getParameter("mtel");
		String memail = request.getParameter("memail");
		System.out.println(request.getParameter("mbirth"));
		Date mbirth = Date.valueOf(request.getParameter("mbirth"));
		String mgender = request.getParameter("mgender");
		String mnation = request.getParameter("mnation");
		MemberDto newMember = new MemberDto(mid, mpw, mkname, mename, mtel, memail, mbirth, mgender, mnation);
		result = mDao.joinMember(newMember);
		HttpSession session = request.getSession();
		session.setAttribute("mid", mid);
		request.setAttribute("joinResult", result);
	}

}



























