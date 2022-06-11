.text


@Let's try strb for different bytes rather than only one byte

mov	r0, #0
mov	r1, #0x80
loop:
cmp	r0, #4
beq 	done
strb	r1, [r0], #1
b	loop

done:
cmp	r0, #0
beq	final_done
ldrsb	r2, [r0, #-1]!
b	done


final_done:


.end


@signal mem: memory := (
@64 => X"E3A00000",
@65 => X"E3A01080",
@66 => X"E3500004",
@67 => X"0A000001",
@68 => X"E4C01001",
@69 => X"EAFFFFFB",
@70 => X"E3500000",
@71 => X"0A000001",
@72 => X"E17020D1",
@73 => X"EAFFFFFB",
@others => (others => '0'));