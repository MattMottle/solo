package com.mattmottle.workinprocess.models;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

@Entity
@Table(name="bids")
public class Bid {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@Column(updatable=false)
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date createdAt;
	
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date updatedAt;
	
	@PrePersist
	protected void onCreate() {
		this.createdAt = new Date();
		this.updatedAt = new Date();
	}
	@PreUpdate
	protected void onUpdate() {
		this.updatedAt = new Date();
	}
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="user_id")
	private User bidder;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="job_id")
	private Job jobWithBids;
	
	@NotNull(message="Please enter a bid amount")
	@Min(value=1, message="Bid amount must be at least 1")
	private Double amount;
	
	@NotEmpty(message="Please bid the job")
	@Size(min=10, message="Bid remarks must be 10 or more characters.")
	private String bidRemarks;
	
	public Bid() {
		
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Date getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}
	public Date getUpdatedAt() {
		return updatedAt;
	}
	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}
	public User getBidder() {
		return bidder;
	}
	public void setBidder(User bidder) {
		this.bidder = bidder;
	}
	public Job getJobWithBids() {
		return jobWithBids;
	}
	public void setJobWithBids(Job jobWithBids) {
		this.jobWithBids = jobWithBids;
	}
	public Double getAmount() {
		return amount;
	}
	public void setAmount(Double amount) {
		this.amount = amount;
	}
	public String getBidRemarks() {
		return bidRemarks;
	}
	public void setBidRemarks(String bidRemarks) {
		this.bidRemarks = bidRemarks;
	}
}
