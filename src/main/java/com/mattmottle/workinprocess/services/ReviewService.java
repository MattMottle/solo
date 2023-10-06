package com.mattmottle.workinprocess.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mattmottle.workinprocess.models.Review;
import com.mattmottle.workinprocess.repositories.ReviewRepository;
@Service
public class ReviewService {
	@Autowired
	private ReviewRepository reviewRepository;
	
	public List <Review> findAll() {
		return reviewRepository.findAll();
	}
	
	public Review findById(Long reviewId) {
		Optional <Review> optionalReview = reviewRepository.findById(reviewId);
		if(optionalReview.isPresent()) {
			return optionalReview.get();
		}
		return null;
	}
	
	public Review create(Review review) {
		return reviewRepository.save(review);
	}
	
	public Review updateReview(Review updatedReview) {
		return reviewRepository.save(updatedReview);
	}
	public void deleteReview(Long reviewId) {
		reviewRepository.deleteById(reviewId);	
	}
}

