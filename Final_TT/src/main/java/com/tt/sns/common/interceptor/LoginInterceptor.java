package com.tt.sns.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class LoginInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {

		if (request.getRequestURI().contains("signin.do") || //
				request.getRequestURI().contains("signup.do") || //
				request.getRequestURI().contains("signupres.do") || //
				request.getRequestURI().contains("ajaxlogin.do") || //
				request.getRequestURI().contains("idChk.do") || //
				request.getRequestURI().contains("forgot.do")||//
				request.getRequestURI().contains("findaccount.do")||//
				request.getRequestURI().contains("editpwform.do")||//
				request.getRequestURI().contains("editpw.do")||//
				request.getRequestURI().contains("phonechk.do")||//
				request.getRequestURI().contains("relogin.do")||//
				request.getSession().getAttribute("login") != null) {
			return true;
		}
		if (request.getSession().getAttribute("login") == null) {
			response.sendRedirect("signin.do");
			return false;
		}
		return false;

	}

	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {

	}

	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {

	}

}