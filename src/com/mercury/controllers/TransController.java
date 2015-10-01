package com.mercury.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.mercury.beans.Transaction;
import com.mercury.beans.User;
import com.mercury.service.TransService;
import com.mercury.service.UserService;

@Controller
@SessionAttributes
public class TransController {
	@Autowired
	private TransService ts;
	@Autowired
	private UserService us;
	
	public TransService getTs() {
		return ts;
	}
	public void setTs(TransService ts) {
		this.ts = ts;
	}
	
	@RequestMapping(value="/validTran")
	@ResponseBody
	public User getValidUser(Principal principal){
		String userName = null;
		if (principal != null && principal.getName() != null){
			userName = principal.getName();			
		}
		return us.findByUserName(userName);
	}
	
	
	@RequestMapping(value="/pending")
	public String listPendings(HttpServletRequest request) throws Exception{
		return "pending";
	}
	
	@RequestMapping(value="/getPending")
	@ResponseBody
	public List<Transaction> getPending(HttpServletRequest request) throws Exception{
		ServletContext context = request.getServletContext();
		List<Transaction> pendingList = ts.getAllPendings(context.getRealPath("CSV"));
		return pendingList;
	}
	
	@RequestMapping(value="/addPending", method=RequestMethod.POST, produces="text/plain")
	@ResponseBody
	public String addPending(@RequestBody Transaction tran, 
			HttpServletRequest request) throws Exception{
		if (tran != null){
			System.out.println(tran);
			ServletContext context = request.getServletContext();
			ts.createPending(tran, context.getRealPath("CSV"));
			return "success";
		}else{
			return "failure";
		}
	}
	
	//Drop a pending transaction
	@RequestMapping(value="/pending", params="drop", method=RequestMethod.GET)
	public String dropPending(@RequestParam("drop") int tid, HttpServletRequest request) throws Exception {
		ServletContext context = request.getServletContext();
		ts.dropPending(tid, context.getRealPath("CSV"));
		return "redirect:pending";
	}
	
	//Commit a pending transaction
	@RequestMapping(value="/pending", params="commit", method=RequestMethod.GET)
	public String commitPending(@RequestParam("commit") int tid, HttpServletRequest request) throws Exception {
		ServletContext context = request.getServletContext();
		ts.commitPending(tid, context.getRealPath("CSV"));
		ts.dropPending(tid, context.getRealPath("CSV"));
		return "redirect:pending";
	}
	
	@RequestMapping(value="/getHistory", method=RequestMethod.GET, produces="application/json")
	@ResponseBody
	public List<Transaction> getHistory(){
		return ts.queryAll();
	}
	
	@RequestMapping(value="/history", method=RequestMethod.GET)
	public String listHistroy(){
		return "history";
	}

}
