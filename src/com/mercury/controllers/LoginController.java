package com.mercury.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.mercury.beans.User;
import com.mercury.beans.UserInfo;
import com.mercury.service.MainService;

@SessionAttributes
@Controller
public class LoginController {
	private MainService ms;
	private String viewPage;
	
	public MainService getMs() {
		return ms;
	}
	public void setMs(MainService ms) {
		this.ms = ms;
	}
	public String getViewPage() {
		return viewPage;
	}
	public void setViewPage(String viewPage) {
		this.viewPage = viewPage;
	}
	
	@RequestMapping(value="login", method = RequestMethod.GET)
	public String login(ModelMap model) {
		return "login";
	}
	
	@RequestMapping(value="/next", method = RequestMethod.GET)
	public ModelAndView mainPage() {
		UserInfo userInfo = ms.process2();
		ModelAndView mav = new ModelAndView();
		mav.setViewName("next");
		mav.addObject("title", "Sample06: Spring Security + Spring 3 MVC ~ Hibernate");
		mav.addObject("userInfo", userInfo);
		return mav;
	}
	
	@RequestMapping(value="/confirmation", method=RequestMethod.POST)
	public ModelAndView process(@ModelAttribute("user") 
			User user, BindingResult result) {
		UserInfo userInfo = ms.process(user);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("confirmation");
		mav.addObject("userInfo", userInfo);
		return mav;
	}
}
