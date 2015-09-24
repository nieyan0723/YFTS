package com.mercury.dao.impl;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.orm.hibernate3.HibernateTemplate;

import com.mercury.beans.User;
import com.mercury.dao.UserDao;

public class UserDaoImpl implements UserDao {
	private HibernateTemplate template;

	public void setSessionFactory(SessionFactory sessionFactory) {
		template = new HibernateTemplate(sessionFactory);
	}
	@Override
	public void save(User user) {
		// TODO Auto-generated method stub
		template.save(user);

	}

	@Override
	public void update(User user) {
		// TODO Auto-generated method stub
		template.update(user);

	}

	@Override
	public void delete(User user) {
		// TODO Auto-generated method stub
		template.delete(user);

	}

	@Override
	public User findByUid(int uid) {
		// TODO Auto-generated method stub
		return template.get(User.class, uid);
	}

	@Override
	public User findByUserName(String userName) {
		// TODO Auto-generated method stub
		return template.get(User.class, userName);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<User> queryAll() {
		// TODO Auto-generated method stub
		String hql = "from User";
		return template.find(hql);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<User> findByUser(User user) {
		// TODO Auto-generated method stub
		return template.findByExample(user);
	}

}
