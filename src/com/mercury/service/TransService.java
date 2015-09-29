package com.mercury.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mercury.beans.OwnershipInfo;
import com.mercury.beans.Stock;
import com.mercury.beans.Transaction;
import com.mercury.beans.User;
import com.mercury.dao.OwnInfoDao;
import com.mercury.dao.StockDao;
import com.mercury.dao.TransDao;
import com.mercury.dao.UserDao;

@Service
public class TransService {
	private final String csvName = "\\pending.csv";
	
	@Autowired
	private UserDao ud;
	@Autowired
	private StockDao sd;
	@Autowired
	private TransDao td;
	@Autowired 
	private OwnInfoDao od;
	@Autowired
	private CsvUtil cu;
	
	public TransDao getTd() {
		return td;
	}
	public void setTd(TransDao td) {
		this.td = td;
	}	
	public OwnInfoDao getOd() {
		return od;
	}
	public void setOd(OwnInfoDao od) {
		this.od = od;
	}
	
	@Transactional
	public void addTransaction(Transaction trans){
		td.saveTransaction(trans);
	}
	
	@Transactional
	public void addTransaction(List<Transaction> trans){
		for (Transaction tran:trans){
			addTransaction(tran);
		}
	}
	
	@Transactional
	public void removeTransaction(Transaction trans){
		td.deleteTransaction(trans);
	}
	
	@Transactional
	public void removeTransaction(List<Transaction> trans){
		for (Transaction tran:trans){
			removeTransaction(tran);
		}
	}

	@Transactional
	public List<Transaction> queryByUser(User user){
		return td.queryByUser(user);
	}
	
	@Transactional
	public List<Transaction> queryByStock(Stock stock){
		return td.queryByStock(stock);
	}
	
	@Transactional
	public List<Transaction> queryAll(){
		return td.queryAll();
	}
	
	@Transactional
	public List<Transaction> getAllPendings(String path){
		List<Transaction> list = cu.parseCSV(path + csvName);
		return list;
	}
	
	@Transactional
	public List<Transaction> findPendingByUid(int uid, String path){
		List<Transaction> list = getAllPendings(path);
		for (Transaction t: list){
			if (t.getUser().getUid() != uid){
				list.remove(t);
			}
		}
		return list;
	}
	
	//Add new pending transaction to csv file
	@Transactional
	public void createPending(Transaction trans, String path){
		cu.appendCSV(trans, path + csvName);
	}
	
	/*Commit pending transaction in csv file, save it to database, 
	 * update balance and ownership
	 */
	@Transactional
	public void commitPending(int transIndex, String path){
		//Parsing pending to transaction
		List<Transaction> transList = getAllPendings(path);
		Transaction tx = transList.get(transIndex);
		User user = tx.getUser();
		System.out.println("Uid: " + user.getUid());
		Stock stock = tx.getStock();
		System.out.println("Sid: " + stock.getSid());
		List<OwnershipInfo> ownList = od.findByOwn(user, stock);
		OwnershipInfo ois = new OwnershipInfo();
		ois.setUser(user);
		ois.setStock(stock);
		//Calculate the quantity after transaction
		int change = tx.getAmount();
		if (ownList == null || ownList.size() == 0){
			ois.setQuantity(change < 0 ? 0 : change);
			user.addOwns(ois);
		}else {
			System.out.println(ownList);
			change += ownList.get(0).getQuantity();
			ownList.get(0).setQuantity(change < 0 ? 0 : change);
		}		
		//Calculate and update balance after transaction
		int balance = user.getBalance();
		balance = (int) Math.round(balance - tx.getPrice().doubleValue() * change) - 5;
		if (balance < 0) balance = 0;
		user.setBalance(balance);
		user.addTrans(tx);			//Save transaction to databse
		ud.update(user);
//		td.saveTransaction(tx);		
		dropPending(transIndex, path);
	}
	
	@Transactional
	public void commitPendings(List<Integer> transList, String path){
		for (Integer i: transList){
			commitPending(i, path);
		}
		dropPendings(transList, path);
	}
	
	//Delete pending transaction from csv file
	@Transactional
	public void dropPending(int transIndex, String path){
		List<Transaction> list = getAllPendings(path);
		list.remove(transIndex);
		cu.rewriteCSV(list, path + csvName);
	}
	
	@Transactional
	public void dropPendings(List<Integer> transList, String path){
		List<Transaction> list = getAllPendings(path);
		for (Integer i: transList){
			list.remove(i);
		}
		cu.rewriteCSV(list, path + csvName);
	}
}
