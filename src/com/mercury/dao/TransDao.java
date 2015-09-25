package com.mercury.dao;

import java.util.List;

import com.mercury.beans.Transaction;

public interface TransDao {
	public void saveTransaction(Transaction trans);
	public void deleteTransaction(Transaction trans);
	public List<Transaction> queryByUserId(int uid);
	public List<Transaction> queryByStockId(int sid);
	public List<Transaction> queryAll();
}
