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



@64 => X"E3A00000",
@65 => X"E3A01001",
@66 => X"E3A03001",
@67 => X"E3530005",
@68 => X"0A000004",
@69 => X"E1A02001",
@70 => X"E0801001",
@71 => X"E1A00002",
@72 => X"E2833001",
@73 => X"EAFFFFF8",