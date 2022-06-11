.text

mov 	r0, #1
mov	r1, r0
mvn	r2, r1
cmp	r2, r1
beq	done
adc	r2, r2, r1
b	done

done:
rsb	r2, r2, #10