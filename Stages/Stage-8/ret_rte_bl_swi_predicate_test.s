.text
    mov r0,#10
    mov r1,#15
    bl gcd
    swi 0x06

gcd:
    cmp r0,r1
    reteq
    blt sublt
subgt:
    sub r0,r0,r1
    b gcd
sublt:
    sub r1,r1,r0
    b gcd
.end