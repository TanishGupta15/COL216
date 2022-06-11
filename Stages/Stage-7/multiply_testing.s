.text


mov	r0, #2
mov	r1, #2
mul	r2, r1, r0		@r2 should have 4
mla	r3, r2, r1, r0	@r3 should have 10
umull r4, r5, r3, r2	@r4 should have 40 and r5 should have 0
umlal	r4, r5, r3, r2	@r4 should have 80 and r5 should have 0 
smull	r4, r5, r3, r2	@r4 should have 40 and r5 should have 0
smlal r4, r5, r3, r2	@r4 should have 80 and r5 should have 0

.end

@signal mem: memory := (
@64 => X"E3A00002",
@65 => X"E3A01002",
@66 => X"E0020091",
@67 => X"E0230192",
@68 => X"E0854293",
@69 => X"E0A54293",
@70 => X"E0C54293",
@71 => X"E0E54293",
@others => (others => '0'));