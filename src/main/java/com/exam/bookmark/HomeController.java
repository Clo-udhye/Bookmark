package com.exam.bookmark;


import java.util.ArrayList;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.exam.booklist.BookDAO;
import com.exam.booklist.BookTO;
import com.exam.paging.pagingTO;



@Controller
public class HomeController {
	@Autowired
	private BookDAO bookdao; 
	//에러 발생 위치 Error creating bean with name 'homeController': Unsatisfied dependency expressed through field 'bookdao' 
	
	@RequestMapping(value = "/home.do")
	public String home() {
		return "home";
	}
	
	@RequestMapping(value = "/list.do")
	public String list() {
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
	
	@RequestMapping(value = "/book_info.do", method = RequestMethod.GET)
	public String book_info(HttpServletRequest req, Model model) {
		String master_seq = req.getParameter("master_seq");
		BookTO book_info = bookdao.Book_infoTemplate(master_seq);
		model.addAttribute("book_info", book_info);
		return "book_info";
	}
	
	@RequestMapping(value = "/login.do")
	public String login() {
		return "login";
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
	
	@RequestMapping(value = "/admin.do")
	public String admin() {
		return "admin";
	}
	
}
