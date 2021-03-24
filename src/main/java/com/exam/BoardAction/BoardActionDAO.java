package com.exam.BoardAction;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.exam.user.UserTO;
@Repository
public class BoardActionDAO {
	@Autowired
	JdbcTemplate jdbcTemplate;
	public int comment(String writer_seq, String comment, String board_seq){
		String sql = "select seq from user where id = ?";
		UserTO user = (UserTO) jdbcTemplate.queryForObject(sql, new Object[]{writer_seq}, new RowMapper<UserTO>() {
			public UserTO mapRow(ResultSet rs, int rowNum) throws SQLException{
				UserTO to = new UserTO();
				to.setSeq(rs.getString("seq"));
				return to;
			}
		});
		
		String user_seq = user.getSeq();
		//System.out.println(user_seq);
		String comment_sql = "insert into comment values (0, ?, ?, ?, now())";
		int flag = 0;
		flag = jdbcTemplate.update(comment_sql, board_seq, user_seq, comment);
		//System.out.println(flag + "개의 records가 추가 되었습니다.");
		return flag;
	}
	
	public int likey(String writer_seq, String board_seq) {
		String sql = "select seq from user where id = ?";
		UserTO user = (UserTO) jdbcTemplate.queryForObject(sql, new Object[]{writer_seq}, new RowMapper<UserTO>() {
			public UserTO mapRow(ResultSet rs, int rowNum) throws SQLException{
				UserTO to = new UserTO();
				to.setSeq(rs.getString("seq"));
				return to;
			}
		});
		String user_seq = user.getSeq();
		//System.out.println(user_seq);
		String comment_sql = "insert into likey values (0, ?, ?, now())";
		int flag_like = 0;
		flag_like = jdbcTemplate.update(comment_sql, board_seq, user_seq);
		//System.out.println(flag + "개의 records가 추가 되었습니다.");
		return flag_like;
	}
	
	public int unlikey(String writer_seq, String board_seq) {
		String sql = "select seq from user where id = ?";
		UserTO user = (UserTO) jdbcTemplate.queryForObject(sql, new Object[]{writer_seq}, new RowMapper<UserTO>() {
			public UserTO mapRow(ResultSet rs, int rowNum) throws SQLException{
				UserTO to = new UserTO();
				to.setSeq(rs.getString("seq"));
				return to;
			}
		});
		String user_seq = user.getSeq();
		//System.out.println(user_seq);
		String comment_sql = "delete from likey where bseq = ? and useq = ?";
		int flag_like = 0;
		flag_like = jdbcTemplate.update(comment_sql, board_seq, user_seq);
		//System.out.println(flag_like + "개의 records가 삭제 되었습니다.");
		return flag_like;
	}
}
