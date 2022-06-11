.text
mov r0, #0
mov r1, #1
mov r3, #1 @fib(r3) is stored in r1
loop:
cmp r3, #10
beq done
mov r2, r1
add r1, r0, r1
mov r0, r2
add r3, r3, #1
b loop

done:
.end

