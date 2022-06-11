.text

mov	r1, #0
mov	r2, #32768   @2^15 = 32768
strh  r2, [r1], #4
strb 	r2, [r1], #4

ldrsb	r3, [r1, #-4]!
ldrsh	r4, [r1, #-4]


.end

@signal mem: memory := (
@64 => X"E3A01000",
@65 => X"E3A02902",
@66 => X"E0C120B4",
@67 => X"E4C12004",
@68 => X"E17130D4",
@69 => X"E15140F4",
@others => (others => '0'));