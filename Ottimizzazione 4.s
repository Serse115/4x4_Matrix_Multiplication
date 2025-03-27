	.data
a1:			.double 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0; elements first matrix
b1:			.double 1.5, 2.5, 3.5, 4.5, 5.5, 6.5, 7.5, 8.5, 9.5, 10.5, 11.5, 12.5, 13.5, 14.5, 15.5, 16.5; elements second matrix
c1:			.double 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0; 	   first row result matrix

	.text
start:
	DADDI   r2, r0, a1			; pointer to the first element in the first matrix
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
	L.D 	f12, 16(r3)			; read b1[i+2]
	L.D 	f13, 48(r3)			; read b2[i+2]
	L.D 	f14, 80(r3)			; read b3[i+2]
	L.D 	f15, 112(r3)		; read b4[i+2]
	L.D 	f16, 24(r3)			; read b1[i+3]
	L.D 	f17, 56(r3)			; read b2[i+3]
	L.D 	f18, 88(r3)			; read b3[i+3]
	L.D 	f19, 120(r3)		; read b4[i+3]
	
	MUL.D	f20, f0, f4			; multiply the value of f0 to f4 (a1[i] * b1[i])
	MUL.D	f21, f1, f5			; multiply the value of f1 to f5 (a1[i+1] * b2[i])	
	MUL.D	f22, f2, f6			; multiply the value of f2 to f6 (a1[i+2] * b3[i])
	MUL.D	f23, f3, f7			; multiply the value of f3 to f7 (a1[i+3] * b4[i])
	
	MUL.D	f24, f0, f8			; multiply the value of f0 to f8 (a1[i] * b1[i+1])
	MUL.D	f25, f1, f9			; multiply the value of f1 to f9 (a1[i+1] * b2[i+1])	
	MUL.D	f26, f2, f10		; multiply the value of f2 to f10 (a1[i+2] * b3[i+1])
	MUL.D	f27, f3, f11		; multiply the value of f3 to f11 (a1[i+3] * b4[i+1])
	
	MUL.D	f28, f0, f12		; multiply the value of f0 to f12 (a1[i] * b1[i+2])
	MUL.D	f29, f1, f13		; multiply the value of f1 to f13 (a1[i+1] * b2[i+2])	
	MUL.D	f30, f2, f14		; multiply the value of f2 to f14 (a1[i+2] * b3[i+2])
	MUL.D	f31, f3, f15		; multiply the value of f3 to f15 (a1[i+3] * b4[i+2])
	
	MUL.D	f4, f0, f16			; multiply the value of f0 to f16 (a1[i] * b1[i+3])
	MUL.D	f5, f1, f17			; multiply the value of f1 to f17 (a1[i+1] * b2[i+3])	
	MUL.D	f6, f2, f18			; multiply the value of f2 to f18 (a1[i+2] * b3[i+3])
	MUL.D	f7, f3, f19			; multiply the value of f3 to f19 (a1[i+3] * b4[i+3])
	
	ADD.D	f20, f20, f21		; add elements for the first row/first column of the result matrix
	ADD.D	f21, f22, f23		; add elements for the first row/first column of the result matrix
	
	ADD.D	f22, f24, f25		; add elements for the first row/second column of the result matrix
	ADD.D	f23, f26, f27		; add elements for the first row/second column of the result matrix
	
	ADD.D	f24, f28, f29		; add elements for the first row/third	column of the result matrix
	ADD.D	f25, f30, f31		; add elements for the first row/third column of the result matrix
	
	ADD.D	f26, f4, f5			; add elements for the first row/fourth	column of the result matrix
	ADD.D	f27, f6, f7			; add elements for the first row/fourth column of the result matrix
	
	ADD.D	f28, f20, f21		; add elements for the first row/first column of the result matrix
	ADD.D	f29, f22, f23		; add elements for the first row/second column of the result matrix
	ADD.D	f30, f24, f25		; add elements for the first row/third column of the result matrix
	ADD.D	f31, f26, f27		; add elements for the first row/fourth column of the result matrix
	
	S.D		f28, 0(r4)			; write the result in c1[i]
	S.D		f29, 8(r4)			; write the result in c1[i+1]
	S.D		f30, 16(r4)			; write the result in c1[i+2]
	S.D		f31, 24(r4)			; write the result in c1[i+3]
		
