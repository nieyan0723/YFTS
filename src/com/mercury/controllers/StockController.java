package com.mercury.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.mercury.beans.Stock;
import com.mercury.service.StockService;

@Controller
@SessionAttributes
public class StockController {
	@Autowired
	private StockService ss;

	public StockService getSs() {
		return ss;
	}
	public void setSs(StockService ss) {
		this.ss = ss;
	}
	
	@RequestMapping(value="/stock")
	public ModelAndView listAllStock(){
		ModelAndView mav = new ModelAndView();
		List<Stock> stockList = ss.getAllStock();
		mav.setViewName("stock");
		mav.addObject("stockList", stockList);
		return mav;
	}
	
	@RequestMapping(value="/stock", params="delete", method=RequestMethod.POST)
	public String deleteStock(@RequestParam("delete") int sid) throws Exception {
		Stock stock = ss.loadById(sid);
		ss.removeStock(stock);
		return "redirect:stock";
	}
	
	@RequestMapping(value="/validateStock", method=RequestMethod.GET)
	@ResponseBody
	public String validateStock(@ModelAttribute("stock") Stock stock, BindingResult result){
		System.out.println(stock.getSymbol() + "\t" + stock.getStockName());
		if (ss.hasStock(stock)){
			System.out.println("Stock already exists!");
			return "Stock already exists!";
		}
		return "valid";
	}	
	
	@RequestMapping(value="/addStock", method=RequestMethod.POST)
	public String addStock(@ModelAttribute("stock") Stock stock, BindingResult result){
		ss.addStock(stock);
		return "redirect:stock";
	}
}