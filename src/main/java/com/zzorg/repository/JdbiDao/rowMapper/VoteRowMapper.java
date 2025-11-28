package com.zzorg.repository.JdbiDao.rowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import com.zzorg.model.Vote;

public class VoteRowMapper implements RowMapper<Vote>{

	@Override
	public Vote map(ResultSet rs, StatementContext ctx) throws SQLException {
		return Vote.builder()
				.id(rs.getInt("vote_id"))
				.survey_id(rs.getInt("vote_survey_id"))
				.createdAt(rs.getTimestamp("vote_created_at").toLocalDateTime())
				.updatedAt(rs.getTimestamp("vote_updated_at").toLocalDateTime())
				.build();
	}

}
