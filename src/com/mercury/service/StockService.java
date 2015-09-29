package com.mercury.service;

import java.io.*;
import java.net.*;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mercury.beans.Stock;
import com.mercury.beans.StockInfo;
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
	
	public StockInfo getPrice(Stock stock) {
		String yahoo_quote = "http://finance.yahoo.com/d/quotes.csv?s=" + stock.getSymbol() + "&f=snc1l1&e=.c";
		double price = 0;
		double change = 0;
		try {
			URL url = new URL(yahoo_quote);
			URLConnection urlconn = url.openConnection();
			BufferedReader in = new BufferedReader(new InputStreamReader(urlconn.getInputStream()));
			String content = in.readLine();
			content = content.replace((char)34, (char)32);//' ' replace '"'
			String[] tokens = content.split(",");
			price = Double.parseDouble(tokens[tokens.length-1].trim());
			change = Double.parseDouble(tokens[tokens.length-2].trim());
		} catch (Exception e) {
			e.printStackTrace();
		}
		StockInfo si = new StockInfo();
		si.setSymbol(stock.getSymbol());
		si.setPrice(price);
		si.setChange(change);
		return si;
	}
	
	//get real time stockInfo
	public List<StockInfo> getInfo(List<Stock> stocks) {
		List<StockInfo> sf = new ArrayList<StockInfo>();
		for (Stock s : stocks) {
			sf.add(getPrice(s));
		}
		return sf;
	}
}
