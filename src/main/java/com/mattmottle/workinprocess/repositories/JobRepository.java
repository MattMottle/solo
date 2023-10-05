package com.mattmottle.workinprocess.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.mattmottle.workinprocess.models.Job;

@Repository
public interface JobRepository extends CrudRepository <Job, Long> {
	List<Job> findAll();
}
