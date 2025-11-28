<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bad Request - Not Found</title>
</head>
<body>
<h1>Error 404</h1>
<p>${empty requestScope['jakarta.servlet.error.message'] ? 'Recurso não encontrado' : requestScope['jakarta.servlet.error.message']}</p>
<p>
</body>
</html>