package com.mercury.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.mercury.dao.UserDao;

@Service
public class MainService {
	@Autowired
	private UserDao ud;
	
	public UserDao getMd() {
		return ud;
	}
	public void setMd(UserDao ud) {
		this.ud = ud;
	}
}
