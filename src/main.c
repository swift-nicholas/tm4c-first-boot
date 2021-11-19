#include <stdint.h>
#include "memory_map.h"
#include <stdbool.h>

#include <driverlib/gpio.h>
#include <driverlib/interrupt.h>
#include <driverlib/pin_map.h>
#include <driverlib/sysctl.h>
#include <inc/hw_memmap.h>

/* System clock for component clocking */
uint32_t g_ui32SysClock;

__attribute__((naked)) static void start_app(uint32_t pc, uint32_t sp) {
  __asm(
      "\n \
           msr msp, r1 \n \
           bx r0\n \
          ");
}

void system_init(void);
void system_deinit(void);

static void delay() {
  for (int i = 0; i < 250000; i++) {
    __asm(" nop");
  }
}

int main(void) {
  uint32_t *app_code = (uint32_t *)&__app_start__;
  uint32_t app_sp = app_code[0];
  uint32_t app_reset = app_code[1];

  system_init();

  for (int i = 0; i < 20; i++) {
    delay();
    GPIOPinWrite(GPIO_PORTN_BASE, GPIO_PIN_0, 0x0);
    delay();
    GPIOPinWrite(GPIO_PORTN_BASE, GPIO_PIN_0, GPIO_PIN_0);
  }

  system_deinit();

  start_app(app_reset, app_sp);

  while (1)
    ;
}

void system_init(void) {
  /* configure the clock for 120mhz */
  g_ui32SysClock = SysCtlClockFreqSet(
      (SYSCTL_XTAL_25MHZ | SYSCTL_OSC_MAIN | SYSCTL_USE_PLL | SYSCTL_CFG_VCO_240), 120000000);

  SysCtlPeripheralEnable(SYSCTL_PERIPH_GPION);
  while (!SysCtlPeripheralReady(SYSCTL_PERIPH_GPION))
    ;

  GPIOPinTypeGPIOOutput(GPIO_PORTN_BASE, GPIO_PIN_0);
  GPIOPinWrite(GPIO_PORTN_BASE, GPIO_PIN_0, GPIO_PIN_0);
}

void system_deinit(void) { SysCtlPeripheralDisable(SYSCTL_PERIPH_GPION); }