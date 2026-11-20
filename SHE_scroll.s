# CMPE 310 Lab 9 - SHE Scrolling Display
# 8086 GAS Assembly
# 8255 PPI: Port A controls digits, Port B controls segments

.code16
.text
.globl _start
_start:
    # Control word: D7=1 selects I/O setup. The other bits are 0,
    # so both groups use Mode 0 and all ports are outputs.
    movb $0x80, %al
    movw $0x643, %dx
    outb %al, %dx

    movw $7,  %si          # Starting position of S
    movw $-1, %bp          # Move right first

frame:
    movw $75, %di          # Refresh before shifting
refresh:
    movb $0x6D, %bl        # S pattern (a, c, d, f, g)
    movw %si, %cx          # Digit for S
    call show_digit

    movb $0x76, %bl        # H pattern (b, c, e, f, g)
    movw %si, %cx
    decw %cx               # H is next to S
    call show_digit

    movb $0x79, %bl        # E pattern (a, d, e, f, g)
    movw %si, %cx
    subw $2, %cx           # E is two digits from S
    call show_digit

    decw %di
    jnz refresh            # Keep refreshing the letters

    cmpw $2, %si           # Check right edge before shifting
    je move_left
    cmpw $7, %si           # Check left edge before shifting
    je move_right
    addw %bp, %si          # Shift one digit
    jmp frame

move_left:
    movw $1, %bp           # Reverse direction to the left
    addw %bp, %si          # Shift one digit
    jmp frame
move_right:
    movw $-1, %bp          # Reverse direction to the right
    addw %bp, %si          # Shift one digit
    jmp frame

# BL holds the letter pattern; CL holds the digit number.
show_digit:
    movw $0x640, %dx
    movb $0xFF, %al        # Turn off all digits
    outb %al, %dx

    movw $0x641, %dx
    movb %bl, %al
    outb %al, %dx          # Send letter to Port B

    movb $1, %al
    shlb %cl, %al          # Shift 1 to the chosen digit
    notb %al               # Selected digit turns on with 0
    movw $0x640, %dx
    outb %al, %dx

    pushw %cx              # Save CX
    movw $500, %cx         # Small delay
hold:
    loop hold
    popw %cx
    ret
