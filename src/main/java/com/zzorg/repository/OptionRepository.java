package com.zzorg.repository;

import java.util.List;
import java.util.Optional;

import com.zzorg.model.Option;

public interface OptionRepository {
	
	int insert(Option option);
	
	List<Option> findBySurveyId(int id);
	
	Optional<Option> findByid(int id);
	
}
