package com.zzorg.repository.JdbiDao.rowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import com.zzorg.model.User;

public class UserRowMapper implements RowMapper<User>{
	
	@Override
	public User map(ResultSet rs, StatementContext ctx) throws SQLException {
		
		
		return User.builder()
				.id(rs.getInt("user_id"))
				.name(rs.getString("user_name"))
				.username(rs.getString("user_username"))
				.email(rs.getString("user_email"))
				.password(rs.getString("user_password"))
				.iconURL(rs.getString("user_icon_url"))
				.createdAt(rs.getTimestamp("user_created_at").toLocalDateTime())
				.updateAt(rs.getTimestamp("user_updated_at").toLocalDateTime())
				.build();
	}

}
