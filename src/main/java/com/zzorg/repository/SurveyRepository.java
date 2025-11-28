package com.zzorg.repository;

import java.util.List;
import java.util.Optional;

import com.zzorg.model.Survey;

public interface SurveyRepository {

	int insert(Survey survey);
	
	List<Survey> findAll(int offset, int limit);
	
	List<Survey> findByUser(int id, int offset, int limit);
	
	Optional<Survey> findById(int id);
	
	void deleteById(int id);
	
}
