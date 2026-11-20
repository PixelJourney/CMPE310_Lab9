# CMPE 310 – Lab 9: Programming the 8255 PPI

**Name:**  
**Date:**  
**Assembly File:** `8255_she_scroll.s`

## Introduction & Objective

The 8255 Programmable Peripheral Interface connects the 8086 to external devices. This lab uses 8086 GNU assembly to scroll "SHE" back and forth across an eight-digit, seven-segment display.

## 1. Control Word Setup

The control word is `10000000` (`0x80`), written to address `0x643`. It configures Ports A, B, and C as outputs using Mode 0. Port A (`0x640`) selects digits, while Port B (`0x641`) controls the segments.

## 2. Segment Patterns (Questions 1–2)

| Letter | Segments | Binary | Hex |
|---|---|---|---|
| S | a, c, d, f, g | 01101101 | 0x6D |
| H | b, c, e, f, g | 01110110 | 0x76 |
| E | a, d, e, f, g | 01111001 | 0x79 |

The program sends these patterns to Port B using the `OUT` instruction.

## 3. Display Activation Through Port A

Port A selects the active digit. The program disables all digits, sends the segment pattern through Port B, and activates the selected digit using an active-low signal.

## 4. Movement / Shifting

The SI register tracks the starting position, while BP controls the direction. The program repeatedly refreshes the display and shifts "SHE" one position at a time, reversing direction at the ends.

## 5. Code Description

The assembly code is provided separately in `8255_she_scroll.s`. It initializes the 8255, displays each letter, uses short delays for visibility, and updates the position to create the scrolling effect.

## 6. Lab Questions

**Question 3: What mode should Ports A and B use?**

Both use Mode 0 as outputs because the display requires basic output signals without handshaking.

**Question 4: Can the 8255 support a 9-digit display?**

Yes, with additional hardware. An available Port C output could control a ninth digit through an additional driver. The program would need updated digit-selection and scrolling logic.

## Conclusion

This lab demonstrates how the 8255 controls a seven-segment display through Mode 0, segment patterns, and digit selection. The code passed an assembly syntax check, but physical hardware testing was not performed.
