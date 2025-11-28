<%@page import="java.util.ArrayList"%>
<%@page import="com.zzorg.repository.sqlObject.SurveySqlObject"%>
<%@page import="com.zzorg.config.Database"%>
<%@page import="com.zzorg.model.Survey"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%
// é de user ? ou geral ?
//funçao para apagar tudo --> 

List<Survey> latestUserSurveys = Database.getJDBI().onDemand(SurveySqlObject.class).latestSurveys(10, 0);
%>



<div id="id_da_div">

	<c:forEach var="srv" items="${latestSurveys}">

		<p> title : ${srv.title} sds </p>

	</c:forEach>


</div>

<script defer>
	// alert(22);
</script>


