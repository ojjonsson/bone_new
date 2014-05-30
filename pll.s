/*
	BBB PLL's
	heavily inspired by TI starterware
	bootloader\src\armv7a\am335x\bl_platform.c
*/


/* peripheral (i.e. UART) PLL */
	.set	SOC_CM_WKUP_REGS,										0x44E00400
	.set	CM_WKUP_CM_CLKMODE_DPLL_PER,							0x0000008C
	.set	CM_WKUP_CM_CLKMODE_DPLL_PER_DPLL_EN,					0x00000007
	.set	CM_WKUP_CM_CLKMODE_DPLL_PER_DPLL_EN_DPLL_MN_BYP_MODE,	0x00000004
	.set	CM_WKUP_CM_IDLEST_DPLL_PER,								0x00000070
	.set	CM_WKUP_CM_IDLEST_DPLL_PER_ST_MN_BYPASS,				0x00000100
	.set	CM_WKUP_CM_CLKSEL_DPLL_PERIPH,							0x0000009C
	.set	CM_WKUP_CM_CLKSEL_DPLL_PERIPH_DPLL_MULT,				0x000FFF00
	.set	CM_WKUP_CM_CLKSEL_DPLL_PERIPH_DPLL_DIV,					0x000000FF
	.set	CM_WKUP_CM_CLKSEL_DPLL_PERIPH_DPLL_MULT_SHIFT,			0x00000008
	.set	CM_WKUP_CM_CLKSEL_DPLL_PERIPH_DPLL_DIV_SHIFT,			0x00000000
	.set	CM_WKUP_CM_DIV_M2_DPLL_PER,								0x000000AC
	.set	CM_WKUP_CM_DIV_M2_DPLL_PER_DPLL_CLKOUT_DIV,				0x0000007F
	.set	CM_WKUP_CM_IDLEST_DPLL_PER_ST_DPLL_CLK,					0x00000001
	
	/* M, N & M2 for 115200 on a 24MHz base clock */
	.set	PERPLL_M,												0x000003C0
	.set	PERPLL_N,												0x00000017
	.set	PERPLL_M2,												0x00000005

	.global 	per_pll_init

	.text
	
	.code 32


	
per_pll_init:
/*    volatile unsigned int regVal = 0;*/
	
	LDR		R0,=SOC_CM_WKUP_REGS

    /* Put the PLL in bypass mode */
