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
	public int loginOk(UserTO to) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int flag = 2;
		
		try{
			conn = dataSource.getConnection();
			
			String sql = "select id, password from user where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, to.getId());
			
			rs = pstmt.executeQuery();		
			if(rs.next()) {
				if(rs.getString("password").equals(to.getPassword())) {
					flag = 1; //로그인 성공
				}else
					flag = 0; //비밀번호 틀림
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
}
