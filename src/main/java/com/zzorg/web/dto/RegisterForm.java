package com.zzorg.web.dto;

import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletRequest;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class RegisterForm {
	
	private String name, username, email, password;
	private List<String> errors = new ArrayList<String>();
	
	public RegisterForm(ServletRequest req) {
		name = req.getParameter("name");
		username = req.getParameter("username");
		email =	req.getParameter("email");
		password = req.getParameter("password");
	}
	
	private void blankFields() {
		if(name == null || name.isBlank()) errors.add("name is blank");
		if(username == null || username.isBlank()) errors.add("username is blank");
		if(email == null || email.isBlank()) errors.add("email is blank");
		if(password == null || password.isBlank()) errors.add("password is blank");
	}
	
	public boolean validate() {
		blankFields();
		return errors.isEmpty();
	}

}
