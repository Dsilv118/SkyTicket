package com.lec.skyticket.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lec.skyticket.dao.MemberDao;
import com.lec.skyticket.dto.MemberDto;

public class MWithdrawalService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String mid = null;
		MemberDto member = (MemberDto) session.getAttribute("member");
		if(member!=null) {
			mid = member.getMid();
		}
		MemberDao mDao = MemberDao.getInstance();
		System.out.println(mid + " 탈퇴함");
		int result = mDao.withdrawalMember(mid); // 회원탈퇴
		session.invalidate(); // 세션 삭제
		if(result==MemberDao.SUCCESS) { 
			request.setAttribute("withdrawalResult", "회원탈퇴가 완료되었습니다.");
		} else {
			request.setAttribute("withdrawalResult", "로그인이 되어 있지 않습니다");
		}
	}

}
