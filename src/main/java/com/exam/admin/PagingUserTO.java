package com.exam.admin;

import java.util.ArrayList;

public class PagingUserTO {
	private int upage;
	private int recordPerPage;
	private int blockPerPage;
	private int totalPage;
	private int totalrecord;
	private int startBlock;
	private int endBlock;
	
	private ArrayList<AdminUserListTO> userList;

	public PagingUserTO() {
		this.upage = 1;
		this.recordPerPage = 15;
		this.blockPerPage = 5;
	}
	
	public int getUpage() {
		return upage;
	}

	public void setUpage(int upage) {
		this.upage = upage;
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

	public ArrayList<AdminUserListTO> getUserList() {
		return userList;
	}

	public void setUserList(ArrayList<AdminUserListTO> userList) {
		this.userList = userList;
	}
}
