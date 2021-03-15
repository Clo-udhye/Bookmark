package com.exam.paging;

import java.util.ArrayList;

import com.exam.booklist.BookTO;

public class pagingTO {
	private int cpage;
	private int recordPerPage;
	private int blockPerPage;
	private int totalPage;
	private int totalrecord;
	private int startBlock;
	private int endBlock;
	
	private ArrayList<BookTO> bookList;
	
	public pagingTO() {
		this.cpage = 1;
		this.recordPerPage = 5;
		this.blockPerPage = 5;
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

	public ArrayList<BookTO> getBookList() {
		return bookList;
	}

	public void setBookList(ArrayList<BookTO> bookList) {
		this.bookList = bookList;
	}
	
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return "Current Paging list : " + "cpage :" + cpage +"\n recordPerPage : " + recordPerPage + "\n blockPerPage : " + blockPerPage + 
			"\n totalPage : " + totalPage + "\n totalrecord : " + totalrecord + "\n startBlock :" + startBlock + "\n endBlock" + endBlock;
	}
}
