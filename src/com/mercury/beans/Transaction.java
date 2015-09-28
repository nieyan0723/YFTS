package com.mercury.beans;

import java.math.BigDecimal;
import java.sql.Timestamp;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="YFTS_TRANS")
public class Transaction {
	private int tid;
	private Integer uid;
	private Integer sid;
	private int amount;
	private BigDecimal price;
	private Timestamp ts;
	
	public Transaction(){}	
		
	public Transaction(Integer uid, Integer sid, int amount,
			BigDecimal price, Timestamp ts) {
		this.uid = uid;
		this.sid = sid;
		this.amount = amount;
		this.price = price;
		this.ts = ts;
	}



	@Id
	@GeneratedValue(generator="trans_id_gen")
	@GenericGenerator(name="trans_id_gen", strategy="increment")
	@Column(name="TRANS_ID")
	public int getTid() {
		return tid;
	}
	public void setTid(int tid) {
		this.tid = tid;
	}
	
	@Column(name="USER_ID")
	public Integer getUid() {
		return uid;
	}
	public void setUid(Integer uid) {
		this.uid = uid;
	}
	
	@Column(name="STOCK_ID")
	public Integer getSid() {
		return sid;
	}
	public void setSid(Integer sid) {
		this.sid = sid;
	}
	
	@Column(name="AMOUNT")
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	
	@Column(name="PRICE")
	public BigDecimal getPrice() {
		return price;
	}
	public void setPrice(BigDecimal price) {
		this.price = price;
	}
	
	@Column(name="TRANS_TIME")
	public Timestamp getTs() {
		return ts;
	}
	public void setTs(Timestamp ts) {
		this.ts = ts;
	}
	
	@Override
	public String toString(){
		return uid.toString()+","+sid.toString()
				+","+Integer.toString(amount)+","+price.toString()+","
				+ts.toString();
	}

}
