/*package com.egrc.cmt.cmttool;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.apache.poi.EncryptedDocumentException;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;

public class ContentManagementFileAttachmentBatch1 {
	final static Logger logger = Logger.getLogger(ContentManagementFileAttachmentBatch1.class);
	int rowCount;
	static String cellData;
	static String docId;
	static String filepath;
	static String fileName;
	static String docIdFolder;
	public static void main(String[] args)
			throws EncryptedDocumentException, InvalidFormatException, IOException, InterruptedException {
		File propFile = new File("./cmt-data/configuration.properties");
		FileInputStream propFis = new FileInputStream(propFile);
		String logPropertyPath = null;
		Properties properties = new Properties();
		properties.load(propFis);
		logPropertyPath = properties.getProperty("log4jPath");

		if (logPropertyPath != null) {
			PropertyConfigurator.configure(logPropertyPath);
		} else {
			logger.info("Invalid logproperty path. verify file-'configuration.properties' and 'log4j.properties'. ");
		}
		String dataFile = properties.getProperty("clientData");
		File f = new File(dataFile);
		String sheetName = properties.getProperty("sheetName");
		String basFoldersPath = properties.getProperty("basFoldersPath");

		FileInputStream fis = new FileInputStream(f);
		Workbook wb = WorkbookFactory.create(fis);
		Sheet st = wb.getSheet(sheetName);
		Row r = st.getRow(0);
		int colCount = r.getLastCellNum();
		int rowCount = st.getLastRowNum() + 1;
		logger.info("No Of Files Found :" + rowCount);
		
		List<String> allData = new ArrayList();
		int cou = 1;
		for (int i = 1; i < rowCount; i++) {
			String data = "";
			
			for (int j = 0; j < colCount; j++) {
				if (j == 1)
					continue;
				if (st.getRow(i).getCell(0) == null)
					continue;
				docIdFolder = st.getRow(i).getCell(j).toString();
				cellData = st.getRow(i).getCell(j).toString();
				data += (j == 0) ? cellData	: cellData;
				data += "	";	
				
			}
			DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss.sss");
			Date date = new Date();
			String timeStamp = dateFormat.format(date).toString();
			if(data == "" || data == null)
				continue;
			String filelocation = (String) data.subSequence(data.indexOf("/"), data.length());
	        String fileName = filelocation.substring(1).trim();
	        String folderPath = filelocation.substring(0,filelocation.lastIndexOf("/")+1).trim();
	        String [] arrData = data.split("	");
			docIdFolder = arrData[0];	
			docId = arrData[0].replaceAll("[^0-9]", "");	
			System.out.println("1	"+docId+"	ziff_davis/"+docIdFolder+"/Base Folder/"+fileName+"	"+i+"	null	"+folderPath+"	0	"+timeStamp+"	user	0	null	null	null");
			allData.add("1	"+docId+"	"+fileName+"	"+cou+"	null	"+folderPath+"	0	"+timeStamp+"	user	0	null	null	null");
			//allData.add(data);
			cou++;
		}
		
		ContentManagementFileAttachmentBatch1 cmt = new ContentManagementFileAttachmentBatch1();
		cmt.WriteToFileAttachement(allData.iterator(), properties);
	}

	void WriteToFileAttachement(Iterator<String> iterator, Properties properties)
			throws InvalidFormatException, IOException {
		Writer writer = null;
		String fileAttachment = properties.getProperty("fileAttachment");
		File f3 = new File(fileAttachment);
		writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(f3), "utf-8"));
		writer.write("SOURCEID	DOCUMENTID	FILENAME	ATTACHMENTID	SHARE_ID	FOLDER_PATH	VERSION	CREATED	CREATED_BY	CHECKOUT_STATUS	CHECKOUT_MACHINE	LEGACY_CHECKOUT_PATH	CHECKOUT_BY" + "\n");
		while (iterator.hasNext())
			writer.write(iterator.next() + "\n");
		writer.flush();
		writer.close();
	}
}
*/