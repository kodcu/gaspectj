package com.kodcu.app.aspects;

import com.kodcu.app.devices.Device;
import com.kodcu.app.devices.Mobile;
import com.kodcu.app.phones.*;
import com.kodcu.app.imp.*;
import com.kodcu.app.aspects.TraceAspect;
/**
 * 
 * @author HAKAN
 *
 */ 
public aspect SystemStructure {
 
	declare parents : com.kodcu.app.devices..* extends Device;

	declare parents : Phone extends Mobile;
	declare parents : SmartPhone extends Phone;

	declare parents : TraceAspect implements Printable;

}
