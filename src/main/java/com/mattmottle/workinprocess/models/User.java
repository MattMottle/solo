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
import jakarta.persistence.OneToMany;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;

@Entity
@Table(name="users")
public class User {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(updatable=false)
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date createdAt;

	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date updatedAt;
    
    @NotEmpty(message="First name is required!")
    @Size(min=3, max=30, message="First name must be between 2 and 30 characters")
    private String firstName;
    
    @NotEmpty(message="Last name is required!")
    @Size(min=3, max=30, message="Last name must be between 2 and 30 characters")
    private String lastName;
    
    @NotEmpty(message="Location is required!")
    @Size(min=3, max=30, message="Location must be between 2 and 30 characters")
    private String location;
    
    @NotEmpty(message="Email is required!")
    @Email(message="Please enter a valid email!")
    private String email;
    
    @NotEmpty(message="Password is required!")
    @Size(min=8, max=128, message="Password must be between 8 and 128 characters")
    private String password;
    
    @Transient
    @NotEmpty(message="Confirm Password is required!")
    @Size(min=8, max=128, message="Confirm Password must match Password")
    private String confirmedPassword;
    
    @OneToMany(mappedBy="jobCreator", fetch = FetchType.LAZY)
    private List<Job> jobs;
    
    @OneToMany(mappedBy="bidder", fetch=FetchType.LAZY)
    private List<Bid> bids;
    
    @OneToMany(mappedBy="reviewedPerson", fetch=FetchType.LAZY)
    private List<Review> allReviews;
    
    @OneToMany(mappedBy="reviewer", fetch=FetchType.LAZY)
    private List<Review> reviews;

	public User() {}
    
    @PrePersist
	 protected void onCreate(){
		 this.createdAt = new Date();
	    }
	@PreUpdate
	protected void onUpdate(){
		this.updatedAt = new Date();
	    }

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	
	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getConfirmedPassword() {
		return confirmedPassword;
	}

	public void setConfirmedPassword(String confirmedPassword) {
		this.confirmedPassword = confirmedPassword;
	}
	
	public List<Job> getJobs() {
		return jobs;
	}

	public void setJobs(List<Job> jobs) {
		this.jobs = jobs;
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

	public List<Bid> getBids() {
		return bids;
	}

	public void setBids(List<Bid> bids) {
		this.bids = bids;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public List<Review> getReviewedReviews() {
		return allReviews;
	}

	public void setReviewedReviews(List<Review> reviewedReviews) {
		this.allReviews = reviewedReviews;
	}

	public List<Review> getReviews() {
		return reviews;
	}

	public void setReviews(List<Review> reviews) {
		this.reviews = reviews;
	}	
}

