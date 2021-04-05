package com.exam.MyPage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.exam.boardlist.BoardTO;
@Repository
public class CountDAO {
	@Autowired
	private DataSource dataSource;
	
	public ArrayList<TodayTO> todayCounts(String useq) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		ArrayList<TodayTO> lists = new ArrayList<TodayTO>();
		
		try{
			conn = dataSource.getConnection();
			
			String sql = "select hc.time as time, hc.hit as hit, hc.comment as comment, l.hit_counts as likey from (\r\n" + 
					"select hit_divied_time.time_table as time, hit_divied_time.hit_counts as hit, comment_divied_time.hit_counts as comment from (\r\n" + 
					"select time_table, count(time_table) as hit_counts from (\r\n" + 
					"select\r\n" + 
					"(case when date_format(date_time, '%H') between date_format((select date_add(now(), interval -2 hour)),'%H')  and date_format((select date_add(now(), interval +1 hour)),'%H')\r\n" + 
					"then 2\r\n" + 
					"when date_format(date_time, '%H') between date_format((select date_add(now(), interval -5 hour)),'%H')  and date_format((select date_add(now(), interval -2 hour)),'%H')\r\n" + 
					"then 5\r\n" + 
					"when date_format(date_time, '%H') between date_format((select date_add(now(), interval -8 hour)),'%H')  and date_format((select date_add(now(), interval -5 hour)),'%H')\r\n" + 
					"then 8\r\n" + 
					"when date_format(date_time,'%H')  between date_format((select date_add(now(), interval -11 hour)),'%H')  and date_format((select date_add(now(), interval -8 hour)),'%H')\r\n" + 
					"then 11\r\n" + 
					"when date_format(date_time,'%H') between date_format((select date_add(now(), interval -14 hour)),'%H')  and date_format((select date_add(now(), interval -11 hour)),'%H')\r\n" + 
					"then 14\r\n" + 
					"when date_format(date_time, '%H') between date_format((select date_add(now(), interval -17 hour)),'%H')  and date_format((select date_add(now(), interval -14 hour)),'%H')\r\n" + 
					"then 17\r\n" + 
					"when date_format(date_time, '%H') between date_format((select date_add(now(), interval -20 hour)),'%H')  and date_format((select date_add(now(), interval -17 hour)),'%H')\r\n" + 
					"then 21\r\n" + 
					"when date_format(date_time, '%H') between date_format((select date_add(now(), interval -1 day)),'%H')  and date_format((select date_add(now(), interval -20 hour)),'%H')\r\n" + 
					"then 24\r\n" + 
					" end\r\n" + 
					") as time_table\r\n" + 
					"from (select * from (select bseq, date_time from hit where date_time between (select date_add(now(), interval -2 day)) and (select date_add(now(), interval +1 day))) as today where today.bseq in (select seq from board where useq=?)) as b\r\n" + 
					") as divied_time group by time_table order by time_table\r\n" + 
					") as hit_divied_time\r\n" + 
					"left outer join (\r\n" + 
					"select time_table, count(time_table) as hit_counts from (\r\n" + 
					"select\r\n" + 
					"(case when date_format(date_time, '%H') between date_format((select date_add(now(), interval -2 hour)),'%H')  and date_format((select date_add(now(), interval +1 hour)),'%H')\r\n" + 
					"then 2\r\n" + 
					"when date_format(date_time, '%H') between date_format((select date_add(now(), interval -5 hour)),'%H')  and date_format((select date_add(now(), interval -2 hour)),'%H')\r\n" + 
					"then 5\r\n" + 
					"when date_format(date_time, '%H') between date_format((select date_add(now(), interval -8 hour)),'%H')  and date_format((select date_add(now(), interval -5 hour)),'%H')\r\n" + 
					"then 8\r\n" + 
					"when date_format(date_time,'%H')  between date_format((select date_add(now(), interval -11 hour)),'%H')  and date_format((select date_add(now(), interval -8 hour)),'%H')\r\n" + 
					"then 11\r\n" + 
					"when date_format(date_time,'%H') between date_format((select date_add(now(), interval -14 hour)),'%H')  and date_format((select date_add(now(), interval -11 hour)),'%H')\r\n" + 
					"then 14\r\n" + 
					"when date_format(date_time, '%H') between date_format((select date_add(now(), interval -17 hour)),'%H')  and date_format((select date_add(now(), interval -14 hour)),'%H')\r\n" + 
					"then 17\r\n" + 
					"when date_format(date_time, '%H') between date_format((select date_add(now(), interval -20 hour)),'%H')  and date_format((select date_add(now(), interval -17 hour)),'%H')\r\n" + 
					"then 21\r\n" + 
					"when date_format(date_time, '%H') between date_format((select date_add(now(), interval -1 day)),'%H')  and date_format((select date_add(now(), interval -20 hour)),'%H')\r\n" + 
					"then 24\r\n" + 
					" end\r\n" + 
					") as time_table\r\n" + 
					"from (select * from (select bseq, date_time from comment where date_time between (select date_add(now(), interval -2 day)) and (select date_add(now(), interval +1 day))) as today where today.bseq in (select seq from board where useq=?)) as b\r\n" + 
					") as divied_time group by time_table order by time_table\r\n" + 
					") as comment_divied_time on hit_divied_time.time_table = comment_divied_time.time_table\r\n" + 
					") as hc left outer join (\r\n" + 
					"select time_table, count(time_table) as hit_counts from (\r\n" + 
					"select\r\n" + 
					"(case when date_format(date_time, '%H') between date_format((select date_add(now(), interval -2 hour)),'%H')  and date_format((select date_add(now(), interval +1 hour)),'%H')\r\n" + 
					"then 2\r\n" + 
					"when date_format(date_time, '%H') between date_format((select date_add(now(), interval -5 hour)),'%H')  and date_format((select date_add(now(), interval -2 hour)),'%H')\r\n" + 
					"then 5\r\n" + 
					"when date_format(date_time, '%H') between date_format((select date_add(now(), interval -8 hour)),'%H')  and date_format((select date_add(now(), interval -5 hour)),'%H')\r\n" + 
					"then 8\r\n" + 
					"when date_format(date_time,'%H')  between date_format((select date_add(now(), interval -11 hour)),'%H')  and date_format((select date_add(now(), interval -8 hour)),'%H')\r\n" + 
					"then 11\r\n" + 
					"when date_format(date_time,'%H') between date_format((select date_add(now(), interval -14 hour)),'%H')  and date_format((select date_add(now(), interval -11 hour)),'%H')\r\n" + 
					"then 14\r\n" + 
					"when date_format(date_time, '%H') between date_format((select date_add(now(), interval -17 hour)),'%H')  and date_format((select date_add(now(), interval -14 hour)),'%H')\r\n" + 
					"then 17\r\n" + 
					"when date_format(date_time, '%H') between date_format((select date_add(now(), interval -20 hour)),'%H')  and date_format((select date_add(now(), interval -17 hour)),'%H')\r\n" + 
					"then 21\r\n" + 
					"when date_format(date_time, '%H') between date_format((select date_add(now(), interval -24 hour)),'%H')  and date_format((select date_add(now(), interval -20 hour)),'%H')\r\n" + 
					"then 24\r\n" + 
					" end\r\n" + 
					") as time_table\r\n" + 
					"from (select * from (select bseq, date_time from likey where date_time between (select date_add(now(), interval -2 day)) and (select date_add(now(), interval +1 day))) as today where today.bseq in (select seq from board where useq=?)) as b\r\n" + 
					") as divied_time group by time_table order by time_table\r\n" + 
					") as l on hc.time = l.time_table order by hc.time";
					
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, useq);
			pstmt.setString(2, useq);
			pstmt.setString(3, useq);
			
