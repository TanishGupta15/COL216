.text


mov	r1, #1
mov	r2, #4
mov	r3, r2, LSL r1
mov	r4, r3, LSL r2
add	r5, r4, r3, LSL r2

str	r1, [r2, r3, LSR #1]
str	r1, [r2, #4]
str	r2, [r3, r4, LSR #4]

.end


@signal mem: memory := (
@64 => X"E3A01001",
@65 => X"E3A02004",
@66 => X"E1A03112",
@67 => X"E1A04213",
@68 => X"E0845213",
@69 => X"E78210A3",
@70 => X"E5821004",
@71 => X"E7832224",
@others => (others => '0'));

