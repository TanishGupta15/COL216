.text

mov	r0, #0
mov	r1, #1
mov	r2, #2

add 	r0, r1, r2, LSL #2
add	r0, r1, r2, LSR #1

mov	r3, #2
add	r0, r1, r2, LSL r3


@signal mem: memory := (
@64 => X"E3A00000",
@65 => X"E3A01001",
@66 => X"E3A02002",
@67 => X"E0810102",
@68 => X"E08100A2",
@69 => X"E3A03002",
@70 => X"E0810312",
@others => (others => '0'));