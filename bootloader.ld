MEMORY
{
    BOOTFLASH (RX) : ORIGIN = 0x00000000, LENGTH = 0x00008000
    APPFLASH (RX) : ORIGIN = 0x00008000, LENGTH = 0x000F8000
    SRAM (WX)  : ORIGIN = 0x20000000, LENGTH = 0x00040000
}

__bootloader_start__ = ORIGIN(BOOTFLASH);
__bootloader_size__ = LENGTH(BOOTFLASH);
__app_start__ = ORIGIN(APPFLASH);
__app_size__ = LENGTH(APPFLASH);

SECTIONS
{
    .text : {
        KEEP (*(.intvecs))
        CREATE_OBJECT_SYMBOLS
        *(.text)
        *(.text.*)
        *(.rodata)
        *(.rodata*)
        . = ALIGN(0x4);
    } > BOOTFLASH

    PROVIDE (__etext = .);
    PROVIDE (_etext = .);
    PROVIDE (etext = .);

    .bss : {
        __bss_start__ = .;
        *(.shbss)
        *(.bss)
        *(.bss.*)
        *(COMMON)
        . = ALIGN (4);
        __bss_end__ = .;
    } > SRAM

    .data : ALIGN (4) {
        __data_load__ = LOADADDR (.data);
        __data_start__ = .;
        *(.data)
        *(.data*)
        . = ALIGN (4);
        __data_end__ = .;
    } > SRAM AT> BOOTFLASH
}