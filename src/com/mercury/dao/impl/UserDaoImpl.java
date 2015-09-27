package com.mercury.dao.impl;

import java.util.List;

import org.hibernate.SessionFactory;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
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

	@SuppressWarnings("unchecked")
	@Override
	public User findByUserName(String username) {
		// TODO Auto-generated method stub
		List<User> users = template.findByCriteria(
		        DetachedCriteria.forClass(User.class).add(Restrictions.eq("userName", username)));
		if(users.size() == 0)
			return null;
		return users.get(0);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public User findByEmail(String email) {
		// TODO Auto-generated method stub
		List<User> users = template.findByCriteria(
		        DetachedCriteria.forClass(User.class).add(Restrictions.eq("email", email)));
		if(users.size() == 0)
			return null;
		return users.get(0);
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
