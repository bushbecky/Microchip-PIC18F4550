;Este es un comentario, esta es una plantilla
    list p=18f4550			;Modelo del microcontrolador
    #include <p18f4550.inc>		;Llamo a la librer�a de nombre de los regs
    #include "LCD_LIB.asm"
    
    ;Zona de los bits de configuraci�n (falta)
    CONFIG  FOSC = INTOSCIO_EC	  ; Oscillator Selection bits (XT oscillator (XT))
    CONFIG  PWRT = ON             ; Power-up Timer Enable bit (PWRT enabled)
    CONFIG  BOR = OFF             ; Brown-out Reset Enable bits (Brown-out Reset disabled in hardware and software)
    CONFIG  WDT = OFF             ; Watchdog Timer Enable bit (WDT disabled (control is placed on the SWDTEN bit))
    CONFIG  PBADEN = OFF          ; PORTB A/D Enable bit (PORTB<4:0> pins are configured as digital I/O on Reset)
    CONFIG  LVP = OFF             ; Single-Supply ICSP Enable bit (Single-Supply ICSP disabled)

    CONFIG  CCP2MX = ON           ; CCP2 MUX bit (CCP2 input/output is multiplexed with RC1)
    CONFIG  MCLRE = ON            ; MCLR Pin Enable bit (MCLR pin enabled; RE3 input pin disabled)
    
    org 0x0000
    goto configuro
    
    org 0x0020
    ;Seg�n la librer�a el LCD esta conectado con el PIC: RS->RD0, RW->RD1, E->RD2, Datos->RD4-RD7
configuro:
    clrf TRISD	    ;Puertos como salida (conexi�n hacia el LCD
    call DELAY15MSEG	;Para inicializar el LCD para que arranque y funcione con interface de 4 bits
    call LCD_CONFIG
    CALL CURSOR_OFF

inicio:
    movlw "H"	    ;Caracter H se almacena en W (valor HEX de su ASCII)
    call ENVIA_CHAR
    movlw "e"	    ;Caracter e se almacena en W (valor HEX de su ASCII)
    call ENVIA_CHAR
    movlw "l"	    ;Caracter l se almacena en W (valor HEX de su ASCII)
    call ENVIA_CHAR
    movlw "l"	    ;Caracter l se almacena en W (valor HEX de su ASCII)
    call ENVIA_CHAR
    movlw "o"	    ;Caracter o se almacena en W (valor HEX de su ASCII)
    call ENVIA_CHAR
    
fin:	nop
	goto fin
	
	end
    
    
    