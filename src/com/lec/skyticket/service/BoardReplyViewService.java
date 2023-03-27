package com.lec.skyticket.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.skyticket.dao.BoardDao;

public class BoardReplyViewService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int bid = Integer.parseInt(request.getParameter("bid")); // 원글의 글번호
		BoardDao bDao = new BoardDao();
		request.setAttribute("BoardReply", bDao.content(bid)); // 원글 dto
	}

}
