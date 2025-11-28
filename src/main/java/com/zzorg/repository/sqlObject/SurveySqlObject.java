package com.zzorg.repository.sqlObject;

import java.util.List;
import java.util.Optional;

import org.jdbi.v3.sqlobject.config.RegisterBeanMapper;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.statement.SqlQuery;

import com.zzorg.model.Survey;

@RegisterBeanMapper(Survey.class)
public interface SurveySqlObject {
	
	@SqlQuery("SELECT * FROM surveys LIMIT :limit OFFSET :offset")
	List<Survey> findAll(@Bind("limit")int limit, @Bind("offset") int offset);
	
	@SqlQuery("SELECT * FROM surveys WHERE id = :id")
	Optional<Survey> findById(@Bind("id") int id);
	
	List<Survey> findByUserId(int id);
	
	@SqlQuery("SELECT * FROM surveys ORDER BY created_at ASC LIMIT :limit OFFSET :offset")
	List<Survey> latestSurveys(@Bind("limit") int limit, @Bind("offset") int offset);
	
	@SqlQuery("SELECT * FROM surveys WHERE user_id = :id ORDER BY created_at ASC LIMIT :limit OFFSET :offset")
	List<Survey> latestSurveysByUserId(@Bind("id") int id, @Bind("limit") int limit, @Bind("offset") int offset);


}
