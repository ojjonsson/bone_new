# CROSS_COMPILE ?= arm-linux-gnueabihf-
CROSS_COMPILE ?= arm-none-eabi-

CC=$(CROSS_COMPILE)gcc
AS=$(CROSS_COMPILE)as
OBJCPY=$(CROSS_COMPILE)objcopy
OBJDUMP=$(CROSS_COMPILE)objdump
LD=$(CROSS_COMPILE)ld

# AS_OPTS=-marm -mfpu=neon -march=armv7-a -g -c 
AS_OPTS=-mfpu=neon -march=armv7-a -g -c 



all: my_init.elf my_init.bin my_init.lst

OBJS=my_init.o led.o pll.o bl_init.o uart.o

my_init.elf: $(OBJS)
	$(LD) -g -T my_init.lds $(OBJS) -o my_init.elf -Map my_init.map

my_init.bin: my_init.elf
	$(OBJCPY) my_init.elf my_init.bin -O binary

my_init.lst: my_init.bin
	$(OBJDUMP) -D -b binary -marm my_init.bin > my_init.lst

my_init.o: my_init.s
	$(AS) $(AS_OPTS) my_init.s -o my_init.o

led.o: led.s
	$(AS) $(AS_OPTS) led.s -o led.o

pll.o: pll.s
	$(AS) $(AS_OPTS) pll.s -o pll.o

bl_init.o: bl_init.s
	$(AS) $(AS_OPTS) bl_init.s -o bl_init.o

uart.o: uart.s
	$(AS) $(AS_OPTS) uart.s -o uart.o
	
clean:
	rm *.o *.bin *.lst *.elf *.map
