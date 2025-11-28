package com.zzorg.web.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import lombok.Getter;
import lombok.Setter;


@Setter
@Getter
public class RequestForm {

	private Map<String, String> fields = new HashMap<String, String>();
	private List<String> errors = new ArrayList<String>();
	
	
	public void addField(String field, String value) {
		fields.put(field, value);
	}
	
	public List<String> anyFieldBlank(){
		List<String> errors = new ArrayList<String>();
		
		for(String field : fields.keySet()) {
			if(fields.get(field).isBlank()) errors.add(field + " vazio");
		}
		
		this.errors.addAll(errors);
		return errors;
	}
	
	public void addError(String name) {
		errors.add(name);
	}
	
	public String getField(String name) {
		return fields.get(name);
	}
}
