package com.exam.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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
	
	
	//sns_user에 아이디가 있는지 확인
	public UserTO snsUser_check(SnsUserTO to, String sns_nickname) {

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		UserTO userInfo = new UserTO(); 

		try{
			conn = dataSource.getConnection();

			String sql = "select count(*) as count from sns_user where sns_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, to.getSns_id());

			rs = pstmt.executeQuery();		
			if(rs.next()) {
				if(rs.getString("count").equals("1")) {// 네이버로 로그인 한적이 있다.
					sql = "select seq, id, nickname from user where id = ?"; 
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, to.getSns_id());
				
					rs = pstmt.executeQuery();
					if(rs.next()) {
						userInfo.setSeq(rs.getString("seq"));
						userInfo.setId(rs.getString("id"));
						userInfo.setNickname(rs.getString("nickname"));
					} 
					
					//System.out.println("userInfo : "+userInfo.getId());
					return userInfo; 
					
				}else// 없다
					sql = "insert into user values(0, ?, null, ?, ?, null, null)";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, to.getSns_id());
					pstmt.setString(2, sns_nickname);
					pstmt.setString(3, to.getSns_id()+"@naver.com");
						
					int result = pstmt.executeUpdate();
					if(result == 1){ //성공적으로 사용자 레코드 생성시 방금 추가한 레코드 정보 가져오기
						sql = "select seq, id, nickname from user where id = ?"; 
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, to.getSns_id());
						
						rs = pstmt.executeQuery();
						if(rs.next()) {
							sql = "insert into sns_user value(?, ?, ?);";
							pstmt = conn.prepareStatement(sql);
							pstmt.setString(1, rs.getString("seq"));
							pstmt.setString(2, rs.getString("id"));
							pstmt.setString(3, to.getSns_type());
							result = pstmt.executeUpdate();
							if(result == 1) {
								userInfo.setSeq(rs.getString("seq"));
								userInfo.setId(rs.getString("id"));
								userInfo.setNickname(rs.getString("nickname"));
								
								return userInfo; 
							}
						}						
					}
			}					

		} catch(SQLException e){
			System.out.println("[에러] " + e.getMessage());
		} finally {
			if(rs!=null) try{rs.close();}catch(SQLException e) {}
			if(pstmt!=null) try{pstmt.close();}catch(SQLException e) {}
			if(conn!=null) try{conn.close();}catch(SQLException e) {}
		}

		return null;
	}
}
