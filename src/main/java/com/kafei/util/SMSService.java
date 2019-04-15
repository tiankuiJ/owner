package com.kafei.util;

import org.apache.commons.lang3.StringUtils;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;

/**
 * 公司名称：四川咖菲科技有限公司
 * 联系电话： 13398376166
 * 联系人： 陈德强
 * 邮箱：200751119@qq.com
 * 微信号： mycdq168
 * 地址：四川省绵阳市创新中心二期412
 * 官方网站 : http://www.kafeikeji.com/
 * 微信公众号： 咖啡科技
 * 项目名称：党建
 * 类名称：短信接口
 * 类描述：   
 * 创建人：蒋莲
 * 创建时间： 2017年4月6日
 * 修改人：
 * 修改时间：
 * 修改备注：   
 * @version 1.0   
 */
public class SMSService {
	public static String sendCode(String mobile,String content,String address){
		if(StringUtils.isBlank(mobile) || StringUtils.isBlank(content) || content.length()>300){
			return "格式错误";
		}
		String result = "";
        BufferedReader in = null;
        try {
        	address = "https://sdk2.028lk.com/sdk2/BatchSend2.aspx?CorpID=XAJS001095&Pwd=xi@1095";
        	String urlNameString = address+"&Mobile="+mobile+"&Content="+URLEncoder.encode(content.replaceAll("<br/>", " "), "GB2312");
        	URL realUrl = new URL(urlNameString);
            URLConnection connection = realUrl.openConnection();
            connection.connect();
            in = new BufferedReader(new InputStreamReader(
                    connection.getInputStream()));
            String line;
            while ((line = in.readLine()) != null) {
                result += line;
            }
        } catch (Exception e) {
            System.out.println("短信get方法error:" + e);
        }
        finally {
            try {
                if (in != null) {
                    in.close();
                }
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
        System.out.println(content);
        System.out.println("短信回调:"+result);
        int code = Integer.parseInt(result);
        if(code>0){
        	result = "验证码已下发，请注意查收"; 
        }else{
        	 switch (code) {
     		case -2:
     			result = "其他错误";
     			break;
     		case -5:
//     			result = "余额不足，请充值";
     			result = "发送失败";
     			break;
     		case -6:
     			result = "定时发送时间不是有效的时间格式";
     			break;
     		case -7:
     			result = "提交信息末尾未签名，请添加中文的企业签名【 】";
     			break;
     		case -11:
     			result = "屏蔽手机号码";
     			break;
     		case -100:
     			result = "IP黑名单";
     		}
        }
        return result;
	}
	
	public static int getNum() {
		String result = "";
		BufferedReader in = null;
		try {
			String address = "https://sdk2.028lk.com/sdk2/SelSum.aspx?CorpID=XAJS001095&Pwd=xi@1095";
			URL realUrl = new URL(address);
			URLConnection connection = realUrl.openConnection();
			connection.connect();
			in = new BufferedReader(new InputStreamReader(
					connection.getInputStream()));
			String line;
			while ((line = in.readLine()) != null) {
				result += line;
			}
		} catch (Exception e) {
			System.out.println("短信get方法error:" + e);
		} finally {
			try {
				if (in != null) {
					in.close();
				}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		int code = Integer.parseInt(result);
		if (code > 0)
			return code;
		System.out.println(result);
		return -1;
	}
	public static void main(String[] args) {
		SMSService.sendCode("18980124835", "您的验证码是123，在30分钟内有效。如非本人操作请忽略本短信。", null);
	}
}
