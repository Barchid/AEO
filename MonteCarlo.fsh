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
	<1
	0
	<1
;
start
	rdm
	>0
	point
	<0
	12
	->
	point
	add
	$FFE001
	<=
	if
		<1
		1
		add
		>1
	endif

	<2
	1
	add
	>2
	
endprogram
