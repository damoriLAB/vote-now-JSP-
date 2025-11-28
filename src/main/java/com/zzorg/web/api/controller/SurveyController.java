package com.zzorg.web.api.controller;


import java.util.List;


import com.zzorg.AppContext;
import com.zzorg.model.Survey;
import com.zzorg.repository.SurveyRepository;

import com.zzorg.web.dto.SurveyListResponse;

import jakarta.ws.rs.DefaultValue;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.QueryParam;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;


@Path("/surveys")
public class SurveyController {

	
	private SurveyRepository surveyRepository = AppContext.daoFactory().surveyRepository();
	
	
	@Path("/user/{id}")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public Response userListSurveys(@PathParam("id") int id, @QueryParam("page") @DefaultValue("1") int page, @QueryParam("limit") @DefaultValue("7") int limit) {
		
		int offset = (page - 1) * limit;
		List<Survey> surveys = surveyRepository.findByUser(id,offset, limit);
		
		
		boolean isLastPage = (surveys.size() < limit) ? true : false;
		
		SurveyListResponse response = SurveyListResponse.builder()
				.current_page(page)
				.limit(limit)
				.next((!isLastPage) ? "/api/surveys/user/"+id+"?page=" + (page + 1) + "&limit=" +limit : null)
				.prev((page > 1) ? "/api/surveys/user/"+id+"?page=" + (page - 1) + "&limit=" +limit : null)
				.data(surveys)
				.build();
		
		
		return Response.ok(response).build();
		
		
	}

	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public Response listSurveys(@QueryParam("page") @DefaultValue("1") int page, @QueryParam("limit") @DefaultValue("7") int limit) {

		int offset = (page - 1) * limit;
		List<Survey> surveys = surveyRepository.findAll(offset, limit) ;
		
		
		boolean isLastPage = (surveys.size() < limit) ? true : false;
		
		SurveyListResponse response = SurveyListResponse.builder()
				.current_page(page)
				.limit(limit)
				.next((!isLastPage) ? "/api/surveys?page=" + (page + 1) + "&limit=" +limit : null)
				.prev((page > 1) ? "/api/surveys?page=" + (page - 1) + "&limit=" +limit : null)
				.data(surveys)
				.build();
		
		
		return Response.ok(response).build();
	}
}
