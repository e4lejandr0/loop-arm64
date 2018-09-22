.text
.globl _start

start = 0
end = 30
asc_zero = 48

_start:
 
    mov     x19, start
loop:
    
    /* split digits */
    mov     x21, 10             /* divisor */
    udiv    x20, x19, x21       /* calculate quotient */
    msub    x22, x20, x21, x19  /* calculate remainder */

    add     x22, x22, asc_zero
    adr     x21, num_offset+1    /* put the offset in a register */
    strb    w22, [x21,0]       /* store the digit in the message */
    cmp     x20, xzr           /* compare with zero register */
    b.eq    print_msg
    add     x20, x20, asc_zero /* add '0' to digit */
    adr     x21, num_offset    /* put the offset in a register */
    strb    w20, [x21,0]       /* store the digit in the message */

print_msg:
    mov     x0, 1
    mov     x0, 1         /* file descriptor: 1 is stdout */
    adr     x1, msg       /* message location (memory address) */
    mov     x2, len       /* message length (bytes) */

    mov     x8, 64         /* write is syscall #64 */
    svc     0              /* invoke syscall */
    add     x19, x19, 1
    cmp     x19, end
    bne     loop

    mov     x0, 0         /* status -> 0 */
    mov     x8, 93        /* exit is syscall #93 */
    svc     0             /* invoke syscall */
 
.data
msg:     .ascii      "Loop:   \n"
len=     . - msg
num_offset= msg + 6

