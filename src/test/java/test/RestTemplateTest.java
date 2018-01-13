package test;


import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.SimpleClientHttpRequestFactory;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;


public class RestTemplateTest {

	static String requestKey = "53261db64ad29f710926eb023ebd6031";
	
	public static void main(String[] args) throws UnsupportedEncodingException {
		SimpleClientHttpRequestFactory factory = new SimpleClientHttpRequestFactory();
		factory.setConnectTimeout(20000);
		
		RestTemplate restTemplate = new RestTemplate(factory);
		
		notify(restTemplate);
		//orderCreate(restTemplate);
		//wxpayNotify(restTemplate);
		
	
		
	}
	
	
	private static void wxpayNotify(RestTemplate restTemplate) {
		 HttpHeaders headers = new HttpHeaders();
		          MediaType type = MediaType.parseMediaType("application/xhtml+xml");
		          headers.setContentType(type);
		          headers.add("Accept", MediaType.APPLICATION_XML.toString());
		          
		          String xml = 
		        "<xml>                                                                       "
		        +"  <appid><![CDATA[wx2421b1c4370ec43b]]></appid>                             "
		        +"  <attach><![CDATA[支付测试]]></attach>                                     "
		        +"  <bank_type><![CDATA[CFT]]></bank_type>                                    "
		        +"  <fee_type><![CDATA[CNY]]></fee_type>                                      "
		        +"  <is_subscribe><![CDATA[Y]]></is_subscribe>                                "
		        +"  <mch_id><![CDATA[10000100]]></mch_id>                                     "
		        +"  <nonce_str><![CDATA[5d2b6c2a8db53831f7eda20af46e531c]]></nonce_str>       "
		        +"  <openid><![CDATA[oUpF8uMEb4qRXf22hE3X68TekukE]]></openid>                 "
		        +"  <out_trade_no><![CDATA[20171101133701973827274178560216]]></out_trade_no>                       "
		        +"  <result_code><![CDATA[SUCCESS]]></result_code>                            "
		        +"  <return_code><![CDATA[SUCCESS]]></return_code>                            "
		        +"  <sign><![CDATA[B552ED6B279343CB493C5DD0D78AB241]]></sign>                 "
		        +"  <sub_mch_id><![CDATA[10000100]]></sub_mch_id>                             "
		        +"  <time_end><![CDATA[20140903131540]]></time_end>                           "
		        +"  <total_fee>1000</total_fee>                                                  "
		        +"  <trade_type><![CDATA[JSAPI]]></trade_type>                                "
		        +"  <transaction_id><![CDATA[1004400740201409030005092168]]></transaction_id> "
		        +"  </xml>                                                                    ";
		          
		          HttpEntity<String> formEntity = new HttpEntity<String>(xml, headers);
		ResponseEntity<String> str = restTemplate.postForEntity("http://localhost:8080/sapp/wx/notify.do",formEntity ,String.class);
		System.out.println(str.getBody());

	}
	
	
	
	private static void notify(RestTemplate restTemplate) throws UnsupportedEncodingException {
	
		
		Map<String, String> map  = new HashMap<>();
			//overtopMoney=5.0&overtopTime=0&payMoney=0.0&refund=5.0&sign=97d0be74623bfbcf7c87c637dc748fb5&status=3&sumMoney%20=
		map.put("id","20171104085135331403522769348595" );
		
		System.out.println(map.get("id").length());
		map.put("orderCode","120171104085026201015" );
		
		map.put("arrearsId","20171112174754130428687161402677" );
		map.put("berthCode","201015" );
		
		map.put("applyDuration","0" );
		
		map.put("inTime","1510480069000" );
		map.put("outTime","1510480074000" );
		
		map.put("status","5" );
		
		map.put("sumMoney","5.0" );
		map.put("payMoney","0.0" );
		map.put("refund", "5.0");
		
		
		map.put("overtopTime","0" );
		map.put("overtopMoney","5.0" );
		
		
		
		
	
		
		//String sign = MD5Util.MD5ToString(/*"http://www.szkljy.com:16081/std/data?"*/u);
		
		String sign =  encrypByMd5(UrlUtils.formatUrlMap(map,true)+"&requestKey="+requestKey, "utf-8");
		
		map.put("sign", sign);
		
		String param = UrlUtils.formatUrlMap(map,false);
	
		System.out.println("http://localhost:8080/sapp/park/order/notify.do?"+param);
		ResponseEntity<String> str = restTemplate.getForEntity("http://localhost:8080/sapp/park/order/notify.do?"+param, String.class,map);
	
		
		
		
		System.out.println(str.getBody());
	}
	
	
	
	private static void orderCreate(RestTemplate restTemplate) throws UnsupportedEncodingException {
	Map<String, String> map  = new HashMap<>();
		
// * "参数：停车场ploid,车牌号carCode,抬杆类型（驶入）（rod=1：驶入，2：驶出），抬杆时间：inTime
		map.put("id","20171018215642252889240541601307" );
		
		
		map.put("carCode","京EY4453" );
		
		map.put("rod","1" );
		map.put("inTime","123454365436546" );
		
		
		
		//String sign = MD5Util.MD5ToString(/*"http://www.szkljy.com:16081/std/data?"*/u);
		
		String sign =  encrypByMd5(UrlUtils.formatUrlMap(map,true)+"&requestKey="+requestKey, "utf-8");
		
		map.put("sign", sign);
		
		String param = UrlUtils.formatUrlMap(map,false);
		
		String url = "http://localhost:8080/sapp/park/order/create.do";
	
		System.out.println(url+"?"+param);
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

		MultiValueMap<String, String> mmap= map2MultiValueMap(map);
		

		HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<MultiValueMap<String, String>>(mmap, headers);
		
		
		
	
		
		ResponseEntity<String> str = restTemplate.postForEntity(url, request,String.class);
	
		
		
		
		System.out.println(str.getBody());

	}
	
	
	private static MultiValueMap<String, String> map2MultiValueMap(Map<String, String> map) {
	
		 MultiValueMap<String, String> multiValueMap  = new LinkedMultiValueMap<String, String>();
		
		for (Entry<String, String> entry : map.entrySet()) {  
			  
			
			multiValueMap.add(entry.getKey(), entry.getValue());
		  
		}  

		return multiValueMap;
	}
	
	
	   
	   public static String encrypByMd5(String context,String charset) throws UnsupportedEncodingException {  
	        try {  
	            MessageDigest md = MessageDigest.getInstance("MD5"); 
	            if(charset==null)charset = "utf-8";
	            md.update(context.getBytes(charset));//update处理  
	            byte [] encryContext = md.digest();//调用该方法完成计算  
	  
	            int i;  
	            StringBuffer buf = new StringBuffer("");  
	            for (int offset = 0; offset < encryContext.length; offset++) {//做相应的转化（十六进制）  
	                i = encryContext[offset];  
	                if (i < 0) i += 256;  
	                if (i < 16) buf.append("0");  
	                buf.append(Integer.toHexString(i));  
	           }  
	            
	            return buf.toString();
	          // System.out.println("32result: " + );// 32位的加密  
	          // System.out.println("16result: " + buf.toString().substring(8, 24));// 16位的加密  
	        } catch (NoSuchAlgorithmException e) {  
	            // TODO Auto-generated catch block  
	            e.printStackTrace();  
	        }
			return null;  
	    }  
}
