package com.exam.theseMonthBoard;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.exam.boardlist.BoardTO;
import com.exam.booklist.BookTO;

@Repository
public class Home_BoardDAO {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public ArrayList<Home_BoardTO> BoardlistTemplate(){
		String sql = "select b.seq as seq, b.date as date, b.title as title, u.id as userID, u.nickname as nickname, b.filename as filename, b.content as content, b.bseq as bseq, b.hit as hit, b.comment as comment from board as b join user as u on b.useq = u.seq order by b.date desc limit 3 offset 5";
		ArrayList<Home_BoardTO> lists = (ArrayList<Home_BoardTO>) jdbcTemplate.query(sql, new BeanPropertyRowMapper<Home_BoardTO>(Home_BoardTO.class));
		return lists;
	}
	
	public Home_BoardTO Book_infoTemplate(String seq){
		String hit_sql = "update board set hit = hit + 1 where seq =?";
		int result = jdbcTemplate.update(hit_sql, seq);
		//System.out.println("hit 1증가 from board : " +result);
		
		String sql = "select b.seq as seq, b.date as date, b.title as title, u.seq as useq ,u.id as userID, u.nickname as nickname, b.filename as filename, b.content as content, book.title as book_title, b.hit as hit, b.comment as comment from board as b join user as u on b.useq = u.seq  join book as book on b.bseq = book.Master_seq where b.seq=?";
		Home_BoardTO book = (Home_BoardTO) jdbcTemplate.queryForObject(sql, new Object[]{seq}, new RowMapper<Home_BoardTO>() {
			public Home_BoardTO mapRow(ResultSet rs, int rowNum) throws SQLException{
				Home_BoardTO to = new Home_BoardTO();
				to.setSeq(rs.getString("seq"));
				to.setDate(rs.getString("date"));
				to.setTitle(rs.getNString("title"));
				to.setNickname(rs.getString("nickname"));
				to.setFilename(rs.getString("filename"));
				to.setContent(rs.getString("content"));
				to.setBook_title(rs.getString("book_title"));
				to.setComment(rs.getString("comment"));
				to.setHit(rs.getString("hit"));
				to.setUserID(rs.getString("userID"));
				to.setUseq(rs.getString("useq"));
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
		String sql = "select c.seq as seq, u.seq as useq, u.nickname as nickname, c.content as content, c.date_time as date_time from comment as c join user as u on c.useq = u.seq where c.bseq="+seq+" order by c.seq desc";
		ArrayList<Board_CommentTO> comment_lists = (ArrayList<Board_CommentTO>) jdbcTemplate.query(sql, new BeanPropertyRowMapper<Board_CommentTO>(Board_CommentTO.class));
		return comment_lists;
	}
	
	public int likey_count (String seq) {
		String sql = "select count(*) from likey where bseq =?";
		int count = jdbcTemplate.queryForObject(sql, new Object[] {seq} , Integer.class);
		//System.out.println(count);
		return count;
	}
	
	public int likey_check (String seq, String userID) {
		String user_sql = "select seq from user where id = ?";
		String useq = jdbcTemplate.queryForObject(user_sql, new Object[] {userID}, String.class);
		
		String sql = "select count(*) from likey where bseq =? and useq =?";
		int count_check = jdbcTemplate.queryForObject(sql, new Object[] {seq, useq} , Integer.class);
		//System.out.println(count);
		return count_check;
	}
}
