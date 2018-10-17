
/*Detallamos los bits de configuraci�n del microcontrolador*/

#pragma config PLLDIV = 1       // PLL Prescaler Selection bits (No prescale (4 MHz oscillator input drives PLL directly))
#pragma config CPUDIV = OSC1_PLL2// System Clock Postscaler Selection bits ([Primary Oscillator Src: /1][96 MHz PLL Src: /2])
#pragma config FOSC = XTPLL_XT  // Oscillator Selection bits (XT oscillator, PLL enabled (XTPLL))
#pragma config FCMEN = OFF      // Fail-Safe Clock Monitor Enable bit (Fail-Safe Clock Monitor disabled)
#pragma config IESO = OFF       // Internal/External Oscillator Switchover bit (Oscillator Switchover mode disabled)
#pragma config PWRT = ON        // Power-up Timer Enable bit (PWRT enabled)
#pragma config BOR = OFF        // Brown-out Reset Enable bits (Brown-out Reset disabled in hardware and software)
#pragma config WDT = OFF        // Watchdog Timer Enable bit (WDT disabled (control is placed on the SWDTEN bit))
#pragma config CCP2MX = ON      // CCP2 MUX bit (CCP2 input/output is multiplexed with RC1)
#pragma config PBADEN = OFF     // PORTB A/D Enable bit (PORTB<4:0> pins are configured as digital I/O on Reset)
#pragma config MCLRE = ON       // MCLR Pin Enable bit (MCLR pin enabled; RE3 input pin disabled)
#pragma config LVP = OFF        // Single-Supply ICSP Enable bit (Single-Supply ICSP disabled)

#include <xc.h>

#define _XTAL_FREQ 48000000UL

//void main(void) {
//    TRISDbits.RD0 = 0;      //Puerto D0 como salida
//    TRISDbits.RD1 = 0;      //Puerto D1 como salida
//    while (1){
//        LATDbits.LD0 = 0;
//        LATDbits.LD1 = 1;
//        __delay_ms(200);
//        LATDbits.LD0 = 1;
//        LATDbits.LD1 = 0;
//        __delay_ms(200);
//    }
//}

void main(void) {
    TRISD = 0xFC;      //Puerto D0 y D1 como salida
    while (1){
        LATD = 0x01;
        __delay_ms(200);
        LATD = 0x02;
        __delay_ms(200);
    }
}
