package servlet;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

//import javax.security.auth.message.callback.PrivateKeyCallback.Request;
//import javax.servlet.http.HttpSession;

@WebFilter(urlPatterns = "/*")
public class WsaFilter implements Filter {

	@Override
	public void destroy() {
		// TODO Auto-generated method stub

	}

	@Override

	public void doFilter(ServletRequest arg0, ServletResponse arg1, FilterChain arg2)
			throws IOException, ServletException {
		// TODO Auto-generated method stub

		// 判断sission
		HttpServletResponse rep = (HttpServletResponse) arg1;
		HttpServletRequest req = (HttpServletRequest) arg0;

		HttpSession session = req.getSession();
		String name = req.getServletPath();

		System.out.println("I'm WsaFilter     path:"+ name);

		if(name.equals("/login.jsp") || name.equals("/user")){
			arg2.doFilter(arg0, arg1);
		}else if((session ==null || session.getAttribute("userId")==null) && (name.indexOf(".jsp")>0)){
			System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@"+req.getServletPath());
			rep.sendRedirect(req.getContextPath()+"/login.jsp");


			//arg2.doFilter(arg0, arg1);
			//return ;
		}else{
			arg2.doFilter(arg0, arg1);
		}


//		System.out.println(req.getServletPath());
//		
//		String token = req.getParameter("token");
		

	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		System.out.println("what?");
	}

}