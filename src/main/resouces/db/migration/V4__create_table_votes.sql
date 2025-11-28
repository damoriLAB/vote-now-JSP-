CREATE TABLE votes (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    survey_id INT NOT NULL REFERENCES surveys(id) ON DELETE CASCADE,
    option_id INT NOT NULL REFERENCES options(id) ON DELETE CASCADE,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- um usuário só pode votar uma vez por survey
    CONSTRAINT unique_vote_per_user_survey UNIQUE (user_id, survey_id)
);

CREATE INDEX idx_votes_user ON votes(user_id);
CREATE INDEX idx_votes_survey ON votes(survey_id);
CREATE INDEX idx_votes_option ON votes(option_id);