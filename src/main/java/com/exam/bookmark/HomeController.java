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
import com.exam.booklist.BookTO;
import com.exam.paging.pagingTO;
import com.exam.user.SHA256;
import com.exam.user.UserDAO;
import com.exam.user.UserTO;

@Controller
public class HomeController {
	@Autowired
	private BookDAO bookdao; 
	//에러 발생 위치 Error creating bean with name 'homeController': Unsatisfied dependency expressed through field 'bookdao' 
	
	@Autowired
	UserDAO userDao;
	
	@Autowired
	BoardDAO boardDao;
	
	@RequestMapping(value = "/test.do")
	public String test() {
		return "test";
	}
	
	@RequestMapping(value = "/duplicationCheck.do")
	public String duplicationCheck(HttpServletRequest request, Model model) {
		
		String item = request.getParameter("item");
		String value = request.getParameter("value");
		int flag = userDao.dupCheck(item, value);
		
		model.addAttribute("flag", flag);
		
		return "duplicationCheck";
	}
	
	
	@RequestMapping(value = "/home.do")
	public String home() {
		return "home";
	}
	
	@RequestMapping(value = "/list.do")
	public String list(HttpServletRequest request, Model model) {
		//paging 없는 일반 리스트 출력
		//ArrayList<BoardTO> lists = boardDao.boardList();
		//model.addAttribute("lists", lists);
		//System.out.println(lists);
		
		int cpage = 1;	// cpage가 없으면 1
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
	public String view() {
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
			System.out.println("book_list_NoResult");
			return "book_list_NoResult";
		} else {
			model.addAttribute("paginglist", paginglist);
			model.addAttribute("bookname", bookname);
			System.out.println("book_list");
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
	
}
