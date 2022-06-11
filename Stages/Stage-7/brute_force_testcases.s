.text

mov	r1, #0
mov	r2, #0x80
str	r2, [r1], #5
strb	r2, [r1], #5
strb	r2, [r1], #5
strb	r2, [r1], #5
strb	r2, [r1], #5
strh	r2, [r1]

ldr	r3, [r1]
ldrh	r3, [r1]
ldrb	r3, [r1]
ldrsh	r3, [r1]
ldrsb	r3, [r1], #-5
ldr	r3, [r1]
ldrh	r3, [r1]
ldrb	r3, [r1]
ldrsh	r3, [r1]
ldrsb	r3, [r1], #-5
ldr	r3, [r1]
ldrh	r3, [r1]
ldrb	r3, [r1]
ldrsh	r3, [r1]
ldrsb	r3, [r1], #-5
ldr	r3, [r1]
ldrh	r3, [r1]
ldrb	r3, [r1]
ldrsh	r3, [r1]
ldrsb	r3, [r1], #-5
ldr	r3, [r1]
ldrh	r3, [r1]
ldrb	r3, [r1]
ldrsh	r3, [r1]
ldrsb	r3, [r1], #-5


ldr	r4, [r1]
ldr	r4, [r1, #5]
ldr	r4, [r1, #10]!
str	r4, [r1, #15]!

.end


@signal mem: memory := (
@64 => X"E3A01000",
@65 => X"E3A02080",
@66 => X"E4812005",
@67 => X"E4C12005",
@68 => X"E4C12005",
@69 => X"E4C12005",
@70 => X"E4C12005",
@71 => X"E1C120B0",
@72 => X"E5913000",
@73 => X"E1D130B0",
@74 => X"E5D13000",
@75 => X"E1D130F0",
@76 => X"E05130D5",
@77 => X"E5913000",
@78 => X"E1D130B0",
@79 => X"E5D13000",
@80 => X"E1D130F0",
@81 => X"E05130D5",
@82 => X"E5913000",
@83 => X"E1D130B0",
@84 => X"E5D13000",
@85 => X"E1D130F0",
@86 => X"E05130D5",
@87 => X"E5913000",
@88 => X"E1D130B0",
@89 => X"E5D13000",
@90 => X"E1D130F0",
@91 => X"E05130D5",
@92 => X"E5913000",
@93 => X"E1D130B0",
@94 => X"E5D13000",
@95 => X"E1D130F0",
@96 => X"E05130D5",
@97 => X"E5913000",
@98 => X"E1D130B0",
@99 => X"E5D13000",
@100 => X"E1D130F0",
@101 => X"E05130D5",
@102 => X"E5914000",
@103 => X"E5914005",
@104 => X"E5B1400A",
@105 => X"E5A1400F",
@others => (others => '0'));