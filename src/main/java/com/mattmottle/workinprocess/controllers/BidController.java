package com.mattmottle.workinprocess.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;

import com.mattmottle.workinprocess.models.Bid;
import com.mattmottle.workinprocess.services.BidService;
import com.mattmottle.workinprocess.services.JobService;
import com.mattmottle.workinprocess.services.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class BidController {
	@Autowired
	private BidService bidService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private JobService jobService;
	
	@Autowired
	private HttpSession session;
	
	@GetMapping("/bids/{id}/new_bid")
	public String newBidPage(@PathVariable Long id, Model model, @ModelAttribute("newBid") Bid newBid) {
		if(session.getAttribute("userId") == null) {
			return "redirect:/";
		}
		Long userId = (Long) session.getAttribute("userId");
		model.addAttribute("loggedUser", userService.findById(userId));
		model.addAttribute("jobToBid", jobService.findById(id));
		return "newBid.jsp";
	}
	
	@PostMapping("/bids/addBid")
	public String addBid(@Valid @ModelAttribute("newBid") Bid newBid, BindingResult result, Model model) {
		if(session.getAttribute("userId") == null) {
			return "redirect:/";
		}
		Long userId = (Long) session.getAttribute("userId");
		Long jobId = newBid.getJobWithBids().getId();
		
		if(result.hasErrors()) {
			model.addAttribute("loggedUser", userService.findById(userId));
			model.addAttribute("jobToBid", jobService.findById(jobId));
			return "newBid.jsp";
		}
		bidService.create(newBid);
		return "redirect:/workinprocess/" + jobId;
	}
	
	@GetMapping("/bids/{id}/edit_bid")
	public String editBid(@PathVariable Long id, Model model) {
		if(session.getAttribute("userId") == null) {
			return "redirect:/";
		}
		Long userId = (Long) session.getAttribute("userId");
		Bid thisBid = bidService.findById(id);
		model.addAttribute("loggedUser", userService.findById(userId));
		model.addAttribute("thisBid", thisBid);
		return "editBid.jsp";
	}
	
	@PutMapping("/bids/{id}/editBid")
	public String editBidInDb(@PathVariable Long id, @Valid @ModelAttribute("thisBid") Bid thisBid, BindingResult result, Model model) {
		if(session.getAttribute("userId") == null) {
			return "redirect:/";
		}
		Long userId = (Long) session.getAttribute("userId");
		if (result.hasErrors()) {
			model.addAttribute("loggedUser", userService.findById(userId));
			model.addAttribute("thisBid", thisBid);
			return "editBid.jsp";
		}
		bidService.updateBid(thisBid);
		return "redirect:/workinprocess/" + thisBid.getJobWithBids().getId();
	
	}
	
	@DeleteMapping("/bids/{id}/deleteBid")
	public String deleteBid(@PathVariable Long id) {
		if(session.getAttribute("userId") == null) {
			return "redirect:/";
		}
		Long userId = (Long) session.getAttribute("userId");
		bidService.deleteBid(id);
		return "redirect:/workinprocess";
	}
}
