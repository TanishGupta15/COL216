@Fibonacci like series, say X(n)
@X(0) = 0, X(1) = 1, X(2) = 2, and for n > 2, X(n) = X(0) + X(1) + X(2)
@Let's calculate X(6)

.text
mov r0, #0
mov r1, #1
mov r2, #2
mov r3, #2  @X(r3) is stored in r2
mov r10, #7 @Number whose X we want to compute + 1
loop:
cmp r3, r10
beq done
add r3, r3, #1
mov r4, r2
add r2, r2, r1
add r2, r2, r0
mov r5, r1
mov r1, r4
mov r0, r5
b loop

done:
.end

@signal mem : prog_memory :=(0 => X"E3A00000",
@1 => X"E3A01001",
@2 => X"E3A02002",
@3 => X"E3A03002",
@4 => X"E3A0A007",
@5 => X"E153000A",
@6 => X"0A000007",
@7 => X"E2833001",
@8 => X"E1A04002",
@9 => X"E0822001",
@10 => X"E0822000",
@11 => X"E1A05001",
@12 => X"E1A01004",
@13 => X"E1A00005",
@14 => X"EAFFFFF5",
@others => X"00000000"
@);