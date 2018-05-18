#include <stdio.h>    // printf
#include <stdint.h>   // uint8_t
#include <stdlib.h>   // malloc
#include <stdbool.h>  // true false
#include <unistd.h>   // sleep
#include <string.h>   // string
#include <fcntl.h>    // open
#include <sys/mman.h> // mmap

// The Altera SoC Abstraction Layer (SoCAL) API Reference Manual
#include "socal/socal.h"
#include "socal/hps.h"

// Useful macros
#define BIT(x,n) (((x) >> (n)) & 1)
#define INSERT_BITS(original, mask, value, num) (original & (~mask)) | (value << num)

// Main function declarations
void config_routine();

void report_status();
uint8_t fpga_state();
void set_cdratio();
void reset_fpga();
void config_fpga();
void set_axicfgen(uint8_t value);
void set_ctrl_en(uint8_t value);
void set_nconfigpull(uint8_t value);
void fpga_off();
void fpga_on();

// Auxiliary functions
char * status_code(uint8_t code);
