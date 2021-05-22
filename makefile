.PHONY: all
all : 
	iverilog *.v -s tb
	# iverilog tb.v
	./a.out
	rm a.out