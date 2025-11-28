package com.zzorg.repository.JdbiDao;

import java.util.List;
import java.util.Optional;

import org.jdbi.v3.core.Jdbi;

import com.zzorg.model.User;
import com.zzorg.repository.UserRepository;
import com.zzorg.repository.JdbiDao.rowMapper.UserRowMapper;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class UserDaoJdbi implements UserRepository {

	private final Jdbi jdbi;

	@Override
	public int insert(User user) {

		return jdbi.withHandle(handle -> handle.createUpdate("""
				INSERT INTO users (name,username,password, email, icon_url)
				VALUES (:name, :username, :password, :email, :iconURL)
				""")
				.bind("name", user.getName())
				.bind("username", user.getUsername())
				.bind("password", user.getPassword())
				.bind("email", user.getEmail())
				.bind("iconURL", user.getIconURL())
				.executeAndReturnGeneratedKeys("id").mapTo(Integer.class).one());

	}

	@Override
	public int update(User user) {
		String sql = """ 
				UPDATE users
				SET
					name = :name,
					username = :username,
					password = :password,
					email = :email,
					icon_url = :iconURL,
					updated_at = NOW()
				WHERE id = :id
				""";
		
		return jdbi.withHandle(handle -> 
					handle.createUpdate(sql)
					.bind("name", user.getName())
					.bind("username", user.getUsername())
					.bind("password", user.getPassword())
					.bind("email", user.getEmail())
					.bind("iconURL", user.getIconURL())
					.bind("id", user.getId())
					.execute()
				);
	}

	@Override
	public Optional<User> findById(int id) {
		return
				jdbi.withHandle(h -> 
					h.createQuery("""
							SELECT 
								id AS user_id, 
								name AS user_name,
								username AS user_username,
								password AS user_password,
								email AS user_email,
								icon_url AS user_icon_url,
								created_at AS user_created_at,
								updated_at AS user_updated_at
							FROM users WHERE id = :id
							""")
					.bind("id", id)
					.map(new UserRowMapper())
					.findOne()
						);
	}

	@Override
	public Optional<User> findByEmail(String email) {
		return 
				jdbi.withHandle(h -> 
					h.createQuery("""
							SELECT 
								id AS user_id, 
								name AS user_name,
								username AS user_username,
								password AS user_password,
								email AS user_email,
								icon_url AS user_icon_url,
								created_at AS user_created_at,
								updated_at AS user_updated_at
							FROM users WHERE email = :email
							""")
					.bind("email", email)
					.map(new UserRowMapper())
					.findOne()
				);
	}

	@Override
	public Optional<User> findByUsername(String username) {
		return 
				jdbi.withHandle(h -> 
					h.createQuery("""
							SELECT 
								id AS user_id, 
								name AS user_name,
								username AS user_username,
								password AS user_password,
								email AS user_email,
								icon_url AS user_icon_url,
								created_at AS user_created_at,
								updated_at AS user_updated_at
							FROM users WHERE username = :username
							""")
					.bind("username", username)
					.map(new UserRowMapper())
					.findOne()				
				);
	}

	@Override
	public Optional<User> findByEmailAndPassword(String email, String password) {
		return 
				jdbi.withHandle(h -> 
					h.createQuery("""
							SELECT 
								id AS user_id, 
								name AS user_name,
								username AS user_username,
								password AS user_password,
								email AS user_email,
								icon_url AS user_icon_url,
								created_at AS user_created_at,
								updated_at AS user_updated_at
							FROM users WHERE email = :email AND password = :password
							""")
					.bind("email", email)
					.bind("password", password)
					.map(new UserRowMapper())
					.findOne()
				);
	}

	@Override
	public List<User> findAll(int page, int limit) {
		// TODO : create findAll()
		return null;
	}

}
