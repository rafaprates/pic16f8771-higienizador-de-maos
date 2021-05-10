;******************************************************************
;* Rotinas para gerar atrasos de tempo,
;* reg. "contador1,2,3" para estabelecer o tempo de atraso
;* frequência de clock = 16.000 Mhz
; UFMT: Jun/2017
;******************************************************************

	cblock
		contador1	;registradores usados para atraso
		contador2
		contador3
		contador4
		contador5
		contador6
	endc

delay_50us:
			;199 cycles
	movlw	0x42
	movwf	contador1
Delay_4
	decfsz	contador1, f
	goto	Delay_4
	nop		;1 cycle	
	return

delay_100us:
			;400 cycles
	movlw	0x85
	movwf	contador1
Delay_5
	decfsz	contador1, f
	goto	Delay_5
	return

delay_1950us:
			;7798 cycles
	movlw	0x17
	movwf	contador1
	movlw	0x07
	movwf	contador2
Delay_3
	decfsz	contador1, f
	goto	$+2
	decfsz	contador2, f
	goto	Delay_3

			;2 cycles
	goto	$+1
	return

delay_1ms:	
	movlw	D'47'
	movwf	contador1
	movlw	D'6'
	movwf	contador2
	decfsz	contador1,F	;
	goto	$-1
	decfsz	contador2,1
	goto	$-3
	return	

delay_2ms:	
	movlw	D'97'
	movwf	contador1
	movlw	D'11'
	movwf	contador2
	decfsz	contador1,F	;
	goto	$-1
	decfsz	contador2,1
	goto	$-3
	return	

delay_3ms:	
	movlw	D'147'
	movwf	contador1
	movlw	D'16'
	movwf	contador2
	decfsz	contador1,F	;
	goto	$-1
	decfsz	contador2,1
	goto	$-3
	return	

delay_4ms:	
	movlw	D'197'
	movwf	contador1
	movlw	D'21'
	movwf	contador2
	decfsz	contador1,F	;
	goto	$-1
	decfsz	contador2,1
	goto	$-3
	return	

delay_5ms:	
	movlw	D'247'
	movwf	contador1
	movlw	D'26'
	movwf	contador2
	decfsz	contador1,F	;
	goto	$-1
	decfsz	contador2,1
	goto	$-3
	return	

delay_10ms:
	movlw	D'240'
	movwf	contador1
	movlw	D'52'
	movwf	contador2
	decfsz	contador1,1
	goto	$-1
	decfsz	contador2,1
	goto	$-3
	return	

delay_20ms:
	movlw	D'226'
	movwf	contador1
	movlw	D'104'
	movwf	contador2
	decfsz	contador1,1
	goto	$-1
	decfsz	contador2,1
	goto	$-3
	return	

delay_100ms:
	movlw	D'117'
	movwf	contador1
	movlw	D'8'
	movwf	contador2
	movlw	D'3'
	movwf	contador3
	decfsz	contador1,1
	goto	$-1
	decfsz	contador2,1
	goto	$-3
	decfsz	contador3,1
	goto	$-5
	return

delay_300ms:
	movlw	0xA3
	movwf	contador1
	movlw	0x9E
	movwf	contador2
	movlw	0x03
	movwf	contador3
Delay_1
	decfsz	contador1, f
	goto	$+2
	decfsz	contador2, f
	goto	$+2
	decfsz	contador3, f
	goto	Delay_1
			;6 cycles
	goto	$+1
	goto	$+1
	goto	$+1

delay_500ms:
	movlw	D'92'
	movwf	contador1
	movlw	D'38'
	movwf	contador2
	movlw	D'11'
	movwf	contador3
	decfsz	contador1,F	;
	goto	$-1
	decfsz	contador2,1
	goto	$-3
	decfsz	contador3,1
	goto	$-5
	return	

delay_1s:
	movlw	D'189'
	movwf	contador1
	movlw	D'75'
	movwf	contador2
	movlw	D'21'
	movwf	contador3
	decfsz	contador1,1
	goto	$-1
	decfsz	contador2,1
	goto	$-3
	decfsz	contador3,1
	goto	$-5
	return

delay_10s:
	movlw	0x6D
	movwf	contador4
	movlw	0x32
	movwf	contador5
	movlw	0x58
	movwf	contador6
Delay_0
	decfsz	contador4, f
	goto	$+2
	decfsz	contador5, f
	goto	$+2
	decfsz	contador6, f
	goto	Delay_0
	return