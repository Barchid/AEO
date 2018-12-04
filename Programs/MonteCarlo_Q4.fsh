:ip rdm $9010
;

:ip comparateur $A820
;

:ip finboucle $B021
;

:ip increment $A822
;

:ip push10000 $9023
;

:ip push1F $9024
;

:ip rshift $A825
;

slave
start
master

start
	ticraz
	push10000
	begin
		
		rdm
		mul16
		comparateur
		if
			swap
			increment
			swap
		endif
		finboucle
	until
	drop

	tic
	
	7segdup
	$1F
	btn
	
	rshift
	7seg
	$1F
	btn
	
	7seg
	$1F
	btn
endprogram
