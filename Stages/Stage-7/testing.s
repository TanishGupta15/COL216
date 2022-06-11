.text


mov	r1, #0
mov	r2, #125
str	r2, [r1, #32]!   @Taking a 5 bit offset to check offset correctly
sub	r2, r2, #4
loop:
cmp	r1, #0
beq	done
str	r2, [r1, #-4]!
sub	r2, r2, #4
b	loop

done:
mov	r0, #4
cmp	r1, #32
beq 	final_done
ldrh	r3, [r1, r0]!
b	done

final_done:

.end


@signal mem: memory := (
@64 => X"E3A01000",
@65 => X"E3A0207D",
@66 => X"E5A12020",
@67 => X"E2422004",
@68 => X"E3510000",
@69 => X"0A000002",
@70 => X"E5212004",
@71 => X"E2422004",
@72 => X"EAFFFFFA",
@73 => X"E3A00004",
@74 => X"E3510020",
@75 => X"0A000001",
@76 => X"E1B130B0",
@77 => X"EAFFFFFA",
@others => (others => '0'));