package com.zzorg.repository;

import java.util.List;

import com.zzorg.model.VoteCount;

public interface VoteCountRepository {

	
	List<VoteCount> findBySurveyId(int id);
}
