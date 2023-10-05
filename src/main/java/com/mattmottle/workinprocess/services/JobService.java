package com.mattmottle.workinprocess.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mattmottle.workinprocess.models.Bid;
import com.mattmottle.workinprocess.models.Job;
import com.mattmottle.workinprocess.repositories.BidRepository;
import com.mattmottle.workinprocess.repositories.JobRepository;

@Service
public class JobService {
	@Autowired
	private JobRepository jobRepository;
	@Autowired
	private BidRepository bidRepository;
	
	public List <Job> findAll() {
		return jobRepository.findAll();
	}
	
	public Job findById(Long jobId) {
		Optional <Job> optionalJob = jobRepository.findById(jobId);
		if(optionalJob.isPresent()) {
			return optionalJob.get();
		}
		return null;
	}
	
	public Job create(Job job) {
		return jobRepository.save(job);
	}
	
	public Job updateJob(Job updatedJob) {
		return jobRepository.save(updatedJob);
	}
	
	public void deleteJob(Long jobId) {
		Job jobToDelete = this.findById(jobId);
		
		for(Bid thisBid : jobToDelete.getAllBids()) {
			bidRepository.delete(thisBid);
		}
		jobRepository.deleteById(jobId);
	}
}
