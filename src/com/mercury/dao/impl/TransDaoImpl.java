package com.mercury.dao.impl;

import java.util.List;

import org.hibernate.SessionFactory;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate3.HibernateTemplate;

import com.mercury.beans.Transaction;
import com.mercury.dao.TransDao;

public class TransDaoImpl implements TransDao {
	private HibernateTemplate template;
	
	public void setSessionFactory(SessionFactory sessionFactory) {
		template = new HibernateTemplate(sessionFactory);
	}

	@Override
	public void saveTransaction(Transaction trans) {
		template.save(trans);
	}

	@Override
	public void deleteTransaction(Transaction trans) {
		template.delete(trans);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Transaction> queryByUserId(int uid) {
		return template.findByCriteria(DetachedCriteria.forClass(Transaction.class)
				.add(Restrictions.eq("uid", uid)));
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Transaction> queryByStockId(int sid) {
		return template.findByCriteria(DetachedCriteria.forClass(Transaction.class)
				.add(Restrictions.eq("sid", sid)));
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Transaction> queryAll() {
		String hql = "from Transaction";
		return template.find(hql);
	}
}
