package com.kafei.util;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class PropsConfig {
	private static Logger logger = LoggerFactory.getLogger(PropsConfig.class);
	private static Properties props = new Properties();
	
	static{
		load();
	}
	
	private static synchronized void load() {
		InputStream is  = null;
		try {
			if(props==null || props.isEmpty()){
				String fileName = System.getProperty("sys.config.name");
				 is = PropsConfig.class.getClassLoader().getResourceAsStream(fileName);
				props.load(is);
			}
		} catch (FileNotFoundException e) {
			logger.error(e.getMessage(),"属性文件不存在");
		} catch (IOException e) {
			logger.error(e.getMessage(),"属性文件加载异常");
		}finally{
			IOUtils.closeQuietly(is);
		}
	}

	public  static String getPropValue(String key) {
		if(props == null || props.isEmpty()){
			load();
		}
		return (String)props.get(key);
	}
	
	public static int getPropValue(String key,int defaultV) {
		return getPropValue(key)!=null?Integer.parseInt(getPropValue(key)):defaultV;
	}
	
	public static String getPropValue(String key,String defaultV) {
		return getPropValue(key)!=null?getPropValue(key):defaultV;
	}
}
