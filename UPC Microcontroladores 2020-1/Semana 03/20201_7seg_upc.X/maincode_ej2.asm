;Este es un comentario, se le antecede un punto y coma
    list p=18f4550	;Modelo del microcontrolador
    #include <p18f4550.inc>	;Llamada a la librería de nombre de los registros
    
    ;Directivas de preprocesador o bits de configuración
    CONFIG  PLLDIV = 1            ; PLL Prescaler Selection bits (No prescale (4 MHz oscillator input drives PLL directly))
    CONFIG  CPUDIV = OSC1_PLL2    ; System Clock Postscaler Selection bits ([Primary Oscillator Src: /1][96 MHz PLL Src: /2])
    CONFIG  FOSC = INTOSCIO_EC
    CONFIG  PWRT = ON             ; Power-up Timer Enable bit (PWRT enabled)
    CONFIG  BOR = OFF             ; Brown-out Reset Enable bits (Brown-out Reset disabled in hardware and software)
    CONFIG  WDT = OFF             ; Watchdog Timer Enable bit (WDT disabled (control is placed on the SWDTEN bit))
    CONFIG  CCP2MX = ON           ; CCP2 MUX bit (CCP2 input/output is multiplexed with RC1)
    CONFIG  PBADEN = OFF          ; PORTB A/D Enable bit (PORTB<4:0> pins are configured as digital I/O on Reset)
    CONFIG  MCLRE = ON            ; MCLR Pin Enable bit (MCLR pin enabled; RE3 input pin disabled)
    CONFIG  LVP = OFF             ; Single-Supply ICSP Enable bit (Single-Supply ICSP disabled)

    ;Bloque para declaración de variables (ponerle nombres a los GPR)
    ;Dicho bloque empieza desde la dirección 0x020 de la memoria de datos
    cblock 0x020
    var_i
    var_j
    var_k
    endc    
    
    org 0x0400
tabla_7s db 0x3E, 0x73, 0x39, 0x00, 0x39, 0x73, 0x3E, 0x00
;tabla_7s dt "UPC "  ;Lo va a interpretar como caracteres ASCII (0x55, 0x50, 0x43, 0x20) 
    
    org 0x0000		;Vector de RESET
    goto init_conf
    
    org 0x0008		;Vector de interrupción
    
    org 0x0020		;Zona de programa de usuario
init_conf:  
	    movlw 0x80
	    movwf TRISD		 ;Puertos RD6-0 como salidas
	    movlw 0x62
	    movwf OSCCON	;Para que el oscilador interno funque a 4MHz
	    movlw low tabla_7s
	    movwf TBLPTRL
	    movlw high tabla_7s
	    movwf TBLPTRH	;Asignando dirección de apunte a TBLPTR
	    
loop:       btfss PORTB, 0	;Lee puerto RB0 para saber si aplica o no el TURBO
	    goto falso
	    bsf OSCCON, 4	;Trabaja el oscilador interno a 8MHz
	    goto sigue
falso:	    bcf OSCCON, 4	;Trabaja el oscilador interno a 4MHZ	    
sigue:	    TBLRD*+
	    movff TABLAT, LATD
	    call delay_long
	    movlw .8		;Cantidad de caracteres de la tabla
	    cpfseq TBLPTRL
	    goto loop
	    clrf TBLPTRL
	    goto loop
	    
;Subrutina de retardo largo    
delay_long:    
    movlw .50
    movwf var_i
otro1:
    call bucle1		;Salto a subrutina
    decfsz var_i,f
    goto otro1
    ;goto delay_long
    return

bucle1:
    movlw .50
    movwf var_j
otro2:
    call bucle2		;Salto a subrutina
    decfsz var_j,f
    goto otro2
    return
    
bucle2:
    movlw .50
    movwf var_k
otro3:
    nop
    decfsz var_k,f
    goto otro3
    return	    
	    end		;Fin del programa