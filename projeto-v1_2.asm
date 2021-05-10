	list   p=16f877a		; define o tipo de uC usado
	#include <p16f877a.inc>	; declarações típicas
	#include <macros.inc>	; Macros
	__CONFIG H'2F02'		; define a palavra de configuração
	ERRORLEVEL -302, -305
;GPR: variáveis de propósito geral
	cblock 0x20
		w_temp, status_temp
	endc

#define BOMBA  	PORTB,5

	org		0x00 		;vetor de reset
	goto	setup
	org		0x04 		;vetor de interrup
	goto	ISR

; Rotina de interrupção
ISR:
 	movwf	w_temp			;salva Wreg
	movfw	STATUS
	movwf	status_temp		;salva STATUS
	bcf	STATUS,RP0		;importante!
	btfss	INTCON,INTF		;verifica se houve interrupção externa
	goto	fim_isr			;Se não houvem sai da interrupção

;Interrupção Confirmada		

	bsf	BOMBA				;Aciona bomba de alcool
	call	delay_100ms			;Aguarda 300 ms
	call	delay_100ms
	call	delay_100ms

	bcf 	BOMBA				;Desliga bomba de alcool
	call	contador
	movlw	0x00
	call	executa_audio


;Mostra contador no LCD
	movlw	0xCB
	call	EnviaCmdLCD

	movfw	dmil
	addlw	0x30
	call	EnviaCarLCD

	movfw	umil
	addlw	0x30
	call	EnviaCarLCD

	movfw	cent
	addlw	0x30
	call	EnviaCarLCD

	movfw	deze
	addlw	0x30
	call	EnviaCarLCD

	movfw	unid
	addlw	0x30
	call	EnviaCarLCD

	bcf	INTCON,INTF			;Limpa o Flag de interrupção

;Reseta contador de 10 segundos
	movlw	0x6D
	movwf	contador4
	movlw	0x32
	movwf	contador5
	movlw	0x58
	movwf	contador6


fim_isr:
	movfw	status_temp
	movwf	STATUS		;recupera STATUS
	swapf	w_temp,F
	swapf	w_temp,W	;recupera Wreg
	retfie	

; Programa principal
setup:	

	clrf	binario_HIGH
	clrf	binario_LOW
	clrf	binario_H
	clrf	binario_L
	clrf	PORTB	
	clrf	PORTD
	clrf	PORTE

	banco1
	movlw	0x03
	movwf	TRISB		;PORTB <0,1> entrada, <2,7>saida
	clrf	TRISD		;porta D como saída
	clrf	TRISE		;porta E como saída
	movlw	0x06
	movwf	ADCON1		;portas A e E com E/S digitais
	bcf		OPTION_REG,7	;habilita Pull-Up de PortB
	bcf		OPTION_REG,INTEDG	;Habilita Interrupção na borda de descida
	banco0

;Configuração de INterrupção Externa
	
	bsf	INTCON,GIE		;Habilita interrupções Globais
	bcf	INTCON,PEIE
	bsf	INTCON,INTE		;Habilita Interrupções Externas RB0

	call 	Inicia_LCD 
	call	msg_lcd
	call	inicia_audio


LOOP:
	btfss	PORTB,1
	goto	$-1
	movlw	0x01
	call	executa_audio
	call 	delay_10s
	goto	LOOP

; inclusão de bibliotecas
	#include "up_audio_driver.asm"
	#include "up_md_atrasos.asm"
	#include "up_md_lcd_driver.asm"
	#include "up_Bin16_BCD.asm"
	
	END