package com.egrc.cmt.cmttool;

import java.io.File;
import java.io.FileInputStream;
import java.util.Properties;

public class Utils {
	public static String fromProperties(String fileName, String key) 
	{
		String value = null;
		try
		{
			File f = new File("D:/workspaces/CMT/ContentManagement/cmt-data/"+fileName+".properties");
			FileInputStream fis = new FileInputStream(f);
			// Step 3
			Properties prop = new Properties();
			prop.load(fis);
			value = (String) prop.get(key);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return value;
	}
}
