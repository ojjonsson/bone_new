/*
my init func
*/
	.set	SOC_CM_WKUP_REGS,							0x44E00400
	.set	CM_WKUP_CONTROL_CLKCTRL,					0x00000004
	.set	CM_WKUP_CONTROL_CLKCTRL_MODULEMODE_ENABLE,	0x00000002


	.set	SOC_WDT_1_REGS,								0x44E35000
	.set	WDT_WSPR,									0x00000048
	.set	WDT_WWPS,									0x00000034


	.global main


.set INCLUDE_LED_DELAY,	1
.if INCLUDE_LED_DELAY
	.set LOOP_DELAY,	1000000
/*	.set LOOP_DELAY,	1000*/
.endif
	
	.text
	
	.code 32


main:

	BL		init_usr_led
	
	LDR		R0,=1
	BL 		set_usr_led
	
	/* config voltages */
	/* TODO: indeed to set up voltages... */

/*
    HWREG(SOC_WDT_1_REGS + WDT_WSPR) = 0xAAAAu;
    while(HWREG(SOC_WDT_1_REGS + WDT_WWPS) != 0x00);
*/
	LDR		R0,=SOC_WDT_1_REGS
	LDR		R1,=0x0000AAAA
	STR		R1,[R0,#WDT_WSPR]
loop_aaaa:
	LDR		R1,[R0,#WDT_WWPS]
	BNE		loop_aaaa

/*
    HWREG(SOC_WDT_1_REGS + WDT_WSPR) = 0x5555u;
    while(HWREG(SOC_WDT_1_REGS + WDT_WWPS) != 0x00);  
*/
	LDR		R0,=SOC_WDT_1_REGS
	LDR		R1,=0x00005555
	STR		R1,[R0,#WDT_WSPR]
loop_5555:
	LDR		R1,[R0,#WDT_WWPS]
	BNE		loop_5555
	
	BL		per_pll_init

    /* Enable the control module */
/*
    HWREG(SOC_CM_WKUP_REGS + CM_WKUP_CONTROL_CLKCTRL) =
            CM_WKUP_CONTROL_CLKCTRL_MODULEMODE_ENABLE;
*/
	LDR		R0,=SOC_CM_WKUP_REGS
	LDR		R1,=CM_WKUP_CONTROL_CLKCTRL_MODULEMODE_ENABLE
	STR		R1,[R0,#CM_WKUP_CONTROL_CLKCTRL]
	
	/* emif init */
	
	/* DDR3 init */
	
	/* UART setup */
 	
	
/*
loop:
	
	MOV		R0,R2
	BL 		set_usr_led
	BL		delay_func
	ADDS	R2,#1
	CMP		R2,#15
	MOVGT	R2,#0

	B		loop
*/

delay_func:
	LDR		R4,=LOOP_DELAY
delay_1:
	SUBS	R4,#1
	BNE		delay_1
	BX		LR




/*	
End of file
*/
	.end
