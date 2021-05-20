.PHONY: all
all : 
	iverilog *.v -s tb
	./a.out
	rm a.out