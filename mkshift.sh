#!/bin/sh

avra shift.asm && avrdude -p attiny85 -c arduino -b 19200 -P /dev/ttyACM0 -U flash:w:shift.hex

