package com.zzorg.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class VoteCount {
	/*
	 * 
	 * Option option
	 * integer count
	 * 
	 */
	private Option option;
	private Integer count;
}
