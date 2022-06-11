.text


mov	r1, #0
mov	r2, #512
str	r2, [r1], #4
ldrh	r3, [r2]


.end


@signal mem: memory := (
@64 => X"E3A01000",
@65 => X"E3A02C02",
@66 => X"E4812004",
@67 => X"E1D230B0",
@others => (others => '0'));