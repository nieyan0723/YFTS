package com.mercury.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	
	public void addStock(Stock stock){
		sd.save(stock);
	}
	
	public void removeStock(Stock stock){
		sd.delete(stock);
	}
	
	public Stock loadById(int id){
		return sd.findBySid(id);
	}
	
	public Stock loadByName(String name){
		return sd.findBySymbol(name);
	}
	
	public List<Stock> getAllStock(){
		return sd.queryAll();
	}
}
