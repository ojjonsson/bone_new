

	.set	SOC_CM_WKUP_REGS,										0x44E00400
	.set	CM_WKUP_UART0_CLKCTRL,0xB4
	.set	CM_WKUP_UART0_CLKCTRL_MODULEMODE,0x00000003
	.set	CM_WKUP_UART0_CLKCTRL_MODULEMODE_ENABLE,0x2
	.set	SOC_CM_PER_REGS,0x44E00000
	.set	CM_PER_L3_CLKCTRL,0xE0
	.set	CM_PER_L3_CLKCTRL_MODULEMODE_ENABLE,0x2
	.set	CM_PER_L3_CLKCTRL_MODULEMODE,0x00000003
	.set	CM_PER_L3_INSTR_CLKCTRL,0xDC
	.set	CM_PER_L3_INSTR_CLKCTRL_MODULEMODE_ENABLE,0x2
	.set	CM_PER_L3_INSTR_CLKCTRL_MODULEMODE,0x00000003
	.set	CM_PER_L3_INSTR_CLKCTRL_IDLEST_FUNC,0x0
	.set	CM_PER_L3_INSTR_CLKCTRL_IDLEST_SHIFT,0x00000010
	.set	CM_PER_L3_INSTR_CLKCTRL_IDLEST,0x00030000
	.set	CM_PER_L3_CLKSTCTRL_CLKTRCTRL_SW_WKUP,0x2
	.set	CM_PER_L3_CLKSTCTRL,0xC
	.set	CM_PER_L3_CLKSTCTRL_CLKTRCTRL,0x00000003
	.set	CM_PER_OCPWP_L3_CLKSTCTRL,0x12C
	.set	CM_PER_OCPWP_L3_CLKSTCTRL_CLKTRCTRL_SW_WKUP,0x2
	.set	CM_PER_OCPWP_L3_CLKSTCTRL_CLKTRCTRL,0x00000003
	.set	CM_PER_L3S_CLKSTCTRL,0x4
	.set	CM_PER_L3S_CLKSTCTRL_CLKTRCTRL_SW_WKUP,0x2
	.set	CM_PER_L3S_CLKSTCTRL_CLKTRCTRL,0x00000003
	.set	CM_PER_L3_CLKCTRL_IDLEST_FUNC,0x0
	.set	CM_PER_L3_CLKCTRL_IDLEST_SHIFT,0x00000010
	.set	CM_PER_L3_CLKCTRL_IDLEST,0x00030000
	.set	CM_PER_L3_CLKSTCTRL_CLKACTIVITY_L3_GCLK,0x00000010
	.set	CM_PER_OCPWP_L3_CLKSTCTRL_CLKACTIVITY_OCPWP_L3_GCLK,0x00000010
	.set	CM_PER_L3S_CLKSTCTRL_CLKACTIVITY_L3S_GCLK,0x00000008
	.set	CM_WKUP_CONTROL_CLKCTRL,0x4
	.set	CM_WKUP_CONTROL_CLKCTRL_MODULEMODE_ENABLE,0x2
	.set	CM_WKUP_CONTROL_CLKCTRL_MODULEMODE,0x00000003
	.set	CM_WKUP_CLKSTCTRL,0x0
	.set	CM_WKUP_CLKSTCTRL_CLKTRCTRL_SW_WKUP,0x2
	.set	CM_WKUP_CLKSTCTRL_CLKTRCTRL,0x00000003
	.set	CM_WKUP_CM_L3_AON_CLKSTCTRL,0x18
	.set	CM_WKUP_CM_L3_AON_CLKSTCTRL_CLKTRCTRL_SW_WKUP,0x2
	.set	CM_WKUP_CM_L3_AON_CLKSTCTRL_CLKTRCTRL,0x00000003
	.set	CM_WKUP_CONTROL_CLKCTRL_IDLEST_FUNC,0x0
	.set	CM_WKUP_CONTROL_CLKCTRL_IDLEST_SHIFT,0x00000010
	.set	CM_WKUP_CONTROL_CLKCTRL_IDLEST,0x00030000
	.set	CM_WKUP_CM_L3_AON_CLKSTCTRL_CLKACTIVITY_L3_AON_GCLK,0x00000008
	.set	CM_WKUP_L4WKUP_CLKCTRL_IDLEST_FUNC,0x0
	.set	CM_WKUP_L4WKUP_CLKCTRL_IDLEST_SHIFT,0x00000010
	.set	CM_WKUP_L4WKUP_CLKCTRL,0xC
	.set	CM_WKUP_L4WKUP_CLKCTRL_IDLEST,0x00030000
	.set	CM_WKUP_CLKSTCTRL_CLKACTIVITY_L4_WKUP_GCLK,0x00000004
	.set	CM_WKUP_CM_L4_WKUP_AON_CLKSTCTRL_CLKACTIVITY_L4_WKUP_AON_GCLK,0x00000004
	.set	CM_WKUP_CM_L4_WKUP_AON_CLKSTCTRL,0xCC
	.set	CM_WKUP_CLKSTCTRL_CLKACTIVITY_UART0_GFCLK,0x00001000
	.set	CM_WKUP_UART0_CLKCTRL_IDLEST_FUNC,0x0
	.set	CM_WKUP_UART0_CLKCTRL_IDLEST_SHIFT,0x00000010
	.set	CM_WKUP_UART0_CLKCTRL_IDLEST,0x00030000




	.global 	uart_setup
	.global		uart_console_putc
	.global		uart_console_getc

	.text
	
	.code 32
	

