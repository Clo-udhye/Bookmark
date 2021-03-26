package com.exam.bookmark;


import java.util.ArrayList;
import javax.servlet.http.HttpServletResponse;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.context.support.HttpRequestHandlerServlet;

import com.exam.boardlist.BoardDAO;
import com.exam.boardlist.BoardPagingTO;
import com.exam.boardlist.BoardTO;
import com.exam.booklist.BookDAO;
import com.exam.booklist.BookRelatedTO;
import com.exam.booklist.BookTO;
import com.exam.paging.pagingTO;
import com.exam.theseMonthBoard.Home_BoardDAO;
import com.exam.theseMonthBoard.Home_BoardTO;
import com.exam.user.SHA256;
import com.exam.user.UserDAO;
import com.exam.user.UserTO;
import com.exam.zipcode.ZipcodeDAO;
import com.exam.zipcode.ZipcodeTO;

@Controller
public class HomeController {
	@Autowired
	private BookDAO bookdao; 
	//에러 발생 위치 Error creating bean with name 'homeController': Unsatisfied dependency expressed through field 'bookdao' 
	
	@Autowired
	UserDAO userDao;
	
	@Autowired
	ZipcodeDAO zipcodeDao;
	
	@Autowired
	BoardDAO boardDao;
	
	@Autowired
	Home_BoardDAO home_boardDAO;
	
	@RequestMapping(value = "/test.do")
	public String test() {
		return "test";
	}
	
	@RequestMapping(value = "/home.do")
	public String home(HttpServletRequest req , Model model) {
		ArrayList<Home_BoardTO> lists = home_boardDAO.BoardlistTemplate();
		model.addAttribute("lists", lists);
		return "home";
	}
	
	@RequestMapping(value = "/list.do")
	public String list(HttpServletRequest request, Model model) {
		//public String list(Locale locale, Model model) {	
		// paging 없는 일반 리스트 출력
		//ArrayList<BoardTO> lists = boardDao.boardList();
		//model.addAttribute("lists", lists);
		//System.out.println(lists);
		
		// paging 리스트 출력
		//BoardPagingTO pagingTO = boardDao.boardList(to);
		//model.addAttribute("pagingTO", pagingTO);
		
		int cpage = 1;   // cpage가 없으면 1
		if(request.getParameter("cpage") != null && !request.getParameter("cpage").equals("")){   
			cpage = Integer.parseInt(request.getParameter("cpage"));
		}
	      
		BoardPagingTO pagingTO = new BoardPagingTO();
		pagingTO.setCpage(cpage);
	      
		pagingTO = boardDao.boardList(pagingTO);
		model.addAttribute("pagingTO", pagingTO);

		return "board_list";
	}
	
	@RequestMapping(value = "/view.do")
	public String view(HttpServletRequest req , Model model) {
		String seq = req.getParameter("seq");
		//System.out.println(seq);
		Home_BoardTO home_BoardTO =  home_boardDAO.Book_infoTemplate(seq);
		model.addAttribute("home_BoardTO", home_BoardTO);
		
		return "board_view";
	}
	
	@RequestMapping(value = "/book_list.do")
	public String book_list(Locale locale, Model model, pagingTO to) {
		//paging 없는 일반 리스트 출력
//		ArrayList<BookTO> booklist = bookdao.BooklistTemplate();
//		model.addAttribute("booklist", booklist);
		
		pagingTO paginglist = bookdao.pagingList(to);
		model.addAttribute("paginglist", paginglist);
		return "book_list";
	}
	@RequestMapping(value = "/book_list_search.do")
	public String book_list_search(HttpServletRequest req , Model model, pagingTO to) {
		String name = req.getParameter("search");
		String bookname = req.getParameter("bookname");
		//System.out.println(name);
		//System.out.println(bookname);
		pagingTO paginglist = bookdao.pagingSearch(to, name, bookname);
		if (paginglist.getTotalrecord() == 0) {
			model.addAttribute("paginglist", paginglist);
			model.addAttribute("bookname", bookname);
			//System.out.println("book_list_NoResult");
			return "book_list_NoResult";
		} else {
			model.addAttribute("paginglist", paginglist);
			model.addAttribute("bookname", bookname);
			//System.out.println("book_list");
			return "book_list";
		}
	}
	
	@RequestMapping(value = "/book_info.do", method = RequestMethod.GET)
	public String book_info(HttpServletRequest req, Model model, pagingTO to) {
		String master_seq = req.getParameter("master_seq");
		BookTO book_info = bookdao.Book_infoTemplate(master_seq);
		model.addAttribute("book_info", book_info);
		int cpage = to.getCpage();
		model.addAttribute("cpage", cpage);
		ArrayList<BookRelatedTO> relatedBoard = bookdao.Book_infoTemplate_relatedBoard(master_seq);
		model.addAttribute("relatedBoard", relatedBoard);
		return "book_info";
	}
	
	@RequestMapping(value = "/login.do")
	public String login() {
		return "login";
	}
	
