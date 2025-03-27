	.data
a1:			.double 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0; elements first matrix
b1:			.double 1.5, 2.5, 3.5, 4.5, 5.5, 6.5, 7.5, 8.5, 9.5, 10.5, 11.5, 12.5, 13.5, 14.5, 15.5, 16.5; elements second matrix
c1:			.double 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0; 	   first row result matrix
n1:			.word	4						; counter for rows of the result matrix
n2:			.word	4						; counter for columns of the result matrix

	.text
start: LW	r1, n1(r0)			; loading numbers of elements in matrices (loop counter)
	   LW	r5, n2(r0)			; loading numbers of elements in matrices (loop counter)
	DADDI	r2, r0, a1			; pointer to the first element in the first matrix
	DADDI	r3, r0, b1			; pointer to the first element in the second matrix
	DADDI	r4, r0, c1			; pointer to the first element in the result matrix
	
	
loop1: L.D	f0, 0(r2)			; read a1[i]
	L.D 	f1, 8(r2)			; read a1[i+1]
	L.D 	f2, 16(r2)			; read a1[i+2]
	L.D 	f3, 24(r2)			; read a1[i+3]
	L.D 	f4, 0(r3)			; read b1[i]
	L.D 	f5, 32(r3)			; read b2[i]
	L.D 	f6, 64(r3)			; read b3[i]
	L.D 	f7, 96(r3)			; read b4[i]
	L.D 	f8, 8(r3)			; read b1[i+1]
	L.D 	f9, 40(r3)			; read b2[i+1]
	L.D 	f10, 72(r3)			; read b3[i+1]
	L.D 	f11, 104(r3)		; read b4[i+1]
	MUL.D	f12, f0, f4			; multiply the value of f0 to f4 (a1[i] * b1[i])
	MUL.D	f13, f1, f5			; multiply the value of f1 to f5 (a1[i+1] * b2[i])	
	MUL.D	f14, f2, f6			; multiply the value of f2 to f6 (a1[i+2] * b3[i])
	MUL.D	f15, f3, f7			; multiply the value of f3 to f7 (a1[i+3] * b4[i])
	MUL.D	f16, f0, f8			; multiply the value of f0 to f8 (a1[i] * b1[i+1])
	MUL.D	f17, f1, f9			; multiply the value of f1 to f9 (a1[i+1] * b2[i+1])	
	MUL.D	f18, f2, f10		; multiply the value of f2 to f10 (a1[i+2] * b3[i+1])
	MUL.D	f19, f3, f11		; multiply the value of f3 to f11 (a1[i+3] * b4[i+1])
	ADD.D	f20, f12, f13		; add elements for the first row/first column of the result matrix
	ADD.D	f21, f14, f15		; add elements for the first row/first column of the result matrix
	ADD.D	f22, f16, f17		; add elements for the first row/second column of the result matrix
	ADD.D	f23, f18, f19		; add elements for the first row/second column of the result matrix
	DADDI 	r1, r1, -1			; decrement the loop counter
	ADD.D	f24, f20, f21		; add elements for the first row/first column of the result matrix
	DADDI	r2, r2, 32			; move to the next row (a2[i])
	ADD.D	f25, f22, f23		; add elements for the first row/second column of the result matrix
	S.D		f24, 0(r4)			; write the result in c1[i]
	DADDI	r4, r4, 8			; move to the next the element of the same row of the second column of the result matrix
	S.D		f25, 0(r4)			; write the result in c1[i+1]
	DADDI	r4, r4, 24			; move to the next the element of the next row of the first column of the result matrix

	BNEZ	r1, loop1			; jump to loop if not equal 0
	
	DADDI	r3, r3, 16			; move twice the next row (b1[i+2])
	DADDI	r2, r0, a1			; pointer to the first element in the first matrix
	DADDI 	r5, r5, -2			; decrement the loop counter
	DADDI	r1, r1, 4			; increment the first loop counter for another column of the result matrix
	BNEZ	r5, loop1			; jump to loop if not equal 0
end:
	HALT