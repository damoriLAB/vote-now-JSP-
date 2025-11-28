package com.zzorg.web.api.controller;



import java.util.List;

import com.zzorg.AppContext;
import com.zzorg.model.Vote;
import com.zzorg.repository.VoteRepository;
import com.zzorg.web.dto.VotesListResponse;

import jakarta.ws.rs.DefaultValue;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.QueryParam;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;


@Path("/votes")
public class VoteController {
	

	private VoteRepository voteRepository = AppContext.daoFactory().voteRepository();


	@Path("/survey/{id}")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public Response getVotesBySurvey(
			@PathParam("id") int surveyID, 
			@QueryParam("page") @DefaultValue("1") int page,
			@QueryParam("limit") @DefaultValue("5") int limit
			) {
		
		int offset = (page - 1) * limit;
		
		List<Vote> data = voteRepository.findBySurveyId(surveyID, offset, limit);
		
		boolean isLastPage = (data.size() < limit) ? true : false;
		
		VotesListResponse response = VotesListResponse.builder()
				.current_page(page)
				.limit(limit)
				.next(null)
				.data(data)
				.next(((!isLastPage) ? "/votes/survey/"+surveyID+"?page=" + (page + 1) + "&limit=" +limit : null))
				.prev((page > 1) ? "/votes/survey/"+surveyID+"?page=" + (page - 1) + "&limit=" +limit : null)
				.build();


		return Response.ok(response).build();
	}
	
	
	@Path("/user/{id}")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public Response getLatestVotesOfUser(
			@PathParam("id") int userID, 
			@QueryParam("page") @DefaultValue("1") int page,
			@QueryParam("limit") @DefaultValue("5") int limit
			) {
		
		
		
	int offset = (page - 1) * limit;
		
		List<Vote> data = voteRepository.findByUserId(userID, offset, limit);
		
		boolean isLastPage = (data.size() < limit) ? true : false;
		
		VotesListResponse response = VotesListResponse.builder()
				.current_page(page)
				.limit(limit)
				.next(null)
				.data(data)
				.next(((!isLastPage) ? "/votes/survey/"+userID+"?page=" + (page + 1) + "&limit=" +limit : null))
				.prev((page > 1) ? "/votes/survey/"+userID+"?page=" + (page - 1) + "&limit=" +limit : null)
				.build();


		return Response.ok(response).build();
		

	}
	
}
