package com.kodcu.app.aspects;

import com.kodcu.app.data.Data;
/**
 * 
 * @author HAKAN
 *
 */
public aspect DataAspect {

	
	private int Data.countNoteBook;
	private int Data.countTablet;
	private int Data.countPhone; 
	
	/**
	 * 
	 * @return length of the notebook list
	 */
	public int Data.getNoteBookslength(){
		return this.countNoteBook;
	}
	
	/**
	 * 
	 * @return length of the phone list
	 */
	public int Data.getPhoneslength(){
		return this.countPhone;
	}	
	
	/**
	 * 
	 * @return length of the tablet list
	 */
	public int Data.getTabletslength(){
		return this.countTablet; 
	} 
	
	private pointcut listsLength() : execution(Data.new(..));
	
	after(Data data) : listsLength() && this(data) {
		 data.countNoteBook = data.getNoteBooksAsList().size();
		 data.countTablet = data.getTabletsAsList().size();
		 data.countPhone = data.getPhonesAsList().size();
	}
}
