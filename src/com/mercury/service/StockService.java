package com.mercury.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mercury.beans.Stock;
import com.mercury.dao.StockDao;

@Service
public class StockService {
	@Autowired
	private StockDao sd;

	public StockDao getSd() {
		return sd;
	}

	public void setSd(StockDao sd){
		this.sd = sd;
	}	
	
	@Transactional
	public void addStock(Stock stock){
		stock.setSymbol(stock.getSymbol().toUpperCase());
		sd.save(stock);
	}
	
	@Transactional
	public void removeStock(Stock stock){
		sd.delete(stock);
	}
	
	@Transactional
	public Stock loadById(int id){
		return sd.findBySid(id);
	}
	
	@Transactional
	public List<Stock> getByName(String name){
		return sd.findBySymbol(name);
	}
	
	@Transactional
	public List<Stock> getAllStock(){
		return sd.queryAll();
	}
	
	@Transactional
	public boolean hasStock(Stock stock){
		List<Stock> s = getByName(stock.getSymbol().toUpperCase());
		if (s == null || s.size() == 0){
			return false;
		}else{
			return true;
		}
	}
}
