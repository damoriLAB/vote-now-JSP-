package com.zzorg.repository.sqlObject;
import java.util.List;
import java.util.Optional;

import org.jdbi.v3.sqlobject.config.RegisterBeanMapper;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.customizer.BindBean;
import org.jdbi.v3.sqlobject.statement.GetGeneratedKeys;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;

import com.zzorg.model.User;


@RegisterBeanMapper(User.class)
public interface UserSqlObject {
	
	@SqlUpdate("INSERT INTO users (name, username, email, password) VALUES (:name, :username, :email, :password)")
	@GetGeneratedKeys
	int insert(@BindBean User user);
	
	@SqlUpdate(" UPDATE users "
			+ "SET icon_url = :iconURL, "
			+ "username = :username, "
			+ "name = :name, "
			+ "email = :email, "
			+ "password = :password "
			+ "WHERE id = :id")
	int update(@BindBean User user);
	
	@SqlQuery("SELECT * FROM users WHERE id = :id")
	Optional<User> findById(@Bind("id") int id);
	
	@SqlQuery("SELECT * FROM users WHERE email = :email")
	Optional<User> findByEmail(@Bind("email") String email);
	
	@SqlQuery("SELECT * FROM users WHERE username = :username")
	Optional<User> findByUsername(@Bind("username") String username);
	
	@SqlQuery("SELECT * FROM users")
	List<User> getAll();
	
	@SqlQuery("SELECT * FROM users WHERE email = :email AND password = :password")
	Optional<User> findByEmailAndPassword(@Bind("email") String email,@Bind("password") String password);
}
