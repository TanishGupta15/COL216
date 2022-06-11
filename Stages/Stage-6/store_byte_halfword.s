.text


mov	r1, #0
mov	r2, #132096

strb	r2, [r1, #4]!
strh	r2, [r1, #4]!
ldr	r3, [r1], #-4
ldr	r4, [r1]


.end


@signal mem: memory := (
@64 => X"E3A01000",
@65 => X"E3A02B81",
@66 => X"E5E12004",
@67 => X"E1E120B4",
@68 => X"E4113004",
@69 => X"E5914000",
@others => (others => '0'));