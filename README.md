# AVR Playground

Dies ist eine Sammlung von Beispielprogrammen und Makros für verschiedene AVR-Mikrocontroller (ATtiny85, ATtiny2313, ATmega328P). Die Beispiele demonstrieren grundlegende Funktionen wie GPIO, PWM, serielle Kommunikation, LCD-Ansteuerung und TWI/I2C.

## Verzeichnisstruktur

```
6050/         # MPU6050 I2C Beispiel
alarm/        # Alarm mit Power-Down und Taster
b2s/          # Byte-zu-ASCII und serielle Ausgabe
blinky/       # Blinky-LED Beispiel
foo/          # Einfaches GPIO Beispiel
hello/        # "Hello World" LED Beispiel
inc/          # Gemeinsame Includes und Makros (Registerdefinitionen, Delay, Serial, etc.)
lcd/          # HD44780 LCD Ansteuerung
pwm/          # PWM Beispiel
quad/         # Quadratur-Encoder Beispiel
ser/          # Serielle Kommunikation
shift/        # Schieberegister Beispiel
twi/          # TWI/I2C Beispiel
```

## Beispiele

- **blinky**: Einfache LED blinkt auf einem ATtiny85.
- **hello**: LED blinkt, mit Delay-Routine.
- **alarm**: Power-Down-Modus und Taster-Interrupt.
- **b2s**: Wandelt ein Byte in ASCII und gibt es seriell aus.
- **lcd**: Ansteuerung eines HD44780 LCDs.
- **pwm**: PWM-Ausgabe auf einem Pin.
- **quad**: Beispiel für Quadratur-Encoder-Auswertung.
- **ser**: Serielle Kommunikation (UART).
- **shift**: Ansteuerung eines Schieberegisters.
- **twi**: I2C/TWI-Kommunikation, z.B. mit MPU6050.

## Build & Flash

Die meisten Beispiele können mit [avra](https://github.com/Ro5bert/avra) und [avrdude](https://www.nongnu.org/avrdude/) gebaut und geflasht werden. In einigen Unterordnern gibt es passende Shell-Skripte (`mkblinky.sh`, `mkshift.sh`).

Beispiel für Blinky:
```sh
cd blinky
sh mkblinky.sh
```

## Abhängigkeiten

- [avra](https://github.com/Ro5bert/avra) (Assembler)
- [avrdude](https://www.nongnu.org/avrdude/) (Programmier-Tool)
- Passende Hardware (ATtiny85, ATtiny2313, ATmega328P)

## Hinweise

- Die Include-Dateien im `inc/`-Verzeichnis enthalten Registerdefinitionen und Makros für verschiedene AVR-Typen.
- Die Beispiele sind als Lern- und Testprojekte gedacht und können als Ausgangspunkt für eigene Entwicklungen dienen.

---

Viel Spaß beim Experimentieren mit AVR-Assembler!
