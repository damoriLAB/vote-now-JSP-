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
@Getter
@Setter
public class LoginForm {
	
	private String email;
	private String password;
	private List<String> errors = new ArrayList<String>();
	
	public LoginForm(ServletRequest req) {
		email = req.getParameter("email");
		password = req.getParameter("password");
	}

	private void blankFields() {
		if(email == null || email.isBlank()) errors.add("Email is blank");
		if(password == null || password.isBlank()) errors.add("Password is blank");
	}
	
	public boolean validate() {
		blankFields();
		
		return errors.isEmpty();
	}
	
}
