:ip rdm $8810
;

slave
start
master

start
	ticraz
	$0
	$10000
	begin
		
		rdm
		dup
		
		$FFF
		and
		dup
		mul16
		
		swap
		$C
		->
		
		$FFF
		and
		dup
		mul16
		
		add
		$FFE001
		<=
		if
			swap
			++
			swap
		endif
		--
		dup
 		0
		=
	until
	drop
	tic
	
	7segdup
	$1F
	btn
	
	$10
	->
	7seg
	$1F
	btn
	
	7seg
	$1F
	btn
endprogram
