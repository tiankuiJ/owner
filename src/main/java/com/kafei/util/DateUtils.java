package com.kafei.util;

import org.apache.commons.lang3.StringUtils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;

public class DateUtils {
	
	public static Date addDay(Date date, int day) {
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		c.add(Calendar.DATE, day);
		return c.getTime();
	}
	public static Date subDay(Date date, int day) {
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		c.setTimeInMillis(date.getTime()-day*24*60*60*1000);
		return c.getTime();
	}
	
	/**
	 * 格式化日期
	 * @param d
	 * @return string
	 */
	public static String forMatDate(Date d){
		if(d==null)
			d = new Date();
		return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(d);
	}


	/**
	 * 格式化日期
	 * @param d
	 * @return string
	 */
	public static String forMatDateOther(Date d){
		return new SimpleDateFormat("yyyy-MM-dd").format(d);
	}
	public static String forMatDateWithNoTime(Date d){
		return new SimpleDateFormat("yyyy-MM-dd").format(d);
	}
	
	public static String forMatDateWithZw(Date d){
		return new SimpleDateFormat("yyyy年MM月dd日").format(d);
	}
	
	public static int daysBetween(Date date1, Date date2){
		Calendar cal = Calendar.getInstance();
		cal.setTime(date1);
		long time1 = cal.getTimeInMillis();
		cal.setTime(date2);
		long time2 = cal.getTimeInMillis();
		long between_days = (time2 - time1) / (1000 * 3600 * 24);
		return Integer.parseInt(String.valueOf(between_days));
	}
	
	public static int miBetween(Date date1, Date date2){
		Calendar cal = Calendar.getInstance();
		cal.setTime(date1);
		long time1 = cal.getTimeInMillis();
		cal.setTime(date2);
		long time2 = cal.getTimeInMillis();
		long between_days = (time2 - time1) / (1000 * 60);
		return Integer.parseInt(String.valueOf(between_days));
	}
	
	public static boolean isSameDate(Date d1,Date d2){
		Calendar c1 = Calendar.getInstance();
		c1.setTime(d1);
		Calendar c2 = Calendar.getInstance();
		c2.setTime(d2);
		if(c1.get(Calendar.YEAR)==c2.get(Calendar.YEAR)){
			if(c1.get(Calendar.MONTH)==c2.get(Calendar.MONTH)){
				if(c1.get(Calendar.DAY_OF_MONTH)==c2.get(Calendar.DAY_OF_MONTH)){
					return true;
				}
			}
		}
		return false;
	}
	
	public static boolean isYestoday(Date d1){
		Calendar c1 = Calendar.getInstance();
		c1.setTime(d1);
		c1.add(Calendar.DAY_OF_YEAR, 1);
		return isSameDate(c1.getTime(), new Date());
	}

	/**
	 * 计算两个日期之间 月份差
	 */
	public static int monthNum(){

		return 0;
	}


	/**
	 * 得到过去／未来几天的日期
	 * @param intervals  天数
	 * @return
	 */
	public static ArrayList<String> getPastDays(int intervals ) {
		ArrayList<String> pastDaysList = new ArrayList<>();
		ArrayList<String> fetureDaysList = new ArrayList<>();
		for (int i = 0; i <intervals; i++) {
			pastDaysList.add(getPastDate(i));
		}
		return pastDaysList;
	}

