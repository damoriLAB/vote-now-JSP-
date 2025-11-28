package com.zzorg.web;
import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


public class AuthFilter implements Filter{
	
	@Override
	public void doFilter(ServletRequest req, ServletResponse res,FilterChain chain) throws IOException, ServletException {
		// TODO: create filter
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) res;
		
		HttpSession session = request.getSession(false);
		Object user = (session != null) ? session.getAttribute("LoggedUser") : null;
		if(user == null) {
			response.sendRedirect(request.getContextPath()+"/auth/login.jsp");
		} else {
			request.setAttribute("userLogged", user);
			chain.doFilter(req, res);
		}
	}
	
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void destroy() {}

}
