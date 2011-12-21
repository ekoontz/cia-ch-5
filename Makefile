.PHONY: test clean repl classes compile-gen-clojure
CLASSPATH=.:classes:src:/Users/ekoontz/.m2/repository/org/clojure/clojure/1.3.0/clojure-1.3.0.jar
clean:
	-rm `find classes -name "*.class"`

classes: 
	-mkdir -p classes/com/curry/utils/calc
	-mkdir -p classes/com/gentest

classes/MyJavaClass.class: MyJavaClass.java classes
	javac -d classes -cp .:classes $<


classes/com/gentest/AbstractJavaClass.class: src/com/gentest/AbstractJavaClass.java classes
	javac -d classes -cp .:classes $<

repl:
	rlwrap java -cp $(CLASSPATH) clojure.main

classes/com/gentest/ConcreteClojureClass.class:
	echo "(compile 'com.gentest.gen_clojure)" | java -cp $(CLASSPATH) clojure.main

test: classes/MyJavaClass.class classes/com/gentest/AbstractJavaClass.class classes/com/gentest/ConcreteClojureClass.class
	java -cp .:classes MyJavaClass foo
	java -cp $(CLASSPATH) com.gentest.ConcreteClojureClass