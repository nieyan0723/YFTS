package com.mercury.service;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mercury.beans.Stock;
import com.mercury.beans.Transaction;
import com.mercury.beans.User;
import com.mercury.dao.TransDao;

@Service
public class TransService {
	@Autowired
	private TransDao td;
	
	public TransDao getTd() {
		return td;
	}
	public void setTd(TransDao td) {
		this.td = td;
	}
	
	public void addTransaction(Transaction trans){
		td.saveTransaction(trans);
	}
	
	public void addTransaction(List<Transaction> trans){
		for (Transaction tran:trans){
			addTransaction(tran);
		}
	}
	
	public void removeTransaction(Transaction trans){
		td.deleteTransaction(trans);
	}
	
	public void removeTransaction(List<Transaction> trans){
		for (Transaction tran:trans){
			removeTransaction(tran);
		}
	}
	
	public List<Transaction> queryByUser(User user){
		List<Transaction> list = td.queryByUserId(user.getUid());
		sortByTid(list);
		return list;
	}
	
	public List<Transaction> queryByStock(Stock stock){
		List<Transaction> list = td.queryByUserId(stock.getSid());
		sortByTid(list);
		return list;
	}
	
	public void sortByTid(List<Transaction> list){
		Collections.sort(list, new Comparator<Transaction>(){
			@Override
			public int compare(Transaction a, Transaction b){
				return a.getTid() - b.getTid();
			}
		});
	}
	
	public void createPending(Transaction trans){
		
	}
	public void commitPending(Transaction trans){
		
	}
	public void dropPending(Transaction trans){
		
	}
}
