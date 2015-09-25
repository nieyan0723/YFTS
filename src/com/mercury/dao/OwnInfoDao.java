package com.mercury.dao;

import java.util.List;

import com.mercury.beans.OwnershipInfo;

public interface OwnInfoDao {
	public void save(OwnershipInfo ois);
	public void update(OwnershipInfo ois);
	public void delete(OwnershipInfo ois);
	public void saveOrUpdate(OwnershipInfo ois);
	public void findByUserId(int uid);
	public void findByStockId(int sid);
	public void findByOwn(int uid, int sid);
	public List<OwnershipInfo> queryAll();
}
