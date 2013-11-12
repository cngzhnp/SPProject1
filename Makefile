CC = gcc
TARGET = program
SOURCE = bitmap.c
FLAGS = -g
PROCESSOR := $(shell uname -m)

ifeq ($(PROCESSOR),i686)
	ELF = elf
endif
ifeq ($(PROCESSOR),x86_64)
	ELF = elf64
endif

ASSEMBLERS := $(wildcard *.asm) 

OBJECTS = $(ASSEMBLERS:.asm=.o)

SOURCEOBJECT = $(SOURCE:.c=.o)

debug: $(foreach var,$(ASSEMBLERS),$(shell nasm -f $(ELF) $(FLAGS) $(var)))
	$(CC) -c $(SOURCE) -o $(SOURCEOBJECT) 
	$(CC) $(FLAGS) $(SOURCEOBJECT) $(OBJECTS) -o $(TARGET)
	
all: $(foreach var,$(ASSEMBLERS),$(shell nasm -f $(ELF) $(var)))
	$(CC) -c $(SOURCE) -o $(SOURCEOBJECT)
	$(CC) $(SOURCEOBJECT) $(OBJECTS) -o $(TARGET)		  
clean:
	rm $(TARGET) $(SOURCEOBJECT) $(OBJECTS) out_*.* *~ *.*~
.PHONY: debug all clean
