package com.zzorg.repository.JdbiDao;

import java.util.List;
import java.util.Optional;

import org.jdbi.v3.core.Jdbi;

import com.zzorg.model.Option;
import com.zzorg.repository.OptionRepository;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class OptionDaoJdbi implements OptionRepository{

	private final Jdbi jdbi;
	
	@Override
	public int insert(Option option) {
		return jdbi.withHandle(handle -> 
			handle.createUpdate("""
					INSERT INTO options (title, survey_id)
					VALUES (:title, :survey_id)
					""")
			.bind("title", option.getTitle())
			.bind("survey_id", option.getSurvey().getId())
			.executeAndReturnGeneratedKeys("id").mapTo(Integer.class).one()
				);
	}

	@Override
	public List<Option> findBySurveyId(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Optional<Option> findByid(int id) {
		// TODO Auto-generated method stub
		return Optional.empty();
	}

}
