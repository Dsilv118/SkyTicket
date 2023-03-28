package com.lec.skyticket.service;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.skyticket.dao.ATicketDao;

public class ATListService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		ATicketDao aDao = ATicketDao.getInstance();
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null) {
			if(request.getAttribute("pageNum")!=null) {
				pageNum = (String) request.getAttribute("pageNum");
			} else {
				pageNum = "1";
			}
		}
		int currentPage = Integer.parseInt(pageNum);
		final int PAGESIZE = 10, BLOCKSIZE = 10;
		int startRow = (currentPage-1)*PAGESIZE + 1;
		int endRow = startRow + PAGESIZE - 1;
		String actname = request.getParameter("actname");
		String dctname = request.getParameter("dctname");
		String temp = request.getParameter("atatime");
		Timestamp atatime = null;
		if(temp != null) {
			String atatimeStr = temp + " 00:00:00";
			atatime = Timestamp.valueOf(atatimeStr);
		}
		request.setAttribute("list", aDao.list(startRow, endRow, atatime, actname, dctname)); 
		int totCnt = aDao.getATicketCnt(atatime, actname, dctname); // 글 갯수
		int pageCnt = (int)Math.ceil((double)totCnt/PAGESIZE);
		int startPage = ((currentPage-1)/BLOCKSIZE)*BLOCKSIZE + 1;
		int endPage = startPage + BLOCKSIZE - 1;
		if(endPage > pageCnt) {
			endPage = pageCnt;
		}
		// 페이지 관련 항복들
		request.setAttribute("pageNum", currentPage);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("pageCnt", pageCnt);
		request.setAttribute("BLOCKSIZE", BLOCKSIZE);
		aDao.cleanAirlineTicket();
		aDao.cleanMemberTicket();
	}
}
