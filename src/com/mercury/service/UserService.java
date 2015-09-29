package com.mercury.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mercury.beans.User;
import com.mercury.beans.UserInfo;
import com.mercury.dao.UserDao;

@Service
public class UserService {
	@Autowired
	private UserDao ud;
	public UserDao getUd() {
		return ud;
	}
	public void setUd(UserDao ud) {
		this.ud = ud;
	}
	
	@Transactional
	public boolean isUserExist(String username) {
		if(ud.findByUserName(username) == null){
			return false;
		}
		return true;
	}
	
	@Transactional
	public boolean isEmailExist(String email) {
		if(ud.findByEmail(email) == null){
			return false;
		}
		return true;
	}
	
	@Transactional
	public UserInfo process(User user) {
		user.setAuthority("ROLE_USER");
		user.setBalance(0);
		user.setEnabled(0);
		ud.save(user);
		UserInfo userInfo = new UserInfo();
		userInfo.setMessage("Hello " + user.getUserName() + ", welcome to YFTS!");
		userInfo.setUsers(ud.queryAll());
		return userInfo;
	}
	
	@Transactional
	public User findByUserName(String username){
		return ud.findByUserName(username);
	}
	
	@Transactional
	public UserInfo userLogin(String username) {
		UserInfo userInfo = new UserInfo();
		userInfo.setMessage("Hello "+ username + ", welcome to YFTS home!");
		userInfo.setUsers(ud.queryAll());
		return userInfo;
	}

}
