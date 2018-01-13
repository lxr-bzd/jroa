package test;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.nio.charset.Charset;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.lang.StringUtils;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.entity.mime.content.FileBody;
import org.apache.http.entity.mime.content.StringBody;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

public class TestHttpUtil {

	public static String baseUrl = "http://localhost:8080/EMIS";
//	public static String baseUrl = "http://www.coding.mobi/EMIS";

	public static String post(String url, String token, Map<String, Object> params) {
		try {
			URL urlObj = new URL(url);// 创建连接
			HttpURLConnection connection = (HttpURLConnection) urlObj.openConnection();
			connection.setDoOutput(true);
			connection.setDoInput(true);
			connection.setUseCaches(false);
			connection.setInstanceFollowRedirects(true);
			connection.setRequestMethod("POST"); // 设置请求方式
			connection.setRequestProperty("Accept", "*/*"); // 设置接收数据的格式
			connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded"); // 设置发送数据的格式
//			if (StringUtils.isNotBlank(token)) {
//				connection.setRequestProperty(Constant.TOKEN_NAME, token);
//				System.out.println("请求Token=" + token);
//			}
			connection.connect();

			if (null != params && !params.isEmpty()) {
				String paramStr = "";
				for (Map.Entry<String, Object> entry : params.entrySet()) {
					paramStr += entry.getKey() + "=" + entry.getValue() + "&";
				}
				paramStr = paramStr.substring(0, paramStr.length() - 1);
				PrintWriter out = new PrintWriter(connection.getOutputStream());
				// 发送请求参数
				out.print(paramStr);
				// flush输出流的缓冲
				out.flush();
				out.close();
			}

//			String responseToken = connection.getHeaderField(Constant.TOKEN_NAME);
//			if (StringUtils.isNotBlank(responseToken)) {
//				System.out.println("响应Token=" + responseToken);
//			}

			// 读取响应
			BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
			String lines;
			StringBuffer sb = new StringBuffer("");
			while ((lines = reader.readLine()) != null) {
				lines = new String(lines.getBytes(), "utf-8");
				sb.append(lines);
			}
			// System.out.println(sb);
			reader.close();
			// 断开连接
			connection.disconnect();
			return sb.toString();
		} catch (MalformedURLException e) {
			e.printStackTrace();
			return "MalformedURLException";
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return "UnsupportedEncodingException";
		} catch (IOException e) {
			e.printStackTrace();
			return "IOException";
		}
	}

	public static String sendPost(String url, String token, String params) {
		try {
			URL urlObj = new URL(url);// 创建连接
			HttpURLConnection connection = (HttpURLConnection) urlObj.openConnection();
			connection.setDoOutput(true);
			connection.setDoInput(true);
			connection.setUseCaches(false);
			connection.setInstanceFollowRedirects(true);
			connection.setRequestMethod("POST"); // 设置请求方式
			connection.setRequestProperty("Accept", "application/json"); // 设置接收数据的格式
			connection.setRequestProperty("Content-Type", "application/json"); // 设置发送数据的格式
//			if (StringUtils.isNotBlank(token)) {
//				connection.setRequestProperty(Constant.TOKEN_NAME, token);
//				System.out.println("请求Token=" + token);
//			}
			connection.connect();
			if (StringUtils.isNotBlank(params)) {
				OutputStreamWriter out = new OutputStreamWriter(connection.getOutputStream(), "UTF-8"); // utf-8编码
				out.append(params);
				out.flush();
				out.close();
			}

//			String responseToken = connection.getHeaderField(Constant.TOKEN_NAME);
//			if (StringUtils.isNotBlank(responseToken)) {
//				System.out.println("响应Token=" + responseToken);
//			}

			// 读取响应
			BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
			String lines;
			StringBuffer sb = new StringBuffer("");
			while ((lines = reader.readLine()) != null) {
				lines = new String(lines.getBytes(), "utf-8");
				sb.append(lines);
			}
			// System.out.println(sb);
			reader.close();
			// 断开连接
			connection.disconnect();
			return sb.toString();
		} catch (MalformedURLException e) {
			e.printStackTrace();
			return "MalformedURLException";
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return "UnsupportedEncodingException";
		} catch (IOException e) {
			e.printStackTrace();
			return "IOException";
		}
	}

