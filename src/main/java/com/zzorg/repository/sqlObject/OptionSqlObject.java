package com.zzorg.repository.sqlObject;

import java.util.List;
import java.util.Optional;

import org.jdbi.v3.sqlobject.config.RegisterBeanMapper;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.statement.SqlQuery;

import com.zzorg.model.Option;

@RegisterBeanMapper(Option.class)
public interface OptionSqlObject {

	
	@SqlQuery("SELECT * FROM options WHERE survey_id = :id ORDER BY id")
	List<Option> findBySurveyId(@Bind("id") int id);
	
	@SqlQuery("SELECT * FROM options WHERE id = :id ")
	Optional<Option> findById(@Bind("id") int id);
}
