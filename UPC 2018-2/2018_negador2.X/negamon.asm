;Este es un comentario, debe de anteceder el s�mbolo ";"

    list p=18f4550		    ;Modelo del PIC
    #include<p18f4550.inc>	    ;Llamada a la librer�a de nombres
    
    ;En esta secci�n se declaran los bits de configuraci�n del PIC
  CONFIG  FOSC = XT_XT          ; Oscillator Selection bits (XT oscillator (XT))
  CONFIG  PWRT = ON             ; Power-up Timer Enable bit (PWRT enabled)
  CONFIG  BOR = OFF             ; Brown-out Reset Enable bits (Brown-out Reset disabled in hardware and software)
  CONFIG  WDT = OFF             ; Watchdog Timer Enable bit (WDT disabled (control is placed on the SWDTEN bit))
  CONFIG  CCP2MX = ON           ; CCP2 MUX bit (CCP2 input/output is multiplexed with RC1)
  CONFIG  PBADEN = OFF           ; PORTB A/D Enable bit (PORTB<4:0> pins are configured as analog input channels on Reset)
  CONFIG  MCLRE = ON            ; MCLR Pin Enable bit (MCLR pin enabled; RE3 input pin disabled)
  CONFIG  LVP = OFF             ; Single-Supply ICSP Enable bit (Single-Supply ICSP disabled)

    org 0x0000			    ;Vector de RESET
    goto configure		    ;Salta a la etiqueta 'configure' cuando reseteas
    
    org 0x0020			    ;Zona de usuario
configure:    
    ;Aqu� van las configuraciones iniciales de registros y puertos
    bsf TRISB, 0	;Puerto B0 como entrada
    bcf TRISD, 0	;Puerto D0 como salida

inicio:
    ;Aqu� va el c�digo de usuario
    btfss PORTB, 0	;Pregunto si el bit0 del registro PORTB es igual a '1'
    goto noescierto	;Aqu� salta de la condicional cuando es falso
    bcf LATD, 0		;Aqu� salta de la condicional cuando es cierto, env�a '0' a D0
    goto inicio		;Salta a realizar nuevamente la rutina
noescierto:
    bsf LATD, 0		;Env�a '1' a D0
    goto inicio		;Salta a realizar nuevamente la rutina
    end		        ;Directiva de fin de programa tipeado
    
    
    