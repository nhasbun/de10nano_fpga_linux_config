# DE10-Nano FPGA Configuration from Linux

> Nicolás Hasbún A. 18 - 05 - 2018

Software to configure the FPGA portion of the Cyclone V SoC. It works under Linux focused on the de10nano platform but should be easily portable to other platforms using the same family chip.

Main sources to accomplish this work:

* Cyclone V HPS Memory Map - [LINK](https://www.altera.com/hps/cyclone-v/hps.html)
* Cyclone V Hard Processor System Technical Reference Manual (Cyclone V Handbook Volume 3) section **FPGA MANAGER**.

This is fully implemented in C using direct register access to take control of the FPGA Manager device which is used by the HPS to configure the FPGA. No external libraries are used other than Linux system calls and SoCAL libraries included on Quartus installations. Partial reconfiguration is still not studied but could be implemented in the future since it gives an important boost to create many applications.

 Programming FPGA from HPS could be accomplished at three different stages:

* From Preloader (at start)
* From U-boot (at start)
* From Linux

Preloader and U-boot methods are well covered on Altera documentation being U-boot the most straightforward of them since you only need to copy your rbf file to sd card. Linux method changes between distributions and documentation for it doesn't always work or it is outdated (as seen on [Rocketboards](https://rocketboards.org/foswiki/Documentation/GSRD131ProgrammingFPGA)). By using direct register access to FPGA Manager we can accomplish a Linux method agnostic to the current distribution or internal system configuration.

## Compilation

Altera Embedded Command Shell (16.1 or newer) should be used to compile the project. Just run "make" and there you go.

If  "socfpga" is presented on LAN then compiled file will be uploaded to */home/root/fpga_manager_test* folder on target.

## Loading rbf File

RBF file should be created from Quartus Project with compression enabled and MSEL [4:0] pins with 01010 settings. Code is easily modifiable to match other MSEL configurations (keep an eye on *cdgwdth* and *cdratio* registers) but Altera recommends using always FPP x 32 configuration scheme anyways.

Main program is called **fpga_rbf_load** and it will look for **fpga_config_file.rbf** file to config the FPGA.