/* putc & getc func, char is expected to reside in R0 */
/* platform/beaglebone/uartConsole.c:UARTCharPut((UART_CONSOLE_BASE, data) */
uart_putc:
/* return ((unsigned char)UARTCharGet(UART_CONSOLE_BASE)) */
uart_getc:

uart_setup:
	LDR		R0,=SOC_CM_WKUP_REGS
	LDR		R1,[R0,#CM_WKUP_UART0_CLKCTRL]
	AND		R1,#~CM_WKUP_UART0_CLKCTRL_MODULEMODE
	ORR		R1,#CM_WKUP_UART0_CLKCTRL_MODULEMODE_ENABLE
	STR		R1,[R0,#CM_WKUP_UART0_CLKCTRL]
	
	BL		uart_stdio_init
	
	BX		LR
	
	
	
uart_stdio_init:
	/* platform/beaglebone/uart.c:UART0ModuleClkConfig */
	BL		uart0_module_clk_config
	/* platform/beaglebone/uart.c:UARTPinMuxSetup(0) */
/*	BL		uart0_pin_mux_setup*/
	/* platform/beaglebone/uartConsole.c:UARTStdioInitExpClk(BAUD_RATE_115200, 1, 1) */
/*	BL		uart_stdio_init_exp_clk*/
	
	BX		LR
	

uart0_module_clk_config:
    /* Configuring L3 Interface Clocks. */

    /* Writing to MODULEMODE field of CM_PER_L3_CLKCTRL register. */
/*    HWREG(SOC_CM_PER_REGS + CM_PER_L3_CLKCTRL) |=
          CM_PER_L3_CLKCTRL_MODULEMODE_ENABLE;*/
	LDR		R0,=SOC_CM_PER_REGS
	LDR		R1,[R0,#CM_PER_L3_CLKCTRL]
	ORR		R1,#CM_PER_L3_CLKCTRL_MODULEMODE_ENABLE
	STR		R1,[R0,#CM_PER_L3_CLKCTRL]
	
    /* Waiting for MODULEMODE field to reflect the written value. */
/*    while(CM_PER_L3_CLKCTRL_MODULEMODE_ENABLE !=
          (HWREG(SOC_CM_PER_REGS + CM_PER_L3_CLKCTRL) &
           CM_PER_L3_CLKCTRL_MODULEMODE));*/
loop_1:
	LDR		R1,[R0,#CM_PER_L3_CLKCTRL]
	AND		R1,#CM_PER_L3_CLKCTRL_MODULEMODE
	CMP		R1,#CM_PER_L3_CLKCTRL_MODULEMODE_ENABLE
	BEQ		loop_1

    /* Writing to MODULEMODE field of CM_PER_L3_INSTR_CLKCTRL register. */
/*    HWREG(SOC_CM_PER_REGS + CM_PER_L3_INSTR_CLKCTRL) |=
          CM_PER_L3_INSTR_CLKCTRL_MODULEMODE_ENABLE;*/
	LDR		R1,[R0,#CM_PER_L3_INSTR_CLKCTRL]
	ORR		R1,#CM_PER_L3_INSTR_CLKCTRL_MODULEMODE_ENABLE
	STR		R1,[R0,#CM_PER_L3_INSTR_CLKCTRL]

    /* Waiting for MODULEMODE field to reflect the written value. */
/*    while(CM_PER_L3_INSTR_CLKCTRL_MODULEMODE_ENABLE !=
          (HWREG(SOC_CM_PER_REGS + CM_PER_L3_INSTR_CLKCTRL) &
           CM_PER_L3_INSTR_CLKCTRL_MODULEMODE));*/
loop_2:
	LDR		R1,[R0,#CM_PER_L3_INSTR_CLKCTRL]
	AND		R1,#CM_PER_L3_INSTR_CLKCTRL_MODULEMODE
	CMP		R1,#CM_PER_L3_INSTR_CLKCTRL_MODULEMODE_ENABLE
	BEQ		loop_2

    /* Writing to CLKTRCTRL field of CM_PER_L3_CLKSTCTRL register. */
/*    HWREG(SOC_CM_PER_REGS + CM_PER_L3_CLKSTCTRL) |=
          CM_PER_L3_CLKSTCTRL_CLKTRCTRL_SW_WKUP;*/
	LDR		R1,[R0,#CM_PER_L3_CLKSTCTRL]
	ORR		R1,#CM_PER_L3_CLKSTCTRL_CLKTRCTRL_SW_WKUP
	STR		R1,[R0,#CM_PER_L3_CLKSTCTRL]
	

    /* Waiting for CLKTRCTRL field to reflect the written value. */
/*    while(CM_PER_L3_CLKSTCTRL_CLKTRCTRL_SW_WKUP !=
          (HWREG(SOC_CM_PER_REGS + CM_PER_L3_CLKSTCTRL) &
           CM_PER_L3_CLKSTCTRL_CLKTRCTRL));*/
loop_3:
	LDR		R1,[R0,#CM_PER_L3_CLKSTCTRL]
	AND		R1,#CM_PER_L3_CLKSTCTRL_CLKTRCTRL
	CMP		R1,#CM_PER_L3_CLKSTCTRL_CLKTRCTRL_SW_WKUP
	BEQ		loop_3

    /* Writing to CLKTRCTRL field of CM_PER_OCPWP_L3_CLKSTCTRL register. */
/*    HWREG(SOC_CM_PER_REGS + CM_PER_OCPWP_L3_CLKSTCTRL) |=
          CM_PER_OCPWP_L3_CLKSTCTRL_CLKTRCTRL_SW_WKUP;*/
	LDR		R1,[R0,#CM_PER_OCPWP_L3_CLKSTCTRL]
	ORR		R1,#CM_PER_OCPWP_L3_CLKSTCTRL_CLKTRCTRL_SW_WKUP
	STR		R1,[R0,#CM_PER_OCPWP_L3_CLKSTCTRL]
	

    /*Waiting for CLKTRCTRL field to reflect the written value. */
/*    while(CM_PER_OCPWP_L3_CLKSTCTRL_CLKTRCTRL_SW_WKUP !=
          (HWREG(SOC_CM_PER_REGS + CM_PER_OCPWP_L3_CLKSTCTRL) &
           CM_PER_OCPWP_L3_CLKSTCTRL_CLKTRCTRL));*/
loop_4:
	LDR		R1,[R0,#CM_PER_OCPWP_L3_CLKSTCTRL]
	AND		R1,#CM_PER_OCPWP_L3_CLKSTCTRL_CLKTRCTRL
	CMP		R1,#CM_PER_OCPWP_L3_CLKSTCTRL_CLKTRCTRL_SW_WKUP
	BEQ		loop_4

    /* Writing to CLKTRCTRL field of CM_PER_L3S_CLKSTCTRL register. */
/*    HWREG(SOC_CM_PER_REGS + CM_PER_L3S_CLKSTCTRL) |=
          CM_PER_L3S_CLKSTCTRL_CLKTRCTRL_SW_WKUP;*/
	LDR		R1,[R0,#CM_PER_L3S_CLKSTCTRL]
	ORR		R1,#CM_PER_L3S_CLKSTCTRL_CLKTRCTRL_SW_WKUP
	STR		R1,[R0,#CM_PER_L3S_CLKSTCTRL]


    /*Waiting for CLKTRCTRL field to reflect the written value. */
/*    while(CM_PER_L3S_CLKSTCTRL_CLKTRCTRL_SW_WKUP !=
          (HWREG(SOC_CM_PER_REGS + CM_PER_L3S_CLKSTCTRL) &
           CM_PER_L3S_CLKSTCTRL_CLKTRCTRL));*/
loop_5:
	LDR		R1,[R0,#CM_PER_L3S_CLKSTCTRL]
	AND		R1,#CM_PER_L3S_CLKSTCTRL_CLKTRCTRL
	CMP		R1,#CM_PER_L3S_CLKSTCTRL_CLKTRCTRL_SW_WKUP
	BEQ		loop_5

    /* Checking fields for necessary values.  */

    /* Waiting for IDLEST field in CM_PER_L3_CLKCTRL register to be set to 0x0. */
/*    while((CM_PER_L3_CLKCTRL_IDLEST_FUNC << CM_PER_L3_CLKCTRL_IDLEST_SHIFT)!=
          (HWREG(SOC_CM_PER_REGS + CM_PER_L3_CLKCTRL) &
           CM_PER_L3_CLKCTRL_IDLEST));*/
loop_6:
	LDR		R1,[R0,#CM_PER_L3_CLKCTRL]
	AND		R1,#CM_PER_L3_CLKCTRL_IDLEST
	CMP		R1,#(CM_PER_L3_CLKCTRL_IDLEST_FUNC << CM_PER_L3_CLKCTRL_IDLEST_SHIFT)
	BEQ		loop_6


    /*
    ** Waiting for IDLEST field in CM_PER_L3_INSTR_CLKCTRL register to attain the
    ** desired value.
    */
/*    while((CM_PER_L3_INSTR_CLKCTRL_IDLEST_FUNC <<
           CM_PER_L3_INSTR_CLKCTRL_IDLEST_SHIFT)!=
          (HWREG(SOC_CM_PER_REGS + CM_PER_L3_INSTR_CLKCTRL) &
           CM_PER_L3_INSTR_CLKCTRL_IDLEST));*/
loop_7:
	LDR		R1,[R0,#CM_PER_L3_INSTR_CLKCTRL]
	AND		R1,#CM_PER_L3_INSTR_CLKCTRL_IDLEST
	CMP		R1,#(CM_PER_L3_INSTR_CLKCTRL_IDLEST_FUNC << CM_PER_L3_INSTR_CLKCTRL_IDLEST_SHIFT)
	BEQ		loop_7

    /*
    ** Waiting for CLKACTIVITY_L3_GCLK field in CM_PER_L3_CLKSTCTRL register to
    ** attain the desired value.
    */
/*    while(CM_PER_L3_CLKSTCTRL_CLKACTIVITY_L3_GCLK !=
          (HWREG(SOC_CM_PER_REGS + CM_PER_L3_CLKSTCTRL) &
           CM_PER_L3_CLKSTCTRL_CLKACTIVITY_L3_GCLK));*/
loop_8:
	LDR		R1,[R0,#CM_PER_L3_CLKSTCTRL]
/*	ANDS	R1,#CM_PER_L3_CLKSTCTRL_CLKACTIVITY_L3_GCLK*/
	CMP		R1,#CM_PER_L3_CLKSTCTRL_CLKACTIVITY_L3_GCLK
	BEQ		loop_8
	

    /*
    ** Waiting for CLKACTIVITY_OCPWP_L3_GCLK field in CM_PER_OCPWP_L3_CLKSTCTRL
    ** register to attain the desired value.
    */
/*    while(CM_PER_OCPWP_L3_CLKSTCTRL_CLKACTIVITY_OCPWP_L3_GCLK !=
          (HWREG(SOC_CM_PER_REGS + CM_PER_OCPWP_L3_CLKSTCTRL) &
           CM_PER_OCPWP_L3_CLKSTCTRL_CLKACTIVITY_OCPWP_L3_GCLK));*/
loop_9:
	LDR		R1,[R0,#CM_PER_OCPWP_L3_CLKSTCTRL]
	CMP		R1,#CM_PER_OCPWP_L3_CLKSTCTRL_CLKACTIVITY_OCPWP_L3_GCLK
	BEQ		loop_9

    /*
    ** Waiting for CLKACTIVITY_L3S_GCLK field in CM_PER_L3S_CLKSTCTRL register
    ** to attain the desired value.
    */
/*    while(CM_PER_L3S_CLKSTCTRL_CLKACTIVITY_L3S_GCLK !=
          (HWREG(SOC_CM_PER_REGS + CM_PER_L3S_CLKSTCTRL) &
          CM_PER_L3S_CLKSTCTRL_CLKACTIVITY_L3S_GCLK));*/
loop_10:
	LDR		R1,[R0,#CM_PER_L3S_CLKSTCTRL]
	CMP		R1,#CM_PER_L3S_CLKSTCTRL_CLKACTIVITY_L3S_GCLK
	BEQ		loop_10


    /* Configuring registers related to Wake-Up region. */

	LDR		R0,=SOC_CM_WKUP_REGS
    /* Writing to MODULEMODE field of CM_WKUP_CONTROL_CLKCTRL register. */
/*    HWREG(SOC_CM_WKUP_REGS + CM_WKUP_CONTROL_CLKCTRL) |=
          CM_WKUP_CONTROL_CLKCTRL_MODULEMODE_ENABLE;*/
	LDR		R1,[R0,#CM_WKUP_CONTROL_CLKCTRL]
	ORR		R1,#CM_WKUP_CONTROL_CLKCTRL_MODULEMODE_ENABLE
	STR		R1,[R0,#CM_WKUP_CONTROL_CLKCTRL]

    /* Waiting for MODULEMODE field to reflect the written value. */
/*    while(CM_WKUP_CONTROL_CLKCTRL_MODULEMODE_ENABLE !=
          (HWREG(SOC_CM_WKUP_REGS + CM_WKUP_CONTROL_CLKCTRL) &
           CM_WKUP_CONTROL_CLKCTRL_MODULEMODE));*/
loop_11:           
	LDR		R1,[R0,#CM_WKUP_CONTROL_CLKCTRL]
	AND		R1,#CM_WKUP_CONTROL_CLKCTRL_MODULEMODE
	CMP		R1,#CM_WKUP_CONTROL_CLKCTRL_MODULEMODE_ENABLE
	BEQ		loop_11

    /* Writing to CLKTRCTRL field of CM_PER_L3S_CLKSTCTRL register. */
/*    HWREG(SOC_CM_WKUP_REGS + CM_WKUP_CLKSTCTRL) |=
          CM_WKUP_CLKSTCTRL_CLKTRCTRL_SW_WKUP;*/
	LDR		R1,[R0,#CM_WKUP_CLKSTCTRL]
	ORR		R1,#CM_WKUP_CLKSTCTRL_CLKTRCTRL_SW_WKUP
	STR		R1,[R0,#CM_WKUP_CLKSTCTRL]

    /*Waiting for CLKTRCTRL field to reflect the written value. */
/*    while(CM_WKUP_CLKSTCTRL_CLKTRCTRL_SW_WKUP !=
          (HWREG(SOC_CM_WKUP_REGS + CM_WKUP_CLKSTCTRL) &
           CM_WKUP_CLKSTCTRL_CLKTRCTRL));*/
loop_12:
	LDR		R1,[R0,#CM_WKUP_CLKSTCTRL]
	AND		R1,#CM_WKUP_CLKSTCTRL_CLKTRCTRL
	CMP		R1,#CM_WKUP_CLKSTCTRL_CLKTRCTRL_SW_WKUP
	BEQ		loop_12


    /* Writing to CLKTRCTRL field of CM_L3_AON_CLKSTCTRL register. */
/*    HWREG(SOC_CM_WKUP_REGS + CM_WKUP_CM_L3_AON_CLKSTCTRL) |=
          CM_WKUP_CM_L3_AON_CLKSTCTRL_CLKTRCTRL_SW_WKUP;*/
	LDR		R1,[R0,#CM_WKUP_CM_L3_AON_CLKSTCTRL]
	ORR		R1,#CM_WKUP_CM_L3_AON_CLKSTCTRL_CLKTRCTRL_SW_WKUP
	STR		R1,[R0,#CM_WKUP_CM_L3_AON_CLKSTCTRL]

    /*Waiting for CLKTRCTRL field to reflect the written value. */
/*    while(CM_WKUP_CM_L3_AON_CLKSTCTRL_CLKTRCTRL_SW_WKUP !=
          (HWREG(SOC_CM_WKUP_REGS + CM_WKUP_CM_L3_AON_CLKSTCTRL) &
           CM_WKUP_CM_L3_AON_CLKSTCTRL_CLKTRCTRL));*/
loop_13:
	LDR		R1,[R0,#CM_WKUP_CM_L3_AON_CLKSTCTRL]
	AND		R1,#CM_WKUP_CM_L3_AON_CLKSTCTRL_CLKTRCTRL
	CMP		R1,#CM_WKUP_CM_L3_AON_CLKSTCTRL_CLKTRCTRL_SW_WKUP
	BEQ		loop_13

    /* Writing to MODULEMODE field of CM_WKUP_UART0_CLKCTRL register. */
/*    HWREG(SOC_CM_WKUP_REGS + CM_WKUP_UART0_CLKCTRL) |=
          CM_WKUP_UART0_CLKCTRL_MODULEMODE_ENABLE;*/
	LDR		R1,[R0,#CM_WKUP_UART0_CLKCTRL]
	ORR		R1,#CM_WKUP_UART0_CLKCTRL_MODULEMODE_ENABLE
	STR		R1,[R0,#CM_WKUP_UART0_CLKCTRL]


    /* Waiting for MODULEMODE field to reflect the written value. */
/*    while(CM_WKUP_UART0_CLKCTRL_MODULEMODE_ENABLE !=
          (HWREG(SOC_CM_WKUP_REGS + CM_WKUP_UART0_CLKCTRL) &
           CM_WKUP_UART0_CLKCTRL_MODULEMODE));*/
loop_14:
	LDR		R1,[R0,#CM_WKUP_UART0_CLKCTRL]
	AND		R1,#CM_WKUP_UART0_CLKCTRL_MODULEMODE
	CMP		R1,#CM_WKUP_UART0_CLKCTRL_MODULEMODE_ENABLE
	BEQ		loop_14

    /* Verifying if the other bits are set to required settings. */

    /*
    ** Waiting for IDLEST field in CM_WKUP_CONTROL_CLKCTRL register to attain
    ** desired value.
    */
/*    while((CM_WKUP_CONTROL_CLKCTRL_IDLEST_FUNC <<
           CM_WKUP_CONTROL_CLKCTRL_IDLEST_SHIFT) !=
          (HWREG(SOC_CM_WKUP_REGS + CM_WKUP_CONTROL_CLKCTRL) &
           CM_WKUP_CONTROL_CLKCTRL_IDLEST));*/
loop_15:
	LDR		R1,[R0,#CM_WKUP_CONTROL_CLKCTRL]
	AND		R1,#CM_WKUP_CONTROL_CLKCTRL_IDLEST
	CMP		R1,#(CM_WKUP_CONTROL_CLKCTRL_IDLEST_FUNC << CM_WKUP_CONTROL_CLKCTRL_IDLEST_SHIFT)
	BEQ		loop_15

    /*
    ** Waiting for CLKACTIVITY_L3_AON_GCLK field in CM_L3_AON_CLKSTCTRL
    ** register to attain desired value.
    */
/*    while(CM_WKUP_CM_L3_AON_CLKSTCTRL_CLKACTIVITY_L3_AON_GCLK !=
          (HWREG(SOC_CM_WKUP_REGS + CM_WKUP_CM_L3_AON_CLKSTCTRL) &
           CM_WKUP_CM_L3_AON_CLKSTCTRL_CLKACTIVITY_L3_AON_GCLK));*/
loop_16:
	LDR		R1,[R0,#CM_WKUP_CM_L3_AON_CLKSTCTRL]
	CMP		R1,#CM_WKUP_CM_L3_AON_CLKSTCTRL_CLKACTIVITY_L3_AON_GCLK
	BEQ		loop_16

    /*
    ** Waiting for IDLEST field in CM_WKUP_L4WKUP_CLKCTRL register to attain
    ** desired value.
    */
/*    while((CM_WKUP_L4WKUP_CLKCTRL_IDLEST_FUNC <<
           CM_WKUP_L4WKUP_CLKCTRL_IDLEST_SHIFT) !=
          (HWREG(SOC_CM_WKUP_REGS + CM_WKUP_L4WKUP_CLKCTRL) &
           CM_WKUP_L4WKUP_CLKCTRL_IDLEST));*/
loop_17:
	LDR		R1,[R0,#CM_WKUP_L4WKUP_CLKCTRL]
	AND		R1,#CM_WKUP_L4WKUP_CLKCTRL_IDLEST
	CMP		R1,#(CM_WKUP_L4WKUP_CLKCTRL_IDLEST_FUNC << CM_WKUP_L4WKUP_CLKCTRL_IDLEST_SHIFT)
	BEQ		loop_17

    /*
    ** Waiting for CLKACTIVITY_L4_WKUP_GCLK field in CM_WKUP_CLKSTCTRL register
    ** to attain desired value.
    */
/*    while(CM_WKUP_CLKSTCTRL_CLKACTIVITY_L4_WKUP_GCLK !=
          (HWREG(SOC_CM_WKUP_REGS + CM_WKUP_CLKSTCTRL) &
           CM_WKUP_CLKSTCTRL_CLKACTIVITY_L4_WKUP_GCLK));*/
loop_18:
	LDR		R1,[R0,#CM_WKUP_CLKSTCTRL]
	CMP		R1,#CM_WKUP_CLKSTCTRL_CLKACTIVITY_L4_WKUP_GCLK
	BEQ		loop_18

    /*
    ** Waiting for CLKACTIVITY_L4_WKUP_AON_GCLK field in CM_L4_WKUP_AON_CLKSTCTRL
    ** register to attain desired value.
    */
/*    while(CM_WKUP_CM_L4_WKUP_AON_CLKSTCTRL_CLKACTIVITY_L4_WKUP_AON_GCLK !=
          (HWREG(SOC_CM_WKUP_REGS + CM_WKUP_CM_L4_WKUP_AON_CLKSTCTRL) &
           CM_WKUP_CM_L4_WKUP_AON_CLKSTCTRL_CLKACTIVITY_L4_WKUP_AON_GCLK));*/
loop_19:
	LDR		R1,[R0,#CM_WKUP_CM_L4_WKUP_AON_CLKSTCTRL]
	CMP		R1,#CM_WKUP_CM_L4_WKUP_AON_CLKSTCTRL_CLKACTIVITY_L4_WKUP_AON_GCLK
	BEQ		loop_19

    /*
    ** Waiting for CLKACTIVITY_UART0_GFCLK field in CM_WKUP_CLKSTCTRL
    ** register to attain desired value.
    */
/*    while(CM_WKUP_CLKSTCTRL_CLKACTIVITY_UART0_GFCLK !=
          (HWREG(SOC_CM_WKUP_REGS + CM_WKUP_CLKSTCTRL) &
           CM_WKUP_CLKSTCTRL_CLKACTIVITY_UART0_GFCLK));*/
loop_20:
	LDR		R1,[R0,#CM_WKUP_CLKSTCTRL]
	CMP		R1,#CM_WKUP_CLKSTCTRL_CLKACTIVITY_UART0_GFCLK
	BEQ		loop_20

    /*
    ** Waiting for IDLEST field in CM_WKUP_UART0_CLKCTRL register to attain
    ** desired value.
    */
/*    while((CM_WKUP_UART0_CLKCTRL_IDLEST_FUNC <<
           CM_WKUP_UART0_CLKCTRL_IDLEST_SHIFT) !=
          (HWREG(SOC_CM_WKUP_REGS + CM_WKUP_UART0_CLKCTRL) &
           CM_WKUP_UART0_CLKCTRL_IDLEST));*/
loop_21:
	LDR		R1,[R0,#CM_WKUP_UART0_CLKCTRL]
	AND		R1,#CM_WKUP_UART0_CLKCTRL_IDLEST
	CMP		R1,#(CM_WKUP_UART0_CLKCTRL_IDLEST_FUNC << CM_WKUP_UART0_CLKCTRL_IDLEST_SHIFT)
	BEQ		loop_21
	
	BX		LR


	.end