loop2: L.D	f0, 32(r2)			; read a2[i]
	L.D 	f1, 40(r2)			; read a2[i+1]
	L.D 	f2, 48(r2)			; read a2[i+2]
	L.D 	f3, 56(r2)			; read a2[i+3]
	L.D 	f4, 0(r3)			; read b1[i]
	L.D 	f5, 32(r3)			; read b2[i]
	L.D 	f6, 64(r3)			; read b3[i]
	L.D 	f7, 96(r3)			; read b4[i]
	
	MUL.D	f20, f0, f4			; multiply the value of f0 to f4 (a2[i] * b1[i])
	MUL.D	f21, f1, f5			; multiply the value of f1 to f5 (a2[i+1] * b2[i])	
	MUL.D	f22, f2, f6			; multiply the value of f2 to f6 (a2[i+2] * b3[i])
	MUL.D	f23, f3, f7			; multiply the value of f3 to f7 (a2[i+3] * b4[i])
	
	MUL.D	f24, f0, f8			; multiply the value of f0 to f8 (a2[i] * b1[i+1])
	MUL.D	f25, f1, f9			; multiply the value of f1 to f9 (a2[i+1] * b2[i+1])	
	MUL.D	f26, f2, f10		; multiply the value of f2 to f10 (a2[i+2] * b3[i+1])
	MUL.D	f27, f3, f11		; multiply the value of f3 to f11 (a2[i+3] * b4[i+1])
	
	MUL.D	f28, f0, f12		; multiply the value of f0 to f12 (a2[i] * b1[i+2])
	MUL.D	f29, f1, f13		; multiply the value of f1 to f13 (a2[i+1] * b2[i+2])	
	MUL.D	f30, f2, f14		; multiply the value of f2 to f14 (a2[i+2] * b3[i+2])
	MUL.D	f31, f3, f15		; multiply the value of f3 to f15 (a2[i+3] * b4[i+2])
	
	MUL.D	f4, f0, f16			; multiply the value of f0 to f16 (a2[i] * b1[i+3])
	MUL.D	f5, f1, f17			; multiply the value of f1 to f17 (a2[i+1] * b2[i+3])	
	MUL.D	f6, f2, f18			; multiply the value of f2 to f18 (a2[i+2] * b3[i+3])
	MUL.D	f7, f3, f19			; multiply the value of f3 to f19 (a2[i+3] * b4[i+3])
	
	ADD.D	f20, f20, f21		; add elements for the second row/first column of the result matrix
	ADD.D	f21, f22, f23		; add elements for the second row/first column of the result matrix
	
	ADD.D	f22, f24, f25		; add elements for the second row/second column of the result matrix
	ADD.D	f23, f26, f27		; add elements for the second row/second column of the result matrix
	
	ADD.D	f24, f28, f29		; add elements for the second row/third	column of the result matrix
	ADD.D	f25, f30, f31		; add elements for the second row/third column of the result matrix
	
	ADD.D	f26, f4, f5			; add elements for the second row/fourth column of the result matrix
	ADD.D	f27, f6, f7			; add elements for the second row/fourth column of the result matrix
	
	ADD.D	f28, f20, f21		; add elements for the second row/first column of the result matrix
	ADD.D	f29, f22, f23		; add elements for the second row/second column of the result matrix
	ADD.D	f30, f24, f25		; add elements for the second row/third column of the result matrix
	ADD.D	f31, f26, f27		; add elements for the second row/fourth column of the result matrix
	
	S.D		f28, 32(r4)			; write the result in c2[i]
	S.D		f29, 40(r4)			; write the result in c2[i+1]
	S.D		f30, 48(r4)			; write the result in c2[i+2]
	S.D		f31, 56(r4)			; write the result in c2[i+3]
	
