package com.mercury.dao.impl;

import java.util.List;

import org.hibernate.SessionFactory;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
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
		return template.get(Stock.class, sid);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Stock> findBySymbol(String symbol) {
		return template.findByCriteria(DetachedCriteria.forClass(Stock.class).add(Restrictions.eq("symbol", symbol)));
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Stock> queryAll() {
		String hql = "from Stock";
		return template.find(hql);
	}
}
