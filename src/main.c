#include <stdint.h>
#include "memory_map.h"

__attribute__((naked)) static void start_app(uint32_t pc, uint32_t sp) {
  __asm(
      "\n \
           msr msp, r1 \n \
           bx r0\n \
          ");
}

int main(void) {
  uint32_t *app_code = (uint32_t *)&__bootloader_addr__;
  uint32_t app_sp = app_code[0];
  uint32_t app_reset = app_code[1];

  start_app(app_reset, app_sp);

  while (1)
    ;
}