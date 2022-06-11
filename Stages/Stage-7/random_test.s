.text

mov	r0, #80
mov	r1, #540
mov	r2, #0
loop:
cmp	r2, #2
beq	done
mul	r1, r0, r1
mla	r1, r0, r1, r1
add	r2, r2, #1
b	loop

done:
str	r1, [r2], #3
str	r1, [r2]

.end


@signal mem: memory := (
@64 => X"E3A00050",
@65 => X"E3A01F87",
@66 => X"E3A02000",
@67 => X"E3520002",
@68 => X"0A000003",
@69 => X"E0010190",
@70 => X"E0211190",
@71 => X"E2822001",
@72 => X"EAFFFFF9",
@73 => X"E4821003",
@74 => X"E5821000",
@others => (others => '0'));