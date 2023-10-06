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

import com.mattmottle.workinprocess.models.Review;
import com.mattmottle.workinprocess.models.User;
import com.mattmottle.workinprocess.services.JobService;
import com.mattmottle.workinprocess.services.ReviewService;
import com.mattmottle.workinprocess.services.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class ReviewController {
	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private JobService jobService;
	
	@Autowired
	private HttpSession session;
	
	@GetMapping("/user/{id}")
	public String userPage(@PathVariable("id") Long id, Model model, HttpSession session) {
		if(session.getAttribute("userId") == null) {
			return "redirect:/";
		}
		User currentUser = userService.findById(id);
		Long userId = (Long) session.getAttribute("userId");
		model.addAttribute("loggedUser", userService.findById(userId));
		model.addAttribute("user", currentUser);
		model.addAttribute("jobs", jobService.findAll());
		
		Integer ratingTotal = 0;
		for(Review currentReview : currentUser.getReviewedReviews()) {
			ratingTotal += currentReview.getRating();
		}
		Double averageRating;
		if(ratingTotal == 0) {
			averageRating = null;
		} else {
			averageRating = Double.valueOf(ratingTotal)/ currentUser.getReviewedReviews().size();
		}
		
		model.addAttribute("averageRating", averageRating);
		return "user.jsp";
	}
	
	@GetMapping("/user/{id}/new_review")
	public String newReviewPage(@PathVariable Long id, Model model, @ModelAttribute("newReview") Review newReview) {
		if(session.getAttribute("userId") == null) {
			return "redirect:/";
		}
		Long userId = (Long) session.getAttribute("userId");
		User currentUser = userService.findById(id);
		model.addAttribute("loggedUser", userService.findById(userId));
		model.addAttribute("user", currentUser);
		return "newReview.jsp";
	}
	
	@PostMapping("/reviews/addReview")
	public String addReview(@Valid @ModelAttribute("newReview") Review newReview, BindingResult result, Model model) {
		if(session.getAttribute("userId") == null) {
			return "redirect:/";
		}
		Long userId = (Long) session.getAttribute("userId");
		Long reviewedUserId = newReview.getReviewedPerson().getId();
		
		if(result.hasErrors()) {
			model.addAttribute("loggedUser", userService.findById(userId));
			model.addAttribute("userToReview", userService.findById(reviewedUserId));
			return "newReview.jsp";
		}
		reviewService.create(newReview);
		return "redirect:/user/" + reviewedUserId;
	}
	
	@GetMapping("/reviews/{id}/edit_review")
	public String editReview(@PathVariable Long id, Model model) {
		if(session.getAttribute("userId") == null) {
			return "redirect:/";
		}
		Long userId = (Long) session.getAttribute("userId");
		Review thisReview = reviewService.findById(id);
		model.addAttribute("loggedUser", userService.findById(userId));
		model.addAttribute("thisReview", thisReview);
		return "editReview.jsp";
	}
	
	@PutMapping("/reviews/{id}/editReview")
	public String editReviewInDb(@PathVariable Long id, @Valid @ModelAttribute("thisReview") Review thisReview, BindingResult result, Model model) {
		if(session.getAttribute("userId") == null) {
			return "redirect:/";
		}
		Long userId = (Long) session.getAttribute("userId");
		if (result.hasErrors()) {
			model.addAttribute("loggedUser", userService.findById(userId));
			model.addAttribute("thisReview", thisReview);
			return "editReview.jsp";
		}
		reviewService.updateReview(thisReview);
		return "redirect:/user/" + thisReview.getReviewedPerson().getId();
	
	}
	
	@DeleteMapping("/reviews/{id}/deleteReview")
	public String deleteReview(@PathVariable Long id) {
		if(session.getAttribute("userId") == null) {
			return "redirect:/";
		}
		Long userId = (Long) session.getAttribute("userId");
		reviewService.deleteReview(id);
		return "redirect:/workinprocess";
	}
}
