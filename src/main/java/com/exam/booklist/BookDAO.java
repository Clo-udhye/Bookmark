package com.exam.booklist;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.exam.paging.pagingTO;
@Repository
public class BookDAO {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private DataSource dataSource;
	
	public ArrayList<BookTO> BooklistTemplate(){
		String sql = "select master_seq, isbn13, title, author, publisher, img_url, description, pub_date order by master_seq from book limit 15";
		ArrayList<BookTO> lists = (ArrayList<BookTO>) jdbcTemplate.query(sql, new BeanPropertyRowMapper<BookTO>(BookTO.class));
		return lists;
	}
	
	public BookTO Book_infoTemplate(String master_seq){
		String sql = "select master_seq, isbn13, title, author, publisher, img_url, description, pub_date from book where master_seq=?";
		BookTO book = (BookTO) jdbcTemplate.queryForObject(sql, new Object[]{master_seq}, new RowMapper<BookTO>() {
			public BookTO mapRow(ResultSet rs, int rowNum) throws SQLException{
				BookTO to = new BookTO();
				to.setMaster_seq(rs.getString("master_seq"));
				to.setIsbn13(rs.getString("isbn13"));
				to.setTitle(rs.getNString("title"));
				to.setAuthor(rs.getString("author"));
				to.setPublisher(rs.getNString("publisher"));
				to.setImg_url(rs.getString("img_url"));
				to.setDescription(rs.getString("description"));
				to.setPub_date(rs.getString("pub_date"));
				return to;
			}
		});
		//(BookTO) jdbcTemplate.query(sql, new BeanPropertyRowMapper(BookTO.class));
		return book;
	}
	public ArrayList<BookRelatedTO> Book_infoTemplate_relatedBoard(String master_seq){
		String sql = "select b.seq as board_seq, b.date as board_date, b.title as board_title, u.nickname as user_nickname from board as b join user as u on b.useq = u.seq where b.bseq="+master_seq+" order by b.date desc";
		ArrayList<BookRelatedTO> lists = (ArrayList<BookRelatedTO>) jdbcTemplate.query(sql, new BeanPropertyRowMapper<BookRelatedTO>(BookRelatedTO.class));
		//(BookTO) jdbcTemplate.query(sql, new BeanPropertyRowMapper(BookTO.class));
		return lists;
	}
	