loop3: L.D	f0, 64(r2)			; read a3[i]
	L.D 	f1, 72(r2)			; read a3[i+1]
	L.D 	f2, 80(r2)			; read a3[i+2]
	L.D 	f3, 88(r2)			; read a3[i+3]
	L.D 	f4, 0(r3)			; read b1[i]
	L.D 	f5, 32(r3)			; read b2[i]
	L.D 	f6, 64(r3)			; read b3[i]
	L.D 	f7, 96(r3)			; read b4[i]
	
	MUL.D	f20, f0, f4			; multiply the value of f0 to f4 (a3[i] * b1[i])
	MUL.D	f21, f1, f5			; multiply the value of f1 to f5 (a3[i+1] * b2[i])	
	MUL.D	f22, f2, f6			; multiply the value of f2 to f6 (a3[i+2] * b3[i])
	MUL.D	f23, f3, f7			; multiply the value of f3 to f7 (a3[i+3] * b4[i])
	
	MUL.D	f24, f0, f8			; multiply the value of f0 to f8 (a3[i] * b1[i+1])
	MUL.D	f25, f1, f9			; multiply the value of f1 to f9 (a3[i+1] * b2[i+1])	
	MUL.D	f26, f2, f10		; multiply the value of f2 to f10 (a3[i+2] * b3[i+1])
	MUL.D	f27, f3, f11		; multiply the value of f3 to f11 (a3[i+3] * b4[i+1])
	
	MUL.D	f28, f0, f12		; multiply the value of f0 to f12 (a3[i] * b1[i+2])
	MUL.D	f29, f1, f13		; multiply the value of f1 to f13 (a3[i+1] * b2[i+2])	
	MUL.D	f30, f2, f14		; multiply the value of f2 to f14 (a3[i+2] * b3[i+2])
	MUL.D	f31, f3, f15		; multiply the value of f3 to f15 (a3[i+3] * b4[i+2])
	
	MUL.D	f4, f0, f16			; multiply the value of f0 to f16 (a3[i] * b1[i+3])
	MUL.D	f5, f1, f17			; multiply the value of f1 to f17 (a3[i+1] * b2[i+3])	
	MUL.D	f6, f2, f18			; multiply the value of f2 to f18 (a3[i+2] * b3[i+3])
	MUL.D	f7, f3, f19			; multiply the value of f3 to f19 (a3[i+3] * b4[i+3])
	
	ADD.D	f20, f20, f21		; add elements for the third row/first column of the result matrix
	ADD.D	f21, f22, f23		; add elements for the third row/first column of the result matrix
	
	ADD.D	f22, f24, f25		; add elements for the third row/second column of the result matrix
	ADD.D	f23, f26, f27		; add elements for the third row/second column of the result matrix
	
	ADD.D	f24, f28, f29		; add elements for the third row/third	column of the result matrix
	ADD.D	f25, f30, f31		; add elements for the third row/third column of the result matrix
	
	ADD.D	f26, f4, f5			; add elements for the third row/fourth	column of the result matrix
	ADD.D	f27, f6, f7			; add elements for the third row/fourth column of the result matrix
	
	ADD.D	f28, f20, f21		; add elements for the third row/first column of the result matrix
	ADD.D	f29, f22, f23		; add elements for the third row/second column of the result matrix
	ADD.D	f30, f24, f25		; add elements for the third row/third column of the result matrix
	ADD.D	f31, f26, f27		; add elements for the third row/fourth column of the result matrix
	
	S.D		f28, 64(r4)			; write the result in c3[i]
	S.D		f29, 72(r4)			; write the result in c3[i+1]
	S.D		f30, 80(r4)			; write the result in c3[i+2]
	S.D		f31, 88(r4)			; write the result in c3[i+3]
	
