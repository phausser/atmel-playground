#!/bin/sh

avra blinky.asm && avrdude -p attiny85 -c usbasp -B 5 -U flash:w:blinky.hex

