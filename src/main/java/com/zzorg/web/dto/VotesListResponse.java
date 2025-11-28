package com.zzorg.web.dto;

import java.util.List;


import com.zzorg.model.Vote;

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
public class VotesListResponse {

	private int current_page;
	private int limit;
	private List<Vote> data;
	private String next;
	private String prev;
}
