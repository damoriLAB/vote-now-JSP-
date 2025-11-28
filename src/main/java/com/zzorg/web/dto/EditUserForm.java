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
public class EditUserForm {

	
	private String iconURL,name,username, email;
	private List<String> errors = new ArrayList<String>();
	
	public EditUserForm(ServletRequest req) {
		iconURL = req.getParameter("iconURL");
		name = req.getParameter("name");
		username = req.getParameter("username");
		email = req.getParameter("email");
	}
	
	private void blankFields() {

		if(name == null || name.isBlank()) errors.add("name is blank");
		if(username == null || username.isBlank()) errors.add("username is blank");
		if(email == null || email.isBlank()) errors.add("email is blank");
	}
	
	public boolean validate() {
		blankFields();
		return errors.isEmpty();
	}
	
}