			rs = pstmt.executeQuery();		
			while( rs.next() ) {
				TodayTO to = new TodayTO();
				to.setComment_count(rs.getInt("comment"));
				to.setHit_count(rs.getInt("hit"));
				to.setLike_count(rs.getInt("likey"));
				to.setTime(rs.getInt("time"));
				
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
	
	public ArrayList<WeekTO> weekCounts(String useq) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		ArrayList<WeekTO> lists = new ArrayList<WeekTO>();
		
		try{
			conn = dataSource.getConnection();
			
			String sql = "select hc.time as time, hc.hit as hit, hc.comment as comment, l.hit_counts as likey from (\r\n" + 
					"select hit_divied_time.time_table as time, hit_divied_time.hit_counts as hit, comment_divied_time.hit_counts as comment from (\r\n" + 
					"select time_table, count(time_table) as hit_counts from (\r\n" + 
					"select\r\n" + 
					"(case when date_format(date_time, '%d') between date_format((select date_add(now(), interval -1 day)),'%d')  and date_format((select date_add(now(), interval +1 day)),'%d')\r\n" + 
					"then 1\r\n" + 
					"when date_format(date_time, '%d') between date_format((select date_add(now(), interval -2 day)),'%d')  and date_format((select date_add(now(), interval -1 day)),'%d')\r\n" + 
					"then 2\r\n" + 
					"when date_format(date_time, '%d') between date_format((select date_add(now(), interval -3 day)),'%H')  and date_format((select date_add(now(), interval -2 day)),'%H')\r\n" + 
					"then 3\r\n" + 
					"when date_format(date_time,'%d')  between date_format((select date_add(now(), interval -4 day)),'%H')  and date_format((select date_add(now(), interval -3 day)),'%H')\r\n" + 
					"then 4\r\n" + 
					"when date_format(date_time,'%d') between date_format((select date_add(now(), interval -5 day)),'%H')  and date_format((select date_add(now(), interval -4 day)),'%H')\r\n" + 
					"then 5\r\n" + 
					"when date_format(date_time, '%d') between date_format((select date_add(now(), interval -6 day)),'%H')  and date_format((select date_add(now(), interval -5 day)),'%H')\r\n" + 
					"then 6\r\n" + 
					"when date_format(date_time, '%d') between date_format((select date_add(now(), interval -7 day)),'%H')  and date_format((select date_add(now(), interval -6 day)),'%H')\r\n" + 
					"then 7\r\n" + 
					" end\r\n" + 
					") as time_table\r\n" + 
					"from (select * from (select bseq, date_time from hit where date_time between (select date_add(now(), interval -7 day)) and (select date_add(now(), interval +1 day))) as today where today.bseq in (select seq from board where useq=?)) as b\r\n" + 
					") as divied_time group by time_table order by time_table\r\n" + 
					") as hit_divied_time\r\n" + 
					"left outer join (\r\n" + 
					"select time_table, count(time_table) as hit_counts from (\r\n" + 
					"select\r\n" + 
					"(case when date_format(date_time, '%d') between date_format((select date_add(now(), interval -1 day)),'%d')  and date_format((select date_add(now(), interval +1 day)),'%d')\r\n" + 
					"then 1\r\n" + 
					"when date_format(date_time, '%d') between date_format((select date_add(now(), interval -2 day)),'%d')  and date_format((select date_add(now(), interval -1 day)),'%d')\r\n" + 
					"then 2\r\n" + 
					"when date_format(date_time, '%d') between date_format((select date_add(now(), interval -3 day)),'%H')  and date_format((select date_add(now(), interval -2 day)),'%H')\r\n" + 
					"then 3\r\n" + 
					"when date_format(date_time,'%d')  between date_format((select date_add(now(), interval -4 day)),'%H')  and date_format((select date_add(now(), interval -3 day)),'%H')\r\n" + 
					"then 4\r\n" + 
					"when date_format(date_time,'%d') between date_format((select date_add(now(), interval -5 day)),'%H')  and date_format((select date_add(now(), interval -4 day)),'%H')\r\n" + 
					"then 5\r\n" + 
					"when date_format(date_time, '%d') between date_format((select date_add(now(), interval -6 day)),'%H')  and date_format((select date_add(now(), interval -5 day)),'%H')\r\n" + 
					"then 6\r\n" + 
					"when date_format(date_time, '%d') between date_format((select date_add(now(), interval -7 day)),'%H')  and date_format((select date_add(now(), interval -6 day)),'%H')\r\n" + 
					"then 7\r\n" + 
					" end\r\n" + 
					") as time_table\r\n" + 
					"from (select * from (select bseq, date_time from comment where date_time between (select date_add(now(), interval -7 day)) and (select date_add(now(), interval +1 day))) as today where today.bseq in (select seq from board where useq=?)) as b\r\n" + 
					") as divied_time group by time_table order by time_table\r\n" + 
					") as comment_divied_time on hit_divied_time.time_table = comment_divied_time.time_table\r\n" + 
					") as hc left outer join (\r\n" + 
					"select time_table, count(time_table) as hit_counts from (\r\n" + 
					"select\r\n" + 
					"(case when date_format(date_time, '%d') between date_format((select date_add(now(), interval -1 day)),'%d')  and date_format((select date_add(now(), interval +1 day)),'%d')\r\n" + 
					"then 1\r\n" + 
					"when date_format(date_time, '%d') between date_format((select date_add(now(), interval -2 day)),'%d')  and date_format((select date_add(now(), interval -1 day)),'%d')\r\n" + 
					"then 2\r\n" + 
					"when date_format(date_time, '%d') between date_format((select date_add(now(), interval -3 day)),'%H')  and date_format((select date_add(now(), interval -2 day)),'%H')\r\n" + 
					"then 3\r\n" + 
					"when date_format(date_time,'%d')  between date_format((select date_add(now(), interval -4 day)),'%H')  and date_format((select date_add(now(), interval -3 day)),'%H')\r\n" + 
					"then 4\r\n" + 
					"when date_format(date_time,'%d') between date_format((select date_add(now(), interval -5 day)),'%H')  and date_format((select date_add(now(), interval -4 day)),'%H')\r\n" + 
					"then 5\r\n" + 
					"when date_format(date_time, '%d') between date_format((select date_add(now(), interval -6 day)),'%H')  and date_format((select date_add(now(), interval -5 day)),'%H')\r\n" + 
					"then 6\r\n" + 
					"when date_format(date_time, '%d') between date_format((select date_add(now(), interval -7 day)),'%H')  and date_format((select date_add(now(), interval -6 day)),'%H')\r\n" + 
					"then 7\r\n" + 
					"end\r\n" + 
					") as time_table\r\n" + 
					"from (select * from (select bseq, date_time from likey where date_time between (select date_add(now(), interval -7 day)) and (select date_add(now(), interval +1 day))) as today where today.bseq in (select seq from board where useq=?)) as b\r\n" + 
					") as divied_time group by time_table order by time_table\r\n" + 
					") as l on hc.time = l.time_table order by hc.time";
					
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, useq);
			pstmt.setString(2, useq);
			pstmt.setString(3, useq);
			
			rs = pstmt.executeQuery();		
			while( rs.next() ) {
				WeekTO to = new WeekTO();
				to.setComment_count(rs.getInt("comment"));
				to.setHit_count(rs.getInt("hit"));
				to.setLike_count(rs.getInt("likey"));
				to.setTime(rs.getInt("time"));
				
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
	
	public ArrayList<TodayTO> todayCounts_insight(String bseq) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		ArrayList<TodayTO> lists = new ArrayList<TodayTO>();
		
		try{
			conn = dataSource.getConnection();
			
			String sql = "select hc.time as time, hc.hit as hit, hc.comment as comment, l.hit_counts as likey from (\r\n" + 
					"select hit_divied_time.time_table as time, hit_divied_time.hit_counts as hit, comment_divied_time.hit_counts as comment from (\r\n" + 
					"select time_table, count(time_table) as hit_counts from (\r\n" + 
					"select\r\n" + 
					"(case when date_format(date_time, '%H') between date_format((select date_add(now(), interval -2 hour)),'%H')  and date_format((select date_add(now(), interval +1 hour)),'%H')\r\n" + 
					"then 2\r\n" + 
					"when date_format(date_time, '%H') between date_format((select date_add(now(), interval -5 hour)),'%H')  and date_format((select date_add(now(), interval -2 hour)),'%H')\r\n" + 
					"then 5\r\n" + 
					"when date_format(date_time, '%H') between date_format((select date_add(now(), interval -8 hour)),'%H')  and date_format((select date_add(now(), interval -5 hour)),'%H')\r\n" + 
					"then 8\r\n" + 
					"when date_format(date_time,'%H')  between date_format((select date_add(now(), interval -11 hour)),'%H')  and date_format((select date_add(now(), interval -8 hour)),'%H')\r\n" + 
					"then 11\r\n" + 
					"when date_format(date_time,'%H') between date_format((select date_add(now(), interval -14 hour)),'%H')  and date_format((select date_add(now(), interval -11 hour)),'%H')\r\n" + 
					"then 14\r\n" + 
					"when date_format(date_time, '%H') between date_format((select date_add(now(), interval -17 hour)),'%H')  and date_format((select date_add(now(), interval -14 hour)),'%H')\r\n" + 
					"then 17\r\n" + 
					"when date_format(date_time, '%H') between date_format((select date_add(now(), interval -20 hour)),'%H')  and date_format((select date_add(now(), interval -17 hour)),'%H')\r\n" + 
					"then 21\r\n" + 
					"when date_format(date_time, '%H') between date_format((select date_add(now(), interval -1 day)),'%H')  and date_format((select date_add(now(), interval -20 hour)),'%H')\r\n" + 
					"then 24\r\n" + 
					" end\r\n" + 
					") as time_table\r\n" + 
					"from hit where bseq =? and date_time between (select date_add(now(), interval -2 day)) and (select date_add(now(), interval +1 day))" + 
					") as divied_time group by time_table order by time_table\r\n" + 
					") as hit_divied_time\r\n" + 
					"left outer join (\r\n" + 
					"select time_table, count(time_table) as hit_counts from (\r\n" + 
					"select\r\n" + 
					"(case when date_format(date_time, '%H') between date_format((select date_add(now(), interval -2 hour)),'%H')  and date_format((select date_add(now(), interval +1 hour)),'%H')\r\n" + 
					"then 2\r\n" + 
					"when date_format(date_time, '%H') between date_format((select date_add(now(), interval -5 hour)),'%H')  and date_format((select date_add(now(), interval -2 hour)),'%H')\r\n" + 
					"then 5\r\n" + 
					"when date_format(date_time, '%H') between date_format((select date_add(now(), interval -8 hour)),'%H')  and date_format((select date_add(now(), interval -5 hour)),'%H')\r\n" + 
					"then 8\r\n" + 
					"when date_format(date_time,'%H')  between date_format((select date_add(now(), interval -11 hour)),'%H')  and date_format((select date_add(now(), interval -8 hour)),'%H')\r\n" + 
					"then 11\r\n" + 
					"when date_format(date_time,'%H') between date_format((select date_add(now(), interval -14 hour)),'%H')  and date_format((select date_add(now(), interval -11 hour)),'%H')\r\n" + 
					"then 14\r\n" + 
					"when date_format(date_time, '%H') between date_format((select date_add(now(), interval -17 hour)),'%H')  and date_format((select date_add(now(), interval -14 hour)),'%H')\r\n" + 
					"then 17\r\n" + 
					"when date_format(date_time, '%H') between date_format((select date_add(now(), interval -20 hour)),'%H')  and date_format((select date_add(now(), interval -17 hour)),'%H')\r\n" + 
					"then 21\r\n" + 
					"when date_format(date_time, '%H') between date_format((select date_add(now(), interval -1 day)),'%H')  and date_format((select date_add(now(), interval -20 hour)),'%H')\r\n" + 
					"then 24\r\n" + 
					" end\r\n" + 
					") as time_table\r\n" + 
					"from comment where bseq =? and date_time between (select date_add(now(), interval -2 day)) and (select date_add(now(), interval +1 day))" + 
					") as divied_time group by time_table order by time_table\r\n" + 
					") as comment_divied_time on hit_divied_time.time_table = comment_divied_time.time_table\r\n" + 
					") as hc left outer join (\r\n" + 
					"select time_table, count(time_table) as hit_counts from (\r\n" + 
					"select\r\n" + 
					"(case when date_format(date_time, '%H') between date_format((select date_add(now(), interval -2 hour)),'%H')  and date_format((select date_add(now(), interval +1 hour)),'%H')\r\n" + 
					"then 2\r\n" + 
					"when date_format(date_time, '%H') between date_format((select date_add(now(), interval -5 hour)),'%H')  and date_format((select date_add(now(), interval -2 hour)),'%H')\r\n" + 
					"then 5\r\n" + 
					"when date_format(date_time, '%H') between date_format((select date_add(now(), interval -8 hour)),'%H')  and date_format((select date_add(now(), interval -5 hour)),'%H')\r\n" + 
					"then 8\r\n" + 
					"when date_format(date_time,'%H')  between date_format((select date_add(now(), interval -11 hour)),'%H')  and date_format((select date_add(now(), interval -8 hour)),'%H')\r\n" + 
					"then 11\r\n" + 
					"when date_format(date_time,'%H') between date_format((select date_add(now(), interval -14 hour)),'%H')  and date_format((select date_add(now(), interval -11 hour)),'%H')\r\n" + 
					"then 14\r\n" + 
					"when date_format(date_time, '%H') between date_format((select date_add(now(), interval -17 hour)),'%H')  and date_format((select date_add(now(), interval -14 hour)),'%H')\r\n" + 
					"then 17\r\n" + 
					"when date_format(date_time, '%H') between date_format((select date_add(now(), interval -20 hour)),'%H')  and date_format((select date_add(now(), interval -17 hour)),'%H')\r\n" + 
					"then 21\r\n" + 
					"when date_format(date_time, '%H') between date_format((select date_add(now(), interval -24 hour)),'%H')  and date_format((select date_add(now(), interval -20 hour)),'%H')\r\n" + 
					"then 24\r\n" + 
					" end\r\n" + 
					") as time_table\r\n" + 
					"from likey where bseq =? and date_time between (select date_add(now(), interval -2 day)) and (select date_add(now(), interval +1 day))" + 
					") as divied_time group by time_table order by time_table\r\n" + 
					") as l on hc.time = l.time_table order by hc.time";
					
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bseq);
			pstmt.setString(2, bseq);
			pstmt.setString(3, bseq);
			
			rs = pstmt.executeQuery();		
			while( rs.next() ) {
				TodayTO to = new TodayTO();
				to.setComment_count(rs.getInt("comment"));
				to.setHit_count(rs.getInt("hit"));
				to.setLike_count(rs.getInt("likey"));
				to.setTime(rs.getInt("time"));
				
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
	
	public ArrayList<WeekTO> weekCounts_insight(String bseq) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		ArrayList<WeekTO> lists = new ArrayList<WeekTO>();
		
		try{
			conn = dataSource.getConnection();
			
			String sql = "select hc.time as time, hc.hit as hit, hc.comment as comment, l.hit_counts as likey from (\r\n" + 
					"select hit_divied_time.time_table as time, hit_divied_time.hit_counts as hit, comment_divied_time.hit_counts as comment from (\r\n" + 
					"select time_table, count(time_table) as hit_counts from (\r\n" + 
					"select\r\n" + 
					"(case when date_format(date_time, '%d') between date_format((select date_add(now(), interval -1 day)),'%d')  and date_format((select date_add(now(), interval +1 day)),'%d')\r\n" + 
					"then 1\r\n" + 
					"when date_format(date_time, '%d') between date_format((select date_add(now(), interval -2 day)),'%d')  and date_format((select date_add(now(), interval -1 day)),'%d')\r\n" + 
					"then 2\r\n" + 
					"when date_format(date_time, '%d') between date_format((select date_add(now(), interval -3 day)),'%H')  and date_format((select date_add(now(), interval -2 day)),'%H')\r\n" + 
					"then 3\r\n" + 
					"when date_format(date_time,'%d')  between date_format((select date_add(now(), interval -4 day)),'%H')  and date_format((select date_add(now(), interval -3 day)),'%H')\r\n" + 
					"then 4\r\n" + 
					"when date_format(date_time,'%d') between date_format((select date_add(now(), interval -5 day)),'%H')  and date_format((select date_add(now(), interval -4 day)),'%H')\r\n" + 
					"then 5\r\n" + 
					"when date_format(date_time, '%d') between date_format((select date_add(now(), interval -6 day)),'%H')  and date_format((select date_add(now(), interval -5 day)),'%H')\r\n" + 
					"then 6\r\n" + 
					"when date_format(date_time, '%d') between date_format((select date_add(now(), interval -7 day)),'%H')  and date_format((select date_add(now(), interval -6 day)),'%H')\r\n" + 
					"then 7\r\n" + 
					" end\r\n" + 
					") as time_table\r\n" + 
					"from hit where bseq =? and date_time between (select date_add(now(), interval -7 day)) and (select date_add(now(), interval +1 day))" + 
					") as divied_time group by time_table order by time_table\r\n" + 
					") as hit_divied_time\r\n" + 
					"left outer join (\r\n" + 
					"select time_table, count(time_table) as hit_counts from (\r\n" + 
					"select\r\n" + 
					"(case when date_format(date_time, '%d') between date_format((select date_add(now(), interval -1 day)),'%d')  and date_format((select date_add(now(), interval +1 day)),'%d')\r\n" + 
					"then 1\r\n" + 
					"when date_format(date_time, '%d') between date_format((select date_add(now(), interval -2 day)),'%d')  and date_format((select date_add(now(), interval -1 day)),'%d')\r\n" + 
					"then 2\r\n" + 
					"when date_format(date_time, '%d') between date_format((select date_add(now(), interval -3 day)),'%H')  and date_format((select date_add(now(), interval -2 day)),'%H')\r\n" + 
					"then 3\r\n" + 
					"when date_format(date_time,'%d')  between date_format((select date_add(now(), interval -4 day)),'%H')  and date_format((select date_add(now(), interval -3 day)),'%H')\r\n" + 
					"then 4\r\n" + 
					"when date_format(date_time,'%d') between date_format((select date_add(now(), interval -5 day)),'%H')  and date_format((select date_add(now(), interval -4 day)),'%H')\r\n" + 
					"then 5\r\n" + 
					"when date_format(date_time, '%d') between date_format((select date_add(now(), interval -6 day)),'%H')  and date_format((select date_add(now(), interval -5 day)),'%H')\r\n" + 
					"then 6\r\n" + 
					"when date_format(date_time, '%d') between date_format((select date_add(now(), interval -7 day)),'%H')  and date_format((select date_add(now(), interval -6 day)),'%H')\r\n" + 
					"then 7\r\n" + 
					" end\r\n" + 
					") as time_table\r\n" + 
					"from comment where bseq =? and date_time between (select date_add(now(), interval -7 day)) and (select date_add(now(), interval +1 day))" + 
					") as divied_time group by time_table order by time_table\r\n" + 
					") as comment_divied_time on hit_divied_time.time_table = comment_divied_time.time_table\r\n" + 
					") as hc left outer join (\r\n" + 
					"select time_table, count(time_table) as hit_counts from (\r\n" + 
					"select\r\n" + 
					"(case when date_format(date_time, '%d') between date_format((select date_add(now(), interval -1 day)),'%d')  and date_format((select date_add(now(), interval +1 day)),'%d')\r\n" + 
					"then 1\r\n" + 
					"when date_format(date_time, '%d') between date_format((select date_add(now(), interval -2 day)),'%d')  and date_format((select date_add(now(), interval -1 day)),'%d')\r\n" + 
					"then 2\r\n" + 
					"when date_format(date_time, '%d') between date_format((select date_add(now(), interval -3 day)),'%H')  and date_format((select date_add(now(), interval -2 day)),'%H')\r\n" + 
					"then 3\r\n" + 
					"when date_format(date_time,'%d')  between date_format((select date_add(now(), interval -4 day)),'%H')  and date_format((select date_add(now(), interval -3 day)),'%H')\r\n" + 
					"then 4\r\n" + 
					"when date_format(date_time,'%d') between date_format((select date_add(now(), interval -5 day)),'%H')  and date_format((select date_add(now(), interval -4 day)),'%H')\r\n" + 
					"then 5\r\n" + 
					"when date_format(date_time, '%d') between date_format((select date_add(now(), interval -6 day)),'%H')  and date_format((select date_add(now(), interval -5 day)),'%H')\r\n" + 
					"then 6\r\n" + 
					"when date_format(date_time, '%d') between date_format((select date_add(now(), interval -7 day)),'%H')  and date_format((select date_add(now(), interval -6 day)),'%H')\r\n" + 
					"then 7\r\n" + 
					"end\r\n" + 
					") as time_table\r\n" + 
					"from likey where bseq =? and date_time between (select date_add(now(), interval -7 day)) and (select date_add(now(), interval +1 day))" + 
					") as divied_time group by time_table order by time_table\r\n" + 
					") as l on hc.time = l.time_table order by hc.time";
					
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bseq);
			pstmt.setString(2, bseq);
			pstmt.setString(3, bseq);
			
			rs = pstmt.executeQuery();		
			while( rs.next() ) {
				WeekTO to = new WeekTO();
				to.setComment_count(rs.getInt("comment"));
				to.setHit_count(rs.getInt("hit"));
				to.setLike_count(rs.getInt("likey"));
				to.setTime(rs.getInt("time"));
				
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
	
}
