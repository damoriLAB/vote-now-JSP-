package com.zzorg.config;

import javax.sql.DataSource;

import org.flywaydb.core.Flyway;

public class FlywayMigration {

	static private final DataSource ds = Database.getDataSource();
	
	public static void migrate() {
		
		Flyway flyway = Flyway.configure().dataSource(ds).load();
		
		flyway.migrate();
		System.out.println("Database Migrate ON");
		
	}
}
