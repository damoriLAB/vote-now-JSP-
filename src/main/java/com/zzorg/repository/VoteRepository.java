package com.zzorg.repository;

import java.util.List;
import java.util.Optional;

import com.zzorg.model.Vote;

public interface VoteRepository {
	
	int insert(Vote vote);
	int update(Vote vote);
	Optional<Vote> findByUserAndSurvey(int userId, int surveyId);
	List<Vote> findBySurveyId(int id, int offset, int limit);
	List<Vote> findByUserId(int id, int offset, int limit);

	
}
