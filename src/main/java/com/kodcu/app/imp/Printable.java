package com.kodcu.app.imp;

import java.io.OutputStream;
/**
 * 
 * @author HAKAN
 *
 */
public interface Printable {
	
	default void printSignature(OutputStream output, String longString) {
		output.write((longString + "\n").getBytes());
	}
	
}
