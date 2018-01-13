package test;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.SimpleClientHttpRequestFactory;
import org.springframework.web.client.RestTemplate;
import net.sf.json.JSONObject;

public class RestTemplateT {
	
	 static SimpleClientHttpRequestFactory factory;
	 
	 static String  jsessionid = "A5A08A6CD70E29EAA13244B3470C86C9";
	 
	 static String  token = "bfeae4eb668eb30caf3756c10e9585b3";
	 
	

	public static void main(String[] args) throws InterruptedException {
	factory = new SimpleClientHttpRequestFactory();
	factory.setConnectTimeout(20000);
		
		
		final String root = "http://localhost:8080/sapi/";
		
		
	/*	
		RestTemplate restTemplate = new RestTemplate();
		restTemplate.setRequestFactory(factory);
		
		String string =  restTemplate.getForObject("http://117.40.83.136:8080/system/data?appId=001852613&channel=103&clienttype=1&comid=200000004&method=addBalance&module=open&phonenum=18279915667&rechargedesc=微信&rechargemoney=0.01&service=Outter&u=20171124153725711914366863370396&v=20171204134150309421171427046204&ve=2&sign=37f688e0eb315db928cf72fc7b0380b1", String.class);
		System.out.println(string);
		if(true)return;*/

//		new Thread(new Runnable() {
//			
//			@Override
//			public void run() {
//				JSONObject use111 = post( root+"user.do");
//				
//				System.out.println(use111);
//				
//			}
//		}).start();
		
		JSONObject use111 = post( root+"user.do");
		
		System.out.println(use111);
		if(true) return;
		
		
	
	
	JSONObject sms = post(root+"login/sms.do?phone=18279915669&debug=true");
	ref(sms);
	String vcode= sms.getString("msg");
	p(sms);
	
	JSONObject login = post( root+"login.do?account=18279915669&type=sms&vcode="+vcode);
	ref(login);
	p(login);
		
		//http://m.0791jr.com/sapi/user/parking/berth/rateView.do?berthCode=201004
	post( root+"user/logout.do");
	JSONObject user = post( root+"user.do");
	ref(user);
	p(user);
	
	
	System.out.println("-----");
	
	System.out.println("延时");
	
	Thread.sleep(61*1000);
	
	
	JSONObject user2 = post( root+"user.do");
	ref(user2);
	p(user2);
	
Thread.sleep(61*1000);
	
	
	JSONObject user3 = post( root+"user.do");
	ref(user3);
	p(user3);
	
Thread.sleep(61*1000);
	
	
	JSONObject user4 = post( root+"user.do");
	ref(user4);
	p(user4);
	
	
	
	}
	
	
	static void p(JSONObject o){
		System.out.println(o);
		System.out.println(jsessionid);
		System.out.println(token);
		
		
	}
	
	static void ref(JSONObject o){
		//if(!"null".equals(o.getString("jsessionid")))
			jsessionid = o.getString("jsessionid");
		
			
			String mtoken = o.getString("token");
		if(!"null".equals(mtoken))
			token = o.getString("token");
		
	}
	
private static JSONObject post2(String url,String session) {
		
		
		RestTemplate restTemplate = new RestTemplate();
		restTemplate.setRequestFactory(factory);
		
		  HttpHeaders requestHeaders = new HttpHeaders();
		  String cookie = "";
		  if(session!=null)
			  cookie+="JSESSIONID="+session+";";
		  if(token!=null)
			  cookie+="stoken="+token+";";
	        requestHeaders.add("Cookie", cookie);
	       
		
	        HttpEntity<String> requestEntity = new HttpEntity<String>(null, requestHeaders);
	        ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, requestEntity, String.class);
		String rString = response.getBody();
		
		
		return JSONObject.fromObject(response.getBody());
		
		

	}
	
	private static JSONObject post(String url) {
		
		
		RestTemplate restTemplate = new RestTemplate();
		restTemplate.setRequestFactory(factory);
		
		  HttpHeaders requestHeaders = new HttpHeaders();
		  String cookie = "";
		  if(jsessionid!=null)
			  cookie+="JSESSIONID="+jsessionid+";";
		  if(token!=null)
			  cookie+="stoken="+token+";";
	        requestHeaders.add("Cookie", cookie);
	       
		
	        HttpEntity<String> requestEntity = new HttpEntity<String>(null, requestHeaders);
	        ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, requestEntity, String.class);
		String rString = response.getBody();
		
		
		return JSONObject.fromObject(response.getBody());
		
		

	}
	
	
}
