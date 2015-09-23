package com.mercury.dao.impl;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.orm.hibernate3.HibernateTemplate;

import com.mercury.beans.Stock;
import com.mercury.dao.StockDao;

public class StockDaoImpl implements StockDao {
	private HibernateTemplate template;
	
	public void setSessionFactory(SessionFactory sessionFactory) {
		template = new HibernateTemplate(sessionFactory);
	}

	@Override
	public void save(Stock stock) {
		template.save(stock);
	}

	@Override
	public void delete(Stock stock) {
		template.delete(stock);
	}

	@Override
	public Stock findBySid(int sid) {
		return template.load(Stock.class, sid);
	}

	@Override
	public Stock findBySymbol(String symbol) {
		return template.load(Stock.class, symbol);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Stock> queryAll() {
		String hql = "from Stock";
		List<Stock> list = template.find(hql);
		Collections.sort(list, new Comparator<Stock>(){
			@Override
			public int compare(Stock a, Stock b){
				return a.getSid() - b.getSid();
			}
		});
		return list;
	}
}
