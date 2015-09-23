package com.mercury.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.mercury.beans.Stock;
import com.mercury.beans.User;
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
	public String deleteStock(@ModelAttribute("stock") Stock stock, BindingResult result) throws Exception {
		ss.removeStock(stock);
		return "redirect:stock";
	}
	
	@RequestMapping(value="/add", method=RequestMethod.POST)
	public String addStock(@ModelAttribute("stock") Stock stock, BindingResult result){
		ss.addStock(stock);
		return "redirect:stock";
	}
}
