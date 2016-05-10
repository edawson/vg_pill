BIN_DIR:=./bin
LIB_DIR:=./lib
INC_DIR:=./include

CWD:=$(shell pwd)

#bison-3.0.tar.gz  jansson-2.7.tar.gz  jq-1.5.tar.gz

bison_archive:=bison-3.0.tar.gz
jq_archive:=jq-1.5.tar.gz
jansson_archive:=jansson-2.7.tar.gz

all: bin/bison bin/jq include/jansson.h

.PHONY: clean

bin/bison: $(bison_archive) .pre-build
	+tar xzf $(bison_archive) bison-3.0 && cd bison-3.0 && ./configure --prefix=$(CWD) && $(MAKE) && $(MAKE) install
	
bin/jq: $(jq_archive) .pre-build
	+tar xzf $(jq_archive) && cd jq-1.5 && configure --prefix=$(CWD) && $(MAKE) && $(MAKE) install

include/jansson.h: $(jansson_archive) .pre-build
	+tar xzf $(jansson_archive) && cd jansson-2.7 && configure --prefix=$(CWD) && $(MAKE) && $(MAKE) install

.pre-build:
	if [ ! -d $(BIN_DIR) ]; then mkdir -p $(BIN_DIR); fi
	if [ ! -d $(LIB_DIR) ]; then mkdir -p $(LIB_DIR); fi
	if [ ! -d $(INC_DIR) ]; then mkdir -p $(INC_DIR); fi
	touch .pre-build

clean:
	$(RM) -rf $(BIN_DIR)
	$(RM) -rf $(LIB_DIR)
	$(RM) -rf $(INC_DIR)
	$(RM) -rf bison-3.0
	$(RM) -rf jansson-2.7
	$(RM) -rf jq-1.5
