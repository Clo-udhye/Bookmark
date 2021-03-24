package com.exam.admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AdminDAO {
	@Autowired
	private DataSource dataSource;
	
	//userList
	public ArrayList<AdminUserListTO> userList() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		ArrayList<AdminUserListTO> lists = new ArrayList<AdminUserListTO>(); 
		try{
			conn = dataSource.getConnection();

			String sql = "select user.seq useq, id, nickname, count(board.seq) bcount " + 
					"from user left outer join board " + 
					"on user.seq = board.useq " + 
					"group by user.seq " + 
					"order by useq;";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();		
			while(rs.next()) {
				AdminUserListTO to = new AdminUserListTO();
				to.setUseq(rs.getString("useq"));
				to.setId(rs.getString("id"));
				to.setNickname(rs.getString("nickname"));
				to.setBcount(rs.getString("bcount"));
				
				lists.add(to);
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
	
	//paginguserList
	public PagingUserTO userList(PagingUserTO pto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		// paging
		int upage = pto.getUpage();
		int recordPerPage = pto.getRecordPerPage();
		int blockPerPage = pto.getBlockPerPage();
		
		//ArrayList<AdminUserListTO> lists = new ArrayList<AdminUserListTO>(); 
		try{
			conn = dataSource.getConnection();

			String sql = "select user.seq useq, id, nickname, count(board.seq) bcount " + 
					"from user left outer join board " + 
					"on user.seq = board.useq " + 
					"group by user.seq " + 
					"order by useq;";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();		
			
			rs.afterLast();
			pto.setTotalrecord(rs.getRow()-1);
			rs.beforeFirst();
			
			pto.setTotalPage(((pto.getTotalrecord()-1) / recordPerPage) + 1 );
			
			int skip = (upage-1)*recordPerPage;
			if(skip != 0) rs.absolute(skip);
			
			ArrayList<AdminUserListTO> lists = new ArrayList<AdminUserListTO>();
			
			for(int i=0; i<recordPerPage && rs.next(); i++){
				AdminUserListTO to = new AdminUserListTO();
				to.setUseq(rs.getString("useq"));
				to.setId(rs.getString("id"));
				to.setNickname(rs.getString("nickname"));
				to.setBcount(rs.getString("bcount"));

				lists.add(to);
			}	
			
			pto.setUserList(lists);
			
			pto.setStartBlock(((upage-1)/blockPerPage)*blockPerPage + 1);
			pto.setEndBlock(((upage-1)/blockPerPage)*blockPerPage + blockPerPage);
			if(pto.getEndBlock()>=pto.getTotalPage()) {
				pto.setEndBlock(pto.getTotalPage());
			}
			
		} catch(SQLException e){
			System.out.println("[에러] " + e.getMessage());
		} finally {
			if(rs!=null) try{rs.close();}catch(SQLException e) {}
			if(pstmt!=null) try{pstmt.close();}catch(SQLException e) {}
			if(conn!=null) try{conn.close();}catch(SQLException e) {}
		}

		return pto;
	}
	
	//boardList
	public ArrayList<AdminBoardListTO> boardList() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		ArrayList<AdminBoardListTO> lists = new ArrayList<AdminBoardListTO>(); 
		try{
			conn = dataSource.getConnection();

			String sql = "select bu.bseq bseq, title, id, nickname, date, hit, comment, likey from ( " + 
					"select board.seq bseq, title, id, nickname, date " + 
					"from board join user on board.useq=user.seq  " + 
					") as bu join ( " + 
					"select l1.bseq, ifnull(hit,0) hit, ifnull(comment,0) comment, ifnull(likey,0) likey from ( " + 
					"select * from " + 
					"(select board.seq bseq1, h.hit " + 
					"from board left outer join (select bseq, count(hit.seq) hit from hit group by bseq) as h " + 
					"on board.seq = h.bseq) as h1 join " + 
					"(select board.seq bseq, c.comment " + 
					"from board left outer join (select bseq, count(comment.seq) comment from comment group by bseq) as c " + 
					"on board.seq = c.bseq) as c1 on h1.bseq1=c1.bseq " + 
					") as hc  " + 
					"left outer join  " + 
					"(select board.seq bseq, l.likey " + 
					"from board left outer join (select bseq, count(likey.seq) likey from likey group by bseq) as l " + 
					"on board.seq = l.bseq) as l1 on hc.bseq1=l1.bseq " + 
					") as hcl on bu.bseq=hcl.bseq;";
			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();		
			while(rs.next()) {
				AdminBoardListTO to = new AdminBoardListTO();
				to.setBseq(rs.getString("bseq"));
				to.setTitle(rs.getString("title"));
				to.setId(rs.getString("id"));
				to.setNickname(rs.getString("nickname"));
				to.setDate(rs.getString("date"));
				to.setHit(rs.getString("hit"));
				to.setComment(rs.getString("comment"));
				to.setLikey(rs.getString("likey"));

				lists.add(to);
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
	
	//pagingboardList
	public PagingBoardTO boardList(PagingBoardTO pto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		// paging
		int bpage = pto.getBpage();
		int recordPerPage = pto.getRecordPerPage();
		int blockPerPage = pto.getBlockPerPage();
 
		try{
			conn = dataSource.getConnection();

			String sql = "select bu.bseq bseq, title, id, nickname, date, hit, comment, likey from ( " + 
					"select board.seq bseq, title, id, nickname, date " + 
					"from board join user on board.useq=user.seq  " + 
					") as bu join ( " + 
					"select l1.bseq, ifnull(hit,0) hit, ifnull(comment,0) comment, ifnull(likey,0) likey from ( " + 
					"select * from " + 
					"(select board.seq bseq1, h.hit " + 
					"from board left outer join (select bseq, count(hit.seq) hit from hit group by bseq) as h " + 
					"on board.seq = h.bseq) as h1 join " + 
					"(select board.seq bseq, c.comment " + 
					"from board left outer join (select bseq, count(comment.seq) comment from comment group by bseq) as c " + 
					"on board.seq = c.bseq) as c1 on h1.bseq1=c1.bseq " + 
					") as hc  " + 
					"left outer join  " + 
					"(select board.seq bseq, l.likey " + 
					"from board left outer join (select bseq, count(likey.seq) likey from likey group by bseq) as l " + 
					"on board.seq = l.bseq) as l1 on hc.bseq1=l1.bseq " + 
					") as hcl on bu.bseq=hcl.bseq;";
			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();
			
			rs.afterLast();
			pto.setTotalrecord(rs.getRow()-1);
			rs.beforeFirst();
			
			pto.setTotalPage(((pto.getTotalrecord()-1) / recordPerPage) + 1 );
			
			int skip = (bpage-1)*recordPerPage;
			if(skip != 0) rs.absolute(skip);
			
			ArrayList<AdminBoardListTO> lists = new ArrayList<AdminBoardListTO>();
			
			for(int i=0; i<recordPerPage && rs.next(); i++){
				AdminBoardListTO to = new AdminBoardListTO();
				to.setBseq(rs.getString("bseq"));
				to.setTitle(rs.getString("title"));
				to.setId(rs.getString("id"));
				to.setNickname(rs.getString("nickname"));
				to.setDate(rs.getString("date"));
				to.setHit(rs.getString("hit"));
				to.setComment(rs.getString("comment"));
				to.setLikey(rs.getString("likey"));

				lists.add(to);
			}				
			pto.setBoardList(lists);
			
			pto.setStartBlock(((bpage-1)/blockPerPage)*blockPerPage + 1);
			pto.setEndBlock(((bpage-1)/blockPerPage)*blockPerPage + blockPerPage);
			if(pto.getEndBlock()>=pto.getTotalPage()) {
				pto.setEndBlock(pto.getTotalPage());
			}

		} catch(SQLException e){
			System.out.println("[에러] " + e.getMessage());
		} finally {
			if(rs!=null) try{rs.close();}catch(SQLException e) {}
			if(pstmt!=null) try{pstmt.close();}catch(SQLException e) {}
			if(conn!=null) try{conn.close();}catch(SQLException e) {}
		}

		return pto;
	}	

}
