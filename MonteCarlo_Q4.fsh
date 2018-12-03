:ip rdm $9010
;

:ip comparateur $A820
;

:ip finboucle $B021
;

:ip increment $C822
;

:ip pushFFFF $A823
;

:ip rshift $A824
;

slave
start
master

start
	ticraz
	pushFFFF
	begin
		
		rdm
		mul16
		$FFE001
		<=
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
