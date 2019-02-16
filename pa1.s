/*
 * pa1.s
 *
 *  Created on: Feb 14, 2019
 *      Author: jessi
 */
 .data
    instruction :   .asciz "%d %d %c"
    flush   :   .asciz "\n"
    result  :   .asciz "%d"
    welcome :   .asciz "Please enter your values and then your operand: +, -, *, /"
    goodbye :   .asciz "See you later!"
    error_msg   :   .asciz "Cannot divide by zero.\n"

    buffer1 :   .space 256
    buffer2 :   .space 256
    buffer3 :   .space 256

.global main

.text

main:

    ldr x0, =welcome
    bl printf
    ldr x0, =flush
    bl printf

    ldr x0, =instruction
    ldr x1, =buffer1
    ldr x2, =buffer2
    ldr x3, =buffer3

    bl scanf

    ldr x1, =buffer1
    ldr x2, =buffer2
    ldr x3, =buffer3

    #load values, #0 pointer to value seeking to load
    ldr x1, [x1, #0]
    ldr x2, [x2, #0]
    ldrb w3, [x3, #0]

   #searching for '+'
    sub w6, w3, #43
    cbz w6, ADD

    #searching for '-'
    sub w6, w3, #45
    cbz w6, SUB

    #searching for '*'
    sub w6, w3, #42
    cbz w6, MUL

    #searching for '/'
    sub w6, w3, #47
    cbz w6, DIV

    ADD:
    add x4, x1, x2
    mov x1, x4
    ldr x0, =result
    bl printf
    ldr x0, =flush
    bl printf
    b exit

    SUB:
    sub x4, x1, x2
    mov x1, x4
    ldr x0, =result
    bl printf
    ldr x0, =flush
    bl printf
    b exit

    MUL:
    mul x4, x1, x2
    mov x1, x4
    ldr x0, =result
    bl printf
    ldr x0, =flush
    bl printf
    b exit

    DIV:
    cmp x2, #0
    bne endif
    then:
        ldr x0, =error_msg
        bl printf
        b exit
    endif:
        sdiv w4, w1, w2
        mov x1, x4
        ldr x0, =result
        bl printf
        ldr x0, =flush
        bl printf
        b exit

    exit:
    ldr x0, =goodbye
    bl printf
    ldr x0, =flush
    bl printf
    mov x0, #0
    mov x8, #93
    svc #0

