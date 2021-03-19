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
		String sql = "select b.seq as seq, b.date as date, b.title as title, u.nickname as nickname, b.filename as filename, b.content as content, b.bseq as bseq, b.hit as hit, b.comment as comment from board as b join user as u on b.useq = u.seq order by b.date desc limit 3 offset 5";
		ArrayList<Home_BoardTO> lists = (ArrayList<Home_BoardTO>) jdbcTemplate.query(sql, new BeanPropertyRowMapper<Home_BoardTO>(Home_BoardTO.class));
		return lists;
	}
	
	public Home_BoardTO Book_infoTemplate(String seq){
		String sql = "select b.seq as seq, b.date as date, b.title as title, u.nickname as nickname, b.filename as filename, b.content as content, book.title as book_title, b.hit as hit, b.comment as comment from board as b join user as u on b.useq = u.seq  join book as book on b.bseq = book.Master_seq where b.seq=?";
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
				return to;
			}
		});
		return book;
	}
}
