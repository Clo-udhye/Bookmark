package com.exam.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class UserDAO {
	@Autowired
	private DataSource dataSource;

	//loginOk
	public LoginTO loginOk(UserTO to) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		LoginTO lto = new LoginTO(); 
		lto.setFlag(2);
		
		try{
			conn = dataSource.getConnection();
			
			String sql = "select seq, id, nickname, password from user where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, to.getId());
			
			UserTO uto = new UserTO();
			rs = pstmt.executeQuery();		
			if(rs.next()) {
				if(rs.getString("password").equals(to.getPassword())) {
					lto.setFlag(1); //로그인 성공
					uto.setSeq(rs.getString("seq"));
					uto.setId(rs.getString("id"));
					uto.setNickname(rs.getString("nickname"));
					
					lto.setUto(uto);
				}else
					lto.setFlag(0); //비밀번호 틀림
			}					
			
		} catch(SQLException e){
			System.out.println("[에러] " + e.getMessage());
		} finally {
			if(rs!=null) try{rs.close();}catch(SQLException e) {}
			if(pstmt!=null) try{pstmt.close();}catch(SQLException e) {}
			if(conn!=null) try{conn.close();}catch(SQLException e) {}
		}
		
		return lto;
	}
	
	//id, nickname duplication check 
	public int dupCheck(String item, String value) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int flag = 0; 
		
		try{
			conn = dataSource.getConnection();
			
			String sql = "select count(*) as count from user where "+ item +"=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, value);
			
			rs = pstmt.executeQuery();		
			if(rs.next()) {
				if(rs.getString("count").equals("1")) {
					flag = 0; //아이디, 닉네임 중복
				}else
					flag = 1; //중복된 아이디, 닉네임 없음
			}					
			
		} catch(SQLException e){
			System.out.println("[에러] " + e.getMessage());
		} finally {
			if(rs!=null) try{rs.close();}catch(SQLException e) {}
			if(pstmt!=null) try{pstmt.close();}catch(SQLException e) {}
			if(conn!=null) try{conn.close();}catch(SQLException e) {}
		}
		
		return flag;
	}
	
	//signupOk
	public int signupOk(UserTO to) {
		Connection conn = null;
		PreparedStatement pstmt = null;

		int flag = 0;

		try{
			conn = dataSource.getConnection();

			String sql = "insert into user values(0, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, to.getId());
			pstmt.setString(2, to.getPassword());
			pstmt.setString(3, to.getNickname());
			pstmt.setString(4, to.getMail());
			pstmt.setString(5, to.getAddress());
			pstmt.setString(6, to.getAddresses());
			
			int result = pstmt.executeUpdate();
			if(result == 1){
				flag = 1;
			}
			
		} catch(SQLException e){
			System.out.println("[에러] " + e.getMessage());
		} finally {
			if(pstmt!=null) try{pstmt.close();}catch(SQLException e) {}
			if(conn!=null) try{conn.close();}catch(SQLException e) {}
		}

		return flag;
	}	
	
	//userDelete
	public int userDelete(UserTO to) {
		Connection conn = null;
		PreparedStatement pstmt = null;

		int flag = 0;

		try{
			conn = dataSource.getConnection();

			String sql = "delete from user where seq = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, to.getSeq());
			
			int result = pstmt.executeUpdate();
			if(result == 1){
				flag = 1;
			}

		} catch(SQLException e){
			System.out.println("[에러] " + e.getMessage());
		} finally {
			if(pstmt!=null) try{pstmt.close();}catch(SQLException e) {}
			if(conn!=null) try{conn.close();}catch(SQLException e) {}
		}

		return flag;

	}	
	
	// mypage_modify
	public ArrayList<UserTO> userinfoList(String seq) {

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		ArrayList<UserTO> lists = new ArrayList<UserTO>();
		
		try{
			conn = dataSource.getConnection();
			
			// mypage에서 특정 항목 가져와서 where절에 넣는 것으로 추후에 수정. ★★
			String sql = "select seq, id, nickname, mail, address, addresses, keywords, introduction, profile_filename from user where seq = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, seq);
			
			rs = pstmt.executeQuery();		
			while( rs.next() ) {
			//if( rs.next() ) {
				UserTO to = new UserTO();
				to.setSeq( rs.getString( "seq" ));
				to.setId( rs.getString( "id" ) );
				to.setNickname( rs.getString( "nickname" ) );
				to.setMail( rs.getString( "mail" ) );
				to.setAddress( rs.getString( "address" ) );
				to.setAddresses( rs.getString( "addresses" ) );
				to.setKeywords( rs.getString( "keywords" ) );
				to.setIntroduction( rs.getString( "introduction" ) );
				to.setProfile_filename( rs.getString( "profile_filename" ) );

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
	
	// 마이페이지 입장할 때의 유저 정보 TO 형식으로 불러오기 by예찬
	public UserTO myPage_Info_load (String useq) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		UserTO uto = null;
		try{
			conn = dataSource.getConnection();
			
			String sql = "select seq, id, nickname, mail, address, addresses, keywords, introduction, profile_filename from user where seq=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, useq);
			
			uto = new UserTO();
			rs = pstmt.executeQuery();		
			if(rs.next()) {
					uto.setSeq(rs.getString("seq"));
					uto.setId(rs.getString("id"));
					uto.setNickname(rs.getString("nickname"));
					uto.setMail(rs.getNString("mail"));
					uto.setAddress(rs.getString("address"));
					uto.setAddresses(rs.getString("addresses"));
					uto.setIntroduction(rs.getString("introduction"));
					uto.setKeywords(rs.getString("keywords"));
					uto.setProfile_filename(rs.getString("profile_filename"));
			}			
			
		} catch(SQLException e){
			System.out.println("[에러] " + e.getMessage());
		} finally {
			if(rs!=null) try{rs.close();}catch(SQLException e) {}
			if(pstmt!=null) try{pstmt.close();}catch(SQLException e) {}
			if(conn!=null) try{conn.close();}catch(SQLException e) {}
		}
		
		return uto;
	}
	
	// mypage_modify_ok
	public int mypagemodifyOk(UserTO to) {
		Connection conn = null;
		PreparedStatement pstmt = null;

		int flag = 0;
		
		try{
			conn = dataSource.getConnection();

			String sql = "update user set id=?, nickname=?, mail=?, address=?, addresses=?, keywords=?, introduction=?, profile_filename=? where seq=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, to.getId());
			pstmt.setString(2, to.getNickname());
			pstmt.setString(3, to.getMail());
			pstmt.setString(4, to.getAddress());
			pstmt.setString(5, to.getAddresses());
			pstmt.setString(6, to.getKeywords());
			pstmt.setString(7, to.getIntroduction());
			pstmt.setString(8, to.getProfile_filename());
			pstmt.setString(9, to.getSeq());
			
			int result = pstmt.executeUpdate();
			if(result == 1){
				flag = 1;
			}
		} catch(SQLException e){
			System.out.println("[에러] " + e.getMessage());
		} finally {
			if(pstmt!=null) try{pstmt.close();}catch(SQLException e) {}
			if(conn!=null) try{conn.close();}catch(SQLException e) {}
		}
		return flag;
	}
	
	// user의 게시글 count by예찬
	public int user_board_count (String useq) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int board_counts = 0;
		try{
			conn = dataSource.getConnection();
			
			String sql = "select count(*) from board where useq=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, useq);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				board_counts = Integer.parseInt(rs.getString("count(*)"));
			}
			
		} catch(SQLException e){
			System.out.println("[에러] " + e.getMessage());
		} finally {
			if(rs!=null) try{rs.close();}catch(SQLException e) {}
			if(pstmt!=null) try{pstmt.close();}catch(SQLException e) {}
			if(conn!=null) try{conn.close();}catch(SQLException e) {}
		}
		return board_counts;
	}
}
