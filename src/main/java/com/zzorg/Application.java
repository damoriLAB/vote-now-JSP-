package com.zzorg;

import org.jdbi.v3.core.Jdbi;

import com.zzorg.config.DaoFactory;
import com.zzorg.config.Database;
import com.zzorg.config.FlywayMigration;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;


// switch system.out to logger SL4J
@WebListener
public class Application implements ServletContextListener{
	
	
	@Override
	public void contextInitialized(ServletContextEvent sce) {
		
		
		Jdbi Jdbi = Database.getJDBI();

		

		
		FlywayMigration.migrate();
		
		DaoFactory daoFactory = new DaoFactory(Jdbi);
		AppContext.setJdbi(Jdbi);
		AppContext.setDaoFactory(daoFactory);
		
		
	}
}
