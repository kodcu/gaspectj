package com.kodcu.app.aspects;
import java.io.IOException;

import com.kodcu.app.aspects.TraceAspect;
/**
 * 
 * @author HAKAN
 *
 */
public aspect SoftenedHandlerAspect { 

	// including the defender method declared in the interface Printable
	declare soft : IOException : execution(* printSignature(..)) ||
				   				 execution(* TraceAspect.*Tracing()) ;
	
} 
