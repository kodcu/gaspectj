package com.kodcu.app.aspects;

import java.util.Objects;
import com.kodcu.app.data.Brand;
import com.kodcu.app.devices.Device;
/**
 * Check the parameters of the constructor of the class <code>Device<code>
 * in that each param must contain a non-null value
 * 
 * @author HAKAN
 *
 */
public aspect ValidationAspect {
 
	before(String type): execution(Device.new(String)) && args(type){
		 Objects.requireNonNull(type);
	}
	
	before(String type,Brand brand): execution(Device.new(String,Brand)) && args(type,brand){
		 Objects.requireNonNull(type);
		 Objects.requireNonNull(brand);
	}
}
