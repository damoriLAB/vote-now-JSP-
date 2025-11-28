package com.zzorg.web.util;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Optional;

import com.zzorg.model.User;

public class RequestUtils {

	public static String requireParam(HttpServletRequest req, HttpServletResponse res, String name) throws IOException {
		String value = req.getParameter(name);
		
		if(value == null || value.isBlank()) {
			res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Param: Blank");
			return null;
		}
		
		return value.trim();
	}
	
	public static int requireIntParam(HttpServletRequest req, HttpServletResponse res, String name) throws IOException {
		String value = requireParam(req, res, name);
		if(value == null) return -1;
		
		try {
			return Integer.parseInt(value);
		} catch (NumberFormatException e) {
			res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Param: "+value);
			return -1;
		}
	}
	
	public static Optional<User> isLogged(HttpServletRequest req, HttpServletResponse res) {
		HttpSession session = req.getSession(false);
		Object user = (session != null) ? session.getAttribute("LoggedUser") : null;
		return (user != null) ? Optional.of((User) user) : Optional.empty();
	}
	
	public static RequestForm validateForm(HttpServletRequest req, HttpServletResponse res, String[] fields) {
		RequestForm form = new RequestForm();
		
		for(String field : fields ) {
			String value = (req.getParameter(field) != null) ? req.getParameter(field) : "";
			form.addField(field, value);
		}
		
		return form;
		
	}
}
