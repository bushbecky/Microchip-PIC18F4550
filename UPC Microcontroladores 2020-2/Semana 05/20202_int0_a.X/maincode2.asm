;Este es un comentario, se le antecede un punto y coma
    list p=18f4550	;Modelo del microcontrolador
    #include <p18f4550.inc>	;Llamada a la librería de nombre de los registros
    
    ;Directivas de preprocesador o bits de configuración
    CONFIG  PLLDIV = 1            ; PLL Prescaler Selection bits (No prescale (4 MHz oscillator input drives PLL directly))
    CONFIG  CPUDIV = OSC1_PLL2    ; System Clock Postscaler Selection bits ([Primary Oscillator Src: /1][96 MHz PLL Src: /2])
    CONFIG  FOSC = XT_XT          ; Oscillator Selection bits (XT oscillator (XT))
    CONFIG  PWRT = ON             ; Power-up Timer Enable bit (PWRT enabled)
    CONFIG  BOR = OFF             ; Brown-out Reset Enable bits (Brown-out Reset disabled in hardware and software)
    CONFIG  WDT = OFF             ; Watchdog Timer Enable bit (WDT disabled (control is placed on the SWDTEN bit))
    CONFIG  CCP2MX = ON           ; CCP2 MUX bit (CCP2 input/output is multiplexed with RC1)
    CONFIG  PBADEN = OFF          ; PORTB A/D Enable bit (PORTB<4:0> pins are configured as digital I/O on Reset)
    CONFIG  MCLRE = ON            ; MCLR Pin Enable bit (MCLR pin enabled; RE3 input pin disabled)
    CONFIG  LVP = OFF             ; Single-Supply ICSP Enable bit (Single-Supply ICSP disabled)

    org 0x0000
    goto init_conf

    org 0x0008
    goto INT0_ISR
    
    org 0x0018
    goto INT1_ISR

    org 0x0020
init_conf:
    bcf TRISD, 7
    bcf TRISD, 5
    bsf RCON, IPEN
    bcf INTCON3, INT1IP
    bsf INTCON, INT0IE
    bsf INTCON3, INT1IE
    bsf INTCON, GIEH
    bsf INTCON, GIEL
    
loop:	nop
	nop
	nop
	nop
	goto loop
    
INT0_ISR:
	btg LATD, 7
	bcf INTCON, INT0IF
	nop
	nop
	nop
	nop
	retfie
	
INT1_ISR:
	btg LATD, 5
	bcf INTCON3, INT1IF
	nop
	nop
	nop
	nop
	retfie
	end