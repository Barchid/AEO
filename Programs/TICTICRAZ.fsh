slave 
start

master 
: saisie
	$1f
	btn
	switch
;
: add32
	add
	tic
	7seg
	$1f
	btn
	7segdup
	$10
	->
	led
;
: main
	ticraz
	1
	for
		saisie
	next
	add32
;
start
	main
endprogram
