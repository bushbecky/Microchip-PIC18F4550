/*
 * File:   maincode.c
 * Author: Kalun Lau
 *
 * Created on February 8, 2021, 8:51 PM
 */

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
#define _XTAL_FREQ 48000000UL

unsigned int estado = 0;
unsigned char cochinada = 0;

void configure(void){
    //Aqu� colocas las configuraciones iniciales de tu aplicacion
    TRISD = 0xFC;               //RD0 y RD1 como salidas
    INTCON = 0x88;              //RBIE y GIE habilitado
}

void main(void) {
    configure();
    while(1){
        if(estado == 1){
            LATD = 0x01;
            __delay_ms(250);
            LATD = 0x02;
            __delay_ms(250);
        }
        else{
            LATD = 0x00;
        }
    }
}

void __interrupt(high_priority) RB_Isr(void){
    cochinada = PORTB;      //Para quitar la condici�n de mismatch
    if(estado == 1){
        estado = 0;
    }
    else{
        estado = 1;
    }
    INTCONbits.RBIF = 0;
}