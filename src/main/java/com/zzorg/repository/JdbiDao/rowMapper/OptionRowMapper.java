package com.zzorg.repository.JdbiDao.rowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;
import com.zzorg.model.Option;

public class OptionRowMapper implements RowMapper<Option>{

	@Override
	public Option map(ResultSet rs, StatementContext ctx) throws SQLException {

		return Option.builder()
				.id(rs.getInt("option_id"))
				.title(rs.getString("option_title"))
				.createdAt(rs.getTimestamp("option_created_at").toLocalDateTime())
				.updatedAt(rs.getTimestamp("option_updated_at").toLocalDateTime())
				.build();
	}

}