	public pagingTO pagingList(pagingTO booklistTO) {
		//paging
		int cpage = booklistTO.getCpage();
		int recordPerPage = booklistTO.getRecordPerPage();
		int blockPerPage = booklistTO.getBlockPerPage();
		
		pagingTO pagingTO = new pagingTO();
		pagingTO.setCpage(cpage);
		pagingTO.setRecordPerPage(recordPerPage);
		pagingTO.setBlockPerPage(blockPerPage);
		
		String queryTotalRecords = "select count(*) from book";
		int totalItems = jdbcTemplate.queryForObject(queryTotalRecords, Integer.class);
		pagingTO.setTotalrecord(totalItems);
		
		pagingTO.setTotalPage((totalItems/5)-1);
		String sql ="";
		if (cpage==1) {
			sql = "select master_seq, isbn13, title, author, publisher, img_url, description, pub_date from book order by master_seq limit " + booklistTO.getRecordPerPage();
		} else {
			sql = "select master_seq, isbn13, title, author, publisher, img_url, description, pub_date from book order by master_seq limit " + booklistTO.getRecordPerPage()+ " offset " + cpage* booklistTO.getRecordPerPage();
		}
		
		ArrayList<BookTO> lists = (ArrayList<BookTO>) jdbcTemplate.query(sql, new BeanPropertyRowMapper<BookTO>(BookTO.class));
		pagingTO.setBookList(lists);
		
		pagingTO.setStartBlock(((cpage-1)/blockPerPage) * blockPerPage + 1);
		pagingTO.setEndBlock(((cpage-1)/blockPerPage)* blockPerPage + blockPerPage );
		if(pagingTO.getEndBlock() >= pagingTO.getTotalPage()) {
			pagingTO.setEndBlock(pagingTO.getTotalPage());
		}
		
		return pagingTO;
	}
	public pagingTO pagingSearch(pagingTO booklistTO, String name, String bookname) {
		//paging
		int cpage = booklistTO.getCpage();
		int recordPerPage = booklistTO.getRecordPerPage();
		int blockPerPage = booklistTO.getBlockPerPage();
		
		pagingTO pagingTO = new pagingTO();
		pagingTO.setCpage(cpage);
		pagingTO.setRecordPerPage(recordPerPage);
		pagingTO.setBlockPerPage(blockPerPage);
		String queryTotalRecords = "";
		if(name.equals("제목")) {
			queryTotalRecords = "select count(*) from book where title like '%"+bookname+"%'";
		} else if (name.equals("작가")){
			queryTotalRecords = "select count(*) from book where author like '%"+bookname+"%'";
		}
		int totalItems = jdbcTemplate.queryForObject(queryTotalRecords, Integer.class);
		pagingTO.setTotalrecord(totalItems);
		
		pagingTO.setTotalPage((totalItems/5)-1);
		String sql ="";
		// preparedstatement 로 하면 자동으로 sql 에서 ''(문자열 화)한다 
		if (cpage==1) {
			if(name.equals("제목")) {
			sql = "select master_seq, isbn13, title, author, publisher, img_url, description, pub_date from book where title like '%"+ bookname +"%' order by master_seq limit " + booklistTO.getRecordPerPage();
			} else if (name.equals("작가")){
				sql = "select master_seq, isbn13, title, author, publisher, img_url, description, pub_date from book where author like '%"+ bookname +"%' order by master_seq limit " + booklistTO.getRecordPerPage();
			}
			
		} else {
			if(name.equals("제목")) {
				sql = "select master_seq, isbn13, title, author, publisher, img_url, description, pub_date from book where title like '%"+ bookname +"%' order by master_seq limit " + booklistTO.getRecordPerPage()+ " offset " + cpage* booklistTO.getRecordPerPage();
			} else if (name.equals("작가")){
				sql = "select master_seq, isbn13, title, author, publisher, img_url, description, pub_date from book where author like '%"+ bookname +"%' order by master_seq limit " + booklistTO.getRecordPerPage()+ " offset " + cpage* booklistTO.getRecordPerPage();
			}
		}
		
		ArrayList<BookTO> lists = (ArrayList<BookTO>) jdbcTemplate.query(sql, new BeanPropertyRowMapper<BookTO>(BookTO.class));
		pagingTO.setBookList(lists);
		
		pagingTO.setStartBlock(((cpage-1)/blockPerPage) * blockPerPage + 1);
		pagingTO.setEndBlock(((cpage-1)/blockPerPage)* blockPerPage + blockPerPage );
		if(pagingTO.getEndBlock() >= pagingTO.getTotalPage()) {
			pagingTO.setEndBlock(pagingTO.getTotalPage());
		}
		
		return pagingTO;
	}
	
	//booklist 
	public ArrayList bookSearch(String option, String searchword) {

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		ArrayList<BookTO> booklist = new ArrayList<BookTO>();

		try{
			conn = dataSource.getConnection();
			
			String sql = "select master_seq, isbn13, title, author, publisher, description, img_url from book where "+ option +" like ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+searchword+"%");

			rs = pstmt.executeQuery();		
			while(rs.next()) {
				BookTO to = new BookTO();
				to.setMaster_seq(rs.getString("master_seq"));
				to.setIsbn13(rs.getString("isbn13"));
				to.setTitle(rs.getString("title"));
				to.setAuthor(rs.getString("author"));
				to.setPublisher(rs.getString("publisher"));
				to.setDescription(rs.getString("description"));
				to.setImg_url(rs.getString("img_url"));
				
				booklist.add(to);
			}					

		} catch(SQLException e){
			System.out.println("[에러] " + e.getMessage());
		} finally {
			if(rs!=null) try{rs.close();}catch(SQLException e) {}
			if(pstmt!=null) try{pstmt.close();}catch(SQLException e) {}
			if(conn!=null) try{conn.close();}catch(SQLException e) {}
		}

		return booklist;
	}	
}
