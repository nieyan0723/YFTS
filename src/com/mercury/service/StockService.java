package com.mercury.service;

import java.util.Collections;
import java.util.Comparator;
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
		stock.setSymbol(stock.getSymbol().toUpperCase());
		sd.save(stock);
	}
	
	public void removeStock(Stock stock){
		sd.delete(stock);
	}
	
	public Stock loadById(int id){
		return sd.findBySid(id);
	}
	
	public List<Stock> getByName(String name){
		return sd.findBySymbol(name);
	}
	
	public List<Stock> getAllStock(){
		List<Stock> list = sd.queryAll();
		Collections.sort(list, new Comparator<Stock>(){
			@Override
			public int compare(Stock a, Stock b){
				return a.getSid() - b.getSid();
			}
		});
		return list;
	}
	
	public boolean hasStock(Stock stock){
		List<Stock> s = getByName(stock.getSymbol().toUpperCase());
		if (s == null || s.size() == 0){
			return false;
		}else{
			return true;
		}
	}
}
