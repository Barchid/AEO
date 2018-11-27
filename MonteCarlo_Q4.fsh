:ip rdm $9010
;

slave
start
master

: point
	$FFF
	and
	dup
	mul16
;

:init
	0
	>1
;

:aff
	7segdup
	$1F
	btn
;



:monteCarlo
	ticraz
	init
	$FFFE
	for
		
		rdm
		point
		>0
		point
		0>
		add
		$FFE001
		<=
		if
			1>
			1
			add
			>1
		endif
	next
	tic
	aff
	$F
	->
	aff
	pop1
	1>
	aff
;

start
begin
	monteCarlo
again
;
endprogram
