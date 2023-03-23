package com.lec.skyticket.service;

import java.sql.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lec.skyticket.dao.MemberDao;
import com.lec.skyticket.dto.MemberDto;

public class MModifyService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int result = MemberDao.FAIL;
		String mid      = request.getParameter("mid");
		String dbMpw    = request.getParameter("dbMpw");
		String oldMpw   = request.getParameter("oldMpw");
		if(!oldMpw.equals(dbMpw)) {
			request.setAttribute("modifyErrorMsg", "현재 비밀번호를 확인하세요");
			return;
		}
		String mpw = request.getParameter("mpw");
		if(mpw.equals("")) { // 새 비밀번호를 입력하지 않을 경우, 현 비밀번호로 
			mpw = dbMpw;
		}
		String mkname = request.getParameter("mkname");
		String mename = request.getParameter("mename");
		String mtel   = request.getParameter("mtel");
		String memail = request.getParameter("memail");
		Date mbirth = Date.valueOf(request.getParameter("mbirth"));
		String mgender = request.getParameter("mgender");
		String mnation = request.getParameter("mnation");
		// 회원정보 수정
		MemberDao mDao = MemberDao.getInstance();
		MemberDto mDto = new MemberDto(mid, mpw, mkname, mename, mtel, memail, mbirth, mgender, mnation);
		result = mDao.modifyMember(mDto);
		if(result == MemberDao.SUCCESS) { // 수정 성공시 세션도 수정
			HttpSession session = request.getSession();
			session.setAttribute("member", mDto);
			request.setAttribute("modifyResult", "회원정보 수정 성공");
		} else {
			request.setAttribute("modifyErrorMsg", "회원정보 수정 실패");
		}
	}

}
































