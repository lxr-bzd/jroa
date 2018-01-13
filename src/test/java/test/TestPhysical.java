package test;

import java.util.HashMap;
import java.util.Map;

import net.sf.json.JSONObject;

public class TestPhysical {

	public static void recognize() {
		String url = TestHttpUtil.baseUrl + "/physical/recognize";
		System.out.println("接口：" + url);
		String token = null;
		Map<String, Object> map = new HashMap<String, Object>();
		// map.put("mediaId",
		// "dwiHNmXcTbMaHaRTJATPAHvmkx9Ptre5cmQICUrU0ZgNOE7wuiEKHsr9bknbyxou");
		map.put("mediaId", "vsQ4fHtYHm_rxajt0_03cZDyTHI16wIBQAigYT38jqnY1_zM0XN6qqJ393xJzNXY");
		// map.put("mediaId",
		// "HVWo0UuNrKOVMgHB6pZctXkf_laFIjsLXe1L777-FgAkptEQefnXpcPTgNTJ1BFM");
		// map.put("filename", "微信wx_01.jpg");
		// map.put("filetype", 1);
		map.put("moduletype", 2);
		JSONObject json = JSONObject.fromObject(map);
		String request = json.toString();
		System.out.println("请求：" + request);
		String result = TestHttpUtil.sendPost(url, token, request);
		System.out.println("返回：" + result);
	}

	public static void recordList() {
		String url = TestHttpUtil.baseUrl + "/physical/recordlist";
		System.out.println("接口：" + url);
		String token = null;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pageNo", 1);
		map.put("pageSize", 10);
		JSONObject json = JSONObject.fromObject(map);
		String request = json.toString();
		System.out.println("请求：" + request);
		String result = TestHttpUtil.sendPost(url, token, request);
		System.out.println("返回：" + result);
	}

	public static void detail() {
		String url = TestHttpUtil.baseUrl + "/physical/detail";
		System.out.println("接口：" + url);
		String token = null;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", 3);
		JSONObject json = JSONObject.fromObject(map);
		String request = json.toString();
		System.out.println("请求：" + request);
		String result = TestHttpUtil.sendPost(url, token, request);
		System.out.println("返回：" + result);
	}

	public static void main(String[] args) {
		try {
			// recognize();
			// recordList();
			detail();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
