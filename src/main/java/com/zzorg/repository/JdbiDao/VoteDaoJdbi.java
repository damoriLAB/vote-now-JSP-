package com.zzorg.repository.JdbiDao;

import java.util.HashMap;
import java.util.List;
import java.util.Optional;

import org.jdbi.v3.core.Jdbi;

import com.zzorg.model.Option;
import com.zzorg.model.Survey;
import com.zzorg.model.User;
import com.zzorg.model.Vote;
import com.zzorg.repository.VoteRepository;
import com.zzorg.repository.JdbiDao.rowMapper.OptionRowMapper;
import com.zzorg.repository.JdbiDao.rowMapper.SurveyRowMapper;
import com.zzorg.repository.JdbiDao.rowMapper.UserRowMapper;
import com.zzorg.repository.JdbiDao.rowMapper.VoteRowMapper;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class VoteDaoJdbi implements VoteRepository{

	private final Jdbi jdbi;
	
	@Override
	public int insert(Vote vote) {
		return jdbi.withHandle(h -> 
			h.createUpdate("""
					INSERT INTO votes (user_id, survey_id, option_id) 
					VALUES (:user_id, :survey_id, :option_id)
					""")
			.bind("user_id", vote.getUser().getId())
			.bind("survey_id", vote.getSurvey_id())
			.bind("option_id", vote.getOption().getId())
			.executeAndReturnGeneratedKeys("id").mapTo(Integer.class).one());
	}

	@Override
	public int update(Vote vote) {
		return jdbi.withHandle(h -> 
			h.createUpdate("""
					UPDATE votes
					SET
						option_id = :option_id,
						updated_at = NOW()
					WHERE id = :id
					""")
			.bind("option_id", vote.getOption().getId())
			.bind("id", vote.getId())
			.execute()
				);
	}
	
	

	@Override
	public List<Vote> findBySurveyId(int id, int offset, int limit) {
		return jdbi.withHandle(h -> 
			h.createQuery("""
					SELECT
						v.id AS vote_id,
						v.user_id AS vote_user_id,
						v.survey_id As vote_survey_id,
						v.option_id AS vote_option_id,
						v.created_at AS vote_created_at,
						v.updated_at AS vote_updated_at,
						u.id AS user_id,
						u.name AS user_name,
						u.username AS user_username,
						u.password AS user_password,
						u.email AS user_email,
						u.icon_url AS user_icon_url,
						u.created_at AS user_created_at,
						u.updated_at AS user_updated_at,
						o.id AS option_id,
						o.title AS option_title,
						o.survey_id AS option_survey_id,
						o.created_at AS option_created_at,
						o.updated_at AS option_updated_at,
						s.id as survey_id,
					    s.title as survey_title,
					    s.description as survey_description,
					    s.status as survey_status,
					    s.user_id as survey_user_id,
					    s.created_at as survey_created_at,
					    s.updated_at as survey_updated_at
					FROM votes v
					JOIN users u ON v.user_id = u.id
					JOIN options o ON o.id = v.option_id
					JOIN surveys s ON s.id = v.survey_id
					WHERE v.survey_id = :id
					ORDER BY v.created_at DESC
					LIMIT :limit
					OFFSET :offset
					""")
			.bind("id", id)
			.bind("limit", limit)
			.bind("offset", offset)
			.registerRowMapper(User.class, new UserRowMapper())
			.registerRowMapper(Option.class, new OptionRowMapper())
			.registerRowMapper(Vote.class, new VoteRowMapper())
			.registerRowMapper(Survey.class, new SurveyRowMapper())
			.reduceRows(new HashMap<Integer, Vote>(), (map , rowView) -> {
				
				Option o = rowView.getRow(Option.class);
				Vote v = rowView.getRow(Vote.class);
				User u = rowView.getRow(User.class);
				Survey s = rowView.getRow(Survey.class);
				
				
				v.setOption(o);
				v.setUser(u);
				v.setSurvey(s);
				map.put(v.getId(), v);
				return map;
				
			}).values().stream().toList()
				);
	}

	@Override
	public List<Vote> findByUserId(int id, int offset, int limit) {	
		
		return jdbi.withHandle(h -> 
		h.createQuery("""
				SELECT
					v.id AS vote_id,
					v.user_id AS vote_user_id,
					v.survey_id As vote_survey_id,
					v.option_id AS vote_option_id,
					v.created_at AS vote_created_at,
					v.updated_at AS vote_updated_at,
					u.id AS user_id,
					u.name AS user_name,
					u.username AS user_username,
					u.password AS user_password,
					u.email AS user_email,
					u.icon_url AS user_icon_url,
					u.created_at AS user_created_at,
					u.updated_at AS user_updated_at,
					o.id AS option_id,
					o.title AS option_title,
					o.survey_id AS option_survey_id,
					o.created_at AS option_created_at,
					o.updated_at AS option_updated_at,
					s.id as survey_id,
				    s.title as survey_title,
				    s.description as survey_description,
				    s.status as survey_status,
				    s.user_id as survey_user_id,
				    s.created_at as survey_created_at,
				    s.updated_at as survey_updated_at
				FROM votes v
				JOIN users u ON v.user_id = u.id
				JOIN options o ON o.id = v.option_id
				JOIN surveys s ON s.id = v.survey_id
				WHERE v.user_id = :id
				ORDER BY v.created_at DESC
				LIMIT :limit
				OFFSET :offset
				""")
		.bind("id", id)
		.bind("limit", limit)
		.bind("offset", offset)
		.registerRowMapper(User.class, new UserRowMapper())
		.registerRowMapper(Option.class, new OptionRowMapper())
		.registerRowMapper(Vote.class, new VoteRowMapper())
		.registerRowMapper(Survey.class, new SurveyRowMapper())
		.reduceRows(new HashMap<Integer, Vote>(), (map , rowView) -> {
			
			User u = rowView.getRow(User.class);
			Option o = rowView.getRow(Option.class);
			Vote v = rowView.getRow(Vote.class);
			Survey s = rowView.getRow(Survey.class);
			
			v.setUser(u);
			v.setOption(o);
			v.setSurvey(s);
			map.put(v.getId(), v);
			return map;
			
		}).values().stream().toList()
			);
	}

	@Override
	public Optional<Vote> findByUserAndSurvey(int userId, int surveyId) {
		return jdbi.withHandle(h -> 
		h.createQuery("""
				SELECT
					v.id AS vote_id,
					v.user_id AS vote_user_id,
					v.survey_id As vote_survey_id,
					v.option_id AS vote_option_id,
					v.created_at AS vote_created_at,
					v.updated_at AS vote_updated_at,
					u.id AS user_id,
					u.name AS user_name,
					u.username AS user_username,
					u.password AS user_password,
					u.email AS user_email,
					u.icon_url AS user_icon_url,
					u.created_at AS user_created_at,
					u.updated_at AS user_updated_at,
					o.id AS option_id,
					o.title AS option_title,
					o.survey_id AS option_survey_id,
					o.created_at AS option_created_at,
					o.updated_at AS option_updated_at
				FROM votes v
				JOIN users u ON v.user_id = u.id
				JOIN options o ON o.id = v.option_id
				WHERE v.user_id = :userId AND v.survey_id = :surveyId
				""")
		.bind("userId", userId)
		.bind("surveyId", surveyId)
		.registerRowMapper(User.class, new UserRowMapper())
		.registerRowMapper(Option.class, new OptionRowMapper())
		.registerRowMapper(Vote.class, new VoteRowMapper())
		.reduceRows(new HashMap<Integer, Vote>(), (map , rowView) -> {
			
			Option o = rowView.getRow(Option.class);
			Vote v = rowView.getRow(Vote.class);
			User u = rowView.getRow(User.class);
			
			v.setUser(u);
			v.setOption(o);
			map.put(v.getId(), v);
			return map;
			
		}).values().stream().findFirst()
			);
	}

}
