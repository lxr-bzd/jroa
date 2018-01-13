package test;

import java.io.IOException;


public class test {

	
	public static void main(String[] args) throws IOException {
		String str = "`mebid`, `bindbank`, `bindbankname`, `bankcardcode`, `contact`, `bindtime`";
		str = str.replaceAll("`", "");
		
		System.out.println(str);
		String [] ss = str.split(",");
		
		String out ="";
		for (String string : ss) {
			out+=",#{ model."+string.trim()+" }";
		}
		String out2 = "";
		for (String string : ss) {
			out2+=","+string.trim()+"=#{ model."+string.trim()+" }\n";
		}
		
		System.out.println(out2);
		
		System.out.println(out);
		
	}
}
