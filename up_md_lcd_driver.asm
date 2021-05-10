	cblock
	  TEMPO1,TEMPO2,c_seq
	endc

#define LCD_RS   PORTE,0
#define LCD_E    PORTE,2
#define LCD_DADO PORTD

LCD_ON_NOCURSOR	EQU	0x0C   ;Display on, cursor off
LCD_ON_CURSOR		EQU	0x0E   ;Display on, cursor on
LCD_ON_CURSOR_BLINK	EQU	0x0F   ;Display on, cursor on-blink
CURSOR_A_ESQUERDA	EQU	0x10	;Cursor � esquerda
CURSOR_A_DIREITA	EQU	0x14	;Cursor � direita
MENSAJE_ESQUERDA	EQU	0x18	;Mensagem � esquerda
MENSAJE_DIREITA	EQU	0x1C	;Mensagem � direita
LCD_CLEAR		EQU	0x01   ;Limpa display e cursor home
LCD_OFF 		EQU	0x008	;desligar display
LCD_Linha_1		EQU	0x80	;primeira linha
LCD_Linha_2		EQU	0xC0	;segunda linha
;====================================================================

;**********************************************************************
; Rotinas para as mensagens de texto a serem enviadas no LCD
;**********************************************************************
	


msg_lcd
	movlw	' '
	call	EnviaCarLCD
	movlw	' '
	call	EnviaCarLCD
	movlw	'H'
	call	EnviaCarLCD
	movlw	'I'
	call	EnviaCarLCD
	movlw	'G'
	call	EnviaCarLCD
	movlw	'I'
	call	EnviaCarLCD
	movlw	'E'
	call	EnviaCarLCD
	movlw	'N'
	call	EnviaCarLCD
	movlw	'I'
	call	EnviaCarLCD
	movlw	'Z'
	call	EnviaCarLCD
	movlw	'A'
	call	EnviaCarLCD
	movlw	'D'
	call	EnviaCarLCD
	movlw	'O'
	call	EnviaCarLCD
	movlw	'R'
	call	EnviaCarLCD

	movlw	0xC0
	call	EnviaCmdLCD


;dt	"USUARIO N"

	movlw	'U'
	call	EnviaCarLCD
	movlw	'S'
	call	EnviaCarLCD
	movlw	'U'
	call	EnviaCarLCD
	movlw	'A'
	call	EnviaCarLCD
	movlw	'R'
	call	EnviaCarLCD
	movlw	'I'
	call	EnviaCarLCD
	movlw	'O'
	call	EnviaCarLCD
	movlw	' '
	call	EnviaCarLCD
	movlw	'N'
	call	EnviaCarLCD
	movlw	0xDF
	call	EnviaCarLCD
	movlw	' '
	call	EnviaCarLCD
	movlw	'0'
	call	EnviaCarLCD
	movlw	'0'
	call	EnviaCarLCD
	movlw	'0'
	call	EnviaCarLCD
	movlw	'0'
	call	EnviaCarLCD
	movlw	'0'
	call	EnviaCarLCD

	return


Inicia_LCD:
	banco1
	clrf	TRISD
	clrf	TRISE
	banco0
	MOVLW	0x38		;
	CALL	EnviaCmdLCD
	MOVLW	0x38		;Modo 8b, 2 linhas de dados
	CALL	EnviaCmdLCD
	MOVLW	0x06		;Cursor, deslocamento para a direita
	CALL	EnviaCmdLCD
	MOVLW	0x0C		;Display on, cursor off
	CALL	EnviaCmdLCD
	MOVLW	0x01		;Limpa display e cursor home
	CALL	EnviaCmdLCD
	RETURN	

EnviaCarLCD:
	BSF		LCD_RS
	BSF		LCD_E
	MOVWF	LCD_DADO
	BCF		LCD_E
	MOVLW	0x06
	GOTO	Delay_LCD	;1.54ms
	RETURN	

EnviaCmdLCD:
	BCF		LCD_RS		;comando
	BSF		LCD_E
	MOVWF	LCD_DADO
	BCF		LCD_E
	MOVLW	0x12
	GOTO	Delay_LCD	;4.6ms
	RETURN

Delay_LCD:
	MOVWF	TEMPO2     
	MOVLW	0xFF
	MOVWF	TEMPO1
	CLRWDT
	DECFSZ	TEMPO1,F
	GOTO	$-02               
	DECFSZ	TEMPO2,F
	GOTO 	$-06                
	RETURN
