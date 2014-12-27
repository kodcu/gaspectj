package com.kodcu.app.main;

import java.util.List;
import java.util.Optional;
import java.util.stream.Stream;

import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;

import com.kodcu.app.data.Brand;
import com.kodcu.app.data.Data;
import com.kodcu.app.devices.Device;
import com.kodcu.app.devices.NoteBook;
import com.kodcu.app.devices.Tablet;
/**
 * 
 * @author HAKAN
 *
 */
public class Startup {  

	public static void main(String[] args) { 
		
		Data data = new Data();
		System.out.println("The lenght of the tablet list : " + data.getTabletslength());
		
		List<Device> tablets =  data.getPhonesAsList();
		System.out.println("## Display all the phones ##");
		tablets.forEach(t -> {
			System.out.println(t.deviceBrand() +"\t::"+t.deviceType());
		});
		System.out.println("## Don't display phones being an unknown brand ##");
		data.getPhonesAsStream().filter(p -> !p.deviceBrand().equals(Brand.Unknown))
								.forEach(p -> System.out.println(p.deviceBrand() +"\t::"+p.deviceType()));
		
		System.out.println("## Match any Asus notebook, if present return true, otherwise false ##");
		Stream<NoteBook> streamNoteBook = data.getNoteBooksAsStream();
		boolean included = streamNoteBook.anyMatch(n -> n.deviceBrand().equals(Brand.Asus));
		System.out.println(included);
		
		System.out.println("## Show non-null tablet brands ##");
		data.getTabletsAsStream().forEach(t->{
			Optional<Tablet> table = Optional.ofNullable(t);
			table.ifPresent(p->{
				System.out.println(p.deviceBrand());
			});
		});
		
		System.out.println("## Show only non-null Samsung and Huawei devices");
		data.getAllDataAsStream().forEach(dev -> {
			Optional<Device> device = Optional.ofNullable(dev);
			device.filter(d -> Boolean.logicalOr(d.deviceBrand().equals(Brand.Samsung) , d.deviceBrand().equals(Brand.Huawei)))
				  .ifPresent(Startup::showBeautyMessage);
		});	
		
		ScriptEngineManager manager = new ScriptEngineManager();
		ScriptEngine engine = manager.getEngineByName( "JavaScript" );
		        
		System.out.println( engine.getClass().getName() );
		try {
			System.out.println( "Result:" + engine.eval( "function f() { return 1; }; f() + 1;" ) );
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	} 
	
	private static void showBeautyMessage(Device d){
		System.out.println("<"+d.deviceBrand()+">\t:: ("+d.deviceType()+")");
	}
}
