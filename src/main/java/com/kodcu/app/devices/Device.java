package com.kodcu.app.devices;

import com.kodcu.app.data.Brand;
/**
 * 
 * @author HAKAN
 *
 */
public class Device {

	private String type;
	private Brand brand;
	
	public Device() {
		this.type = null;
		this.brand = Brand.Unknown;
	}
	
	public Device(String type){
		this.type = type;
		this.brand = Brand.Unknown;
	}
	
	public Device(String type,Brand brand){
		 this.type = type;
		 this.brand = brand;
	}
	
	public String deviceType(){
		return type;
	}
	
	public Brand deviceBrand(){
		return brand;
	}
}
