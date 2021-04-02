package com.exam.bookmark;


import java.util.ArrayList;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Locale;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.exam.BoardAction.BoardActionDAO;
import com.exam.admin.AdminDAO;
import com.exam.admin.PagingBoardTO;
import com.exam.admin.PagingUserTO;
import com.exam.boardlist.BoardDAO;
import com.exam.boardlist.BoardPagingTO;
import com.exam.boardlist.BoardTO;
import com.exam.boardlist.MyPageTO;
import com.exam.booklist.BookDAO;
import com.exam.booklist.BookRelatedTO;
import com.exam.booklist.BookTO;
import com.exam.paging.pagingTO;
import com.exam.theseMonthBoard.Board_CommentTO;
import com.exam.theseMonthBoard.Board_Modify_Delete_DAO;
import com.exam.theseMonthBoard.Home_BoardDAO;
import com.exam.theseMonthBoard.Home_BoardTO;
import com.exam.user.LoginTO;
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
	
	@Autowired
	BoardActionDAO boardActionDAO;

	@Autowired
	AdminDAO adminDao;

	@Autowired
	Board_Modify_Delete_DAO board_Modify_Delete_DAO;
	
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
		HttpSession session = req.getSession();
		if (session.getAttribute("userInfo") != null) {
			UserTO userInfo = (UserTO)session.getAttribute("userInfo");
			String useq = userInfo.getSeq();
			int count_check = home_boardDAO.likey_check(seq, useq);
			model.addAttribute("like_count_check", count_check);
		}
		Home_BoardTO home_BoardTO =  home_boardDAO.Book_infoTemplate(seq);
		model.addAttribute("home_BoardTO", home_BoardTO);
		ArrayList<Board_CommentTO> board_CommentTO = home_boardDAO.CommentListTemplate(seq);
		model.addAttribute("board_commentTO", board_CommentTO);
		int count = home_boardDAO.likey_count(seq);
		model.addAttribute("likey_count", count);
		return "board_view";
	}
	@RequestMapping(value = "/comment.do")
	public String comment(HttpServletRequest req , Model model) {
		String value = req.getParameter("value");
		String seq = req.getParameter("seq");
		if(value.equals("create")) {
			String writer_seq = req.getParameter("user");
			String comment = req.getParameter("comment");
			String board_seq = req.getParameter("seq");
			int flag = boardActionDAO.comment(writer_seq, comment, board_seq);
			model.addAttribute("flag", flag);
		} else if(value.equals("modify")) {
			String comment = req.getParameter("comment");
			String comment_seq = req.getParameter("comment_seq");
			int flag = boardActionDAO.comment_modify(comment, comment_seq);
			model.addAttribute("flag", flag);
		} else if (value.equals("delete")) {
			String comment_seq = req.getParameter("comment_seq");
			int flag = boardActionDAO.comment_delete(comment_seq);
			model.addAttribute("flag", flag);
		}
		ArrayList<Board_CommentTO> board_CommentTO = home_boardDAO.CommentListTemplate(seq);
		model.addAttribute("board_commentTO", board_CommentTO);
		
		return "comment_xml";
	}

	@RequestMapping(value = "/likey.do")
	public String likey(HttpServletRequest req , Model model) {
		String board_seq = req.getParameter("bseq");
		String writer_seq = req.getParameter("user");			

		if (req.getParameter("value").equals("likey")) {
			int flag_like = boardActionDAO.likey(writer_seq, board_seq);
			model.addAttribute("flag_like", flag_like);
		} else if(req.getParameter("value").equals("unlikey")) {
			int flag_like = boardActionDAO.unlikey(writer_seq, board_seq);
			model.addAttribute("flag_like", flag_like);
		}
		int count = home_boardDAO.likey_count(board_seq);
		model.addAttribute("likey_count", count);
		
		int count_check = home_boardDAO.likey_check(board_seq, writer_seq);
		model.addAttribute("like_count_check", count_check);
		
		return "likey_xml";
	}
	
	@RequestMapping(value = "/board_modify.do")
	public String board_modify(HttpServletRequest req , Model model) {
		String writer_seq = req.getParameter("user");
		String board_seq = req.getParameter("bseq");
		String board_title = req.getParameter("board_title");
		String board_content = req.getParameter("board_content");
		int flag = board_Modify_Delete_DAO.Board_Modify(writer_seq, board_seq, board_title, board_content);
		model.addAttribute("flag", flag);
		
		Home_BoardTO home_BoardTO =  home_boardDAO.Book_infoTemplate(board_seq);
		model.addAttribute("home_BoardTO", home_BoardTO);
		
		return "modify_ok";
	}
	
	@RequestMapping(value = "/board_delete.do")
	public String board_delete(HttpServletRequest req , Model model) {
		String writer_seq = req.getParameter("user");
		String board_seq = req.getParameter("bseq");
		int flag = board_Modify_Delete_DAO.Board_Delete(writer_seq, board_seq);
		model.addAttribute("flag", flag);
		
		return "";
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
		
		LoginTO lto = userDao.loginOk(to);
		model.addAttribute("lto", lto);

		
		//System.out.println(flag);
		
		return "login_ok";
	}
	
	@RequestMapping(value = "/logout_ok.do")
	public String logout_ok() {
		return "logout_ok";
	}
	
	@RequestMapping(value = "/mypage.do")
	public String mypage(HttpServletRequest req, Model model) {
		String vister_useq = req.getParameter("useq");
		
		UserTO visiterTO = userDao.myPage_Info_load(vister_useq);
		model.addAttribute("visiterTO", visiterTO);
		int board_counts = userDao.user_board_count(vister_useq);
		model.addAttribute("board_counts", board_counts);
		ArrayList<MyPageTO> myboard_list = boardDao.boardList_Mypage(vister_useq);
		model.addAttribute("myboard_list", myboard_list);
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
	public String admin(HttpServletRequest request, Model model) {
		//ArrayList<AdminUserListTO> userList = adminDao.userList();
		//model.addAttribute("userList", userList);
		//System.out.println(userList.size());
		int upage = 1;   // upage가 없으면 1
		if(request.getParameter("upage") != null && !request.getParameter("upage").equals("")){   
			upage = Integer.parseInt(request.getParameter("upage"));
		}
	      
		PagingUserTO pUserList = new PagingUserTO();
		pUserList.setUpage(upage);
	      
		pUserList = adminDao.userList(pUserList);
		model.addAttribute("pUserList", pUserList);
		
		//ArrayList<AdminBoardListTO> boardList = adminDao.boardList();
		//model.addAttribute("boardList", boardList);
		int bpage = 1;   // upage가 없으면 1
		if(request.getParameter("bpage") != null && !request.getParameter("bpage").equals("")){   
			bpage = Integer.parseInt(request.getParameter("bpage"));
		}
	      
		PagingBoardTO pBoardList = new PagingBoardTO();
		pBoardList.setBpage(bpage);
	      
		pBoardList = adminDao.boardList(pBoardList);
		model.addAttribute("pBoardList", pBoardList);
		
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
	
	@RequestMapping(value = "/user_delete_ok.do")
	public String user_delete_ok(HttpServletRequest request, Model model) {
		
		UserTO to = new UserTO();
		to.setSeq(request.getParameter("useq"));
		int flag = userDao.userDelete(to);
		model.addAttribute("flag", flag);
		
		return "user_delete_ok";
	}
	
	@RequestMapping(value = "/board_delete_ok.do")
	public String board_delete_ok(HttpServletRequest request, Model model) {
		
		BoardTO to = new BoardTO();
		to.setBseq(request.getParameter("bseq"));
		int flag = boardDao.boardDelete(to);
		model.addAttribute("flag", flag);
		
		return "board_delete_ok";
	}
	
	@RequestMapping(value = "/view2.do")
	public String view2(HttpServletRequest req , Model model) {
		String seq = req.getParameter("seq");
		HttpSession session = req.getSession();
		if (session.getAttribute("userInfo") != null) {
			UserTO userInfo = (UserTO)session.getAttribute("userInfo");
			String userID = userInfo.getId();
			int count_check = home_boardDAO.likey_check(seq, userID);
			model.addAttribute("like_count_check", count_check);
		}
		Home_BoardTO home_BoardTO =  home_boardDAO.Book_infoTemplate(seq);
		model.addAttribute("home_BoardTO", home_BoardTO);
		ArrayList<Board_CommentTO> board_CommentTO = home_boardDAO.CommentListTemplate(seq);
		model.addAttribute("board_commentTO", board_CommentTO);
		int count = home_boardDAO.likey_count(seq);
		model.addAttribute("likey_count", count);
		return "board_view2";
	}
	
	@RequestMapping(value = "/modify.do")
	public String modify(HttpServletRequest req , Model model) {
		String seq = req.getParameter("seq");
		HttpSession session = req.getSession();
		if (session.getAttribute("userInfo") != null) {
			UserTO userInfo = (UserTO)session.getAttribute("userInfo");
			String userID = userInfo.getId();
			int count_check = home_boardDAO.likey_check(seq, userID);
			model.addAttribute("like_count_check", count_check);
		}
		Home_BoardTO home_BoardTO =  home_boardDAO.Book_infoTemplate(seq);
		model.addAttribute("home_BoardTO", home_BoardTO);
		ArrayList<Board_CommentTO> board_CommentTO = home_boardDAO.CommentListTemplate(seq);
		model.addAttribute("board_commentTO", board_CommentTO);
		int count = home_boardDAO.likey_count(seq);
		model.addAttribute("likey_count", count);
		return "board_modify";
	}
}
