package com.mercury.service;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mercury.beans.OwnershipInfo;
import com.mercury.beans.User;
import com.mercury.beans.UserInfo;
import com.mercury.dao.OwnInfoDao;
import com.mercury.dao.UserDao;

@Service
public class UserService {
	@Autowired
	private UserDao ud;
	@Autowired
	private OwnInfoDao od;
	
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
	public User findUserByUserName(String username){
		return ud.findByUserName(username);
	}
	
	@Transactional
	public UserInfo userLogin(String username) {
		UserInfo userInfo = new UserInfo();
		userInfo.setMessage("Hello "+ username + ", welcome to YFTS home!");
		userInfo.setUsers(ud.queryAll());
		return userInfo;
	}

	@Transactional
	public List<OwnershipInfo> findOwnByUserName(String username){
		User user = findUserByUserName(username);
		return od.findOwnByUser(user);
	}
	
	@Transactional
	public void addBalance(String username, int addMoney) {
		User user =ud.findByUserName(username);
		int newBalance =user.getBalance() + addMoney;
		if(newBalance<99999999) {
			user.setBalance(newBalance);
			ud.update(user);
		}
	}
	@Transactional
	public int getBalance(String username) {
		return ud.findByUserName(username).getBalance();
	}
}
