package com.exam.theseMonthBoard;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.exam.boardlist.BoardTO;
import com.exam.boardlist.JoinBULCTO;
import com.exam.booklist.BookTO;

@Repository
public class Home_BoardDAO {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	/*
	public ArrayList<Home_BoardTO> BoardlistTemplate(){
		String sql = "select b.seq as seq, b.date as date, b.title as title, u.id as userID, u.nickname as nickname, b.filename as filename, b.content as content, b.bseq as bseq, b.hit as hit, b.comment as comment from board as b join user as u on b.useq = u.seq order by b.date desc limit 3 offset 5";
		ArrayList<Home_BoardTO> lists = (ArrayList<Home_BoardTO>) jdbcTemplate.query(sql, new BeanPropertyRowMapper<Home_BoardTO>(Home_BoardTO.class));
		return lists;
	}
	*/
	// 이달의 게시글 출력 항목 수정
	public ArrayList<JoinBULCTO> BoardlistTemplate() {
		//String sql = "select b.seq as seq, b.date as date, b.title as title, u.id as userID, u.nickname as nickname, b.filename as filename, b.content as content, b.bseq as bseq, b.hit as hit, b.comment as comment from board as b join user as u on b.useq = u.seq order by b.date desc limit 3 offset 5";
		/*
		String sql = "select bnunltable.seq, date, filename, title, bnunltable.useq, nickname, Lcount, count(comment.bseq) Ccount " + 
				"from (select bnutable.seq, date, filename, title, bnutable.useq, nickname, count(likey.bseq) Lcount " + 
				"from (select board.seq, date, board.filename, title, useq, nickname from board inner join user on board.useq = user.seq) bnutable " + 
				"left outer join likey on bnutable.seq = likey.bseq group by bnutable.seq) bnunltable " + 
				"left outer join comment on bnunltable.seq = comment.bseq group by bnunltable.seq order by date desc limit 3 offset 4";
		*/
		String sql = "select bl.seq as seq, bl.date as date, bl.filename as filename, bl.title as title, bl.useq as useq,bl.nickname as nickname, bl.likey as lcount, count(bl.seq) as ccount from ("+
				"select b.seq as seq, b.date as date, b.filename as filename, b.title as title, b.useq as useq, b.nickname as nickname, count(b.seq) as likey from (" +
						"select o.seq as seq, o.date as date, o.filename as filename, o.title as title, o.useq as useq, u.nickname as nickname from ("+
						"select seq, date, title, useq, filename from board "+
						"where seq in ( select * from (select bseq from hit where date_time between date_sub(now(), interval 1 month) and now() group by bseq order by count(bseq) desc limit 3) as subquery)"+
						") as o join user as u on o.useq = u.seq"+
						") as b left outer join likey as l on b.seq = l.useq group by b.seq"+
						") as bl left outer join comment as c on bl.seq = c.bseq group by bl.seq";
		ArrayList<JoinBULCTO> lists = (ArrayList<JoinBULCTO>) jdbcTemplate.query(sql, new BeanPropertyRowMapper<JoinBULCTO>(JoinBULCTO.class));
		return lists;
	}
	
	
	public Home_BoardTO Book_infoTemplate(String seq){
		String hit_sql = "update board set hit = hit + 1 where seq =?";
		int result = jdbcTemplate.update(hit_sql, seq);
		//System.out.println("hit 1증가 from board : " +result);
		
		String sql = "select b.seq as seq, b.date as date, book.Master_seq as bookseq, b.title as title, u.seq as useq ,u.id as userID, u.nickname as nickname, b.filename as filename, b.content as content, book.title as book_title, b.hit as hit, b.comment as comment, u.profile_filename as profile from board as b join user as u on b.useq = u.seq  join book as book on b.bseq = book.Master_seq where b.seq=?";
		Home_BoardTO book = (Home_BoardTO) jdbcTemplate.queryForObject(sql, new Object[]{seq}, new RowMapper<Home_BoardTO>() {
			public Home_BoardTO mapRow(ResultSet rs, int rowNum) throws SQLException{
				Home_BoardTO to = new Home_BoardTO();
				to.setSeq(rs.getString("seq"));
				to.setDate(rs.getString("date"));
				to.setTitle(rs.getNString("title"));
				to.setNickname(rs.getString("nickname"));
				to.setFilename(rs.getString("filename"));
				to.setContent(rs.getString("content"));
				to.setBseq(rs.getString("bookseq"));
				to.setBook_title(rs.getString("book_title"));
				to.setComment(rs.getString("comment"));
				to.setHit(rs.getString("hit"));
				to.setUserID(rs.getString("userID"));
				to.setUseq(rs.getString("useq"));
				to.setProfile(rs.getString("profile"));
				return to;
			}
		});
		
		String useq = book.getUseq();
		String hit_sql_table = "insert into hit values (0,?,?, now())";
		int result_hit = jdbcTemplate.update(hit_sql_table, seq, useq);
		//System.out.println("hit 테이블에  "+result_hit+ "개의 record 기록");
		
		return book;
	}
	
	public ArrayList<Board_CommentTO> CommentListTemplate(String seq){
		String sql = "select c.seq as seq, ifnull(u.seq, -1) as useq, ifnull(u.nickname,'탈퇴한 회원입니다.') as nickname, ifnull(u.profile_filename,'no-profile.png') as filename, c.content as content, c.date_time as date_time from comment as c left outer join user as u on c.useq = u.seq where c.bseq="+seq+" order by c.seq desc";
		ArrayList<Board_CommentTO> comment_lists = (ArrayList<Board_CommentTO>) jdbcTemplate.query(sql, new BeanPropertyRowMapper<Board_CommentTO>(Board_CommentTO.class));
		return comment_lists;
	}
	
	public int likey_count (String seq) {
		String sql = "select count(*) from likey where bseq =?";
		int count = jdbcTemplate.queryForObject(sql, new Object[] {seq} , Integer.class);
		//System.out.println(count);
		return count;
	}
	
	public int likey_check (String seq, String useq) throws EmptyResultDataAccessException {
		String sql = "select count(*) from likey where bseq =? and useq =?";
		int count_check = jdbcTemplate.queryForObject(sql, new Object[] {seq, useq} , Integer.class);
		return count_check;
	}
	
	//조회수를 증가시키지 않고 게시글 정보를 가져오기
	public Home_BoardTO board_Template(String seq){
		String sql = "select b.seq as seq, b.date as date, b.title as title, u.seq as useq ,u.id as userID, u.nickname as nickname, b.filename as filename, b.content as content, book.title as book_title, u.profile_filename as profile from board as b join user as u on b.useq = u.seq  join book as book on b.bseq = book.Master_seq where b.seq=?";
		Home_BoardTO board = (Home_BoardTO) jdbcTemplate.queryForObject(sql, new Object[]{seq}, new RowMapper<Home_BoardTO>() {
			public Home_BoardTO mapRow(ResultSet rs, int rowNum) throws SQLException{
				Home_BoardTO to = new Home_BoardTO();
				to.setSeq(rs.getString("seq"));
				to.setDate(rs.getString("date"));
				to.setTitle(rs.getNString("title"));
				to.setNickname(rs.getString("nickname"));
				to.setFilename(rs.getString("filename"));
				to.setContent(rs.getString("content"));
				to.setBook_title(rs.getString("book_title"));
				to.setUserID(rs.getString("userID"));
				to.setUseq(rs.getString("useq"));
				to.setProfile(rs.getString("profile"));
				return to;
			}
		});
		
		return board;
	}
}
