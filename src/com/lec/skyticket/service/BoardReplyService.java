package com.lec.skyticket.service;

import java.sql.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.skyticket.dao.BoardDao;
import com.lec.skyticket.dto.BoardDto;

public class BoardReplyService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int result = 0;
		BoardDao bDao = BoardDao.getInstance();
		String mid = request.getParameter("mid");
		String bsubject   = request.getParameter("bsubject");
		String bcontent = request.getParameter("bcontent");
		String bfile = null;
		Date brdate = new Date(System.currentTimeMillis());
		int bgroup  = Integer.parseInt(request.getParameter("bgroup"));  
		int bstep   = Integer.parseInt(request.getParameter("bstep"));   
		int bindent = Integer.parseInt(request.getParameter("bindent")); 
		String mkname = "관리자";
		String bip = request.getRemoteAddr();
		BoardDto bDto = new BoardDto(0, mid, bsubject, bcontent, bfile, bip, bgroup, bstep, bindent, brdate, mkname);
		result = bDao.replyBoard(bDto);
		request.setAttribute("replyResult", result);
		request.setAttribute("pageNum", request.getParameter("pageNum"));
	}
}