	@RequestMapping(value = "/login_ok.do")
	public String login_ok(HttpServletRequest request, Model model) {
		UserTO to = new UserTO();
		to.setId(request.getParameter("userID"));
		//비밀번호 암호화
		//to.setPassword(request.getParameter("userPassword"));
		to.setPassword(SHA256.encodeSHA256(request.getParameter("userPassword")));
		
		//System.out.println(request.getParameter("userID"));
		//System.out.println(request.getParameter("userPassword"));
		
		int flag = userDao.loginOk(to);
		model.addAttribute("flag", flag);
		
		//System.out.println(flag);
		
		return "login_ok";
	}
	
	@RequestMapping(value = "/logout_ok.do")
	public String logout_ok() {
		return "logout_ok";
	}
	
	@RequestMapping(value = "/mypage.do")
	public String mypage() {
		return "mypage";
	}
	
	@RequestMapping(value = "/search.do")
	public String search() {
		return "search";
	}
	
	@RequestMapping(value = "/search_list.do")
	public String search_list(HttpServletRequest request, Model model) {
		
		int tpage = 1;   // cpage가 없으면 1
		if(request.getParameter("tpage") != null && !request.getParameter("tpage").equals("")){   
			tpage = Integer.parseInt(request.getParameter("tpage"));
		}
	    
		// 입력한 검색어 받아오려고..
		String searchword = request.getParameter("searchword");
		
		BoardPagingTO slpagingTO = new BoardPagingTO();
		slpagingTO.setCpage(tpage);
	    
		// BoardDAO에 searchList에 인자 searchword 추가로 적음. (boardList와 달리)
		slpagingTO = boardDao.searchTList(slpagingTO, searchword);
		// ""안에 있는 게 search_list.jsp에서 사용할 이름
		// , 뒤에 있는 게 가져올 데이터 이름
		model.addAttribute("slpagingTO", slpagingTO);
		// searchword도 addAttribute로 가져와야 jsp파일에서 사용할 수 있음
		model.addAttribute("searchword", searchword);
		
		
		// 작가 검색 결과 게시글 리스트
		int npage = 1;   // cpage가 없으면 1
		if(request.getParameter("npage") != null && !request.getParameter("npage").equals("")){   
			npage = Integer.parseInt(request.getParameter("npage"));
		}
		
		BoardPagingTO snlpagingTO = new BoardPagingTO();
		snlpagingTO.setCpage(npage);
		
		snlpagingTO = boardDao.searchNList(snlpagingTO, searchword);
		model.addAttribute("snlpagingTO", snlpagingTO);
		model.addAttribute("searchword", searchword);
		
		//System.out.println(slpagingTO.getCpage());
		//System.out.println(snlpagingTO.getCpage());
		
		// 검색 결과 작가 리스트 
		int nnpage = 1;   // cpage가 없으면 1
		// getParameter는 url에서 가져오는 키워드라서 nnpage가 아니라 npage를 가져와야 함!!
		if(request.getParameter("npage") != null && !request.getParameter("npage").equals("")){   
			nnpage = Integer.parseInt(request.getParameter("npage"));
		}
		
		BoardPagingTO snnlpagingTO = new BoardPagingTO();
		snnlpagingTO.setCpage(nnpage);
		
		snnlpagingTO = boardDao.searchNNList(snnlpagingTO, searchword);
		model.addAttribute("snnlpagingTO", snnlpagingTO);
		model.addAttribute("searchword", searchword);
		
		return "search_list";
	}
	
	@RequestMapping(value = "/signup.do")
	public String signup() {
		return "signup";
	}
	
	@RequestMapping(value = "/signup_ok.do")
	public String signup_ok(HttpServletRequest request, Model model) {
		UserTO to = new UserTO();
		to.setId(request.getParameter("userID"));
		
		//비밀번호 암호화
		//to.setPassword(request.getParameter("userPassword"));
		to.setPassword(SHA256.encodeSHA256(request.getParameter("userPassword")));
		
		to.setNickname(request.getParameter("nickname"));
		to.setMail(request.getParameter("mail"));
		if(!request.getParameter("address").trim().equals("")) {
			to.setAddress(request.getParameter("address"));
			to.setAddresses(request.getParameter("addresses"));
		}

		int flag = userDao.signupOk(to) ;
		model.addAttribute("flag", flag);
		
		return "signup_ok";
	}
	
	@RequestMapping(value = "/admin.do")
	public String admin() {
		return "admin";
	}
	
	@RequestMapping(value = "/duplicationCheck.do")
	public String duplicationCheck(HttpServletRequest request, Model model) {
		
		String item = request.getParameter("item");
		String value = request.getParameter("value");
		int flag = userDao.dupCheck(item, value);
		
		model.addAttribute("flag", flag);
		
		return "duplicationCheck";
	}
	
	@RequestMapping(value = "/zipsearch.do")
	public String zipsearch(HttpServletRequest request, Model model) {
		
		String strDong = null;
		if(!request.getParameter("strDong").trim().equals("")) {
			strDong = request.getParameter("strDong");
		}
		
		//System.out.println("strDong : " + strDong);
		ArrayList<ZipcodeTO> lists = zipcodeDao.searchLists(strDong);
		model.addAttribute("lists", lists);
		return "zipsearch";
	}
	

}
