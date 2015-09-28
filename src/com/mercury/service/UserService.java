package com.mercury.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	public boolean isUserExist(String username) {
		if(ud.findByUserName(username) == null){
			return false;
		}
		return true;
	}
	
	public boolean isEmailExist(String email) {
		if(ud.findByEmail(email) == null){
			return false;
		}
		return true;
	}
	
	public User findUser(String username){
		return ud.findByUserName(username);
	}
	
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
	public UserInfo process2(String username) {
		UserInfo userInfo = new UserInfo();
		userInfo.setMessage("Hello "+ username + ", welcome to YFTS home!");
		userInfo.setUsers(ud.queryAll());
		return userInfo;
	}
}
