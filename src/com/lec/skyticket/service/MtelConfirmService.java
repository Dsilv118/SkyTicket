package com.lec.skyticket.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.skyticket.dao.MemberDao;

public class MtelConfirmService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String mtel = request.getParameter("mtel");
		MemberDao mDao = MemberDao.getInstance();
		int result = mDao.mtelConfirm(mtel);
		if(result == MemberDao.DUPLI) {
			request.setAttribute("mtelConfirmResult", "<b>중복된 연락처입니다</b>");
		} else {
			request.setAttribute("mtelConfirmResult", "사용 가능한 연락처입니다");
		}
	}

}
