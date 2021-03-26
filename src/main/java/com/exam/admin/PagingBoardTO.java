package com.exam.admin;

import java.util.ArrayList;

public class PagingBoardTO {
	private int bpage;
	private int recordPerPage;
	private int blockPerPage;
	private int totalPage;
	private int totalrecord;
	private int startBlock;
	private int endBlock;
	
	private ArrayList<AdminBoardListTO> boardList;

	public PagingBoardTO() {
		this.bpage = 1;
		this.recordPerPage = 15;
		this.blockPerPage = 5;
	}
	
	public int getBpage() {
		return bpage;
	}

	public void setBpage(int bpage) {
		this.bpage = bpage;
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

	public int getTotalrecord() {
		return totalrecord;
	}

	public void setTotalrecord(int totalrecord) {
		this.totalrecord = totalrecord;
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
	public ArrayList<AdminBoardListTO> getBoardList() {
		return boardList;
	}

	public void setBoardList(ArrayList<AdminBoardListTO> boardList) {
		this.boardList = boardList;
	}
}
