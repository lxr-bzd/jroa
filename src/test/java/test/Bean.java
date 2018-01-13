package test;

import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;

import com.foxtail.model.BaseModel;

public class Bean {

	public static void main(String[] args) throws Exception {
		System.out.println(getModelAttriButeType(BaseModel.class));
	}
	
	/**
     * java读取文件中的属性类型
     * @param model
     * @return
     * @throws Exception
     */
    public static Map<String,String> getModelAttriButeType(Class cls) throws Exception{
        Field[] field = cls.getDeclaredFields();        //获取实体类的所有属性，返回Field数组  
        Map<String,String> map = new HashMap<String, String>();
        for(int j=0 ; j<field.length ; j++){     //遍历所有属性
              String name = field[j].getName();    //获取属性的名字
              
              //System.out.print("attribute name:"+name);     
              name = name.substring(0,1).toUpperCase()+name.substring(1); //将属性的首字符大写，方便构造get，set方法
              String type = field[j].getGenericType().toString();    //获取属性的类型
              /*if(type.equals("class java.lang.String")){   //如果type是类类型，则前面包含"class "，后面跟类名
                  Method m = model.getClass().getMethod("get"+name);
                  String value = (String) m.invoke(model);    //调用getter方法获取属性值
                  if(value != null){

                      System.out.println("attribute value:"+value);
                  }
              }*/
              type = type.replace("class ", "");
              //System.out.println("=>:"+type);
              map.put(name, type);
              
          }
        return map;
    }
	
}
