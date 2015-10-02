package com.mercury.controllers;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.mercury.beans.OwnershipInfo;
import com.mercury.beans.StockInfo;
import com.mercury.beans.User;
import com.mercury.beans.UserInfo;
import com.mercury.service.StockService;
import com.mercury.service.UserService;

@SessionAttributes
@Controller
public class CustomerController {
	
	@Autowired
	private UserService us;
	@Autowired
	private StockService ss;
	
	@RequestMapping(value="/portfolio", method=RequestMethod.GET)
	public String portfolio() {
		return "portfolio";
	}

	@RequestMapping(value="/getOwnInfo", method=RequestMethod.GET)
	@ResponseBody
	public List<StockInfo> getPortfolio(Principal principal) {
		String userName = principal.getName();
		System.out.println(userName);
		List<OwnershipInfo> ownInfo = us.findOwnByUserName(userName);
		List<StockInfo> list = new ArrayList<StockInfo>();
		for(OwnershipInfo oi: ownInfo){
			StockInfo si = ss.getStockInfo(oi.getOwn().getStock());
			si.setQuantity(oi.getQuantity());
			list.add(si);
		}
		return list;
	}
	
//	@RequestMapping(value="/portfolio", method = RequestMethod.GET)
//	public ModelAndView portFolio(Principal principal){
//		String username = principal.getName();
//		System.out.println(username);
//		List<OwnershipInfo> userOwns = us.findOwnByUserName(username);
//		Map<StockInfo,Integer> map = new HashMap<StockInfo,Integer>();
//		for(OwnershipInfo oi: userOwns){
//			StockInfo si = ss.getStockInfo(oi.getOwn().getStock());
//			map.put(si, oi.getQuantity());
//		}
//		ModelAndView mav = new ModelAndView();
//		mav.setViewName("portfolio");
//		mav.addObject("userOwns", map);
//		return mav;
//	}
}
