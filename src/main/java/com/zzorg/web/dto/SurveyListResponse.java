package com.zzorg.web.dto;

import java.util.List;

import com.zzorg.model.Survey;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@Builder
public class SurveyListResponse {

	private int current_page;
	private int limit;
	private List<Survey> data;
	private String next;
	private String prev;
	
}
