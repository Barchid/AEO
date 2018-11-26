:ip rdm $8810
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
		>0
		0>
		point
		0>
		$C
		->
		point
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
	monteCarlo
endprogram
