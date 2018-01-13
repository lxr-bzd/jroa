package com.foxtail.common.util;

import java.io.UnsupportedEncodingException;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.List;
import java.util.regex.Pattern;

/**
* Description:通用检查工具类 
* @ClassName: PublicUtil 
 */
public class PublicUtil {
	
	/**
	* Description:检查邮件是否合法    
	* @Title: checkEmail  
	 */
    public static boolean checkEmail (String email) {
        Pattern p = Pattern.compile("^[_\\.0-9a-z-]+@([0-9a-z][0-9a-z-]+\\.)+[a-z]{2,3}$");
        return p.matcher(email).matches();
    }

    /**
    * Description:检查是否是空的list
    * @Title: checkEmptyList  
     */
    public static boolean checkEmptyList (List list) {
        if ((list == null) || (list.size() == 0)) {
            return true;
        }
        else {
            return false;
        }
    }

    /**
    * Description:检查字符串是否为空    
    * @Title: checkEmptyString  
     */
    public static boolean checkEmptyString (String str) {
        if(((str == null) || (str.trim().length() == 0))||"null".equals(str)) {
            return true;
        }else{
            return false;
        }
    }

    /**
    * Description:转换字符串编码    
    * @Title: convertStringEncode  
     */
    public static String convertStringEncode (String str, String encode) {
        try {
            byte bytes[] = str.getBytes(encode);    // "ISO-8859-1");
            String UTFtekst = new String(bytes);
            return UTFtekst;
        }
        catch (UnsupportedEncodingException w) {
            System.out.println("cannot get this charset");
            return "error";
        }
    }

    /**
    * Description:格式化float型数据    
    * @Title: formatFloat  
     */
    public static String formatFloat (float source) {
        return new DecimalFormat("######0.00").format(source);
    }
    
    /**
    * Description:数字前面补零    
    * @Title: leftFillPosition  
     */
    public static String leftFillPosition(int count,int data){
    	//得到一个NumberFormat的实例
        NumberFormat nf = NumberFormat.getInstance();
        //设置是否使用分组
        nf.setGroupingUsed(false);
        //设置最大整数位数
        nf.setMaximumIntegerDigits(count);
        //设置最小整数位数   
        nf.setMinimumIntegerDigits(count);
    	return nf.format(data);
    }
    
}
