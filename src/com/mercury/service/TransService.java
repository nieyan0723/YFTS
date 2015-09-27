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
import com.mercury.util.CsvUtil;

@Service
public class TransService {
	private final String csvName = "\\pending.csv";
	
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
	
	public List<Transaction> queryAll(){
		List<Transaction> list = td.queryAll();
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
	
	public List<Transaction> getAllPendings(String path){
		List<Transaction> list = CsvUtil.parseCSV(path + csvName);
		return list;
	}
	
	//Add new pending transaction to csv file
	public void createPending(Transaction trans, String path){
		CsvUtil.appendCSV(trans, path + csvName);
	}
	
	//Commit pending transaction in csv file, save it to database
	public void commitPending(int transIndex, String path){
		List<Transaction> list = getAllPendings(path);
		td.saveTransaction(list.get(transIndex));
		dropPending(transIndex, path);
	}
	
	public void commitPendings(List<Integer> transList, String path){
		List<Transaction> list = getAllPendings(path);
		for (Integer i: transList){
			td.saveTransaction(list.get(i));
		}
		dropPendings(transList, path);
	}
	
	//Delete pending transaction from csv file
	public void dropPending(int transIndex, String path){
		List<Transaction> list = getAllPendings(path);
		list.remove(transIndex);
		CsvUtil.rewriteCSV(list, path + csvName);
	}
	
	public void dropPendings(List<Integer> transList, String path){
		List<Transaction> list = getAllPendings(path);
		for (Integer i: transList){
			list.remove(i);
		}
		CsvUtil.rewriteCSV(list, path + csvName);
	}
}
