package com.kafei.util;
import org.apache.commons.lang3.StringUtils;
import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.math.BigDecimal;
import java.net.URL;

public class AESUtil {
	/*
	 * 加密用的Key 可以用26个字母和数字组成 此处使用AES-128-CBC加密模式，key需要为16位。
	 */
	private String sKey = "0123456789abcdef";
	private String ivParameter = "0123456789abcdef";
	private static AESUtil instance = null;

	private AESUtil() {

	}
	private AESUtil(String key) {
		this.sKey=key;
	}
	public static AESUtil getInstance() {
		if (instance == null)
			instance = new AESUtil();
		return instance;
	}
	public static AESUtil getInstance(String key) {
		if (instance == null)
			instance = new AESUtil(key);
		return instance;
	}
	// 加密
	public String encrypt(String sSrc) throws Exception {
		Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
		byte[] raw = sKey.getBytes();
		SecretKeySpec skeySpec = new SecretKeySpec(raw, "AES");
		IvParameterSpec iv = new IvParameterSpec(ivParameter.getBytes());// 使用CBC模式，需要一个向量iv，可增加加密算法的强度
		cipher.init(Cipher.ENCRYPT_MODE, skeySpec, iv);
		byte[] encrypted = cipher.doFinal(sSrc.getBytes("utf-8"));
		return new BASE64Encoder().encode(encrypted);// 此处使用BASE64做转码。
	}

	// 解密
	public String decrypt(String sSrc) throws Exception {
		try {
			byte[] raw = sKey.getBytes("ASCII");
			SecretKeySpec skeySpec = new SecretKeySpec(raw, "AES");
			Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
			IvParameterSpec iv = new IvParameterSpec(ivParameter.getBytes());
			cipher.init(Cipher.DECRYPT_MODE, skeySpec, iv);
			byte[] encrypted1 = new BASE64Decoder().decodeBuffer(sSrc);
			byte[] original = cipher.doFinal(encrypted1);
			String originalString = new String(original, "utf-8");
			return originalString;
		} catch (Exception ex) {
			return null;
		}
	}

	public void test(){

	}

	public static void main(String[] args) throws Exception {
//		System.out.println(AESUtil.getInstance().decrypt("/o4Xso1dtVGZM0/BFv2jPg=="));
//		System.out.println(AESUtil.getInstance().encrypt("123455"));
//		String a = "http://localhost:8080/files/EC3DFDCB4E361.jpg";
//		System.out.println(a.lastIndexOf("/")+1);//获取到文件名称);
//		Double d = 1.0;
//		Double d1 = 0.9;
//		String str = Double.toString(0.1000000000000000055511151231257827021181583404541015625);
////		System.out.println((new BigDecimal(d.toString()).subtract(new BigDecimal(d1.toString()))).doubleValue());
//		System.out.println(new BigDecimal(
//				str).toString());// 0.1
		String str = null;
		System.out.println(str);
	}
}
