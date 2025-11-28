package com.zzorg.config;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.sqlobject.SqlObjectPlugin;

import com.zzorg.exception.DatabaseException;

// TODO : set up exceptions
//TODO : remover o sout

public class Database {
	private static Context ctx;
	private static DataSource ds;
	private static Jdbi jdbi;

	public static Jdbi getJDBI() {
		try {
			if (jdbi == null) {
				
				ds = getDataSource();

				jdbi = Jdbi.create(ds);
				jdbi.installPlugin(new SqlObjectPlugin());
				System.out.println("JDBI CREATED");
			}
			return jdbi;

		} catch (DatabaseException e) {
			System.out.println(e.getMessage());
			throw new DatabaseException(e.getMessage());
		}
	}

	public static Context getContext() {
		try {
			if(ctx == null) {
				ctx = new InitialContext();
			}
			return ctx;
		} catch (NamingException e) {
			throw new DatabaseException(e.getMessage());
		}
	}
	
	public static DataSource getDataSource() {
		try {
			if(ds == null) {
				ds = (DataSource ) getContext().lookup("java:/comp/env/jdbc/postgres");
			}
			return ds;
		} catch (NamingException e) {
			throw new DatabaseException(e.getMessage());
		}
	}

}


