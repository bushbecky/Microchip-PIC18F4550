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

    org 0x0020
init_conf:
    clrf TRISD	    ;RD todos salidas
    movlw 0xF0
    movwf TRISB	    ;RB3-RB0 son salidas
    movlw 0x0F
    movwf LATB	    ;RB3-RB0 en uno logico para deshabilitar los displays

loop:
    movlw 0x06
    movwf LATD	    ;digito 0 a RD
    bcf LATB, 3	    ;habilito disp0
    nop
    nop
    nop
    nop
    bsf LATB, 3	    ;deshabilito disp0
    movlw 0x5B
    movwf LATD	    ;digito 0 a RD
    bcf LATB, 2	    ;habilito disp0
    nop
    nop
    nop
    nop
    bsf LATB, 2	    ;deshabilito disp0
    movlw 0x4F
    movwf LATD	    ;digito 0 a RD
    bcf LATB, 1	    ;habilito disp0
    nop
    nop
    nop
    nop
    bsf LATB, 1	    ;deshabilito disp0
    movlw 0x66
    movwf LATD	    ;digito 0 a RD
    bcf LATB, 0	    ;habilito disp0
    nop
    nop
    nop
    nop
    bsf LATB, 0	    ;deshabilito disp0
    goto loop
    end