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
	public boolean isUserExist(User user) {
		if(ud.findByUser(user) == null){
			return false;
		}
		return true;
	}
	
	public UserInfo process(User user) {
		ud.save(user);
		UserInfo userInfo = new UserInfo();
		userInfo.setMessage("Hello " + user.getUserName() + ", welcome to YFTS!");
		userInfo.setUsers(ud.queryAll());
		return userInfo;
	}
	public UserInfo process2() {
		UserInfo userInfo = new UserInfo();
		userInfo.setMessage("Hello , welcome to YFTS!");
		userInfo.setUsers(ud.queryAll());
		return userInfo;
	}
}
