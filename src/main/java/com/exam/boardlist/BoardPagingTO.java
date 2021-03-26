package com.exam.boardlist;

import java.util.ArrayList;

import com.exam.user.UserTO;

public class BoardPagingTO {

	private int cpage;
	private int recordPerPage;
	private int blockPerPage;
	private int totalPage;
	private int totalRecord;
	private int startBlock;
	private int endBlock;
	
	private ArrayList<BoardTO> boardList;
	
	// 검색결과페이지에 작가 리스트에 nickname 출력하려고.
	private ArrayList<UserTO> userList;
	public ArrayList<UserTO> getUserList() {
		return userList;
	}
	public void setUserList(ArrayList<UserTO> userList) {
		this.userList = userList;
	}
	
	// 검색결과페이지에 작가 리스트에 좋아요수 출력하려고.
	private ArrayList<JoinBLUTO> joinbluList;
	public ArrayList<JoinBLUTO> getJoinbluList() {
		return joinbluList;
	}
	public void setJoinbluList(ArrayList<JoinBLUTO> joinbluList) {
		this.joinbluList = joinbluList;
	}
	

	public BoardPagingTO() {
		this.cpage = 1;
		// 한 페이지에 보일 게시글 수
		this.recordPerPage = 20;
		// 페이지탭에 보일 페이지 수 (한 줄에 보일 게시글 수 아님 주의!)
		this.blockPerPage = 3;
		this.totalPage = 1;
		this.totalRecord = 0;
	}
	
	public int getCpage() {
		return cpage;
	}
	public void setCpage(int cpage) {
		this.cpage = cpage;
	}
	public int getRecordPerPage() {
		return recordPerPage;
	}
	public void setRecordPerPage(int recordPerPage) {
		this.recordPerPage = recordPerPage;
	}
	public int getBlockPerPage() {
		return blockPerPage;
	}
	public void setBlockPerPage(int blockPerPage) {
		this.blockPerPage = blockPerPage;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public int getTotalRecord() {
		return totalRecord;
	}
	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
	}
	public int getStartBlock() {
		return startBlock;
	}
	public void setStartBlock(int startBlock) {
		this.startBlock = startBlock;
	}
	public int getEndBlock() {
		return endBlock;
	}
	public void setEndBlock(int endBlock) {
		this.endBlock = endBlock;
	}
	
	public ArrayList<BoardTO> getBoardList() {
		return boardList;
	}

	public void setBoardList(ArrayList<BoardTO> boardList) {
		this.boardList = boardList;
	}

}
