package com.mercury.beans;

public class StockInfo {
	private double price;
	private double change;
	private String stockName;
	private Stock stock;
	public Stock getStock() {
		return stock;
	}
	public void setStock(Stock stock) {
		this.stock = stock;
	}
	public String getStockName() {
		return stockName;
	}
	public void setStockName(String stockName) {
		this.stockName = stockName;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public double getChange() {
		return change;
	}
	public void setChange(double change) {
		this.change = change;
	}
	
	@Override
	public String toString(){
		return "{price:"+price+",change:"+change+",stockName:"+stockName+",stock:{sid:"+stock.getSid()+",symbol:"+stock.getSymbol()+"}}";
	}
}