/*    regVal = HWREG(SOC_CM_WKUP_REGS + CM_WKUP_CM_CLKMODE_DPLL_PER) &
                ~CM_WKUP_CM_CLKMODE_DPLL_PER_DPLL_EN;
*/
	LDR		R1,[R0,#CM_WKUP_CM_CLKMODE_DPLL_PER]
	AND		R1,#~CM_WKUP_CM_CLKMODE_DPLL_PER_DPLL_EN

/*    regVal |= CM_WKUP_CM_CLKMODE_DPLL_PER_DPLL_EN_DPLL_MN_BYP_MODE;*/
	ORR		R1,#CM_WKUP_CM_CLKMODE_DPLL_PER_DPLL_EN_DPLL_MN_BYP_MODE

/*    HWREG(SOC_CM_WKUP_REGS + CM_WKUP_CM_CLKMODE_DPLL_PER) = regVal;*/
	STR		R1,[R0,#CM_WKUP_CM_CLKMODE_DPLL_PER]

/*    while(!(HWREG(SOC_CM_WKUP_REGS + CM_WKUP_CM_IDLEST_DPLL_PER) &
                      CM_WKUP_CM_IDLEST_DPLL_PER_ST_MN_BYPASS));
*/
per_pll_bypass_loop:
	LDR		R1,[R0,#CM_WKUP_CM_IDLEST_DPLL_PER]
	ANDS	R1,#CM_WKUP_CM_IDLEST_DPLL_PER_ST_MN_BYPASS
	BEQ		per_pll_bypass_loop
	
/*
    HWREG(SOC_CM_WKUP_REGS + CM_WKUP_CM_CLKSEL_DPLL_PERIPH) &=
                             ~(CM_WKUP_CM_CLKSEL_DPLL_PERIPH_DPLL_MULT |
                                    CM_WKUP_CM_CLKSEL_DPLL_PERIPH_DPLL_DIV);
*/
	LDR		R1,[R0,#CM_WKUP_CM_CLKSEL_DPLL_PERIPH]
/*	AND		R1,#~(CM_WKUP_CM_CLKSEL_DPLL_PERIPH_DPLL_MULT | CM_WKUP_CM_CLKSEL_DPLL_PERIPH_DPLL_DIV)*/
/*	LDR		R2,=0xFFF00000*/
	LDR		R2,=~(CM_WKUP_CM_CLKSEL_DPLL_PERIPH_DPLL_MULT | CM_WKUP_CM_CLKSEL_DPLL_PERIPH_DPLL_DIV)
	AND		R1,R2

    /* Set the multipler and divider values for the PLL */
/*
    HWREG(SOC_CM_WKUP_REGS + CM_WKUP_CM_CLKSEL_DPLL_PERIPH) |=
        ((PERPLL_M << CM_WKUP_CM_CLKSEL_DPLL_PERIPH_DPLL_MULT_SHIFT) |
         (PERPLL_N << CM_WKUP_CM_CLKSEL_DPLL_PERIPH_DPLL_DIV_SHIFT));
*/
/*	ORR		R1,#((PERPLL_M << CM_WKUP_CM_CLKSEL_DPLL_PERIPH_DPLL_MULT_SHIFT)|(PERPLL_N << CM_WKUP_CM_CLKSEL_DPLL_PERIPH_DPLL_DIV_SHIFT))*/
	LDR		R2,=((PERPLL_M << CM_WKUP_CM_CLKSEL_DPLL_PERIPH_DPLL_MULT_SHIFT)|(PERPLL_N << CM_WKUP_CM_CLKSEL_DPLL_PERIPH_DPLL_DIV_SHIFT))
	ORR		R1,R2
	STR		R1,[R0,#CM_WKUP_CM_CLKSEL_DPLL_PERIPH]

/*
    regVal = HWREG(SOC_CM_WKUP_REGS + CM_WKUP_CM_DIV_M2_DPLL_PER);
    regVal = regVal & ~CM_WKUP_CM_DIV_M2_DPLL_PER_DPLL_CLKOUT_DIV;
    regVal = regVal | PERPLL_M2;
*/
	LDR		R1,[R0,#CM_WKUP_CM_DIV_M2_DPLL_PER]
	AND		R1,#~CM_WKUP_CM_DIV_M2_DPLL_PER_DPLL_CLKOUT_DIV
	ORR		R1,#PERPLL_M2

    /* Set the CLKOUT2 divider */
/*
    HWREG(SOC_CM_WKUP_REGS + CM_WKUP_CM_DIV_M2_DPLL_PER) = regVal;
*/
	STR		R1,[R0,#CM_WKUP_CM_DIV_M2_DPLL_PER]
    
    /* Now LOCK the PLL by enabling it */
/*
    regVal = HWREG(SOC_CM_WKUP_REGS + CM_WKUP_CM_CLKMODE_DPLL_PER) &
                ~CM_WKUP_CM_CLKMODE_DPLL_PER_DPLL_EN;
*/
	LDR		R1,[R0,#CM_WKUP_CM_CLKMODE_DPLL_PER]
	AND		R1,#~CM_WKUP_CM_CLKMODE_DPLL_PER_DPLL_EN
/*
    regVal |= CM_WKUP_CM_CLKMODE_DPLL_PER_DPLL_EN;
*/
	ORR		R1,#CM_WKUP_CM_CLKMODE_DPLL_PER_DPLL_EN
/*
    HWREG(SOC_CM_WKUP_REGS + CM_WKUP_CM_CLKMODE_DPLL_PER) = regVal;
*/
	STR		R1,[R0,#CM_WKUP_CM_CLKMODE_DPLL_PER]

/*
    while(!(HWREG(SOC_CM_WKUP_REGS + CM_WKUP_CM_IDLEST_DPLL_PER) &
                           CM_WKUP_CM_IDLEST_DPLL_PER_ST_DPLL_CLK)); 
*/						   
per_pll_lock_loop:
	LDR		R1,[R0,#CM_WKUP_CM_IDLEST_DPLL_PER]
	ANDS	R1,#CM_WKUP_CM_IDLEST_DPLL_PER_ST_DPLL_CLK
	BEQ		per_pll_lock_loop
		
	BX	LR

	
	
	
	.end
	