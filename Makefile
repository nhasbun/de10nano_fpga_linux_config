################################################
#
# Makefile to Manage ->
# DE10-Nano Programming FPGA from HPS Project
#
# Nicolas Hasbún A.
# nhasbun@gmail.com
# 12-05-2018 (dd-mm-yyyy)
#
################################################

## DEFINE TARGET AND SOURCE CODE
TARGET = fpga_rbf_load

# Source Code
SRCS=$(wildcard *.c functions/*.c)
OBJECTS=$(SRCS:.c=.o)

## ALTERA INFO
ALT_DEVICE_FAMILY ?= soc_cv_av
HWLIBS_ROOT = $(SOCEDS_DEST_ROOT)/ip/altera/hps/altera_hps/hwlib

## COMPILER FLAGS
CFLAGS = -g -std=c99 -Wall -Werror -I$(HWLIBS_ROOT)/include -I$(HWLIBS_ROOT)/include/$(ALT_DEVICE_FAMILY) -D$(ALT_DEVICE_FAMILY)
LDFLAGS = -g -std=c99 -Wall -Werror -pthread -lpthread

CROSS_COMPILE = arm-linux-gnueabihf-
CC = $(CROSS_COMPILE)gcc
LD = $(CROSS_COMPILE)gcc
ARCH = arm

## UPLOAD FILES TO DE10NANO USING SSH
# Parameters for SCP upload. Set up SSH keys to bypass password prompt
SCP_TARGET_IP           = socfpga
SCP_USER                = root
SCP_TARGET_PATH         = /home/root/fpga_manager_test
SCP                     = SCP
SCP_FLAGS               = -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null

## BUILD (DEFAULT) RECIPE
.PHONY: build
build: $(TARGET)

$(TARGET): $(OBJECTS)
	$(LD) $(LDFLAGS)   $^ -o $@
	make upload

%.o : %.c
	$(CC) $(CFLAGS) -c $< -o $@

## CLEAN RECIPE
.PHONY: clean
clean:
	rm -f $(TARGET) *.a *.o *~

## UPLOAD RECIPE
.PHONY: upload
upload:
	@echo "*****************************************"
	@echo "Subiendo archivo por SSH"
	@echo "*****************************************"
	$(SCP) $(SCP_FLAGS) $(TARGET) $(SCP_USER)@$(SCP_TARGET_IP):$(SCP_TARGET_PATH)
