package com.exam.theseMonthBoard;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class Board_Modify_Delete_DAO {
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	public int Board_Modify (String writer_seq, String board_seq, String board_title, String board_content) {
		String sql_modify = "update board set title = ?, content = ? where seq = ? and useq = ? ";
		int result = jdbcTemplate.update(sql_modify, board_title, board_content, board_seq, writer_seq);
		//System.out.println("board 테이블 board_seq : " +board_seq+ "useq :" + writer_seq +"의 " + result+ "record가 수정되었습니다.");
		return result;
	};
	
	public int Board_Delete (String writer_seq, String board_seq) {
		String sql_delete = "delete from board where seq = ? and useq = ?";
		int result_board = jdbcTemplate.update(sql_delete, board_seq, writer_seq);
		//System.out.println("board 테이블 board_seq : " +board_seq+ "useq :" + writer_seq +"의 " + result_board+ "개의 record가 삭제되었습니다.");
		
		String sql_delete_comment = "delete from comment where bseq = ?";
		int result_board_comment = jdbcTemplate.update(sql_delete_comment, board_seq);
		//System.out.println("comment 테이블 bseq : " +board_seq+"의 " + result_board_comment+ "개의 record가 삭제되었습니다.");
		
		String sql_delete_likey = "delete from likey where bseq = ?";
		int result_board_likey = jdbcTemplate.update(sql_delete_likey, board_seq);
		//System.out.println("lieky 테이블 bseq : " +board_seq+"의 " + result_board_likey+ "개의 record가 삭제되었습니다.");
		
		String sql_delete_hit = "delete from hit where bseq = ?";
		int result_board_hit = jdbcTemplate.update(sql_delete_hit, board_seq);
		//System.out.println("hit 테이블 bseq : " +board_seq+"의 " + result_board_hit+ "개의 record가 삭제되었습니다.");
		
		return result_board;
	};
	
	//삭제할 게시글의 사진 이름받아오기
	public String Board_Select_Filename (String board_seq) {
	      String sql_select_filename = "select filename from board where seq = ?";
	      String result_filename = jdbcTemplate.queryForObject(sql_select_filename, new Object[]{board_seq}, String.class);
	      return result_filename;
	   }
}