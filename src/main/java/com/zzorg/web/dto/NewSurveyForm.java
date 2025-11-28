package com.zzorg.web.dto;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;


import jakarta.servlet.ServletRequest;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
public class NewSurveyForm {

	String title;
	String description;
	List<String> options;
	List<String> errors = new ArrayList<String>();
	
	public NewSurveyForm(ServletRequest req) {
		title = req.getParameter("title");
		description = req.getParameter("description");
		options = Arrays.asList(req.getParameterValues("options"))
				.stream()
				.distinct()
				.toList();
		
	}
	
	public boolean validate() {
		
		blankFields();
		validateTitle();
		validateOptions();
		return errors.isEmpty();
	}
	
	private void blankFields() {
		if(title == null || title.isBlank()) errors.add("title is blank");
		if(description == null || description.isBlank()) errors.add("description is blank");
	}
	
	private void validateTitle() {
		if(title.length() > 100) errors.add("Title can not have more than 100 characters");
	}
	
	private void validateOptions() {
		
		if(options.isEmpty()) { 
			errors.add("Options is blank");
			return;
		}
		if(options.size() < 2) {
			errors.add("at least 3 options required");
			return;
		}
		
		options.stream().forEach(string -> {
			if(string.isBlank()) errors.add("Option blank");
			if(string.length() > 20) errors.add("Option can not have more than 20 characters");
		});
		
	}
}
