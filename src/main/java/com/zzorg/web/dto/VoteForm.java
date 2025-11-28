package com.zzorg.web.dto;

import java.util.ArrayList;
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
public class VoteForm {

	private Integer selectedOption;
	private List<String> errors = new ArrayList<String>();
	
	public VoteForm(ServletRequest req) {
		
		String[] checkMultipleOptions = req.getParameterValues("selectedOption");
		if(checkMultipleOptions == null) {
			errors.add("None option selected");
			return;
		}
		if(checkMultipleOptions.length > 1) errors.add("More than 1 options selected");
		if(checkMultipleOptions.length < 1) errors.add("None option selected");
		
		try {
			selectedOption = Integer.parseInt(checkMultipleOptions[0]);
		} catch (NumberFormatException e) {
			errors.add("Invalid option");
		}
		
	}
	
	public boolean validate() {
		return errors.isEmpty();
	}
}
