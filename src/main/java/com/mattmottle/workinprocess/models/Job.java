package com.mattmottle.workinprocess.models;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

@Entity
@Table(name="jobs")
public class Job {
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(updatable=false)
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date createdAt;

	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date updatedAt;
	
	@PrePersist
	 protected void onCreate(){
		 this.createdAt = new Date();
	    }
	@PreUpdate
	protected void onUpdate(){
		this.updatedAt = new Date();
	    }
	@NotEmpty(message="Please enter a name of the job.")
	@Size(min=4, max=255, message="Name of job must be 4-255 charcters.")
	private String name;
	
	@Min(value=1, message="Budget must be higher than 0.")
	@NotNull(message="Budget must not be empty!")
	private Double maxBudget;
	
	@NotNull(message="Must choose whether bid was accepted.")
	private Boolean isBidAccepted;
	
	@NotEmpty(message="Please describe the job.")
	private String description;
	
	@ManyToOne(fetch= FetchType.LAZY)
	@JoinColumn(name="user_id")
	private User jobCreator;
	
	@OneToMany(mappedBy="jobWithBids", fetch=FetchType.LAZY)
	private List<Bid> allBids;

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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Double getMaxBudget() {
		return maxBudget;
	}
	public void setMaxBudget(Double maxBudget) {
		this.maxBudget = maxBudget;
	}
	public Boolean getIsBidAccepted() {
		return isBidAccepted;
	}
	public void setIsBidAccepted(Boolean isBidAccepted) {
		this.isBidAccepted = isBidAccepted;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public User getJobCreator() {
		return jobCreator;
	}
	public void setJobCreator(User jobCreator) {
		this.jobCreator = jobCreator;
	}
	public List<Bid> getAllBids() {
		return allBids;
	}
	public void setAllBids(List<Bid> allBids) {
		this.allBids = allBids;
	}
	
}

