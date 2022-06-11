.text

mov	r0, #0xFFFFFFF6
mov	r1, #0x00000014

mul	r2, r0, r1    	@r2 should contain 0xFFFFFF38
mla	r3, r0, r1, r1	@r3 should contain 0xFFFFFF4C

umull	r4, r5, r0, r1	@r4 should contain 0xFFFFFF38 and r5 = 0x13
smull	r4, r5, r0, r1	@r4 should contain 0xFFFFFF38 and r5 = 0xFFFFFFFF

umlal	r4, r5, r0, r1	@r4 should contain 0xFFFFFE70 and r5 = 0x13
smlal	r4, r5, r0, r1	@r4 should contain 0xFFFFFDA8 and r5 = 0x13


.end

@signal mem: memory := (
@64 => X"E3E00009",
@65 => X"E3A01014",
@66 => X"E0020190",
@67 => X"E0231190",
@68 => X"E0854190",
@69 => X"E0C54190",
@70 => X"E0A54190",
@71 => X"E0E54190",
@others => (others => '0'));