	public static String upload(String url, String token, Map<String, Object> params, List<String> fileList) {
		// List<String> list = new ArrayList<String>(); //
		// 要上传的文件名,如：d:\haha.doc.你要实现自己的业务。我这里就是一个空list.
		try {
			String CHARSET = "UTF-8";
			String PREFIX = "--";
			String LINE_END = "\r\n";
			String BOUNDARY = "---------7d4a6d158c9"; // 定义数据分隔线
			URL urlObj = new URL(url);
			HttpURLConnection conn = (HttpURLConnection) urlObj.openConnection();
			// 发送POST请求必须设置如下两行
			conn.setDoOutput(true);
			conn.setDoInput(true);
			conn.setUseCaches(false);
			conn.setRequestMethod("POST");
//			if (StringUtils.isNotBlank(token)) {
//				conn.setRequestProperty(Constant.TOKEN_NAME, token);
//				System.out.println("请求Token=" + token);
//			}
			conn.setRequestProperty("connection", "Keep-Alive");
			conn.setRequestProperty("user-agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)");
			conn.setRequestProperty("Charsert", CHARSET);
			conn.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + BOUNDARY);

//			String responseToken = conn.getHeaderField(Constant.TOKEN_NAME);
//			if (StringUtils.isNotBlank(responseToken)) {
//				System.out.println("响应Token=" + responseToken);
//			}

			OutputStream out = new DataOutputStream(conn.getOutputStream());

			// 传参
			if (null != params && !params.isEmpty()) {
				StringBuffer buffer = new StringBuffer();
				buffer.append(LINE_END);
				for (Map.Entry<String, Object> entry : params.entrySet()) {
					buffer.append(PREFIX).append(BOUNDARY).append(LINE_END);// 分界符
					buffer.append("Content-Disposition: form-data; name=\"" + entry.getKey() + "\"" + LINE_END);
					buffer.append("Content-Type: text/plain; charset=" + CHARSET + LINE_END);
					buffer.append("Content-Transfer-Encoding: 8bit" + LINE_END);
					buffer.append(LINE_END);
					buffer.append(entry.getValue());
					buffer.append(LINE_END);// 换行！
				}
				out.write(buffer.toString().getBytes());
			}

			// 上传
			if (null != fileList && fileList.size() > 0) {
				StringBuffer sb = new StringBuffer();
				int leng = fileList.size();
				for (int i = 0; i < leng; i++) {
					String fname = fileList.get(i);
					File file = new File(fname);
					sb.append("--");
					sb.append(BOUNDARY);
					sb.append("\r\n");
					if (leng == 1) {
						sb.append("Content-Disposition: form-data;name=\"attachment\";filename=\"" + file.getName()
								+ "\"\r\n");
					} else {
						sb.append("Content-Disposition: form-data;name=\"attachment" + i + "\";filename=\""
								+ file.getName() + "\"\r\n");
					}

					sb.append("Content-Type:application/octet-stream\r\n\r\n");

					byte[] data = sb.toString().getBytes();
					out.write(data);
					DataInputStream in = new DataInputStream(new FileInputStream(file));
					int bytes = 0;
					byte[] bufferOut = new byte[1024];
					while ((bytes = in.read(bufferOut)) != -1) {
						out.write(bufferOut, 0, bytes);
					}
					out.write("\r\n".getBytes()); // 多个文件时，二个文件之间加入这个
					in.close();
				}
				// 写入文件数据
				out.write(LINE_END.getBytes());
				byte[] end_data = (PREFIX + BOUNDARY + PREFIX + LINE_END).getBytes();
				out.write(end_data);
				out.flush();
			}

			// 定义BufferedReader输入流来读取URL的响应
			BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = null;
			StringBuffer buf = new StringBuffer();
			while ((line = reader.readLine()) != null) {
				buf.append(line);
			}
			return buf.toString();
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}

