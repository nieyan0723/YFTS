package com.mercury.controllers;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.mercury.beans.Transaction;
import com.mercury.service.TransService;

@Controller
@SessionAttributes
public class TransController {
	@Autowired
	private TransService ts;

	public TransService getTs() {
		return ts;
	}

	public void setTs(TransService ts) {
		this.ts = ts;
	}
	
	@RequestMapping(value="/pending")
	public ModelAndView listPendings(HttpServletRequest request){
		ModelAndView mav = new ModelAndView();
		ServletContext context = request.getServletContext();
		List<Transaction> transList = ts.getAllPendings(context.getRealPath("CSV"));
		mav.setViewName("pending");
		mav.addObject("transList", transList);
		return mav;
	}
	
	//Drop a pending transaction
	@RequestMapping(value="/pending", params="drop", method=RequestMethod.POST)
	public String dropPending(@RequestParam("drop") int tid, HttpServletRequest request) throws Exception {
		ServletContext context = request.getServletContext();
		ts.dropPending(tid, context.getRealPath("CSV"));
		return "redirect:pending";
	}
	
	//Commit a pending transaction
	@RequestMapping(value="/pending", params="commit", method=RequestMethod.POST)
	public String commitPending(@RequestParam("commit") int tid, HttpServletRequest request) throws Exception {
		ServletContext context = request.getServletContext();
		ts.commitPending(tid, context.getRealPath("CSV"));
		return "redirect:pending";
	}
	
	@RequestMapping(value="/history")
	public ModelAndView listHistory(){
		ModelAndView mav = new ModelAndView();
		List<Transaction> transList = ts.queryAll();
		mav.setViewName("history");
		mav.addObject("transList", transList);
		return mav;
	}
}
