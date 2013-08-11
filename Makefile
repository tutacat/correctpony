# Copyright © 2012, 2013  Mattias Andrée (maandree@member.fsf.org)
# 
# Copying and distribution of this file, with or without modification,
# are permitted in any medium without royalty provided the copyright
# notice and this notice are preserved.  This file is offered as-is,
# without any warranty.
# 
# [GNU All Permissive License]

JAVA_OPTIMISE = -O

JAVAC = javac
JAR = jar
INSTALLED_PREFIX = /usr
INSTALLED_LIB = /lib
INSTALLED_JARS = $(INSTALLED_PREFIX)$(INSTALLED_LIB)

JAVADIRS = -s "src" -d "bin" -cp "src:$(INSTALLED_JARS)/ArgParser.jar"
JAVAFLAGS = -Xlint $(JAVA_OPTIMISE)
JAVA_FLAGS = $(JAVADIRS) $(JAVAFLAGS)

CLASSES = Correctpony


.PHONY: all
all: java jar

.PHONY: java
java: $(foreach CLASS, $(CLASSES), bin/$(CLASS).class)

bin/%.class: src/%.java
	@mkdir -p bin
	$(JAVAC) $(JAVA_FLAGS) "$<"

.PHONY: jar
jar: bin/Correctpony.jar

bin/Correctpony.jar: java
	cd bin; $(JAR) cfm Correctpony.jar META-INF/MANIFEST.MF $(foreach CLASS, $(CLASSES), $(CLASS).class)



.PHONY: clean
clean:
	-rm -rf -- bin

