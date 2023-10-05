package com.mattmottle.workinprocess.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mattmottle.workinprocess.models.Bid;
import com.mattmottle.workinprocess.repositories.BidRepository;

@Service
public class BidService {
	@Autowired
	private BidRepository bidRepository;
	
	public List <Bid> findAll() {
		return bidRepository.findAll();
	}
	
	public Bid findById(Long bidId) {
		Optional <Bid> optionalBid = bidRepository.findById(bidId);
		if(optionalBid.isPresent()) {
			return optionalBid.get();
		}
		return null;
	}
	
	public Bid create(Bid bid) {
		return bidRepository.save(bid);
	}
	
	public Bid updateBid(Bid updatedBid) {
		return bidRepository.save(updatedBid);
	}
	
	public void deleteBid(Long bidId) {
		bidRepository.deleteById(bidId);
	}
}
