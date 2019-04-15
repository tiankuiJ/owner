package com.kafei.util;

import org.springframework.format.Formatter;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

public class DateFormatter implements Formatter<Date>{

	public String print(Date object, Locale locale) {
		return null;
	}

	public Date parse(String text, Locale locale) throws ParseException {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = null;
		try {
			date = format.parse(text);
		} catch (Exception e) {
			try {
				format = new SimpleDateFormat("yyyy-MM-dd");
				date = format.parse(text);
			}catch (Exception e1){
				format = new SimpleDateFormat("yyyy-MM");
				date = format.parse(text);
			}

		}
		return date;
	}

}
