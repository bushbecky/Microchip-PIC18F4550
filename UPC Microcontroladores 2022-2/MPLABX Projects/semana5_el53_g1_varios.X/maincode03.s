    PROCESSOR 18F4550
    #include "cabecera.inc"
    
    PSECT pollo_a_la_brasa, class=CODE, reloc=2, abs
pollo_a_la_brasa:
    ORG 000000H		    ;Vector de reset
    goto configuro

    ORG 000008H		    ;Vector de interrupcion de alta prioridad
    goto Tmr0_ISR
    
    ORG 000100H
msg_copa:   db 39H, 3FH, 73H, 77H
   
    ORG 000200H
msg_vino:   db 1CH, 04, 54H, 5CH

   ORG 000020H		    ;Zona de programa de usuario
configuro:
    ;              TRISB
    ; ---------------------------------
    ; | 1 | 1 | 0 | 1 | 0 | 0 | 0 | 0 | -----> 0D0H
    ; ---------------------------------
    ;   7   6   5   4   3   2   1   0
    movlw 0D0H
    movwf TRISB
    ;              TRISD
    ; ---------------------------------
    ; | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | -----> 080H
    ; ---------------------------------
    ;   7   6   5   4   3   2   1   0
    movlw 80H
    movwf TRISD
    movlw 83H
    movwf T0CON
    movlw 0A0H
    movwf INTCON
    bcf INTCON2, 7
    clrf TBLPTRU	;TBLPTRU = 0
        
loop:
    btfsc PORTB, 4	;pregunto si presione BTN
    goto no_presione
    movlw 02H
    movwf TBLPTRH
    goto sale
no_presione:
    movlw 01H
    movwf TBLPTRH
sale:
    clrf TBLPTRL
    call muxxed		;llamo a subrutina muxxed
    goto loop		;retorno a loop

muxxed:
    TBLRD*+
    movff TABLAT, LATD
    bsf LATB, 0		;habilito primer digito del display
    call nopx16		;espero un ratito
    bcf LATB, 0		;deshabilito primer digito del display
    TBLRD*+
    movff TABLAT, LATD
    bsf LATB, 1		;habilito segundo digito del display
    call nopx16		;espero un ratito
    bcf LATB, 1		;deshabilito segundo digito del display
    TBLRD*+
    movff TABLAT, LATD
    bsf LATB, 2		;habilito tercer digito del display
    call nopx16		;espero un ratito
    bcf LATB, 2		;deshabilito tercer digito del display
    TBLRD*
    movff TABLAT, LATD
    bsf LATB, 3		;habilito cuarto digito del display
    call nopx16		;espero un ratito
    bcf LATB, 3		;deshabilito cuarto digito del display
    return		;retorno de subrutina

nopx16:
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    return
    
Tmr0_ISR:		;rutina de interrupcion por desborde de TMR0
    bcf INTCON, 2	;bajo la bandera TMR0IF
    movlw 0BH
    movwf TMR0H
    movlw 0DCH
    movwf TMR0L		;cargamos cuenta inicial en TMR0
    btg LATB, 5
    retfie		;retorno de rutina de interrupcion
    
    end pollo_a_la_brasa





