package com.kodcu.app.aspects;

import java.lang.reflect.Modifier;
import com.kodcu.app.main.Startup;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.Optional;

import org.aspectj.lang.Signature;
import org.aspectj.lang.reflect.CodeSignature;
import org.aspectj.lang.reflect.MethodSignature;
import org.aspectj.lang.reflect.ConstructorSignature;
/**
 * 
 * @author HAKAN
 *
 */
public aspect TraceAspect {

	private OutputStream output;

	pointcut trace() : execution(* Startup.main(..));

	before() : trace(){
		Runnable r = () -> {
			startTracing();
			System.out.println("### Starting ###");
		};
		r.run();
	}

	after() : trace(){
		Runnable r = () -> {
			System.out.println("### See the trace file under MaJ");
			System.out.println("### Ending ###");
			stopTracing();
		};
		r.run();
	} 

	// trace all kind of method & constructor calls within the class "Startup"
	// print all the signatures that we created without AJDT's default signature view
	after() : (call(* *(..)) || (call(*.new(..)) && !call(StringBuilder.new(..))) || get(* *))  && 
			  within(com.kodcu.app.main..*){
		Optional<Signature> targetObj = Optional.of(thisJoinPoint.getSignature());
		targetObj 
		.filter(sign -> Boolean.logicalOr(sign instanceof MethodSignature, sign instanceof ConstructorSignature)) // Hmm.. skip fieldSignature
		.ifPresent(signature -> {
			String longResult = getAdvisedMembers(thisJoinPoint,signature);
			printSignature(TraceAspect.aspectOf().output,longResult);
		});
	}

	/**
	 * Get the blueprint of the advised method(s) and constructor(s) using our way
	 * 
	 */
	private String getAdvisedMembers(org.aspectj.lang.JoinPoint joinPoint, Signature signature) {
		String adviceKind = joinPoint.getKind();
		int lineNumber = joinPoint.getSourceLocation().getLine();

		if(signature instanceof MethodSignature){
			MethodSignature methodSignature = (MethodSignature)signature;
			String sketch = sketch(adviceKind, methodSignature, lineNumber);
			return sketch;
		}
		else {
			ConstructorSignature constructorSignature = (ConstructorSignature)signature;
			String sketch = sketch(adviceKind, constructorSignature, lineNumber);
			return sketch;
		}
	}

	/**
	 *
	 * Overloaded methods
	 * 
	 */

	private String sketch(String adviceKind, ConstructorSignature constructorSignature, int lineNumber) {

		String name = constructorSignature.getName();
		String declaringType = constructorSignature.getDeclaringTypeName();
		String modifier = Modifier.toString(constructorSignature.getModifiers());
		String kind = adviceKind + "(";

		String kmd  =  String.join(" ",kind, modifier,declaringType);
		String kmdn =  String.join(".",kmd,name,"new");
		String pattern  =  String.join("::","after","JPoint",String.valueOf(lineNumber),printArgs(constructorSignature, kmdn));

		return pattern;
	}

	private String sketch(String adviceKind, MethodSignature methodSignature, int lineNumber) {

		String name = methodSignature.getName();
		String returnType = methodSignature.getReturnType().getName();
		String declaringType = methodSignature.getDeclaringTypeName();
		String modifier = Modifier.toString(methodSignature.getModifiers());
		String kind = adviceKind + "(";

		String kmrd  =  String.join(" ",kind, modifier,returnType,declaringType);
		String kmrdn =  String.join(".",kmrd,name);
		String pattern  =  String.join("::","after","JPoint",String.valueOf(lineNumber),printArgs(methodSignature, kmrdn));

		return pattern;	
	}

	/**
	 * 
	 * Other method declarations
	 * 
	 */
	
	private String printArgs(CodeSignature signature,String declaration) {
		String params = declaration + "(";
		for (int i = 0; i < signature.getParameterTypes().length; i++) {
			params += " " + signature.getParameterTypes()[i].getSimpleName() + " " + signature.getParameterNames()[i]+ " ";
		}
		params += ") );";
		return params;
	}

	private void startTracing() {
		output = new FileOutputStream("trace.txt", false);
		output.write("First ====> trace all kind of method & constructor calls within the class \"Startup\"\n".getBytes());
	}

	private void stopTracing() {
		output.write("<==== Last".getBytes());
		output.close();
	}
}