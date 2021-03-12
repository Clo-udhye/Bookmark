package com.exam.bookmark;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.exam.user.UserDAO;
import com.exam.user.UserTO;

@Controller
public class HomeController {
	
	@Autowired
	UserDAO dao;
	
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
	public String book_list() {
		return "book_list";
	}
	
	@RequestMapping(value = "/book_info.do")
	public String book_info() {
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
		to.setPassword(request.getParameter("userPassword"));
		
		//System.out.println(request.getParameter("userID"));
		//System.out.println(request.getParameter("userPassword"));
		
		int flag = dao.loginOk(to);
		model.addAttribute("flag", flag);
		
		//System.out.println(flag);
		
		return "login_ok";
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
