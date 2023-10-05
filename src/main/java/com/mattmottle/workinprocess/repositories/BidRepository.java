package com.mattmottle.workinprocess.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.mattmottle.workinprocess.models.Bid;
@Repository
public interface BidRepository extends CrudRepository <Bid, Long> {
	List<Bid> findAll();
}
