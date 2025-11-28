package com.zzorg.config;

import org.jdbi.v3.core.Jdbi;

import com.zzorg.repository.OptionRepository;
import com.zzorg.repository.SurveyRepository;
import com.zzorg.repository.UserRepository;
import com.zzorg.repository.VoteCountRepository;
import com.zzorg.repository.VoteRepository;
import com.zzorg.repository.JdbiDao.OptionDaoJdbi;
import com.zzorg.repository.JdbiDao.SurveyDaoJdbi;
import com.zzorg.repository.JdbiDao.UserDaoJdbi;
import com.zzorg.repository.JdbiDao.VoteCountDaoJdbi;
import com.zzorg.repository.JdbiDao.VoteDaoJdbi;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class DaoFactory {

	private final Jdbi jdbi;

	private UserRepository userRepository;
	private SurveyRepository surveyRepository;
	private VoteRepository voteRepository;
	private OptionRepository optionRepository;
	private VoteCountRepository voteCountRepository;

	public UserRepository userRepository() {
		if (userRepository == null)
			userRepository = new UserDaoJdbi(jdbi);

		return userRepository;
	}

	public SurveyRepository surveyRepository() {
		if (surveyRepository == null)
			surveyRepository = new SurveyDaoJdbi(jdbi);
		return surveyRepository;
	}
	
	public OptionRepository optionRepository() {
		if(optionRepository == null) optionRepository = new OptionDaoJdbi(jdbi);
		return optionRepository;
	}
	
	public VoteRepository voteRepository() {
		if(voteRepository == null) voteRepository = new VoteDaoJdbi(jdbi);
		return voteRepository;
	}
	
	public VoteCountRepository voteCountRepository() {
		if(voteCountRepository == null) voteCountRepository = new VoteCountDaoJdbi(jdbi);
		return voteCountRepository;
	}


}
