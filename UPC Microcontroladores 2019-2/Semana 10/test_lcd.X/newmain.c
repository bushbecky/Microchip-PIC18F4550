//Este es un comentario
/*Este es otro comentario*/

// PIC18F4550 Configuration Bit Settings
#pragma config PLLDIV = 1       // PLL Prescaler Selection bits (No prescale (4 MHz oscillator input drives PLL directly))
#pragma config CPUDIV = OSC1_PLL2// System Clock Postscaler Selection bits ([Primary Oscillator Src: /1][96 MHz PLL Src: /2])
#pragma config FOSC = XTPLL_XT  // Oscillator Selection bits (XT oscillator, PLL enabled (XTPLL))
#pragma config PWRT = ON        // Power-up Timer Enable bit (PWRT enabled)
#pragma config BOR = OFF        // Brown-out Reset Enable bits (Brown-out Reset disabled in hardware and software)
#pragma config BORV = 3         // Brown-out Reset Voltage bits (Minimum setting 2.05V)
#pragma config WDT = OFF        // Watchdog Timer Enable bit (WDT disabled (control is placed on the SWDTEN bit))
#pragma config WDTPS = 32768    // Watchdog Timer Postscale Select bits (1:32768)
#pragma config CCP2MX = ON      // CCP2 MUX bit (CCP2 input/output is multiplexed with RC1)
#pragma config PBADEN = OFF     // PORTB A/D Enable bit (PORTB<4:0> pins are configured as digital I/O on Reset)
#pragma config LPT1OSC = OFF    // Low-Power Timer 1 Oscillator Enable bit (Timer1 configured for higher power operation)
#pragma config MCLRE = ON       // MCLR Pin Enable bit (MCLR pin enabled; RE3 input pin disabled)
#pragma config LVP = OFF        // Single-Supply ICSP Enable bit (Single-Supply ICSP disabled)


#include <xc.h>
#include "LCD.h"
#define _XTAL_FREQ 48000000UL   // Frecuencia de trabajo del microcontrolador

unsigned int temporal = 0;
unsigned int digcen = 0;
unsigned int digdec = 0;
unsigned int diguni = 0;

unsigned int conviertemoncito(numero){
    digcen = numero / 100;
    temporal = numero - (digcen * 100);
    digdec = temporal / 10;
    diguni = temporal - (digdec * 10);        
}

void main(void) {
    __delay_ms(15);
    TRISD = 0x00;
    LCD_CONFIG();
    __delay_ms(10);
    CURSOR_ONOFF(OFF);
    BORRAR_LCD();
    CURSOR_HOME();
    ESCRIBE_MENSAJE("Hola mundo",10);
    POS_CURSOR(2,0);
    ESCRIBE_MENSAJE("Cuenta: ",8);
    while(1){
        for(unsigned int loli=0;loli<1000;loli++){
            conviertemoncito(loli);
            ENVIA_CHAR(digcen+0x30);
            ENVIA_CHAR(digdec+0x30);
            ENVIA_CHAR('.');
            ENVIA_CHAR(diguni+0x30);
            POS_CURSOR(2,8);
            __delay_ms(50);
        }
    }
    }
