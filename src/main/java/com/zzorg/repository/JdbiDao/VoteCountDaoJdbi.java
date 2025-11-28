package com.zzorg.repository.JdbiDao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jdbi.v3.core.Jdbi;

import com.zzorg.model.Option;
import com.zzorg.model.Survey;
import com.zzorg.model.VoteCount;
import com.zzorg.repository.VoteCountRepository;
import com.zzorg.repository.JdbiDao.rowMapper.OptionRowMapper;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class VoteCountDaoJdbi implements VoteCountRepository{

	final private Jdbi jdbi;
	@Override
	public List<VoteCount> findBySurveyId(int id) {
		// TODO Auto-generated method stub
		
		Map< Integer, Survey> surveys = new HashMap<Integer, Survey>();
		
		return jdbi.withHandle(h -> 
			h.createQuery("""
					SELECT
						o.id AS option_id,
						o.title AS option_title,
						o.survey_id AS option_survey_id,
						o.created_at AS option_created_at,
						o.updated_at AS option_updated_at,
						COUNT(v.id) AS vote_count
					FROM options o
					LEFT JOIN votes v ON v.option_id = o.id
					WHERE o.survey_id = :id
					GROUP BY o.id, o.title, o.survey_id, o.created_at, o.updated_at
					ORDER BY o.id
					""")
			.bind("id", id)
			.registerRowMapper(Option.class, new OptionRowMapper())
			.reduceRows(new HashMap<Integer, VoteCount>(), (map, rowView) -> {
				
				VoteCount votecount = new VoteCount();
				Integer count = rowView.getColumn("vote_count", Integer.class);
				Option o = rowView.getRow(Option.class);
				
				Integer surveyId = rowView.getColumn("option_survey_id", Integer.class);
				
				surveys.computeIfAbsent(surveyId, sid -> {				
					return Survey.builder().id(surveyId).build();
				});
				
				votecount.setCount(count);
				votecount.setOption(o);
				map.put(o.getId(), votecount);
				
				return map;
			}).values().stream().toList()
				);
	}

}
