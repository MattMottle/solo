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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mattmottle.workinprocess.models.Job;
import com.mattmottle.workinprocess.models.User;
import com.mattmottle.workinprocess.services.JobService;
import com.mattmottle.workinprocess.services.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class JobController {
	@Autowired
	private JobService jobService;
	@Autowired
	private UserService userService;
	
	@GetMapping("/workinprocess")
	public String home(HttpSession session, Model model) {
		if(session.getAttribute("userId") == null) {
			return "redirect:/";
		}
		Long userId = (Long) session.getAttribute("userId");
		
		model.addAttribute("loggedUser", userService.findById(userId));
		model.addAttribute("jobs", jobService.findAll());
		
		return "home.jsp";
	}
	
	@GetMapping("/workinprocess/{jobId}")
	public String oneJob(Model model, @PathVariable("jobId") Long jobId, 
			HttpSession session) {
		if(session.getAttribute("userId") == null) {
			return "redirect:/";
		}
		Long userId = (Long) session.getAttribute("userId");
		model.addAttribute("loggedUser", userService.findById(userId));
		Job job = jobService.findById(jobId);
		
		model.addAttribute("job", job);
		
		return "job.jsp";
	}
	
	@GetMapping("/workinprocess/pastjobs")
	public String pastJobs(HttpSession session, Model model) {
		if(session.getAttribute("userId") == null) {
			return "redirect:/";
		}
		Long userId = (Long) session.getAttribute("userId");
		
		model.addAttribute("loggedUser", userService.findById(userId));
		model.addAttribute("jobs", jobService.findAll());
		
		return "pastJobs.jsp";
	}
	
	@GetMapping("/workinprocess/new")
	public String newJob(@ModelAttribute("job") Job job, Model model, HttpSession session) {
		if(session.getAttribute("userId") == null) {
			return "redirect:/";
		}
		User user = userService.findById((Long)session.getAttribute("userId"));
		model.addAttribute("user", user);
		return "newJob.jsp";
	}
	
	@PostMapping("/workinprocess/new/process")
	public String createJob(Model model, @Valid @ModelAttribute("job") Job job, BindingResult result) {
		if(result.hasErrors()) {
			return "newJob.jsp";
		}
		jobService.create(job);
		return "redirect:/workinprocess";
	}
	
	@GetMapping("/workinprocess/{jobId}/edit")
	public String editTrail(@PathVariable("jobId") Long jobId, HttpSession session, Model model) {
		if(session.getAttribute("userId") == null) {
			return "redirect:/";
		}
		Long userId = (Long) session.getAttribute("userId");
		model.addAttribute("loggedUser", userService.findById(userId));
		Job job = jobService.findById(jobId);
		model.addAttribute("job", job);
		model.addAttribute("originalJobName", job.getName());
		
		return "editJob.jsp";
	}
	
	@RequestMapping(value="/workinprocess/{jobId}/edit/process", method=RequestMethod.PUT)
	public String updateJob(@Valid @ModelAttribute("job") Job job, BindingResult result, Model model, @PathVariable("jobId") Long jobId) {
		if(result.hasErrors()) {
			model.addAttribute("job", job);
			model.addAttribute("originalJobName", jobService.findById(jobId).getName());
			return "editJob.jsp";
		}
		jobService.updateJob(job);
		return "redirect:/workinprocess";
	}
	
	@DeleteMapping("/{jobId}/delete")
	public String deleteJob(@PathVariable("jobId") Long jobId) {
		jobService.deleteJob(jobId);
		return "redirect:/workinprocess";
	}
}
