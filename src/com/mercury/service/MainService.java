package com.mercury.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mercury.beans.User;
import com.mercury.beans.UserInfo;
import com.mercury.dao.MainDao;

@Service
public class MainService {
	@Autowired
	private MainDao md;
	
	public MainDao getMd() {
		return md;
	}
	public void setMd(MainDao md) {
		this.md = md;
	}

	public UserInfo process(User user) {
		md.save(user);
		UserInfo userInfo = new UserInfo();
		userInfo.setMessage("Hello " + user.getUserName() + ", welcome to YFTS!");
		userInfo.setUsers(md.queryAll());
		return userInfo;
	}
	public UserInfo process2() {
		UserInfo userInfo = new UserInfo();
		userInfo.setMessage("Hello , welcome to YFTS!");
		userInfo.setUsers(md.queryAll());
		return userInfo;
	}
}
