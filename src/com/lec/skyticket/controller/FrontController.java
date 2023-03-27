package com.lec.skyticket.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.skyticket.service.*;

@WebServlet("*.do")
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private boolean controlView = false;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		actionDo(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		actionDo(request, response);
	}

	private void actionDo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		String conPath = request.getContextPath();
		String command = uri.substring(conPath.length());
		String viewPage = null;
		Service service = null;
		if(command.equals("/main.do")) { // 첫 메인화면
			viewPage = "Main/main.jsp";
		} else if(command.equals("/joinView.do")) { 
			/*          Member 관련 요청                */
			viewPage = "Member/join.jsp";
			controlView = true;
		} else if(command.equals("/midConfirm.do")) {
			service = new MidConfirmService();
			service.execute(request, response);
			viewPage = "Member/midConfirm.jsp";
		} else if(command.equals("/memailConfirm.do")) {
			service = new MemailConfirmService();
			service.execute(request, response);
			viewPage = "Member/emailConfirm.jsp";			
		} else if(command.equals("/mtelConfirm.do")) {
			service = new MtelConfirmService();
			service.execute(request, response);
			viewPage = "Member/mtelConfirm.jsp";
		} else if(command.equals("/join.do")) {
			if(controlView) {
				service = new JoinService();
				service.execute(request, response);
				controlView = false;
			}
			viewPage = "loginView.do";
		} else if(command.equals("/loginView.do")) {
			viewPage = "Member/login.jsp";
			controlView = true;
		} else if(command.equals("/login.do")) {
			if (controlView) {
				service = new MLoginService();
				service.execute(request, response);
				controlView = false;
			}
			viewPage ="Main/main.jsp";
		} else if(command.equals("/logout.do")) {
			service = new MLogoutService();
			service.execute(request, response);
			viewPage = "Main/main.jsp";
		} else if(command.equals("/modifyView.do")) {
			viewPage = "Member/modify.jsp";
		} else if(command.equals("/modify.do")) {
			service = new MModifyService();
			service.execute(request, response);
			viewPage = "Main/main.jsp";
		} else if(command.equals("/withdrawal.do")) {
			service = new MWithdrawalService();
			service.execute(request, response);
			viewPage = "Main/main.jsp";
		} else if(command.equals("/adminLoginView.do")) {
			/*          admin 관련 요청                */
			viewPage = "Admin/adminLoginView.jsp";
			controlView = true;
		} else if(command.equals("/adminLogin.do")) {
			service = new ADLoginService();
			service.execute(request, response);
			viewPage = "main.do";
		} else if(command.equals("/boardList.do")) {
			service = new BoardListService();
			service.execute(request, response);
			viewPage = "Board/boardList.jsp";
		} else if(command.equals("/boardListMs.do")) {
			service = new BoardListMsService();
			service.execute(request, response);
			viewPage = "Board/boardListMs.jsp";
		} else if(command.equals("/boardWriteView.do")) {
			viewPage = "Board/boardWrite.jsp";
			controlView = true;
		} else if(command.equals("/boardWrite.do")) {
			if(controlView) {
				service = new BoardWriteService();
				service.execute(request, response);
				controlView = false;
			}
			viewPage = "boardList.do";
		} else if(command.equals("/boardContent.do")) {
			service = new BoardContentService();
			service.execute(request, response);
			viewPage = "Board/boardContent.jsp";
			controlView = true;
		} else if(command.equals("/boardDelete.do")) {
			if(controlView) {
				service = new BoardDeleteService();
				service.execute(request, response);
				controlView = false;
			}
			viewPage = "boardList.do";
		} else if(command.equals("/boardReplyView.do")) {
			service = new BoardReplyViewService();
			service.execute(request, response);
			viewPage = "Board/boardReply.jsp";
		} else if(command.equals("/boardReply.do")) {
			service = new BoardReplyService();
			service.execute(request, response);
			viewPage = "boardList.do";
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}

}
