package com.mercury.dao;

import java.util.List;

import com.mercury.beans.Stock;

public interface StockDao {
	public void save(Stock stock);
	public void update(Stock stock);
	public void delete(Stock stock);
	public Stock findBySid(int sid);
	public Stock findBySymbol(String symbol);
	public List<Stock> queryAll();
}
