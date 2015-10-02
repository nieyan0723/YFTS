package com.mercury.controllers;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.mercury.beans.OwnershipInfo;
import com.mercury.beans.UserInfo;
import com.mercury.service.UserService;

@SessionAttributes
@Controller
public class CustomerController {
	
	@Autowired
	private UserService us;

	@RequestMapping(value="/portfolio", method = RequestMethod.GET)
	public ModelAndView portFolio(Principal principal){
		String username = principal.getName();
		System.out.println(username);
		List<OwnershipInfo> userOwns = us.findOwnByUserName(username);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("portfolio");
		mav.addObject("userOwns", userOwns);
		return mav;
	}
}
