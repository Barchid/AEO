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
	7segdup
	$10
	->
	led
;
: main
	1
	for
		saisie
	next
	add32
;
start
	main
endprogram
