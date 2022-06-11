.text
mov	r1, #5
mov	r2, #15
subs	r3, r1, r2
adds	r1, r1, r3
muls	r2, r2, r3
cmp	r1, #0
moveq	r0, #5
movlt r0, #4
movgt	r0, #3

