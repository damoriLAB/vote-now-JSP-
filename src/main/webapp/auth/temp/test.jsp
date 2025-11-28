<%@page import="com.zzorg.repository.sqlObject.SurveySqlObject"%>
<%@page import="com.zzorg.model.Survey"%>
<%@page import="com.zzorg.repository.sqlObject.UserSqlObject"%>
<%@page import="com.zzorg.model.User"%>
<%@page import="java.util.List"%>
<%@page import="com.zzorg.config.Database"%>
<%@page import="org.jdbi.v3.core.Jdbi"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    Jdbi jdbi = Database.getJDBI();


      UserSqlObjectry dao = jdbi.onDemanUserSqlObjectry.class);

        List<User> users = dao.getAll();

        request.setAttribute("users", users);


        List<Survey> latestUserSurveys = Database.getJDBI().onDemand(SurveySqlObject.class).latestSurveys(10, 0);
        request.setAttribute("latestUserSurveys", latestUserSurveys);
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="module" src="${pageContext.request.contextPath}/static/js/main.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/dist.css">
</head>
<body>

	<jsp:include page="/WEB-INF/jsp/components/surveyList.jsp"></jsp:include>
	
	<div id="seila" ></div>
	

	
</body>
</html>