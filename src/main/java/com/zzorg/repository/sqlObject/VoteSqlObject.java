package com.zzorg.repository.sqlObject;

import java.util.List;

import org.jdbi.v3.sqlobject.config.RegisterBeanMapper;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.statement.SqlQuery;

import com.zzorg.model.Vote;
import com.zzorg.model.VoteCount;

@RegisterBeanMapper(Vote.class)
@RegisterBeanMapper(VoteCount.class)
public interface VoteSqlObject {

	@SqlQuery("""
			    SELECT o.id AS option_id, o.title AS option_title, COUNT(v.id) AS count
			    FROM options o
			    LEFT JOIN votes v ON v.option_id = o.id
			    WHERE o.id = :id
			    GROUP BY o.id, o.title
			""")
	VoteCount getVoteByOptionId(@Bind("id") int id);
	
	@SqlQuery("SELECT * FROM votes WHERE survey_id = :id LIMIT :limit OFFSET :offset")
	List<Vote> getLatestVotesBySurveyId(@Bind("id") int id, @Bind("limit") int limit, @Bind("offset") int offset);
	
	@SqlQuery("SELECT * FROM votes WHERE user_id = :id LIMIT :limit OFFSET :offset")
	List<Vote> getLatestVotesByUserId(@Bind("id") int id, @Bind("limit") int limit, @Bind("offset") int offset);
}
