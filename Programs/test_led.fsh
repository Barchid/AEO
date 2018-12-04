// test chenillard 

slave 
start
master 
: main
1
begin 
	leddup
	$fffff 
	delay
	2*
	dup $100  =
	if 
		drop 1 
	endif
again
;
start 
main

endprogram
