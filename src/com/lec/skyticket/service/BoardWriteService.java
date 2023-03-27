package com.lec.skyticket.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Date;
import java.util.Enumeration;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.skyticket.dao.BoardDao;
import com.lec.skyticket.dto.BoardDto;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class BoardWriteService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String path = request.getRealPath("BoardFile");
		int maxSize = 1024*1024*5;
		String filename = "";
		MultipartRequest mRequest = null;
		int result = 0;
		BoardDao bDao = BoardDao.getInstance();
		try {
			mRequest = new MultipartRequest(request, path, maxSize, "utf-8", new DefaultFileRenamePolicy());
			Enumeration<String> paramNames = mRequest.getFileNames();
			String param = paramNames.nextElement();
			filename = mRequest.getFilesystemName(param);
			String mid = mRequest.getParameter("mid");
			String bsubject = mRequest.getParameter("bsubject").trim();
			String bcontent = mRequest.getParameter("bcontent").trim();
			String bfile = filename; 
			Date brdate = new Date(System.currentTimeMillis());
			String bip = request.getRemoteAddr();
			String mkname = mRequest.getParameter("mkname");
			BoardDto bDto = new BoardDto(0, mid, bsubject, bcontent, bfile, bip, 0, 0, 0, brdate, mkname);
			result = bDao.write(bDto);
			request.setAttribute("writeResult", result);
		} catch (IOException e) {
			System.out.println(e.getMessage());
		}
		InputStream  is = null;
		OutputStream os = null;
		try {
			File serverFile = new File(path + "/" + filename);
			if(serverFile.exists() && !filename.equals(null) && result==bDao.SUCCESS) {
				is = new FileInputStream(serverFile);
				os = new FileOutputStream("D:\\Dsilv\\source\\08_1stProject\\SkyTicket\\WebContent\\BoardFile\\"+filename);
				byte[] bs = new byte[(int)serverFile.length()];
				while(true) {
					int nReadCnt = is.read(bs);
					if(nReadCnt == -1) break;
					os.write(bs, 0, nReadCnt);
				}
				System.out.println("서버에 업로드한 파일을 서버폴더로 복사 성공");
			}
		} catch(Exception e) {
			System.out.println(e.getMessage());
		} finally {
			try{
				if(os!=null) os.close();
				if(is!=null) is.close();
			} catch(IOException e) {
				System.out.println(e.getMessage());
			}
			
		}
	}

}
