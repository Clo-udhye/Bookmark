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

@Controller
public class HomeController {
	@Autowired
	private BookDAO bookdao; 
	//에러 발생 위치 Error creating bean with name 'homeController': Unsatisfied dependency expressed through field 'bookdao' 
	
	@Autowired
	UserDAO userDao;
	
	@Autowired
	BoardDAO boardDao;
	
	@Autowired
	Home_BoardDAO home_boardDAO;
	
	@RequestMapping(value = "/test.do")
	public String test() {
		/* 암호화할 텍스트 */
		String text = "Hello, Java";
		
		/* SHA256 암호화 */
		String encryptSHA256 = SHA256.encodeSHA256(text);
		
		/* SHA256 암호화 결과 */
		System.out.println("SHA256 암호화 요청 텍스트 : " + text);
		System.out.println("SHA256 암호화 완료 텍스트 : " + encryptSHA256);
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
	public String home(HttpServletRequest req , Model model) {
		ArrayList<Home_BoardTO> lists = home_boardDAO.BoardlistTemplate();
		model.addAttribute("lists", lists);
		return "home";
	}
	
	@RequestMapping(value = "/list.do")
	public String list(Locale locale, Model model) {
		//paging 없는 일반 리스트 출력
		ArrayList<BoardTO> lists = boardDao.boardList();
		model.addAttribute("lists", lists);
		//System.out.println(lists);
		return "board_list";
	}
	
	@RequestMapping(value = "/view.do")
	public String view(HttpServletRequest req , Model model) {
		String seq = req.getParameter("seq");
		System.out.println(seq);
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
