package com.mercury.util;

import java.io.FileReader;
import java.io.FileWriter;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVParser;
import org.apache.commons.csv.CSVPrinter;
import org.apache.commons.csv.CSVRecord;

import com.mercury.beans.Transaction;


public class CsvUtil {
	public static String csvPath;
	
	public CsvUtil(){}
	public CsvUtil(String csvPath){
		CsvUtil.csvPath = csvPath;
	}
	public String getCsvPath() {
		return csvPath;
	}
	public void setCsvPath(String csvPath) {
		CsvUtil.csvPath = csvPath;
	}
	
	public static List<Transaction> parseCSV(String csvFile){
		List<Transaction> list = new ArrayList<Transaction>();
		try{
			FileReader fr = new FileReader(csvFile);
			CSVParser parser = new CSVParser(fr, CSVFormat.DEFAULT);
			List<CSVRecord> l = parser.getRecords();
			for (CSVRecord r:l){
				Transaction ts = new Transaction();
				ts.setUid(Integer.parseInt(r.get(0)));
				ts.setSid(Integer.parseInt(r.get(1)));
				ts.setAmount(Integer.parseInt(r.get(2)));
				ts.setPrice(new BigDecimal(r.get(3)));
				ts.setTs(Timestamp.valueOf(r.get(4)));
				list.add(ts);
			}
			fr.close();
			parser.close();
			
		}catch (Exception e){
			e.printStackTrace();
		}
		return list;
	}
	
	public static void appendCSV(Transaction trans, String csvFile){
		try{
			FileWriter fw = new FileWriter(csvFile, true);			
			CSVPrinter cp = new CSVPrinter(fw, CSVFormat.DEFAULT);
			cp.printRecord((Object[]) trans.toString().split(","));
			fw.flush();
			fw.close();
			cp.close();			
		}catch (Exception e){
			e.printStackTrace();
		}
	}
	
	public static void rewriteCSV(List<Transaction> trans, String csvFile){
		try{
			FileWriter fw = new FileWriter(csvFile);
			CSVPrinter cp = new CSVPrinter(fw, CSVFormat.DEFAULT);
			for (Transaction t: trans){
				cp.printRecord((Object[]) t.toString().split(","));
			}
			fw.flush();
			fw.close();
			cp.close();
		}catch (Exception e){
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args){
		Transaction t1 = new Transaction(1,1,1000,new BigDecimal(20.02f), new Timestamp(System.currentTimeMillis()));
		Transaction t2 = new Transaction(2,2,-1000,new BigDecimal(20.02f), new Timestamp(System.currentTimeMillis()));
		List<Transaction> list = new ArrayList<Transaction>();
		list.add(t1);
		list.add(t2);
		rewriteCSV(list, "test.csv");
	}
}