	/**
	 * 获取过去第几天的日期
	 *
	 * @param past
	 * @return
	 */
	public static String getPastDate(int past) {
		Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.DAY_OF_YEAR, calendar.get(Calendar.DAY_OF_YEAR) - past);
		Date today = calendar.getTime();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String result = format.format(today);
		return result;
	}

	/**
	 * 获取未来 第 past 天的日期
	 * @param past
	 * @return
	 */
	public static String getFetureDate(int past) {
		Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.DAY_OF_YEAR, calendar.get(Calendar.DAY_OF_YEAR) + past);
		Date today = calendar.getTime();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String result = format.format(today);
		return result;
	}
	
	/**
	 * 指定年份最早一刻
	 * @param num
	 * @return
	 */
	public static Date loadNumToYearFirstDay(int num){
		Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.YEAR, num);
		calendar.set(Calendar.DAY_OF_YEAR, 1);
		calendar.set(Calendar.HOUR_OF_DAY, 0);
		calendar.set(Calendar.MINUTE, 0);
		calendar.set(Calendar.SECOND, 0);
		calendar.set(Calendar.MILLISECOND, 0);
		return calendar.getTime();
	}
	
	/**
	 * 指定年份后一刻
	 * @param num
	 * @return
	 */
	public static Date loadNumToYearLastDay(int num){
		Calendar calendar = Calendar.getInstance();
		if(num==0){
			num = calendar.get(Calendar.YEAR);
		}
		calendar.setTime(loadNumToYearFirstDay(num+1));
		calendar.add(Calendar.MILLISECOND, -1);
		return calendar.getTime();
	}
	/**
	 * 判读是否超过2小时
	 * @param oldDate
	 * @return
	 */
	public static boolean moreThanTwoHours(Date oldDate){
		Calendar c = Calendar.getInstance();
		c.setTime(oldDate);
		if(((System.currentTimeMillis()-c.getTimeInMillis())/1000)<7200){
			return false;
		}
		return true;
	}
	
	/**
	 * 根据日期字符串获取年龄
	 * @param str
	 * @return
	 */
	public static int getAge(String str){
		if(StringUtils.isNotEmpty(str)){
			try {
				Date d = new SimpleDateFormat("yyyy").parse(str);
				Calendar c = Calendar.getInstance();
				int cy = c.get(Calendar.YEAR);
				c.setTime(d);
				int uy = c.get(Calendar.YEAR);
				int num = cy-uy;
				return num<0?0:num;
			} catch (ParseException e) {
				return 0;
			}
		}
		return 0;
	}
	
	
	public static Date parseDate(String val) throws ParseException{
		if(val.contains("/")){
			return new SimpleDateFormat("yy/MM/dd").parse(val);
		}else{
			return new SimpleDateFormat("yy-MM-dd").parse(val);
		}
	}


	/**
	 * 根据当前日期  获取 本周的周一至当前
	 * @param date
	 * @return
	 */
	public static ArrayList<String> getTimeInterval(Date date) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		ArrayList<String> list = new ArrayList<>();
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		// 判断要计算的日期是否是周日，如果是则减一天计算周六的，否则会出问题，计算到下一周去了
		int dayWeek = cal.get(Calendar.DAY_OF_WEEK);// 获得当前日期是一个星期的第几天
		if (1 == dayWeek) {
			cal.add(Calendar.DAY_OF_MONTH, -1);
		}
		// 设置一个星期的第一天，按中国的习惯一个星期的第一天是星期一
		cal.setFirstDayOfWeek(Calendar.MONDAY);
		// 获得当前日期是一个星期的第几天
		int day = cal.get(Calendar.DAY_OF_WEEK);
		// 根据日历的规则，给当前日期减去星期几与一个星期第一天的差值
//		System.out.println("abc:"+day);
		for(int i = 0;i < day-1;i++){
			Calendar cal1 = Calendar.getInstance();
			cal1.setTime(date);
			cal1.add(Calendar.DATE, -i);
			list.add(format.format(cal1.getTime()));
		}
		Collections.reverse(list);
		return list;
	}

	/**
	 * 根据当前日期  获取 上周的周一至周日
	 * @return
	 */
	public static ArrayList<String> getLastTimeInterval() {
		ArrayList<String> list = new ArrayList<>();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		for(int i = 6;i >= 0;i--){
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(new Date());
			int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK) - 1;
			int offset =  - (dayOfWeek+i);
			calendar.add(Calendar.DATE , offset);
			list.add(format.format(calendar.getTime()));
		}
		return list;
	}
	
}
