package com.kodcu.app.data;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Stream;

import com.kodcu.app.devices.Device;
import com.kodcu.app.devices.Mobile;
import com.kodcu.app.devices.NoteBook;
import com.kodcu.app.devices.Tablet;
import com.kodcu.app.phones.Phone;
import com.kodcu.app.phones.SmartPhone;
/**
 * 
 * @author HAKAN
 *
 */
public class Data {

	final Phone phone1 = new Phone("9000");
	final Phone phone2 = new Phone("3210", Brand.Nokia);
	final Phone phone3 = new Phone("3220", Brand.Nokia);

	final SmartPhone mphone1 = new SmartPhone("S5", Brand.Samsung);
	final SmartPhone mphone3 = new SmartPhone("Note 3", Brand.Samsung);
	final SmartPhone mphone2 = new SmartPhone("Lumia 730", Brand.Nokia);
	final SmartPhone mphone4 = new SmartPhone("Honor 4X", Brand.Huawei);
	final SmartPhone mphone5 = new SmartPhone("Liquid Z500", Brand.Acer);

	final NoteBook nb1 = new NoteBook("ZENBOOK 1", Brand.Asus);
	final NoteBook nb2 = new NoteBook("ZENBOOK 2", Brand.Asus);

	final Tablet tt1 = new Tablet("iPad Air");
	final Tablet tt2 = new Tablet("Galaxy Tab", Brand.Samsung);
	final Tablet tt3 = new Tablet("Iconia Tab 8", Brand.Acer);
	final Tablet tt4 = null;

	public Stream<Mobile> getPhonesAsStream() {
		return Stream.of(phone1, phone2, phone3, mphone1, mphone2, mphone3,
				mphone4, mphone5);
	} 

	public List<Device> getPhonesAsList() {
		return Arrays.asList(phone1, phone2, phone3, mphone1, mphone2, mphone3,
				mphone4, mphone5);
	}

	public Stream<Tablet> getTabletsAsStream() {
		return Stream.of(tt1, tt2, tt3, tt4);
	}

	public List<Device> getTabletsAsList() {
		return Arrays.asList(tt1, tt2, tt3, tt4);
	}

	public Stream<NoteBook> getNoteBooksAsStream() {
		return Stream.of(nb1, nb2);
	}

	public List<Device> getNoteBooksAsList() {
		return Arrays.asList(nb1, nb2);
	}

	public Stream<Device> getAllDataAsStream() {
		return Stream.of(phone1, phone2, phone3, mphone1, mphone2, mphone3,
				mphone4, mphone5, tt1, tt2, tt3, tt4, nb1, nb2);
	}

}
