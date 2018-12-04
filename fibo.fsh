slave 
start
master
start
	ticraz
	1
	1
	switch
	dup
	2
	>=
	if
		--
		--
		for
			dup
			rot
			add
		next

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
		endif
	clearstack
endprogram
