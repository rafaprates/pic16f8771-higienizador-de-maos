;**********************************************************************
; Rotinas para as mensagens de audio a serem enviadas 
;**********************************************************************
	cblock
		cont_bits,f_audio
	endc

#define AUDIO_RESET   	PORTB,2
#define AUDIO_CLOCK   	PORTB,3
#define AUDIO_DATA  	PORTB,4
#define AUDIO_BUSY  	PORTB,6

inicia_audio:

	bsf		AUDIO_RESET
	bsf		AUDIO_CLOCK
	call	delay_1ms
	return

executa_audio:
	
	movwf	f_audio		;salva a faixa de audio selecionada	
	clrf	cont_bits	;Limpa o contador de bit
;espera modulo ficar disponivel
;	btfss	AUDIO_BUSY
;	goto 	$-1

;preparando o módulo	
	
	bcf		AUDIO_RESET
	call	delay_5ms
	bsf		AUDIO_RESET
	call	delay_300ms


	
;modulo acordado

	bcf		AUDIO_CLOCK
	call	delay_1950us

;Enviando  Dados ao Módulo de Áudio
loop_audio
	incf	cont_bits
	bcf		AUDIO_CLOCK
	call 	delay_50us
	bcf		AUDIO_DATA	
	call 	delay_50us
	bsf		AUDIO_CLOCK
	call	delay_100us
	movlw	0x08
	xorwf	cont_bits,W
	btfss	STATUS,Z
	goto	loop_audio


	
;Envia bit7
	bcf		AUDIO_CLOCK
	call	delay_50us
	btfsc	f_audio,7
	goto	data_H7
data_L7:
	bcf		AUDIO_DATA
	call	delay_50us
	bsf		AUDIO_CLOCK
	call	delay_100us
	goto	envia_bit6
data_H7:
	bsf		AUDIO_DATA
	call	delay_50us
	bsf		AUDIO_CLOCK
	call	delay_100us

envia_bit6:	
	bcf		AUDIO_CLOCK
	call	delay_50us
	btfsc	f_audio,6
	goto	data_H6
data_L6:
	bcf		AUDIO_DATA
	call	delay_50us
	bsf		AUDIO_CLOCK
	call	delay_100us
	goto	envia_bit5
data_H6:
	bsf		AUDIO_DATA
	call	delay_50us
	bsf		AUDIO_CLOCK
	call	delay_100us

envia_bit5:	
	bcf		AUDIO_CLOCK
	call	delay_50us
	btfsc	f_audio,5
	goto	data_H5
data_L5:
	bcf		AUDIO_DATA
	call	delay_50us
	bsf		AUDIO_CLOCK
	call	delay_100us
	goto	envia_bit4
data_H5:
	bsf		AUDIO_DATA
	call	delay_50us
	bsf		AUDIO_CLOCK
	call	delay_100us

envia_bit4:	
	bcf		AUDIO_CLOCK
	call	delay_50us
	btfsc	f_audio,4
	goto	data_H4
data_L4:
	bcf		AUDIO_DATA
	call	delay_50us
	bsf		AUDIO_CLOCK
	call	delay_100us
	goto	envia_bit3
data_H4:
	bsf		AUDIO_DATA
	call	delay_50us
	bsf		AUDIO_CLOCK
	call	delay_100us

envia_bit3:	
	bcf		AUDIO_CLOCK
	call	delay_50us
	btfsc	f_audio,3
	goto	data_H3
data_L3:
	bcf		AUDIO_DATA
	call	delay_50us
	bsf		AUDIO_CLOCK
	call	delay_100us
	goto	envia_bit2
data_H3:
	bsf		AUDIO_DATA
	call	delay_50us
	bsf		AUDIO_CLOCK
	call	delay_100us

envia_bit2:	
	bcf		AUDIO_CLOCK
	call	delay_50us
	btfsc	f_audio,2
	goto	data_H2
data_L2:
	bcf		AUDIO_DATA
	call	delay_50us
	bsf		AUDIO_CLOCK
	call	delay_100us
	goto	envia_bit1
data_H2:
	bsf		AUDIO_DATA
	call	delay_50us
	bsf		AUDIO_CLOCK
	call	delay_100us

envia_bit1:	
	bcf		AUDIO_CLOCK
	call	delay_50us
	btfsc	f_audio,1
	goto	data_H1
data_L1:
	bcf		AUDIO_DATA
	call	delay_50us
	bsf		AUDIO_CLOCK
	call	delay_100us
	goto	envia_bit0
data_H1:
	bsf		AUDIO_DATA
	call	delay_50us
	bsf		AUDIO_CLOCK
	call	delay_100us

envia_bit0:	
	bcf		AUDIO_CLOCK
	call	delay_50us
	btfsc	f_audio,0
	goto	data_H0
data_L0:
	bcf		AUDIO_DATA
	call	delay_50us
	bsf		AUDIO_CLOCK
	call	delay_100us
	return
data_H0:
	bsf		AUDIO_DATA
	call	delay_50us
	bsf		AUDIO_CLOCK
	call	delay_100us
	return


	
	
		


