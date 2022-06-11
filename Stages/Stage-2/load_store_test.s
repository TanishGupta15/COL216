@This file tests load/store operations of the processor

.text

mov	r0, #0
mov	r1, #1
mov 	r2, #0  @Will store the sum
loop:
cmp	r0, #24
beq	step2
str	r1, [r0]
add	r1, r1, #1
add	r0, r0, #4
b	loop

step2:
mov	r0, #0
loop2:
cmp	r0, #24
beq 	done
ldr	r1, [r0]
add	r2, r2, r1
add	r0, r0, #4
b	loop2

done:
.end

@signal mem : prog_memory :=(0 => X"E3A00000",
@1 => X"E3A01001",
@2 => X"E3A02000",
@3 => X"E3500018",
@4 => X"0A000003",
@5 => X"E5801000",
@6 => X"E2811001",
@7 => X"E2800004",
@8 => X"EAFFFFF9",
@9 => X"E3A00000",
@10 => X"E3500018",
@11 => X"0A000003",
@12 => X"E5901000",
@13 => X"E0822001",
@14 => X"E2800004",
@15 => X"EAFFFFF9",
@others => X"00000000"
@);