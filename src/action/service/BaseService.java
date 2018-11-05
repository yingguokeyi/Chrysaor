package action.service;

import aioclient.AioTcpClient;
import cache.AioTcpCache;
import cache.ResultPoor;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import model.Parameter;
import model.TranPst;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

public abstract class BaseService{
	public static int sendObject(int mid, Object... args) {
		int sid = ResultPoor.sid.incrementAndGet();
		ArrayList<Object> ay = new ArrayList<Object>();
		ay.add("");
		JSONObject sendJson = new JSONObject();
		sendJson.put("sid", sid);
		sendJson.put("mid", mid);
		for (Object s : args) {
			Parameter p = new Parameter();
			if (s instanceof String) {
				p.setType(1);
			} else if (s instanceof Integer) {
				p.setType(2);
			}
			p.setValue(s);
			ay.add(p);
		}
		sendJson.put("pts", ay);

		System.out.println(sendJson.toString());

		try {
			AioTcpCache.ctc.send(sendJson.toString());
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return sid;
	}

	
	public static int sendObject(AioTcpClient atc, int mid, String sql, Object... args) {
		int sid = ResultPoor.sid.incrementAndGet();
		ArrayList<Object> ay = new ArrayList<Object>();
		ay.add(sql);
		JSONObject sendJson = new JSONObject();
		sendJson.put("sid", sid);
		sendJson.put("mid", mid);
		for (Object s : args) {
			Parameter p = new Parameter();
			if (s instanceof String) {
				p.setType(1);
			} else if (s instanceof Integer) {
				p.setType(2);
			}
			p.setValue(s);
			ay.add(p);
		}
		sendJson.put("pts", ay);

		try {
			atc.send(sendJson.toString());
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return sid;
	}
	
	public static int sendObjectCreate(int mid, Object... args) {
		int sid = ResultPoor.sid.incrementAndGet();
		ArrayList<Object> ay = new ArrayList<Object>();
		JSONObject sendJson = new JSONObject();
		sendJson.put("sid", sid);
		sendJson.put("mid", mid);
		for (Object s : args) {
			Parameter p = new Parameter();
			if (s instanceof String) {
				p.setType(1);
			} else if (s instanceof Integer) {
				p.setType(2);
			}
			p.setValue(s);
			ay.add(p);
		}
		sendJson.put("pts", ay);

		System.out.println(sendJson.toString());

		try {
			AioTcpCache.ctc.send(sendJson.toString());
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return sid;
	}
	
	
	public static Object getFieldValue(String resText, String field,Class<?> c) {
		return JSONObject.parseObject(resText).getJSONObject("result").getJSONArray("rs").getJSONObject(0).getObject(field,c);
	}

	public static Object getFieldEachValue(String resText, String field, Class<?> c, int i) {
		JSONArray ja = JSONObject.parseObject(resText).getJSONObject("result").getJSONArray("rs");
		if (ja.size() == 0) {
			return null;
		} else {
			return ja.getJSONObject(i).getObject(field, c);
		}
	}
	
	public static int sendObjectBase(int mid,String sql, Object... args) {
		int sid = ResultPoor.sid.incrementAndGet();
		ArrayList<Object> ay = new ArrayList<Object>();
		ay.add(sql);
		JSONObject sendJson = new JSONObject();
		sendJson.put("sid", sid);
		sendJson.put("mid", mid);
		for (Object s : args) {
			Parameter p = new Parameter();
			if (s instanceof String) {
				p.setType(1);
			} else if (s instanceof Integer) {
				p.setType(2);
			}
			p.setValue(s);
			ay.add(p);
		}
		sendJson.put("pts", ay);

		System.out.println(sendJson.toString());

		try {
			AioTcpCache.ctc.send(sendJson.toString());
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return sid;
	}

	public static ArrayList<Object> addTransJa(ArrayList<Object> ay, String sql, Object... args) {
		JSONObject jo = new JSONObject();
		jo.put("SQL", sql);
		JSONArray SQLPSja = new JSONArray();
		for (Object s : args) {
			Parameter p = new Parameter();
			if (s instanceof String) {
				p.setType(1);
				p.setValue(s);
			} else if (s instanceof Integer) {
				p.setType(2);
				p.setValue(s);
			} else if (s instanceof TranPst) {
				p.setType(3);
				p.setValue(((TranPst) s).getValue());
			}

			SQLPSja.add(p);
		}

		jo.put("SQLPS", SQLPSja);
		ay.add(jo);
		return ay;
	}

	public static int sendTransJa(ArrayList<Object> ay) {
		int sid = ResultPoor.sid.incrementAndGet();
		JSONObject sendJson = new JSONObject();
		sendJson.put("sid", sid);
		sendJson.put("mid", 9998);
		sendJson.put("pts", ay);
		System.out.println(sendJson.toString());
		try {
			AioTcpCache.ctc.send(sendJson.toString());
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return sid;
	}
}