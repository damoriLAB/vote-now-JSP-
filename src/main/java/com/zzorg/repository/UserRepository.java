package com.zzorg.repository;


import java.util.List;
import java.util.Optional;

import com.zzorg.model.User;

public interface UserRepository {
	
	int insert(User user);
	
	int update(User user);
	
	
	Optional<User> findById(int id);
	
	Optional<User> findByEmail(String email);
	
	Optional<User> findByUsername(String username);
	
	Optional<User> findByEmailAndPassword(String email, String password);
	
	List<User> findAll(int offset, int limit);

}
