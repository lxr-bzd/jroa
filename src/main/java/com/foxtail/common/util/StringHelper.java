package com.foxtail.common.util;

import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.regex.PatternSyntaxException;

/**
 * <p>标题: </p>
 * <p>描述: 字符串处理类</p>
 */
public class StringHelper
{
	/** 
	  * 判断字符串是否空
	  * @param value
	  * @return 
	*/ 
	public static boolean isBlank(String value) {
		if (value == null) {
			return true;
		} else {
			if ("".equals(value.trim())) {
				return true;
			}
		}
		return false;
	}
	
	public static boolean isNotBlank(String value) {
		return !isBlank(value);
	}
	
	/**
	 * @Description:把数组转换为一个用逗号分隔的字符串 ，以便于用in+String 查询
	 */
	public static String converToString(String[] ig) {
		String str = "";
		if (ig != null && ig.length > 0) {
			for (int i = 0; i < ig.length; i++) {
				str += ig[i] + ",";
			}
		}
		str = str.substring(0, str.length() - 1);
		return str;
	}

	/**
	 * @Description:把list转换为一个用逗号分隔的字符串
	 */
	public static String listToString(List list) {
		StringBuilder sb = new StringBuilder();
		if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				if (i < list.size() - 1) {
					if(list.get(i)!=null){
						sb.append(list.get(i) + ",");
					}
					
				} else {
					if(list.get(i)!=null){
						sb.append(list.get(i));
					}
				}
			}
		}
		return sb.toString();
	}
	
   /**
    *将空值或空字符串转换为""
    * @param strOrig 原始字符串
    * @return 返回转换后的字符串
    */
   public static final String convertStringNull(String strOrig)
   {
      String strReturn = "";
      if (strOrig == null || strOrig.equals("null"))
      {
         strReturn = "";
      }
      else
      {
         strReturn = strOrig.trim();
      }
      return strReturn;
   }

   /**
    * 分解以特定分隔符分隔多个同一类型信息的字符串为字符串数组
    * @param strOrigin 原始字符串
    * @param separator 分隔符
    * @return 字符串数组
    */
   public static final String[] parserString(String strOrigin, String separator)
   {
      try
      {
         StringTokenizer st;
         String strItem;

         if (strOrigin == null)
         {
            return null;
         }
         st = new StringTokenizer(strOrigin, separator);
         String[] returnValue = new String[st.countTokens()];
         int index = 0;
         while (st.hasMoreTokens())
         {
            strItem = (String) st.nextToken();
            if (strItem != null && strItem.trim().length() != 0)
            {
               returnValue[index++] = strItem;
            }
         }
         return returnValue;
      }
      catch (Exception e)
      {
         return null;
      }
   }

   /**
    * 分解以特定分隔符分隔多个同一类型信息的字符串为字符串数组
    * @param strOrigin 原始字符串
    * @param separator 分隔符
    * @return 字符串数组
    */
   public static String[] split(String strOrigin, String separator)
   {
      return strOrigin.split(separator);
   }

   /**
    * 将源字符串中的某些字符串替换为新字符串
    * @param line 源字符串
    * @param oldString 要被替换的字符串
    * @param newString 替换的字符串
    * @return 替换后的字符串
    */
   public static final String replace(String line, String oldString,
         String newString)
   {
      if (line == null)
      {
         return null;
      }
      int i = 0;
      if ((i = line.indexOf(oldString, i)) >= 0)
      {
         char[] line2 = line.toCharArray();
         char[] newString2 = newString.toCharArray();
         int oLength = oldString.length();
         StringBuffer buf = new StringBuffer(line2.length);
         buf.append(line2, 0, i).append(newString2);
         i += oLength;
         int j = i;
         while ((i = line.indexOf(oldString, i)) > 0)
         {
            buf.append(line2, j, i - j).append(newString2);
            i += oLength;
            j = i;
         }
         buf.append(line2, j, line2.length - j);
         return buf.toString();
      }
      return line;
   }

   /**
    * 将源字符串中的某些字符串忽略大小写替换为新字符串
    * @param line 源字符串
    * @param oldString 要被替换的字符串
    * @param newString 替换的字符串
    * @return 替换后的字符串
    */
   public static final String replaceIgnoreCase(String line, String oldString,
         String newString)
   {
      if (line == null)
      {
         return null;
      }
      String lcLine = line.toLowerCase();
      String lcOldString = oldString.toLowerCase();
      int i = 0;
      if ((i = lcLine.indexOf(lcOldString, i)) >= 0)
      {
         char[] line2 = line.toCharArray();
         char[] newString2 = newString.toCharArray();
         int oLength = oldString.length();
         StringBuffer buf = new StringBuffer(line2.length);
         buf.append(line2, 0, i).append(newString2);
         i += oLength;
         int j = i;
         while ((i = lcLine.indexOf(lcOldString, i)) > 0)
         {
            buf.append(line2, j, i - j).append(newString2);
            i += oLength;
            j = i;
         }
         buf.append(line2, j, line2.length - j);
         return buf.toString();
      }
      return line;
   }

   /**
    * 将源字符串中的某些字符替换为指定的字符
    * @param str 源字符串
    * @param oldChar 要被替换的字符
    * @param newChar 替换的字符
    * @return 替换后的字符串
    */
   public static String replaceChar(String str, char oldChar, char newChar)
   {
      str = convertStringNull(str);
      if (str.length() > 0)
      {
         str = str.replace(oldChar, newChar);
      }
      return str;
   }

   /**
    * 将传入的字符串转换为中文字符串，并将空字符串转换为""
    * @param strOrigin 原始字符串
    * @return 中文字符串
    */
   public static String toChineseStr(String strOrigin)
   {
      if (strOrigin == null || strOrigin.equals(null))
      {
         strOrigin = "";
      }
      else
      {
         strOrigin = strOrigin.trim();
      }

      try
      {
         strOrigin = new String(strOrigin.getBytes("ISO8859_1"), "GBK");
      }
      catch (Exception e)
      {
      }
      return strOrigin;
   }
   
   /**
    * 将传入的字符串转换为中文字符串，并将空字符串转换为""
    * @param str 原始字符串
    * @param str 旧编码
    * @param str 新编码
    * @return 中文字符串
    */
   public static String toChineseStr(String str,String oldCode,String newCode)
   {
      if (str == null || str.equals(null)){
    	  str = "";
      } else {
    	  str = str.trim();
      }

      try{
    	  str = new String(str.getBytes(oldCode), newCode);
      }catch (Exception e){
    	  e.printStackTrace();
      }
      return str;
   }

   /**
    * 将中文字符串转换为ISO8859_1编码格式，并将空字符串转换为""
    * @param strOrigin  原始字符串（中文字符串）
    * @return 转换后的字符串
    */
   public static String toStandardStr(String strOrigin)
   {
      if (strOrigin == null || strOrigin.equals(null))
      {
         strOrigin = "";
      }
      else
      {
         strOrigin = strOrigin.trim();
      }

      try
      {
         strOrigin = new String(strOrigin.getBytes("GBK"), "ISO8859_1");
      }
      catch (Exception e)
      {
      }
      return strOrigin;
   }

   /**
    * 将字符串转换为utf-8编码格式
    * @param s 要转换的字符串
    * @return 转换后的字符串
    */
   public static String toUtf8String(String s)
   {
      StringBuffer sb = new StringBuffer();
      for (int i = 0; i < s.length(); i++)
      {
         char c = s.charAt(i);
         if (c >= 0 && c <= 255)
         {
            sb.append(c);
         }
         else
         {
            byte[] b;
            try
            {
               b = new Character(c).toString().getBytes("utf-8");
            }
            catch (Exception ex)
            {
               System.out.println(ex);
               b = new byte[0];
            }
            for (int j = 0; j < b.length; j++)
            {
               int k = b[j];
               if (k < 0)
                  k += 256;
               sb.append("%" + Integer.toHexString(k).toUpperCase());
            }
         }
      }
      return sb.toString();
   }

   /**
    * 将字符串从原来的编码格式转换为指定的编码格式
    * @param strOrigin 原始字符串
    * @param originEncode 原始编码格式
    * @param desEncode 目标编码格式
    * @return 转换后的字符串
    */
   public static String converStrEncode(String strOrigin, String originEncode,
         String desEncode)
   {
      if (strOrigin == null || strOrigin.equals(null))
      {
         strOrigin = "";
      }
      else
      {
         strOrigin = strOrigin.trim();
      }

      try
      {
         strOrigin = new String(strOrigin.getBytes(originEncode), desEncode);
      }
      catch (Exception e)
      {
         System.out.println("字符串编码格式转换出错！");
         //e.printStackTrace();
      }
      return strOrigin;
   }

   /**
    *将空格串" "或空指针转换为html的空格编码
    * @param strOrigin原始字符串
    * @return 返回转换后的字符串
    */
   public static final String filterNullStringToHTMLSpace(String strOrigin)
   {
      if (strOrigin == null)
      {
         return "&nbsp;";
      }
      else if (strOrigin.length() == 0)
      {
         return "&nbsp;";
      }
      else
      {
         return strOrigin.trim();
      }
   }

   /**
    *将字符串转换成可以在HTML中正常显示的字符串，如在input框中显示< > ' 等特殊字符,在这里<转变成了&lt
    * @param strOrigin 原始字符串
    * @return 返回转换后的字符串
    */
   public static String toHTMLString(String strOrigin)
   {
      StringBuffer out = new StringBuffer();
      for (int i = 0; strOrigin != null && i < strOrigin.length(); i++)
      {
         char c = strOrigin.charAt(i);
         if (c == '\'')
            out.append("&#039;");
         else if (c == '\"')
            out.append("&#034;");
         else if (c == '<')
            out.append("&lt;");
         else if (c == '>')
            out.append("&gt;");
         else if (c == '&')
            out.append("&amp;");
         else if (c == ' ')
            out.append("&nbsp;");
         else if (c == '\n')
            out.append("<br>");
         else
            out.append(c);
      }
      return out.toString();
   }
   
   /**
    *将字符串转换成可以在HTML中正常显示的字符串，如在input框中显示< > ' 等特殊字符,在这里<转变成了&lt
    * @param strOrigin 原始字符串
    * @return 返回转换后的字符串
    */
   public static String to1HTMLString(String strOrigin)
   {
      StringBuffer out = new StringBuffer();
      for (int i = 0; strOrigin != null && i < strOrigin.length(); i++)
      {
         char c = strOrigin.charAt(i);
         if (c == '\'')
            out.append("&#039;");
         else if (c == '\"')
            out.append("&#034;");
         else if (c == '<')
            out.append("&lt;");
         else if (c == '>')
            out.append("&gt;");
         else if (c == '&')
            out.append("&amp;");
//         else if (c == ' ')
//            out.append("&nbsp;");
         else if (c == '\n')
            out.append("<br>");
         else
            out.append(c);
      }
      return out.toString();
   }


   /**
    *将字符串的HTML编码的字串转成正常的字符串
    * @param strOrigin 原始字符串
    * @return 返回转换后的字符串
    */
   public static String UnEncodeHtml(String strOrigin)
   {
      int index = 0, pos = 0;
      if (strOrigin == null || strOrigin.length() == 0)
         return strOrigin;
      StringBuffer buffer = new StringBuffer();
      do
      {
         index = strOrigin.indexOf('&');
         if (index != -1)
         {
            pos = strOrigin.indexOf(';');
            if (strOrigin.charAt(index + 1) == '#' && pos > 0)
            {
               String tmp = strOrigin.substring(index + 2, pos);
               char ch = (char) Integer.parseInt(tmp);
               buffer.append(ch);
            }
            else if (pos > 0)
            {
               String tmp = strOrigin.substring(index, pos + 1);
               if (tmp.equals("&quot;"))
               {
                  buffer.append('\"');
               }
               else if (tmp.equals("&amp;"))
               {
                  buffer.append('&');
               }
               else if (tmp.equals("&lt;"))
               {
                  buffer.append('<');
               }
               else if (tmp.equals("&gt;"))
               {
                  buffer.append('>');
               }
               else if (tmp.equals("&nbsp;"))
               {
                  buffer.append(' ');
               }
            }
            pos = pos + 1;
            if (pos <= strOrigin.length())
               strOrigin = strOrigin.substring(pos, strOrigin.length());
         }
      } while (index != -1);
      if (strOrigin.length() > 0)
         buffer.append(strOrigin.substring(0, strOrigin.length()));
      return buffer.toString();
   }
   
   /**
    * 将字符串转换成小写
    * @param strUp
    * @return
    */
   public static String toLowerCase(String strUp)
   {
      return strUp.toLowerCase();
   }

   /**
    * 去除右边多余的空格
    * @param value 待去右边空格的字符串
    * @return 去右边空格的字符串
    */
   public static String trimRight(String value) {
       String result = value;
       if (result == null)
           return result;
       char ch[] = result.toCharArray();
       int endIndex = -1;
       for (int i = ch.length - 1; i > -1; i--) {
           if (Character.isWhitespace(ch[i])) {
               endIndex = i;
           } else {
               break;
           }
       }
       if (endIndex != -1) {
           result = result.substring(0, endIndex);
       }
       return result;
   }

   /**
    * 去除左边多余的空格
    * @param value 待去左边空格的字符串
    * @return 去掉左边空格后的字符串
    */
   public static String trimLeft(String value) {
       String result = value;
       if (result == null)
           return result;
       char ch[] = result.toCharArray();
       int index = -1;
       for (int i = 0; i < ch.length; i++) {
           if (Character.isWhitespace(ch[i])) {
               index = i;
           } else {
               break;
           }
       }
       if (index != -1) {
           result = result.substring(index + 1);
       }
       return result;
   }
   
	
	/**
	 * 把包含有 html代码的字符串转换成纯字符串
	 * */
	public static String Html2Text(String htmlStr) { //含html标签的字符串 
      String textStr ="";
      Pattern p_script;
      Matcher m_script;
      Pattern p_style;
      Matcher m_style;
      Pattern p_html;
      Matcher m_html;
   
      try {
       String regEx_script = "<[\\s]*?script[^>]*?>[\\s\\S]*?<[\\s]*?\\/[\\s]*?script[\\s]*?>"; //定义script的正则表达式{或<script[^>]*?>[\\s\\S]*?<\\/script> } 
       String regEx_style = "<[\\s]*?style[^>]*?>[\\s\\S]*?<[\\s]*?\\/[\\s]*?style[\\s]*?>"; //定义style的正则表达式{或<style[^>]*?>[\\s\\S]*?<\\/style> } 
       String regEx_html = "<[^>]+>"; //定义HTML标签的正则表达式 
      
       p_script = Pattern.compile(regEx_script,Pattern.CASE_INSENSITIVE);
       m_script = p_script.matcher(htmlStr);
       htmlStr = m_script.replaceAll(""); //过滤script标签 

       p_style = Pattern.compile(regEx_style,Pattern.CASE_INSENSITIVE); 
       m_style = p_style.matcher(htmlStr);
       htmlStr = m_style.replaceAll(""); //过滤style标签 
      
       p_html = Pattern.compile(regEx_html,Pattern.CASE_INSENSITIVE); 
       m_html = p_html.matcher(htmlStr);
       htmlStr = m_html.replaceAll(""); //过滤html标签 

      /* htmlStr = htmlStr.replaceAll("&nbsp;", "");
       htmlStr = htmlStr.replaceAll("&#160;", "");
       htmlStr = htmlStr.replaceAll("&lt;", "");
       htmlStr = htmlStr.replaceAll("&gt;", "");
       htmlStr = htmlStr.replaceAll("&quot;", "");
       htmlStr = htmlStr.replaceAll("&amp;", "");
       htmlStr = htmlStr.replaceAll("&darr;", "");
       htmlStr = htmlStr.replaceAll("&uarr;", "");
       htmlStr = htmlStr.replaceAll("&rarr;", "");
       htmlStr = htmlStr.replaceAll("&mdash;", "");*/
       textStr = htmlStr;
      }catch(Exception e) {
               System.err.println("Html2Text: " + e.getMessage()); 
      }
      return textStr;//返回文本字符串 
	}
	
	/**
	 * 判断当前字符是否包含中文，包含则返回true
	 * 
	 */
	public static boolean isExisteChinese(String str){
		boolean flag=false;
		if(str==null)
			return flag;
		char[] charArray = str.toCharArray();  
		for(int i=0;i<charArray.length;i++){  
		if ((charArray[i] >= 0x4e00)&&(charArray[i] <= 0x9fbb)){  
		    flag=true;
		}       
		} 
		return flag;
	}
	
	/**
	 * 获取指定字符串的MD5加密串
	 * @param srcString 源字符串
	 * @return MD5加密串
	 */
	public static String getMd5String(String srcString){
		MessageDigest messageDigest = null;
		try {
			messageDigest = MessageDigest.getInstance("MD5");
			messageDigest.reset();
			messageDigest.update(srcString.getBytes("UTF-8"));
		} catch (Exception e) {
		}
		byte[] byteArray = messageDigest.digest();
		StringBuilder md5StrBuff = new StringBuilder();
		for (int i = 0; i < byteArray.length; i++) {
			if (Integer.toHexString(0xFF & byteArray[i]).length() == 1)
				md5StrBuff.append("0").append(
						Integer.toHexString(0xFF & byteArray[i]));
			else
				md5StrBuff.append(Integer.toHexString(0xFF & byteArray[i]));
		}
		return md5StrBuff.toString();
	}
	/**
	 * 是否包含某一字符串
	 */
	public static Boolean stringHasWhat(String what,String hasWhat){
		if (what!=null&&what!=""&&hasWhat!=null&&hasWhat!="") {
			if (what.indexOf(hasWhat)==-1) {
				return false;
			}else {
				return true;
			}
		}else {
			return false;
		}
	}
	/**
	 * 是否包含某一字符串
	 */
	public static Boolean stringLeftHasWhat(String what){
		List<String> list=new ArrayList<String>();
		if (what!=null&&what!="") {
			String[] result = what.split("\\@|\\﹫|\\#|\\﹟");  
			for (int i = 0; i < result.length; i++) {
				list.add(result[i]);
			}
		}
		System.err.println(list);
		if (list.size()<=1) {
			return false;
		}else {
			return true;
		}
	}
	public static Boolean stringLeftHasWhat(String what,String hasWhat){
		List<String> list=new ArrayList<String>();
		String returnString="";
		String[] result = null;
		if (what!=null&&what!="") {
			result = what.split("\\@|\\﹫|\\#|\\﹟");  
			if (result.length>=1) {
				returnString=result[0];
			}
		}
		if (returnString.equals(hasWhat)) {
			return true;
		}else if(result!=null&&result.length==1&&returnString.lastIndexOf(hasWhat)!=-1){
			return true;
		}else{
			return false;
		}
		
	}
	public static String stringRightWhat(String what){
		List<String> list=new ArrayList<String>();
		String returnString="";
		if (what!=null&&what!="") {
			String[] result = what.split("\\@|\\＠|\\﹫|\\#|\\﹟");  
			if(result.length==1){
				returnString=result[0];
			}else{
				for (int i = 1; i < result.length; i++) {
					returnString+=result[i];
				}
			}
			
		}
		return returnString;
	}
	public static String stringLeftWhat(String what){
		List<String> list=new ArrayList<String>();
		String returnString="";
		if (what!=null&&what!="") {
			String[] result = what.split("\\@|\\＠|\\﹫|\\#|\\﹟");  
			if (result.length>=1) {
				returnString=result[0];
			}
		}
		return returnString;
	}
	/**
	 * 安全输出(防止string为null)
	 */
	public static String toSafePrintOut(String what){
		if (what!=null) {
			return what;
		}else {
			return "";
		}
	}
	
	 public static final String SPECIAL_CHAR = "[`~!@#$%^&*+=|{}',:;\"[url=file://\\[\\].<]\\[\\].<>/[/url]?～！＠＃￥％……＆×（）——＋｜｛｝【】［］‘；：＂。，、．＜＞／☆？]";
	      
	     /**
	      * 替换特殊字符(全角&半角)
	      */
	     public static String StringFilter(String srcString) throws PatternSyntaxException {     
	         return Pattern.compile(SPECIAL_CHAR).matcher(srcString).replaceAll("").replaceAll("[url=]\\\\[/url]", "").trim();       
	     }

	
	public static void main(String[] args) {
		//System.out.println(StringHelper.stringLeftWhat("我@的项@目"));
		System.out.println(StringHelper.stringRightWhat("工作计划＠哈哈哈1"));
		System.out.println(StringHelper.stringRightWhat("工作计划﹫哈哈哈2"));
		System.out.println(StringHelper.stringRightWhat("工作计划@哈哈哈2"));
		//System.out.println(StringHelper.stringRightWhat(""));
		//System.out.println(StringHelper.stringLeftHasWhat("通讯录","通讯录"));
	}
}