bits 16 ; tell the assembler (NASM) that this is 16 bit code
org 0x7c00 ; tell the assembler (NASM) to start outputting inforation at 0x7c00
boot: 
  mov si, hello ; point si register to hello label memory location
  mov ah, 0x0e ; 0x0e means "Write character in TTY mode"
.loop:
  lodsb ; load byte from si into al and increment si
  or al, al ; is al == 0 ?
  jz halt ; if al == 0, jump to halt label
  int 0x10 ; runs BIOS inturrupt 0x10 - video services
  jmp .loop ; jump to .loop label (infinite loop) 
halt: 
  cli ; clear interrupts
  hlt ; halt execution
hello: db 'Hello World!', 0 ; declare string and null terminator

times 510 - ($-$$) db 0 ; pad the rest of the boot sector (510 bytes) with 0s
dw 0xaa55 ; add boot signature (0xaa55) to end of boot sector, magic bootloader, marks 512 byte sector bootable