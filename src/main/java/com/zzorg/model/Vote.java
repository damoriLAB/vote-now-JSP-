package com.zzorg.model;
import lombok.Builder;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
public class Vote {

	Integer id;
	Integer survey_id;
	User user;
	Survey survey;
	Option option;
	LocalDateTime createdAt;
	LocalDateTime updatedAt;
}
