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
		final int PAGESIZE = 4, BLOCKSIZE = 4;
		int startRow = (currentPage-1)*PAGESIZE + 1;
		int endRow = startRow + PAGESIZE - 1;
		String schActname = request.getParameter("schActname");
		String schDctname = request.getParameter("schDctname");
		String temp = request.getParameter("schAtatime");
		Timestamp schAtatime = null;
		if(temp.length() > 11) {
			schAtatime = Timestamp.valueOf(temp);
		} else if(temp != "") {
			String atatimeStr = temp + " 00:00:00";
			schAtatime = Timestamp.valueOf(atatimeStr);
		}
		request.setAttribute("list", aDao.list(startRow, endRow, schAtatime, schActname, schDctname)); 
		int totCnt = aDao.getATicketCnt(schAtatime, schActname, schDctname); 
		int pageCnt = (int)Math.ceil((double)totCnt/PAGESIZE);
		int startPage = ((currentPage-1)/BLOCKSIZE)*BLOCKSIZE + 1;
		int endPage = startPage + BLOCKSIZE - 1;
		if(endPage > pageCnt) {
			endPage = pageCnt;
		}
		request.setAttribute("pageNum", currentPage);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("pageCnt", pageCnt);
		request.setAttribute("BLOCKSIZE", BLOCKSIZE);
		request.setAttribute("schActname", schActname);
		request.setAttribute("schDctname", schDctname);
		request.setAttribute("schAtatime", schAtatime);
		request.setAttribute("rightView", 1);
		aDao.cleanMemberTicket();
		aDao.cleanAirlineTicket();
		aDao.cleanPlane();
	}
}
