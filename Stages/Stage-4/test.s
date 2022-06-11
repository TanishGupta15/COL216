.text

mov	r0, #0
mov	r1, #1
mov	r2, #2
mov 	r3, #3
mov	r4, #4
mov 	r5, #5
and	r6, r0, r1
and	r7, r1, r2
and	r8, r2, r3
and	r9, r3, r4
and 	r10, r4, r5
eor	r6, r0, r1
eor	r7, r1, r2
eor	r8, r2, r3
eor	r9, r3, r4
eor 	r10, r4, r5
sub	r6, r0, r1
sub	r7, r2, r1
sub	r8, r2, r0
sub	r9, r4, r1
sub 	r10, r5, r6
rsb	r6, r0, r1
rsb	r7, r1, #3
rsb	r8, r5, #2
add	r6, r0, r1
add	r7, r0, r2
add	r8, r6, r7
mvn	r6, r0
mvn	r7, r1
mvn 	r8, r2
bic	r6, r0, r1
bic	r7, r1, r2
bic	r8, r2, r3
orr	r6, r0, r1
orr	r7, r1, r2
orr	r8, r1, r3
tst	r0, r1
tst	r1, r2
tst	r2, r3
teq	r0, r1
teq	r1, r2
teq	r2, r3
cmp	r0, r1
cmp	r1, r2
cmp	r2, r2
cmn	r0, r1
cmn	r1, r2
cmn	r2, #-2
adc	r6, r0, r1
adc	r7, r1, r2
sub	r6, r0, r1 @This will set the carry flag
adc	r8, r2, r3
sbc	r6, r1, r0
sbc	r7, r0, r1
rsc	r6, r0, r1
rsc	r7, r1, #2

