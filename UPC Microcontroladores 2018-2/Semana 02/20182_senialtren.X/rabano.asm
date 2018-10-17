;Este es un comentario, esta es una plantilla
    list p=18f4550			;Modelo del microcontrolador
    #include<p18f4550.inc>		;Llamo a la librer�a de nombre de los regs
    
    ;Zona de los bits de configuraci�n (falta)
    CONFIG  FOSC = XT_XT	  ; Oscillator Selection bits (XT oscillator (XT))
    CONFIG  PWRT = ON             ; Power-up Timer Enable bit (PWRT enabled)
    CONFIG  BOR = OFF             ; Brown-out Reset Enable bits (Brown-out Reset disabled in hardware and software)
    CONFIG  WDT = OFF             ; Watchdog Timer Enable bit (WDT disabled (control is placed on the SWDTEN bit))
    CONFIG  PBADEN = OFF          ; PORTB A/D Enable bit (PORTB<4:0> pins are configured as digital I/O on Reset)
    CONFIG  LVP = OFF             ; Single-Supply ICSP Enable bit (Single-Supply ICSP disabled)

    CONFIG  CCP2MX = ON           ; CCP2 MUX bit (CCP2 input/output is multiplexed with RC1)
    CONFIG  MCLRE = ON            ; MCLR Pin Enable bit (MCLR pin enabled; RE3 input pin disabled)

;Declaramos nombres a registros GPR
var_i	EQU 0x060
var_j	EQU 0x061
var_k	EQU 0x062
	
    org 0x0000				;Vector de RESET
    goto configuro
    
    org 0x0020				;Zona de programa de usuario
configuro:
    ;Instrucciones de configuraci�n inicial del programa de usuario
    movlw 0xFC			; b'11111100' en binario
    movwf TRISB			;Puertos RB1 y RB0 como salidas
        
inicio:
    movlw 0x01
    movwf LATB
    ;nop				;Retardo de un microsegundo a Fosc = 4MHz
    call retardado
    movlw 0x02
    movwf LATB
    call retardado
    ;nop
    goto inicio

retardado:
	    movlw .100
	    movwf var_i
otro1:	    call bucle1
	    decfsz var_i, 1
	    goto otro1
	    return
	    
bucle1:	    movlw .100
	    movwf var_j
otro2:	    call bucle2
	    decfsz var_j, 1
	    goto otro2
	    return

bucle2:	    movlw .30
	    movwf var_k
otro3:	    nop
	    decfsz var_k, 1
	    goto otro3
	    return
	    
    end
    