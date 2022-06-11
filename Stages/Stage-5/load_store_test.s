@This file tests load/store operations of the processor using shifts

.text

mov	r0, #0
mov	r1, #1
mov 	r2, #0  @Will store the sum
loop:
cmp	r1, #4
beq	step2
str	r1, [r0, r1, LSL #2]
add	r1, r1, #1
b	loop

step2:
mov	r0, #0
loop2:
cmp	r0, #16
beq 	done
ldr	r1, [r0]
add	r2, r2, r1
add	r0, r0, #4
b	loop2

done:
.end

@signal mem: memory := (
@64 => X"E3A00000",
@65 => X"E3A01001",
@66 => X"E3A02000",
@67 => X"E3510004",
@68 => X"0A000002",
@69 => X"E7801101",
@70 => X"E2811001",
@71 => X"EAFFFFFA",
@72 => X"E3A00000",
@73 => X"E3500010",
@74 => X"0A000003",
@75 => X"E5901000",
@76 => X"E0822001",
@77 => X"E2800004",
@78 => X"EAFFFFF9",
@others => (others => '0'));