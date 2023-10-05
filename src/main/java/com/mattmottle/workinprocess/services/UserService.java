package com.mattmottle.workinprocess.services;

import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.mattmottle.workinprocess.models.LoginUser;
import com.mattmottle.workinprocess.models.User;
import com.mattmottle.workinprocess.repositories.UserRepository;

@Service
public class UserService {
	@Autowired
	private UserRepository userRepository;
	
	public User register(User newUser, BindingResult result) {
		Optional<User> potentialUser = userRepository.findByEmail(newUser.getEmail());
		if(potentialUser.isPresent()) {
			result.rejectValue("email", "exists", "The email is already in use.");
		}
		if(!newUser.getPassword().equals(newUser.getConfirmedPassword()) ) {
			result.rejectValue("password","passwordsDisagree.registerUser.password", "The passwords must match");
		}
		if(result.hasErrors()) {
			return null;
		} else {
			//hashed password
			String hashedPassword = BCrypt.hashpw(newUser.getPassword(), BCrypt.gensalt());
			newUser.setPassword(hashedPassword);
			return userRepository.save(newUser);
		}
	}
	public User login(LoginUser newLoginObject, BindingResult result) {
		Optional<User> foundUser = userRepository.findByEmail(newLoginObject.getLoginEmail());
		if(foundUser.isEmpty()) {
			result.rejectValue("loginEmail", "invalidCredentials.loginUser.loginEmail", "Invalid login credentials");
			return null;
		} else {
			User userFromDB = foundUser.get();
			if(!BCrypt.checkpw(newLoginObject.getLoginPassword(), userFromDB.getPassword())) {
				result.rejectValue("loginEmail", "invalidCredentials.loginUser.loginEmail", "Invalid login credentials");
				return null;
			} else {
				return userFromDB;
			}
		}
	}
	
	public User findById(Long id) {
		Optional<User> optionalUser = userRepository.findById(id);
		if(optionalUser.isPresent()) {
			return optionalUser.get();
		} 
			return null;
	}
}

