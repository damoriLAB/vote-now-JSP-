package com.zzorg.repository.JdbiDao;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Optional;

import org.jdbi.v3.core.Jdbi;

import com.zzorg.model.Option;
import com.zzorg.model.Survey;
import com.zzorg.model.SurveyStatus;
import com.zzorg.model.User;
import com.zzorg.repository.SurveyRepository;
import com.zzorg.repository.JdbiDao.rowMapper.OptionRowMapper;
import com.zzorg.repository.JdbiDao.rowMapper.SurveyRowMapper;
import com.zzorg.repository.JdbiDao.rowMapper.UserRowMapper;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class SurveyDaoJdbi implements SurveyRepository {

	private final Jdbi jdbi;
	
	@Override
	public int insert(Survey s) {
		
		return jdbi.withHandle(handle -> 
			handle.createUpdate("""
					INSERT INTO surveys (title, description, status, user_id) 
					VALUES (:title, :description, :status, :user_id)
					""")
					.bind("title", s.getTitle())
					.bind("description", s.getDescription())
					.bind("status", SurveyStatus.OPEN)
					.bind("user_id", s.getUser().getId())
					.executeAndReturnGeneratedKeys("id").mapTo(Integer.class).one()
				);
		
	}
	
	@Override
	public List<Survey> findAll(int offset, int limit) {
		return jdbi.withHandle(h ->

		h.createQuery("""
				            WITH paginated_surveys AS (
						    SELECT id
						    FROM surveys
						    ORDER BY created_at DESC
						    LIMIT :limit
						    OFFSET :offset
							)
							SELECT
							    s.id as survey_id,
							    s.title as survey_title,
							    s.description as survey_description,
							    s.status as survey_status,
							    s.user_id as survey_user_id,
							    s.created_at as survey_created_at,
							    s.updated_at as survey_updated_at,
							    u.id as user_id,
							    u.name as user_name,
							    u.username as user_username,
							    u.password as user_password,
							    u.email as user_email,
							    u.icon_url as user_icon_url,
							    u.created_at as user_created_at,
							    u.updated_at as user_updated_at,
							    o.id as option_id,
							    o.title as option_title,
							    o.survey_id as option_survey_id,
							    o.created_at as option_created_at,
							    o.updated_at as option_updated_at
							FROM paginated_surveys ps
							JOIN surveys s ON s.id = ps.id
							JOIN users u ON u.id = s.user_id
							LEFT JOIN options o ON o.survey_id = s.id
							ORDER BY s.created_at DESC;
		         
		""")
		.bind("limit", limit)
		.bind("offset", offset)
		.registerRowMapper(Option.class, new OptionRowMapper())
		.registerRowMapper(User.class, new UserRowMapper())
		.registerRowMapper(Survey.class, new SurveyRowMapper())
		.reduceRows(new LinkedHashMap<Integer, Survey>(), (map, rowView) -> {

			Survey s = rowView.getRow(Survey.class);
			User u = rowView.getRow(User.class);
			Option o = null;

			if (rowView.getColumn("option_id", Integer.class) != null) {
				o = rowView.getRow(Option.class);
			}

			Survey existing = map.computeIfAbsent(s.getId(), txt -> {
				s.setUser(u);
				s.setOptions(new ArrayList<>());
				return s;
			});

			if (o != null) {
				existing.getOptions().add(o);
				o.setSurvey(s);
			}

			return map;
		}).values().stream().toList());
	}

	@Override
	public List<Survey> findByUser(int id,int offset, int limit) {

		return jdbi.withHandle(h ->

				h.createQuery("""
				            WITH paginated_surveys AS (
						    SELECT id
						    FROM surveys
						    WHERE user_id = :id
						    ORDER BY created_at DESC
						    LIMIT :limit
						    OFFSET :offset
							)
							SELECT
							    s.id as survey_id,
							    s.title as survey_title,
							    s.description as survey_description,
							    s.status as survey_status,
							    s.user_id as survey_user_id,
							    s.created_at as survey_created_at,
							    s.updated_at as survey_updated_at,
							    u.id as user_id,
							    u.name as user_name,
							    u.username as user_username,
							    u.password as user_password,
							    u.email as user_email,
							    u.icon_url as user_icon_url,
							    u.created_at as user_created_at,
							    u.updated_at as user_updated_at,
							    o.id as option_id,
							    o.title as option_title,
							    o.survey_id as option_survey_id,
							    o.created_at as option_created_at,
							    o.updated_at as option_updated_at
							FROM paginated_surveys ps
							JOIN surveys s ON s.id = ps.id
							JOIN users u ON u.id = s.user_id
							LEFT JOIN options o ON o.survey_id = s.id
							ORDER BY s.created_at DESC;
				""")
				.bind("id", id)
				.bind("limit", limit)
				.bind("offset", offset)
				.registerRowMapper(Option.class, new OptionRowMapper())
				.registerRowMapper(User.class, new UserRowMapper())
				.registerRowMapper(Survey.class, new SurveyRowMapper())
				.reduceRows(new LinkedHashMap<Integer, Survey>(), (map, rowView) -> {

					Survey s = rowView.getRow(Survey.class);
					User u = rowView.getRow(User.class);
					Option o = null;

					if (rowView.getColumn("option_id", Integer.class) != null) {
						o = rowView.getRow(Option.class);
					}

					Survey existing = map.computeIfAbsent(s.getId(), txt -> {
						s.setUser(u);
						s.setOptions(new ArrayList<>());
						return s;
					});

					if (o != null) {
						existing.getOptions().add(o);
						o.setSurvey(s);
					}

					return map;
				}).values().stream().toList());

		// return Optional.empty();
	}

	@Override
	public Optional<Survey> findById(int id) {
		return jdbi.withHandle(h ->

		h.createQuery("""
				              SELECT
				             s.id as survey_id,
				             s.title as survey_title,
				             s.description as survey_description ,
				             s.status as survey_status,
				             s.user_id as survey_user_id,
				             s.created_at as survey_created_at,
				             s.updated_at as survey_updated_at,
				             u.id as user_id,
				             u.name as user_name,
				             u.username as user_username,
				             u.password as user_password,
				             u.email as user_email,
				             u.icon_url as user_icon_url,
				             u.created_at as user_created_at,
				             u.updated_at as user_updated_at,
				             o.id as option_id,
				             o.title as option_title,
				             o.survey_id as option_survey_id,
				             o.created_at as option_created_at,
				             o.updated_at as option_updated_at
				         FROM surveys s
				         JOIN users u ON u.id = s.user_id
				         LEFT JOIN options o ON o.survey_id = s.id
				         WHERE s.id = :id
				""").bind("id", id).registerRowMapper(Option.class, new OptionRowMapper())
				.registerRowMapper(User.class, new UserRowMapper())
				.registerRowMapper(Survey.class, new SurveyRowMapper())
				.reduceRows(new LinkedHashMap<Integer, Survey>(), (map, rowView) -> {

					Survey s = rowView.getRow(Survey.class);
					User u = rowView.getRow(User.class);
					Option o = null;

					if (rowView.getColumn("option_id", Integer.class) != null) {
						o = rowView.getRow(Option.class);
					}

					Survey existing = map.computeIfAbsent(s.getId(), txt -> {
						s.setUser(u);
						s.setOptions(new ArrayList<>());
						return s;
					});

					if (o != null) {
						existing.getOptions().add(o);
						o.setSurvey(s);
					}

					return map;
				}).values().stream().findFirst());

		// return Optional.empty();
	}

	@Override
	public void deleteById(int id) {
		// TODO Auto-generated method stub

	}

}
