package com.exam.boardlist;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDAO {

	@Autowired
	private DataSource dataSource;
	
	//board_list
	public ArrayList<BoardTO> boardList() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		ArrayList<BoardTO> lists = new ArrayList<BoardTO>();
		
		try{
			conn = dataSource.getConnection();
			
			String sql = "select seq, date, title, useq, filename, filesize, content, bseq, hit, comment from board order by date desc";
			pstmt = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			
			
			rs = pstmt.executeQuery();		
			while( rs.next() ) {
				BoardTO to = new BoardTO();
				to.setSeq( rs.getString( "seq" ) );
				to.setDate( rs.getString( "date" ) );
				to.setTitle( rs.getString( "title" ) );
				to.setUseq( rs.getString( "useq" ) );
				to.setFilename( rs.getString( "filename" ) );
				to.setFilesize( rs.getString( "filesize" ) );
				to.setContent( rs.getString( "content" ) );
				to.setBseq( rs.getString( "bseq" ) );
				to.setHit( rs.getString( "hit" ) );
				to.setComment( rs.getString( "comment" ) );

				lists.add( to );
			}				
			
		} catch(SQLException e){
			System.out.println("[에러] " + e.getMessage());
		} finally {
			if(rs!=null) try{rs.close();}catch(SQLException e) {}
			if(pstmt!=null) try{pstmt.close();}catch(SQLException e) {}
			if(conn!=null) try{conn.close();}catch(SQLException e) {}
		}
		
		return lists;
	}
	
	// board_list__overloading
	// BoardListTO = BoardPagingTO
	// listTO = pagingTO
	public BoardPagingTO boardList(BoardPagingTO pagingTO){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 

		// paging
		int cpage = pagingTO.getCpage();
		int recordPerPage = pagingTO.getRecordPerPage();
		int blockPerPage = pagingTO.getBlockPerPage();
		
		try{
			conn = dataSource.getConnection();

			String sql = "select seq, date, title, useq, filename, filesize, content, bseq, hit, comment from board order by date desc";
			pstmt = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);

			rs = pstmt.executeQuery();

			rs.afterLast();
			pagingTO.setTotalRecord(rs.getRow()-1);
			rs.beforeFirst();
			
			pagingTO.setTotalPage(((pagingTO.getTotalRecord()-1) / recordPerPage) + 1 );
			
			int skip = (cpage-1)*recordPerPage;
			if(skip != 0) rs.absolute(skip);
			
			ArrayList<BoardTO> lists = new ArrayList<BoardTO>();
			
			if(rs.next()) {
				for(int i=0; i<recordPerPage; i++){
					BoardTO to =new BoardTO();
					to.setSeq( rs.getString( "seq" ) );
					to.setDate( rs.getString( "date" ) );
					to.setTitle( rs.getString( "title" ) );
					to.setUseq( rs.getString( "useq" ) );
					to.setFilename( rs.getString( "filename" ) );
					to.setFilesize( rs.getString( "filesize" ) );
					to.setContent( rs.getString( "content" ) );
					to.setBseq( rs.getString( "bseq" ) );
					to.setHit( rs.getString( "hit" ) );
					to.setComment( rs.getString( "comment" ) );

					lists.add(to);
					
					if(!rs.next()){
						for(; i<recordPerPage; i++){
							BoardTO to1 =new BoardTO();
							lists.add(to1);
						}
						break;
					}
				}
			}
			
			pagingTO.setBoardLists(lists);
			
			pagingTO.setStartBlock(((cpage-1)/blockPerPage)*blockPerPage + 1);
			pagingTO.setEndBlock(((cpage-1)/blockPerPage)*blockPerPage + blockPerPage);
			if(pagingTO.getEndBlock()>=pagingTO.getTotalPage()) {
				pagingTO.setEndBlock(pagingTO.getTotalPage());
			}
		} catch(SQLException e){
			System.out.println("[에러] " + e.getMessage());
		} finally {
			if(rs!=null) try{rs.close();} catch(SQLException e) {}
			if(pstmt!=null) try{pstmt.close();} catch(SQLException e) {}
			if(conn!=null) try{conn.close();} catch(SQLException e) {}
		}
		
		return pagingTO;
	}
}
