.text

mov	r0, #256
mov	r1, #260
mov	r2, #503808

add	r0, r1, r1, LSL #2
mov	r3, r2, LSR #4
mov	r4, r3, ASR #4



@signal mem: memory := (
@64 => X"E3A00C01",
@65 => X"E3A01F41",
@66 => X"E3A02A7B",
@67 => X"E0810101",
@68 => X"E1A03222",
@69 => X"E1A04243",
@others => (others => '0'));