	/**
	 * 使用HttpURLConnection通过POST方式提交请求，并上传文件。
	 * 
	 * @param actionUrl
	 *            访问的url
	 * @param textParams
	 *            文本类型的POST参数(key:value)
	 * @param filePaths
	 *            文件路径的集合
	 * @return 服务器返回的数据，出现异常时返回 null
	 */
	public static String postFiles(String url, String token, Map<String, Object> params, List<String> fileList) {
		try {
			final String BOUNDARY = UUID.randomUUID().toString();
			final String PREFIX = "--";
			final String LINE_END = "\r\n";

			final String MULTIPART_FROM_DATA = "multipart/form-data";
			final String CHARSET = "UTF-8";

			URL uri = new URL(url);
			HttpURLConnection conn = (HttpURLConnection) uri.openConnection();

			// 缓存大小
			// conn.setChunkedStreamingMode(1024 * 64);
			// 超时
			conn.setReadTimeout(5 * 1000);
			conn.setDoInput(true);
			conn.setDoOutput(true);
			conn.setUseCaches(false);
			conn.setRequestMethod("POST");

			conn.setRequestProperty("connection", "keep-alive");
			conn.setRequestProperty("Charset", "UTF-8");
			conn.setRequestProperty("Content-Type", MULTIPART_FROM_DATA + ";boundary=" + BOUNDARY);

//			if (StringUtils.isNotBlank(token)) {
//				conn.setRequestProperty(Constant.TOKEN_NAME, token);
//				System.out.println("请求Token=" + token);
//			}

			// 拼接文本类型的参数
			StringBuilder textSb = new StringBuilder();
			if (params != null && !params.isEmpty()) {
				for (Map.Entry<String, Object> entry : params.entrySet()) {
					textSb.append(PREFIX).append(BOUNDARY).append(LINE_END);
					textSb.append("Content-Disposition: form-data; name=\"" + entry.getKey() + "\"" + LINE_END);
					textSb.append("Content-Type: text/plain; charset=" + CHARSET + LINE_END);
					textSb.append("Content-Transfer-Encoding: 8bit" + LINE_END);
					textSb.append(LINE_END);
					textSb.append(entry.getValue());
					textSb.append(LINE_END);
				}
			}

			DataOutputStream outStream = new DataOutputStream(conn.getOutputStream());
			outStream.write(textSb.toString().getBytes());

			// 参数POST方式
			// outStream.write("userId=1&cityId=26".getBytes());

			// 发送文件数据
			if (fileList != null && !fileList.isEmpty()) {
				for (String file : fileList) {
					StringBuilder fileSb = new StringBuilder();
					fileSb.append(PREFIX).append(BOUNDARY).append(LINE_END);
					fileSb.append("Content-Disposition: form-data; name=\"attachment\"; filename=\""
							+ file.substring(file.lastIndexOf("/") + 1) + "\"" + LINE_END);
					fileSb.append("Content-Type: application/octet-stream; charset=" + CHARSET + LINE_END);
					fileSb.append(LINE_END);
					outStream.write(fileSb.toString().getBytes());

					InputStream is = new FileInputStream(file);
					byte[] buffer = new byte[1024 * 8];
					int len;
					while ((len = is.read(buffer)) != -1) {
						outStream.write(buffer, 0, len);
					}

					is.close();
					outStream.write(LINE_END.getBytes());
				}
			}

			// 请求结束标志
			outStream.write((PREFIX + BOUNDARY + PREFIX + LINE_END).getBytes());
			outStream.flush();

			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), CHARSET));

			StringBuilder resultSb = new StringBuilder();
			String line = "";
			while ((line = br.readLine()) != null) {
				resultSb.append(line).append("\n");
			}

			br.close();
			outStream.close();
			conn.disconnect();

			return resultSb == null ? null : resultSb.toString();
		} catch (IOException e) {
			e.printStackTrace();
		}

		return null;
	}

	public static String uploadFiles(String url, String token, Map<String, String> params, List<String> fileList) {
		String name = "attachment";
		CloseableHttpClient httpclient = HttpClients.createDefault();

		try {
			HttpPost httppost = new HttpPost(url);
//			if (StringUtils.isNotBlank(token)) {
//				httppost.addHeader(Constant.TOKEN_NAME, token);
//			}
			MultipartEntityBuilder builder = MultipartEntityBuilder.create();
			builder.setCharset(Charset.forName("UTF-8"));
			for (String filePath : fileList) {
				FileBody fileBody = new FileBody(new File(filePath));
				builder.addPart(name, fileBody);
			}
			if (null != params && !params.isEmpty()) {
				for (Map.Entry<String, String> entry : params.entrySet()) {
					StringBody stringBody = new StringBody(entry.getValue(), ContentType.TEXT_PLAIN);
					builder.addPart(entry.getKey(), stringBody);
				}
			}
			HttpEntity reqEntity = builder.build();
			httppost.setEntity(reqEntity);

			System.out.println("executing request " + httppost.getRequestLine());
			CloseableHttpResponse response = httpclient.execute(httppost);
			System.out.println("----------------------------------------");
			System.out.println(response.getStatusLine());
			HttpEntity resEntity = response.getEntity();
			String result = "";
			if (resEntity != null) {
				System.out.println("Response content length: " + resEntity.getContentLength());
				result = EntityUtils.toString(response.getEntity());
			}
			EntityUtils.consume(resEntity);
			response.close();
			httpclient.close();

			return result;
		} catch (Exception e) {
			e.printStackTrace();
			return "Error";
		}
	}

}
