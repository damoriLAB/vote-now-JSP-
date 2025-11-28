package com.zzorg.exception;

public class NotFoundResource extends RuntimeException{
	
	private static final long serialVersionUID = 1L;

	public NotFoundResource(String msg) {
		super(msg);
	}

}
