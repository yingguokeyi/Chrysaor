package servlet;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.Parameter;
import java.util.HashMap;
import java.util.Map.Entry;

public class BaseServlet extends HttpServlet {

	private static final long serialVersionUID = 3106090118273183078L;
	private Class<? extends BaseServlet> c;
	private HashMap<String,Method> methodMap;
	private HashMap<String,Parameter[]> ParameterMap;
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		c = this.getClass();// 获得当前类的Class对象
		Method methods[] = c.getMethods();
		methodMap = new HashMap<String,Method>();
		ParameterMap = new HashMap<String,Parameter[]>();
		for(int i=0;i<methods.length;i++) {
			methodMap.put(methods[i].getName(), methods[i]);
			
			Parameter[] p = methods[i].getParameters();
			ParameterMap.put(methods[i].getName(), p);
		}
		
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("doGet");
		service(req, resp);
	}
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("1:"+this.getServletInfo());
		System.out.println("2:"+req.getServletPath());
		
		String name = req.getParameter("method");// 获取方法名
		if (name == null || name.isEmpty()) {
			throw new RuntimeException("没有传递method参数,请给出你想调用的方法");
		}

		
		Method method = null;

		try {
			if(methodMap.containsKey(name))
				method = methodMap.get(name);
		} catch (Exception e) {
			throw new RuntimeException("没有找到" + name + "方法，请检查该方法是否存在");
		}
		
		Parameter[] ps = ParameterMap.get(name);
		Object[] objs = new Object[ps.length];

		for(int i=0;i<ps.length;i++) {
			if(HttpServletRequest.class.getName().equals(ps[i].getType().getName())) {
				objs[i] = req;
				continue;
			}
			if(HttpServletResponse.class.getName().equals(ps[i].getType().getName())) {
				objs[i] = resp;
				continue;
			}
			objs[i] = req.getParameter(ps[i].getName());
			System.out.println(ps[i].getName() +":"+ objs[i]);
		}

		try {
			resp.setContentType("text/html; charset=UTF-8");
			//如果是void，代表是跳转类型的方法，后期如果有特殊需求，修改此处请商量一下
			if(method.getGenericReturnType().getTypeName().equals("void")){
				System.out.println(name + "方法，void");
				method.invoke(this,objs);
				return ;
			}else{
				String rstr = (String) method.invoke(this,objs);// 反射调用方法
				System.out.println(rstr);
				resp.getWriter().print(rstr);
			}
		} catch (IllegalAccessException | IllegalArgumentException | InvocationTargetException e) {
			e.printStackTrace();
		}
		
		
		HasToken hasToken = method.getAnnotation(HasToken.class);
		if (hasToken != null) {
			
		}
	}

	public static JSONObject creatResult(int success, String errorMessage, HashMap<String, Object> map) {
		JSONObject jo = new JSONObject();
		if (map != null) {
			JSONObject jors = new JSONObject();
			jors.put("total", map.size());

			JSONArray ja = new JSONArray();
			for (Entry<String, Object> entry : map.entrySet()) {
				String key = entry.getKey();
				Object value = entry.getValue();
				System.out.println("key =" + key + " value = " + value);

				JSONObject joo = new JSONObject();
				joo.put(key, value);
				ja.add(joo);
			}
			jors.put("rs", ja);
			jo.put("result",jors);
		}
		jo.put("success", success);
		jo.put("errorMessage", errorMessage);
		return jo;
	}
}