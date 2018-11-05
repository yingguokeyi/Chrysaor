package common;

import cache.AioTcpCache;
import cache.ResultPoor;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import java.io.UnsupportedEncodingException;

/**
 * @ClassName: LoadInvoker
 * @Description: TODO(工程启动加载类)
 * @author jiangshidi
 * @date 2016年9月14日 下午5:42:32
 * 
 */

@WebServlet(loadOnStartup = 1, urlPatterns = { "/dwr-invoker" })
public class LoadInvoker extends HttpServlet {
	/**
	 * @Fields serialVersionUID : TODO(序列化)
	 */
	private static final long serialVersionUID = 1L;

	public void init() {

		// 初始化项目参数
		PropertiesConf pcf = new PropertiesConf();
		pcf.init();

		// 初始化redis连接池token_user
		RedisClient.initialShardedPool(PropertiesConf.REDIS_IP, PropertiesConf.REDIS_PORT, "user_token");
		RedisClient.initialShardedPool(PropertiesConf.REDIS_IP, PropertiesConf.REDIS_PORT, "token_user");
		
		aioclient.AioTcpClient atc = new aioclient.AioTcpClient() {
			@Override
			public void disconnect() {

			}
		};
		new Thread() {
			public void run() {
				try {
					String[] uri = PropertiesConf.PHANTOM.split(":");

					atc.start(uri[0], Integer.valueOf(uri[1]), Integer.valueOf(uri[2]));
					System.out.println("  uri[0]  is "+uri[0]);
					// ----链接chaos服务
					int sid1 = ResultPoor.sid.incrementAndGet();

					JSONObject mjo1 = new JSONObject();
					mjo1.put("id", "chaos");
					mjo1.put("sid", sid1);
					mjo1.put("mid", 2);
					atc.send(mjo1.toString());

					Thread.sleep(800);

					new JSONObject();
					JSONObject jo = JSON.parseObject(ResultPoor.getResult(sid1));
					JSONArray ja = jo.getJSONArray("result");

					for (int i = 0; i < ja.size(); i++) {
						String urix = ja.getString(i);
						System.out.println(urix);
						String[] uri3 = urix.split(":");
						aioclient.AioTcpClient atc1 = new aioclient.AioTcpClient() {
							@Override
							public void disconnect() {

							}
						};
						atc1.start(uri3[0], Integer.valueOf(uri3[1]), 20);//count 连接数
						AioTcpCache.ctc = atc1;
					}
					// ----链接chaos结束

					// 链接gaia服务
					int sid2 = ResultPoor.sid.incrementAndGet();

					JSONObject mjo2 = new JSONObject();
					mjo2.put("id", "gaia");
					mjo2.put("sid", sid2);
					mjo2.put("mid", 2);
					atc.send(mjo2.toString());

					Thread.sleep(500);

					JSONObject jo2 = JSON.parseObject(ResultPoor.getResult(sid2));
					JSONArray ja2 = jo2.getJSONArray("result");

					for (int i = 0; i < ja2.size(); i++) {
						String urix = ja2.getString(i);
						System.out.println(urix);
						String[] uri3 = urix.split(":");
						aioclient.AioTcpClient atc1 = new aioclient.AioTcpClient() {
							@Override
							public void disconnect() {

							}
						};
						atc1.start(uri3[0], Integer.valueOf(uri3[1]), 10);
						AioTcpCache.gtc = atc1;
					}
					// 链接gaia结束
					new Thread() {
						public void run() {
							BaseCache.timeLoop();
						};
					}.start();

					new Thread() {
						public void run() {
							while(true) {
								// TimerTest.getStatus();
								try {
									Thread.sleep(600000);
								} catch (InterruptedException e) {
									e.printStackTrace();
								}
							}
						}
					}.start();
					new Thread() {
						public void run() {
							while(true) {
								//TimerTest.updateShelfState();
								try {
									Thread.sleep(600000);
								} catch (InterruptedException e) {
									e.printStackTrace();
								}
							}
						}
					}.start();
					new Thread() {
						public void run() {
							while(true) {
								//TimerTest.commissionsLoad();
								try {
									Thread.sleep(100000);
								} catch (InterruptedException e) {
									e.printStackTrace();
								}
							}
						}
					}.start();
				} catch (NumberFormatException e) {
					e.printStackTrace();
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			};
		}.start();
	}
}