loop4: L.D	f0, 96(r2)			; read a4[i]
	L.D 	f1, 104(r2)			; read a4[i+1]
	L.D 	f2, 112(r2)			; read a4[i+2]
	L.D 	f3, 120(r2)			; read a4[i+3]
	L.D 	f4, 0(r3)			; read b1[i]
	L.D 	f5, 32(r3)			; read b2[i]
	L.D 	f6, 64(r3)			; read b3[i]
	L.D 	f7, 96(r3)			; read b4[i]
	
	MUL.D	f20, f0, f4			; multiply the value of f0 to f4 (a4[i] * b1[i])
	MUL.D	f21, f1, f5			; multiply the value of f1 to f5 (a4[i+1] * b2[i])	
	MUL.D	f22, f2, f6			; multiply the value of f2 to f6 (a4[i+2] * b3[i])
	MUL.D	f23, f3, f7			; multiply the value of f3 to f7 (a4[i+3] * b4[i])
	
	MUL.D	f24, f0, f8			; multiply the value of f0 to f8 (a4[i] * b1[i+1])
	MUL.D	f25, f1, f9			; multiply the value of f1 to f9 (a4[i+1] * b2[i+1])	
	MUL.D	f26, f2, f10		; multiply the value of f2 to f10 (a4[i+2] * b3[i+1])
	MUL.D	f27, f3, f11		; multiply the value of f3 to f11 (a4[i+3] * b4[i+1])
	
	MUL.D	f28, f0, f12		; multiply the value of f0 to f12 (a4[i] * b1[i+2])
	MUL.D	f29, f1, f13		; multiply the value of f1 to f13 (a4[i+1] * b2[i+2])	
	MUL.D	f30, f2, f14		; multiply the value of f2 to f14 (a4[i+2] * b3[i+2])
	MUL.D	f31, f3, f15		; multiply the value of f3 to f15 (a4[i+3] * b4[i+2])
	
	MUL.D	f4, f0, f16			; multiply the value of f0 to f16 (a4[i] * b1[i+3])
	MUL.D	f5, f1, f17			; multiply the value of f1 to f17 (a4[i+1] * b2[i+3])	
	MUL.D	f6, f2, f18			; multiply the value of f2 to f18 (a4[i+2] * b3[i+3])
	MUL.D	f7, f3, f19			; multiply the value of f3 to f19 (a4[i+3] * b4[i+3])
	
	ADD.D	f20, f20, f21		; add elements for the fourth row/first column of the result matrix
	ADD.D	f21, f22, f23		; add elements for the fourth row/first column of the result matrix
	
	ADD.D	f22, f24, f25		; add elements for the fourth row/second column of the result matrix
	ADD.D	f23, f26, f27		; add elements for the fourth row/second column of the result matrix
	
	ADD.D	f24, f28, f29		; add elements for the fourth row/third	column of the result matrix
	ADD.D	f25, f30, f31		; add elements for the fourth row/third column of the result matrix
	
	ADD.D	f26, f4, f5			; add elements for the fourth row/fourth column of the result matrix
	ADD.D	f27, f6, f7			; add elements for the fourth row/fourth column of the result matrix
	
	ADD.D	f28, f20, f21		; add elements for the fourth row/first column of the result matrix
	ADD.D	f29, f22, f23		; add elements for the fourth row/second column of the result matrix
	ADD.D	f30, f24, f25		; add elements for the fourth row/third column of the result matrix
	ADD.D	f31, f26, f27		; add elements for the fourth row/fourth column of the result matrix
	
	S.D		f28, 96(r4)			; write the result in c4[i]
	S.D		f29, 104(r4)		; write the result in c4[i+1]
	S.D		f30, 112(r4)		; write the result in c4[i+2]
	S.D		f31, 120(r4)		; write the result in c4[i+3]
end:
	HALT
