package com.lec.skyticket.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.skyticket.dao.BoardDao;

public class BoardDeleteService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int bid = Integer.parseInt(request.getParameter("bid"));
		BoardDao bDao = new BoardDao();
		int result  = bDao.deleteBoard(bid);
		String deleteResult = result == 1 ? "글 삭제 성공" : "글 삭제 실패";
		request.setAttribute("deleteResult", deleteResult);
	}
}
