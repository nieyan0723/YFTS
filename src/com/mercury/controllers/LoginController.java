package com.mercury.controllers;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.mercury.beans.User;
import com.mercury.beans.UserInfo;
import com.mercury.service.UserService;

@SessionAttributes
@Controller
public class LoginController {
	@Autowired
	private UserService us;
	
	public UserService getMs() {
		return us;
	}
	public void setMs(UserService us) {
		this.us = us;
	}
	
	@RequestMapping(value="login", method = RequestMethod.GET)
	public String login(ModelMap model) {
		return "login";
	}
	
	@RequestMapping(value="/home", method = RequestMethod.GET)
	public ModelAndView mainPage() {
		UserInfo userInfo = us.process2();
		ModelAndView mav = new ModelAndView();
		mav.setViewName("home");
		mav.addObject("title", "Sample06: Spring Security + Spring 3 MVC ~ Hibernate");
		mav.addObject("userInfo", userInfo);
		return mav;
	}
	
	@RequestMapping(value="/confirmation", method=RequestMethod.POST)
	public ModelAndView process(@ModelAttribute("user") 
			User user, BindingResult result) {
		UserInfo userInfo = us.process(user);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("confirmation");
		mav.addObject("userInfo", userInfo);
		return mav;
	}
	
	@RequestMapping(value="/registervalidation", method=RequestMethod.POST)
	public String isUserExist(@ModelAttribute("user") 
			User user, BindingResult result) {
		System.out.println(user.getUserName() + "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		if(us.isUserExist(user)) {
			System.out.println("name existeddd...........................");
			return "true";
		}
		return "false";
	}
}
