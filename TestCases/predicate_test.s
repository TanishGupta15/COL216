.text
    mov r0,#45	
    mov r1,#50
gcd:
    cmp r0,r1
    beq fin
    subgt r0,r0,r1
    sublt r1,r1,r0
    b gcd

fin:
    mvn r2,#0
.end