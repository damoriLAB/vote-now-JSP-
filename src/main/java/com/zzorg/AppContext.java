package com.zzorg;

import org.jdbi.v3.core.Jdbi;

import com.zzorg.config.DaoFactory;


public class AppContext {
	
	static private Jdbi jdbi;
	static private DaoFactory daoFactory;

	
	static public Jdbi jdbi() {
		if(jdbi == null) throw new NullPointerException();
		return jdbi;
	}
	
	static public DaoFactory daoFactory() {
		if(daoFactory == null) throw new NullPointerException();
		return daoFactory;
	} 
	
	
	static protected void setDaoFactory(DaoFactory d) {
		daoFactory = d;
	}
	
	static protected void setJdbi(Jdbi j) {
		jdbi = j;
	}

}
