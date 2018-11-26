:ip rdm $8810
;

slave
start
master
: rand
	49
	for // 50 itération 
	    	rdm
		pop1
	next 
	rdm
	7seg
	$1F
	btn
;
start
	rand
endprogram
