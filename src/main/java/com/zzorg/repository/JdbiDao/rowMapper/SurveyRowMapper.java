package com.zzorg.repository.JdbiDao.rowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;
import com.zzorg.model.Survey;
import com.zzorg.model.SurveyStatus;

public class SurveyRowMapper implements RowMapper<Survey>{

	@Override
	public Survey map(ResultSet rs, StatementContext ctx) throws SQLException {
		
		return Survey.builder()
				.id(rs.getInt("survey_id"))
				.title(rs.getString("survey_title"))
				.description(rs.getString("survey_description"))
				.status(SurveyStatus.valueOf(rs.getString("survey_status")))
				.createdAt(rs.getTimestamp("survey_created_at").toLocalDateTime())
				.updatedAt(rs.getTimestamp("survey_updated_at").toLocalDateTime())
				.build();
	}

}
