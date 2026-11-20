CMPE 310 - Lab 9: Programming the 8255 PPI

Aiden Wood-Bland 

Assembly file: SHE_scroll.s

Introduction and Objective

The 8255 Programmable Peripheral Interface (PPI) lets the 8086 control external devices. The goal is to scroll 
“SHE” back and forth across an eight-digit, seven-segment display using 8086 GNU assembly.

1. Control Word Setup

The code sends 10000000 (0x80) to the control register at 0x643. This configures Mode 0 with Ports A, B, and 
C as outputs. Port A (0x640) selects digits, and Port B (0x641) controls the LED segments.

2. Segment Patterns (Questions 1 and 2)

Port B uses the bit order X g f e d c b a, with X set to 0.
S: a, c, d, f, g — 01101101 (0x6D)
H: b, c, e, f, g — 01110110 (0x76)
E: a, d, e, f, g — 01111001 (0x79)
The program sends each pattern to Port B using the OUT instruction.

3. Display Activation Through Port A

The code first writes 0xFF to Port A to turn off all digits. It then sends the segment pattern to Port B and clears 
the selected Port A bit to activate that digit (active-low selection).

4. Movement / Shifting

SI stores the position of S, and BP stores the movement direction. The program repeatedly refreshes S, H, and 
E on neighboring digits, shifts the word one position, and reverses direction at either end.

5. Code Description

The SHE_scroll.s file has code descriptions, and it initializes the 8255, outputs each letter pattern, selects a 
digit, delays briefly, and updates the word position.

6. Questions 3 and 4

Q3: Ports A and B use Mode 0 as outputs because they send basic display signals and do not require 
handshaking.
Q4: A ninth digit could be supported with an additional driver connected to an available Port C output and 
changes to the digit-selection and scrolling code.

Conclusion

This lab shows how the 8255 uses port configuration, segment patterns, and digit selection to scroll text. I am 
not able to test it on actual hardware. 
