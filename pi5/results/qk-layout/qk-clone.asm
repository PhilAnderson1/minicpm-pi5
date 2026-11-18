
/home/philip/minicpm-pi5/build-qk-layout/bench:     file format elf64-littleaarch64


Disassembly of section .init:

Disassembly of section .plt:

Disassembly of section .text:

000000000000a9d0 <_Z8qk_clonePKcmiRK8DataInfo>:
    a9d0:	a9bb7bfd 	stp	x29, x30, [sp, #-80]!
    a9d4:	910003fd 	mov	x29, sp
    a9d8:	6d022be9 	stp	d9, d10, [sp, #32]
    a9dc:	6d0333eb 	stp	d11, d12, [sp, #48]
    a9e0:	6d043bed 	stp	d13, d14, [sp, #64]
    a9e4:	f9400469 	ldr	x9, [x3, #8]
    a9e8:	f9400c6a 	ldr	x10, [x3, #24]
    a9ec:	f9401465 	ldr	x5, [x3, #40]
    a9f0:	b9402066 	ldr	w6, [x3, #32]
    a9f4:	fd000fef 	str	d15, [sp, #24]
    a9f8:	b40043e5 	cbz	x5, b274 <_Z8qk_clonePKcmiRK8DataInfo+0x8a4>
    a9fc:	937d7cc4 	sbfiz	x4, x6, #3, #32
    aa00:	91002087 	add	x7, x4, #0x8
    aa04:	9100408b 	add	x11, x4, #0x10
    aa08:	b86468be 	ldr	w30, [x5, x4]
    aa0c:	91006088 	add	x8, x4, #0x18
    aa10:	8b0700ae 	add	x14, x5, x7
    aa14:	8b0b00ad 	add	x13, x5, x11
    aa18:	8b0800ac 	add	x12, x5, x8
    aa1c:	b86b68b1 	ldr	w17, [x5, x11]
    aa20:	b86868af 	ldr	w15, [x5, x8]
    aa24:	b9400592 	ldr	w18, [x12, #4]
    aa28:	b94005a8 	ldr	w8, [x13, #4]
    aa2c:	b94005d0 	ldr	w16, [x14, #4]
    aa30:	f9000bf3 	str	x19, [sp, #16]
    aa34:	b86768b3 	ldr	w19, [x5, x7]
    aa38:	8b0400a7 	add	x7, x5, x4
    aa3c:	b9402464 	ldr	w4, [x3, #36]
    aa40:	b94004e7 	ldr	w7, [x7, #4]
    aa44:	1ac40e6e 	sdiv	w14, w19, w4
    aa48:	1ac40fcd 	sdiv	w13, w30, w4
    aa4c:	1ac40e2c 	sdiv	w12, w17, w4
    aa50:	1ac40deb 	sdiv	w11, w15, w4
    aa54:	1b04cdce 	msub	w14, w14, w4, w19
    aa58:	f9400bf3 	ldr	x19, [sp, #16]
    aa5c:	1b04f9ad 	msub	w13, w13, w4, w30
    aa60:	1b04c58c 	msub	w12, w12, w4, w17
    aa64:	1b103890 	madd	w16, w4, w16, w14
    aa68:	1b073487 	madd	w7, w4, w7, w13
    aa6c:	1b083088 	madd	w8, w4, w8, w12
    aa70:	1b04bd6b 	msub	w11, w11, w4, w15
    aa74:	93407e10 	sxtw	x16, w16
    aa78:	93407ce7 	sxtw	x7, w7
    aa7c:	93407d08 	sxtw	x8, w8
    aa80:	9b0a2610 	madd	x16, x16, x10, x9
    aa84:	1b122c84 	madd	w4, w4, w18, w11
    aa88:	9b0a2508 	madd	x8, x8, x10, x9
    aa8c:	9b0a24e7 	madd	x7, x7, x10, x9
    aa90:	93407c84 	sxtw	x4, w4
    aa94:	9b0a2489 	madd	x9, x4, x10, x9
    aa98:	93407c42 	sxtw	x2, w2
    aa9c:	3dc000f9 	ldr	q25, [x7]
    aaa0:	d2800204 	mov	x4, #0x10                  	// #16
    aaa4:	9b017c4a 	mul	x10, x2, x1
    aaa8:	3dc00105 	ldr	q5, [x8]
    aaac:	3dc0012f 	ldr	q15, [x9]
    aab0:	8b0a002b 	add	x11, x1, x10
    aab4:	8b0a000f 	add	x15, x0, x10
    aab8:	8b0b0032 	add	x18, x1, x11
    aabc:	3cea681f 	ldr	q31, [x0, x10]
    aac0:	8b0b000e 	add	x14, x0, x11
    aac4:	8b120031 	add	x17, x1, x18
    aac8:	8b12000d 	add	x13, x0, x18
    aacc:	8b11002a 	add	x10, x1, x17
    aad0:	3dc00213 	ldr	q19, [x16]
    aad4:	8b11000c 	add	x12, x0, x17
    aad8:	8b0a0021 	add	x1, x1, x10
    aadc:	3ceb681e 	ldr	q30, [x0, x11]
    aae0:	8b0a000b 	add	x11, x0, x10
    aae4:	3cea681b 	ldr	q27, [x0, x10]
    aae8:	6e5f1f38 	fmul	v24.8h, v25.8h, v31.8h
    aaec:	8b01000a 	add	x10, x0, x1
    aaf0:	6e5f1ca4 	fmul	v4.8h, v5.8h, v31.8h
    aaf4:	3ce1681a 	ldr	q26, [x0, x1]
    aaf8:	6e5f1e72 	fmul	v18.8h, v19.8h, v31.8h
    aafc:	6e5f1dff 	fmul	v31.8h, v15.8h, v31.8h
    ab00:	3cf2681d 	ldr	q29, [x0, x18]
    ab04:	6e5e1f37 	fmul	v23.8h, v25.8h, v30.8h
    ab08:	6e5e1ca3 	fmul	v3.8h, v5.8h, v30.8h
    ab0c:	3cf1681c 	ldr	q28, [x0, x17]
    ab10:	6e591f74 	fmul	v20.8h, v27.8h, v25.8h
    ab14:	6e451f60 	fmul	v0.8h, v27.8h, v5.8h
    ab18:	6e5e1e71 	fmul	v17.8h, v19.8h, v30.8h
    ab1c:	6e531f66 	fmul	v6.8h, v27.8h, v19.8h
    ab20:	6e5d1f36 	fmul	v22.8h, v25.8h, v29.8h
    ab24:	6e5d1ca2 	fmul	v2.8h, v5.8h, v29.8h
    ab28:	6e591f95 	fmul	v21.8h, v28.8h, v25.8h
    ab2c:	6e451f81 	fmul	v1.8h, v28.8h, v5.8h
    ab30:	6e5d1e70 	fmul	v16.8h, v19.8h, v29.8h
    ab34:	6e531f87 	fmul	v7.8h, v28.8h, v19.8h
    ab38:	6e4f1f7b 	fmul	v27.8h, v27.8h, v15.8h
    ab3c:	6e4f1f9c 	fmul	v28.8h, v28.8h, v15.8h
    ab40:	6e5d1dfd 	fmul	v29.8h, v15.8h, v29.8h
    ab44:	6e5e1dfe 	fmul	v30.8h, v15.8h, v30.8h
    ab48:	6e591f59 	fmul	v25.8h, v26.8h, v25.8h
    ab4c:	6e451f45 	fmul	v5.8h, v26.8h, v5.8h
    ab50:	6e531f53 	fmul	v19.8h, v26.8h, v19.8h
    ab54:	6e4f1f4f 	fmul	v15.8h, v26.8h, v15.8h
    ab58:	d503201f 	nop
    ab5c:	d503201f 	nop
    ab60:	3ce468fa 	ldr	q26, [x7, x4]
    ab64:	3ce469ee 	ldr	q14, [x15, x4]
    ab68:	3ce469cd 	ldr	q13, [x14, x4]
    ab6c:	3ce469ac 	ldr	q12, [x13, x4]
    ab70:	3ce4698b 	ldr	q11, [x12, x4]
    ab74:	4e4e0f58 	fmla	v24.8h, v26.8h, v14.8h
    ab78:	3ce4696a 	ldr	q10, [x11, x4]
    ab7c:	4e4d0f57 	fmla	v23.8h, v26.8h, v13.8h
    ab80:	3ce46949 	ldr	q9, [x10, x4]
    ab84:	4e4c0f56 	fmla	v22.8h, v26.8h, v12.8h
    ab88:	4e4b0f55 	fmla	v21.8h, v26.8h, v11.8h
    ab8c:	4e4a0f54 	fmla	v20.8h, v26.8h, v10.8h
    ab90:	4e490f59 	fmla	v25.8h, v26.8h, v9.8h
    ab94:	3ce46a1a 	ldr	q26, [x16, x4]
    ab98:	4e4e0f52 	fmla	v18.8h, v26.8h, v14.8h
    ab9c:	4e4d0f51 	fmla	v17.8h, v26.8h, v13.8h
    aba0:	4e4c0f50 	fmla	v16.8h, v26.8h, v12.8h
    aba4:	4e4b0f47 	fmla	v7.8h, v26.8h, v11.8h
    aba8:	4e4a0f46 	fmla	v6.8h, v26.8h, v10.8h
    abac:	4e490f53 	fmla	v19.8h, v26.8h, v9.8h
    abb0:	3ce4691a 	ldr	q26, [x8, x4]
    abb4:	4e4e0f44 	fmla	v4.8h, v26.8h, v14.8h
    abb8:	4e4d0f43 	fmla	v3.8h, v26.8h, v13.8h
    abbc:	4e4c0f42 	fmla	v2.8h, v26.8h, v12.8h
    abc0:	4e4b0f41 	fmla	v1.8h, v26.8h, v11.8h
    abc4:	4e4a0f40 	fmla	v0.8h, v26.8h, v10.8h
    abc8:	4e490f45 	fmla	v5.8h, v26.8h, v9.8h
    abcc:	3ce4693a 	ldr	q26, [x9, x4]
    abd0:	91004084 	add	x4, x4, #0x10
    abd4:	4e4e0f5f 	fmla	v31.8h, v26.8h, v14.8h
    abd8:	4e4d0f5e 	fmla	v30.8h, v26.8h, v13.8h
    abdc:	4e4c0f5d 	fmla	v29.8h, v26.8h, v12.8h
    abe0:	4e4b0f5c 	fmla	v28.8h, v26.8h, v11.8h
    abe4:	4e4a0f5b 	fmla	v27.8h, v26.8h, v10.8h
    abe8:	4e490f4f 	fmla	v15.8h, v26.8h, v9.8h
    abec:	f104009f 	cmp	x4, #0x100
    abf0:	54fffb81 	b.ne	ab60 <_Z8qk_clonePKcmiRK8DataInfo+0x190>  // b.any
    abf4:	5e18071a 	mov	d26, v24.d[1]
    abf8:	f9400060 	ldr	x0, [x3]
    abfc:	93407cc4 	sxtw	x4, w6
    ac00:	f9400861 	ldr	x1, [x3, #16]
    ac04:	0e58175a 	fadd	v26.4h, v26.4h, v24.4h
    ac08:	0e217b5a 	fcvtl	v26.4s, v26.4h
    ac0c:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    ac10:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    ac14:	b4003445 	cbz	x5, b29c <_Z8qk_clonePKcmiRK8DataInfo+0x8cc>
    ac18:	d37df087 	lsl	x7, x4, #3
    ac1c:	8b040ca4 	add	x4, x5, x4, lsl #3
    ac20:	f9401869 	ldr	x9, [x3, #48]
    ac24:	b8a768a8 	ldrsw	x8, [x5, x7]
    ac28:	b9800487 	ldrsw	x7, [x4, #4]
    ac2c:	9b017d04 	mul	x4, x8, x1
    ac30:	9b0910e7 	madd	x7, x7, x9, x4
    ac34:	8b070807 	add	x7, x0, x7, lsl #2
    ac38:	d37ef442 	lsl	x2, x2, #2
    ac3c:	93407cc4 	sxtw	x4, w6
    ac40:	bc2268fa 	str	s26, [x7, x2]
    ac44:	5e1806fa 	mov	d26, v23.d[1]
    ac48:	0e57175a 	fadd	v26.4h, v26.4h, v23.4h
    ac4c:	0e217b5a 	fcvtl	v26.4s, v26.4h
    ac50:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    ac54:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    ac58:	b4003285 	cbz	x5, b2a8 <_Z8qk_clonePKcmiRK8DataInfo+0x8d8>
    ac5c:	d37df087 	lsl	x7, x4, #3
    ac60:	8b040ca4 	add	x4, x5, x4, lsl #3
    ac64:	f9401869 	ldr	x9, [x3, #48]
    ac68:	b8a768a8 	ldrsw	x8, [x5, x7]
    ac6c:	b9800487 	ldrsw	x7, [x4, #4]
    ac70:	9b017d04 	mul	x4, x8, x1
    ac74:	9b0910e7 	madd	x7, x7, x9, x4
    ac78:	8b070807 	add	x7, x0, x7, lsl #2
    ac7c:	9100104b 	add	x11, x2, #0x4
    ac80:	93407cc4 	sxtw	x4, w6
    ac84:	bc2b68fa 	str	s26, [x7, x11]
    ac88:	5e1806da 	mov	d26, v22.d[1]
    ac8c:	0e56175a 	fadd	v26.4h, v26.4h, v22.4h
    ac90:	0e217b5a 	fcvtl	v26.4s, v26.4h
    ac94:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    ac98:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    ac9c:	b40030c5 	cbz	x5, b2b4 <_Z8qk_clonePKcmiRK8DataInfo+0x8e4>
    aca0:	d37df087 	lsl	x7, x4, #3
    aca4:	8b040ca4 	add	x4, x5, x4, lsl #3
    aca8:	f9401869 	ldr	x9, [x3, #48]
    acac:	b8a768a8 	ldrsw	x8, [x5, x7]
    acb0:	b9800487 	ldrsw	x7, [x4, #4]
    acb4:	9b017d04 	mul	x4, x8, x1
    acb8:	9b0910e7 	madd	x7, x7, x9, x4
    acbc:	8b070807 	add	x7, x0, x7, lsl #2
    acc0:	9100204a 	add	x10, x2, #0x8
    acc4:	93407cc4 	sxtw	x4, w6
    acc8:	bc2a68fa 	str	s26, [x7, x10]
    accc:	5e1806ba 	mov	d26, v21.d[1]
    acd0:	0e55175a 	fadd	v26.4h, v26.4h, v21.4h
    acd4:	0e217b5a 	fcvtl	v26.4s, v26.4h
    acd8:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    acdc:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    ace0:	b4002f05 	cbz	x5, b2c0 <_Z8qk_clonePKcmiRK8DataInfo+0x8f0>
    ace4:	d37df087 	lsl	x7, x4, #3
    ace8:	8b040ca4 	add	x4, x5, x4, lsl #3
    acec:	f9401869 	ldr	x9, [x3, #48]
    acf0:	b8a768a8 	ldrsw	x8, [x5, x7]
    acf4:	b9800487 	ldrsw	x7, [x4, #4]
    acf8:	9b017d04 	mul	x4, x8, x1
    acfc:	9b0910e7 	madd	x7, x7, x9, x4
    ad00:	8b070807 	add	x7, x0, x7, lsl #2
    ad04:	91003048 	add	x8, x2, #0xc
    ad08:	93407cc4 	sxtw	x4, w6
    ad0c:	bc2868fa 	str	s26, [x7, x8]
    ad10:	5e18069a 	mov	d26, v20.d[1]
    ad14:	0e54175a 	fadd	v26.4h, v26.4h, v20.4h
    ad18:	0e217b5a 	fcvtl	v26.4s, v26.4h
    ad1c:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    ad20:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    ad24:	b4002d45 	cbz	x5, b2cc <_Z8qk_clonePKcmiRK8DataInfo+0x8fc>
    ad28:	d37df087 	lsl	x7, x4, #3
    ad2c:	8b040ca4 	add	x4, x5, x4, lsl #3
    ad30:	f940186c 	ldr	x12, [x3, #48]
    ad34:	b8a768a7 	ldrsw	x7, [x5, x7]
    ad38:	b9800489 	ldrsw	x9, [x4, #4]
    ad3c:	9b017ce4 	mul	x4, x7, x1
    ad40:	9b0c1129 	madd	x9, x9, x12, x4
    ad44:	8b090809 	add	x9, x0, x9, lsl #2
    ad48:	91004047 	add	x7, x2, #0x10
    ad4c:	93407cc4 	sxtw	x4, w6
    ad50:	bc27693a 	str	s26, [x9, x7]
    ad54:	5e18073a 	mov	d26, v25.d[1]
    ad58:	0e59175a 	fadd	v26.4h, v26.4h, v25.4h
    ad5c:	0e217b5a 	fcvtl	v26.4s, v26.4h
    ad60:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    ad64:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    ad68:	b4002b85 	cbz	x5, b2d8 <_Z8qk_clonePKcmiRK8DataInfo+0x908>
    ad6c:	d37df089 	lsl	x9, x4, #3
    ad70:	8b040ca4 	add	x4, x5, x4, lsl #3
    ad74:	f940186d 	ldr	x13, [x3, #48]
    ad78:	b8a968a9 	ldrsw	x9, [x5, x9]
    ad7c:	b980048c 	ldrsw	x12, [x4, #4]
    ad80:	9b017d24 	mul	x4, x9, x1
    ad84:	9b0d118c 	madd	x12, x12, x13, x4
    ad88:	8b0c080c 	add	x12, x0, x12, lsl #2
    ad8c:	91005044 	add	x4, x2, #0x14
    ad90:	110004c9 	add	w9, w6, #0x1
    ad94:	93407d29 	sxtw	x9, w9
    ad98:	bc24699a 	str	s26, [x12, x4]
    ad9c:	5e18065a 	mov	d26, v18.d[1]
    ada0:	0e52175a 	fadd	v26.4h, v26.4h, v18.4h
    ada4:	0e217b5a 	fcvtl	v26.4s, v26.4h
    ada8:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    adac:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    adb0:	b40029a5 	cbz	x5, b2e4 <_Z8qk_clonePKcmiRK8DataInfo+0x914>
    adb4:	d37df12c 	lsl	x12, x9, #3
    adb8:	8b090ca9 	add	x9, x5, x9, lsl #3
    adbc:	f940186d 	ldr	x13, [x3, #48]
    adc0:	b8ac68ac 	ldrsw	x12, [x5, x12]
    adc4:	b9800529 	ldrsw	x9, [x9, #4]
    adc8:	9b017d8c 	mul	x12, x12, x1
    adcc:	9b0d3129 	madd	x9, x9, x13, x12
    add0:	8b090809 	add	x9, x0, x9, lsl #2
    add4:	bc22693a 	str	s26, [x9, x2]
    add8:	5e18063a 	mov	d26, v17.d[1]
    addc:	110004c9 	add	w9, w6, #0x1
    ade0:	93407d29 	sxtw	x9, w9
    ade4:	0e51175a 	fadd	v26.4h, v26.4h, v17.4h
    ade8:	0e217b5a 	fcvtl	v26.4s, v26.4h
    adec:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    adf0:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    adf4:	b40027e5 	cbz	x5, b2f0 <_Z8qk_clonePKcmiRK8DataInfo+0x920>
    adf8:	d37df12c 	lsl	x12, x9, #3
    adfc:	8b090ca9 	add	x9, x5, x9, lsl #3
    ae00:	f940186d 	ldr	x13, [x3, #48]
    ae04:	b8ac68ac 	ldrsw	x12, [x5, x12]
    ae08:	b9800529 	ldrsw	x9, [x9, #4]
    ae0c:	9b017d8c 	mul	x12, x12, x1
    ae10:	9b0d3129 	madd	x9, x9, x13, x12
    ae14:	8b090809 	add	x9, x0, x9, lsl #2
    ae18:	bc2b693a 	str	s26, [x9, x11]
    ae1c:	5e18061a 	mov	d26, v16.d[1]
    ae20:	110004c9 	add	w9, w6, #0x1
    ae24:	93407d29 	sxtw	x9, w9
    ae28:	0e50175a 	fadd	v26.4h, v26.4h, v16.4h
    ae2c:	0e217b5a 	fcvtl	v26.4s, v26.4h
    ae30:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    ae34:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    ae38:	b4002625 	cbz	x5, b2fc <_Z8qk_clonePKcmiRK8DataInfo+0x92c>
    ae3c:	d37df12c 	lsl	x12, x9, #3
    ae40:	8b090ca9 	add	x9, x5, x9, lsl #3
    ae44:	f940186d 	ldr	x13, [x3, #48]
    ae48:	b8ac68ac 	ldrsw	x12, [x5, x12]
    ae4c:	b9800529 	ldrsw	x9, [x9, #4]
    ae50:	9b017d8c 	mul	x12, x12, x1
    ae54:	9b0d3129 	madd	x9, x9, x13, x12
    ae58:	8b090809 	add	x9, x0, x9, lsl #2
    ae5c:	bc2a693a 	str	s26, [x9, x10]
    ae60:	5e1804fa 	mov	d26, v7.d[1]
    ae64:	110004c9 	add	w9, w6, #0x1
    ae68:	93407d29 	sxtw	x9, w9
    ae6c:	0e47175a 	fadd	v26.4h, v26.4h, v7.4h
    ae70:	0e217b5a 	fcvtl	v26.4s, v26.4h
    ae74:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    ae78:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    ae7c:	b4002465 	cbz	x5, b308 <_Z8qk_clonePKcmiRK8DataInfo+0x938>
    ae80:	d37df12c 	lsl	x12, x9, #3
    ae84:	8b090ca9 	add	x9, x5, x9, lsl #3
    ae88:	f940186d 	ldr	x13, [x3, #48]
    ae8c:	b8ac68ac 	ldrsw	x12, [x5, x12]
    ae90:	b9800529 	ldrsw	x9, [x9, #4]
    ae94:	9b017d8c 	mul	x12, x12, x1
    ae98:	9b0d3129 	madd	x9, x9, x13, x12
    ae9c:	8b090809 	add	x9, x0, x9, lsl #2
    aea0:	bc28693a 	str	s26, [x9, x8]
    aea4:	5e1804da 	mov	d26, v6.d[1]
    aea8:	110004c9 	add	w9, w6, #0x1
    aeac:	93407d29 	sxtw	x9, w9
    aeb0:	0e46175a 	fadd	v26.4h, v26.4h, v6.4h
    aeb4:	0e217b5a 	fcvtl	v26.4s, v26.4h
    aeb8:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    aebc:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    aec0:	b40022a5 	cbz	x5, b314 <_Z8qk_clonePKcmiRK8DataInfo+0x944>
    aec4:	d37df12c 	lsl	x12, x9, #3
    aec8:	8b090ca9 	add	x9, x5, x9, lsl #3
    aecc:	f940186d 	ldr	x13, [x3, #48]
    aed0:	b8ac68ac 	ldrsw	x12, [x5, x12]
    aed4:	b9800529 	ldrsw	x9, [x9, #4]
    aed8:	9b017d8c 	mul	x12, x12, x1
    aedc:	9b0d3129 	madd	x9, x9, x13, x12
    aee0:	8b090809 	add	x9, x0, x9, lsl #2
    aee4:	bc27693a 	str	s26, [x9, x7]
    aee8:	5e18067a 	mov	d26, v19.d[1]
    aeec:	110004c9 	add	w9, w6, #0x1
    aef0:	93407d29 	sxtw	x9, w9
    aef4:	0e53175a 	fadd	v26.4h, v26.4h, v19.4h
    aef8:	0e217b5a 	fcvtl	v26.4s, v26.4h
    aefc:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    af00:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    af04:	b40020e5 	cbz	x5, b320 <_Z8qk_clonePKcmiRK8DataInfo+0x950>
    af08:	d37df12c 	lsl	x12, x9, #3
    af0c:	8b090ca9 	add	x9, x5, x9, lsl #3
    af10:	f940186d 	ldr	x13, [x3, #48]
    af14:	b8ac68ac 	ldrsw	x12, [x5, x12]
    af18:	b9800529 	ldrsw	x9, [x9, #4]
    af1c:	9b017d8c 	mul	x12, x12, x1
    af20:	9b0d3129 	madd	x9, x9, x13, x12
    af24:	8b090809 	add	x9, x0, x9, lsl #2
    af28:	bc24693a 	str	s26, [x9, x4]
    af2c:	5e18049a 	mov	d26, v4.d[1]
    af30:	110008c9 	add	w9, w6, #0x2
    af34:	93407d29 	sxtw	x9, w9
    af38:	0e44175a 	fadd	v26.4h, v26.4h, v4.4h
    af3c:	0e217b5a 	fcvtl	v26.4s, v26.4h
    af40:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    af44:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    af48:	b4001f25 	cbz	x5, b32c <_Z8qk_clonePKcmiRK8DataInfo+0x95c>
    af4c:	d37df12c 	lsl	x12, x9, #3
    af50:	8b090ca9 	add	x9, x5, x9, lsl #3
    af54:	f940186d 	ldr	x13, [x3, #48]
    af58:	b8ac68ac 	ldrsw	x12, [x5, x12]
    af5c:	b9800529 	ldrsw	x9, [x9, #4]
    af60:	9b017d8c 	mul	x12, x12, x1
    af64:	9b0d3129 	madd	x9, x9, x13, x12
    af68:	8b090809 	add	x9, x0, x9, lsl #2
    af6c:	bc22693a 	str	s26, [x9, x2]
    af70:	5e18047a 	mov	d26, v3.d[1]
    af74:	110008c9 	add	w9, w6, #0x2
    af78:	93407d29 	sxtw	x9, w9
    af7c:	0e43175a 	fadd	v26.4h, v26.4h, v3.4h
    af80:	0e217b5a 	fcvtl	v26.4s, v26.4h
    af84:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    af88:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    af8c:	b4001d65 	cbz	x5, b338 <_Z8qk_clonePKcmiRK8DataInfo+0x968>
    af90:	d37df12c 	lsl	x12, x9, #3
    af94:	8b090ca9 	add	x9, x5, x9, lsl #3
    af98:	f940186d 	ldr	x13, [x3, #48]
    af9c:	b8ac68ac 	ldrsw	x12, [x5, x12]
    afa0:	b9800529 	ldrsw	x9, [x9, #4]
    afa4:	9b017d8c 	mul	x12, x12, x1
    afa8:	9b0d3129 	madd	x9, x9, x13, x12
    afac:	8b090809 	add	x9, x0, x9, lsl #2
    afb0:	bc2b693a 	str	s26, [x9, x11]
    afb4:	5e18045a 	mov	d26, v2.d[1]
    afb8:	110008c9 	add	w9, w6, #0x2
    afbc:	93407d29 	sxtw	x9, w9
    afc0:	0e42175a 	fadd	v26.4h, v26.4h, v2.4h
    afc4:	0e217b5a 	fcvtl	v26.4s, v26.4h
    afc8:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    afcc:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    afd0:	b4001ba5 	cbz	x5, b344 <_Z8qk_clonePKcmiRK8DataInfo+0x974>
    afd4:	d37df12c 	lsl	x12, x9, #3
    afd8:	8b090ca9 	add	x9, x5, x9, lsl #3
    afdc:	f940186d 	ldr	x13, [x3, #48]
    afe0:	b8ac68ac 	ldrsw	x12, [x5, x12]
    afe4:	b9800529 	ldrsw	x9, [x9, #4]
    afe8:	9b017d8c 	mul	x12, x12, x1
    afec:	9b0d3129 	madd	x9, x9, x13, x12
    aff0:	8b090809 	add	x9, x0, x9, lsl #2
    aff4:	bc2a693a 	str	s26, [x9, x10]
    aff8:	5e18043a 	mov	d26, v1.d[1]
    affc:	110008c9 	add	w9, w6, #0x2
    b000:	93407d29 	sxtw	x9, w9
    b004:	0e41175a 	fadd	v26.4h, v26.4h, v1.4h
    b008:	0e217b5a 	fcvtl	v26.4s, v26.4h
    b00c:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    b010:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    b014:	b40019e5 	cbz	x5, b350 <_Z8qk_clonePKcmiRK8DataInfo+0x980>
    b018:	d37df12c 	lsl	x12, x9, #3
    b01c:	8b090ca9 	add	x9, x5, x9, lsl #3
    b020:	f940186d 	ldr	x13, [x3, #48]
    b024:	b8ac68ac 	ldrsw	x12, [x5, x12]
    b028:	b9800529 	ldrsw	x9, [x9, #4]
    b02c:	9b017d8c 	mul	x12, x12, x1
    b030:	9b0d3129 	madd	x9, x9, x13, x12
    b034:	8b090809 	add	x9, x0, x9, lsl #2
    b038:	bc28693a 	str	s26, [x9, x8]
    b03c:	5e18041a 	mov	d26, v0.d[1]
    b040:	110008c9 	add	w9, w6, #0x2
    b044:	93407d29 	sxtw	x9, w9
    b048:	0e40175a 	fadd	v26.4h, v26.4h, v0.4h
    b04c:	0e217b5a 	fcvtl	v26.4s, v26.4h
    b050:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    b054:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    b058:	b4001825 	cbz	x5, b35c <_Z8qk_clonePKcmiRK8DataInfo+0x98c>
    b05c:	d37df12c 	lsl	x12, x9, #3
    b060:	8b090ca9 	add	x9, x5, x9, lsl #3
    b064:	f940186d 	ldr	x13, [x3, #48]
    b068:	b8ac68ac 	ldrsw	x12, [x5, x12]
    b06c:	b9800529 	ldrsw	x9, [x9, #4]
    b070:	9b017d8c 	mul	x12, x12, x1
    b074:	9b0d3129 	madd	x9, x9, x13, x12
    b078:	8b090809 	add	x9, x0, x9, lsl #2
    b07c:	bc27693a 	str	s26, [x9, x7]
    b080:	5e1804ba 	mov	d26, v5.d[1]
    b084:	110008c9 	add	w9, w6, #0x2
    b088:	93407d29 	sxtw	x9, w9
    b08c:	0e45175a 	fadd	v26.4h, v26.4h, v5.4h
    b090:	0e217b5a 	fcvtl	v26.4s, v26.4h
    b094:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    b098:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    b09c:	b4001665 	cbz	x5, b368 <_Z8qk_clonePKcmiRK8DataInfo+0x998>
    b0a0:	d37df12c 	lsl	x12, x9, #3
    b0a4:	8b090ca9 	add	x9, x5, x9, lsl #3
    b0a8:	f940186d 	ldr	x13, [x3, #48]
    b0ac:	b8ac68ac 	ldrsw	x12, [x5, x12]
    b0b0:	b9800529 	ldrsw	x9, [x9, #4]
    b0b4:	9b017d8c 	mul	x12, x12, x1
    b0b8:	9b0d3129 	madd	x9, x9, x13, x12
    b0bc:	8b090809 	add	x9, x0, x9, lsl #2
    b0c0:	bc24693a 	str	s26, [x9, x4]
    b0c4:	5e1807fa 	mov	d26, v31.d[1]
    b0c8:	11000cc9 	add	w9, w6, #0x3
    b0cc:	93407d29 	sxtw	x9, w9
    b0d0:	0e5f175a 	fadd	v26.4h, v26.4h, v31.4h
    b0d4:	0e217b5a 	fcvtl	v26.4s, v26.4h
    b0d8:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    b0dc:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    b0e0:	b40014a5 	cbz	x5, b374 <_Z8qk_clonePKcmiRK8DataInfo+0x9a4>
    b0e4:	d37df12c 	lsl	x12, x9, #3
    b0e8:	8b090ca9 	add	x9, x5, x9, lsl #3
    b0ec:	f940186d 	ldr	x13, [x3, #48]
    b0f0:	b8ac68ac 	ldrsw	x12, [x5, x12]
    b0f4:	b9800529 	ldrsw	x9, [x9, #4]
    b0f8:	9b017d8c 	mul	x12, x12, x1
    b0fc:	9b0d3129 	madd	x9, x9, x13, x12
    b100:	8b090809 	add	x9, x0, x9, lsl #2
    b104:	bc22693a 	str	s26, [x9, x2]
    b108:	5e1807da 	mov	d26, v30.d[1]
    b10c:	11000cc2 	add	w2, w6, #0x3
    b110:	93407c42 	sxtw	x2, w2
    b114:	0e5e175a 	fadd	v26.4h, v26.4h, v30.4h
    b118:	0e217b5a 	fcvtl	v26.4s, v26.4h
    b11c:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    b120:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    b124:	b40012e5 	cbz	x5, b380 <_Z8qk_clonePKcmiRK8DataInfo+0x9b0>
    b128:	d37df049 	lsl	x9, x2, #3
    b12c:	8b020ca2 	add	x2, x5, x2, lsl #3
    b130:	f940186c 	ldr	x12, [x3, #48]
    b134:	b8a968a9 	ldrsw	x9, [x5, x9]
    b138:	b9800442 	ldrsw	x2, [x2, #4]
    b13c:	9b017d29 	mul	x9, x9, x1
    b140:	9b0c2442 	madd	x2, x2, x12, x9
    b144:	8b020802 	add	x2, x0, x2, lsl #2
    b148:	bc2b685a 	str	s26, [x2, x11]
    b14c:	5e1807ba 	mov	d26, v29.d[1]
    b150:	11000cc2 	add	w2, w6, #0x3
    b154:	93407c42 	sxtw	x2, w2
    b158:	0e5d175a 	fadd	v26.4h, v26.4h, v29.4h
    b15c:	0e217b5a 	fcvtl	v26.4s, v26.4h
    b160:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    b164:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    b168:	b4001125 	cbz	x5, b38c <_Z8qk_clonePKcmiRK8DataInfo+0x9bc>
    b16c:	d37df049 	lsl	x9, x2, #3
    b170:	8b020ca2 	add	x2, x5, x2, lsl #3
    b174:	f940186b 	ldr	x11, [x3, #48]
    b178:	b8a968a9 	ldrsw	x9, [x5, x9]
    b17c:	b9800442 	ldrsw	x2, [x2, #4]
    b180:	9b017d29 	mul	x9, x9, x1
    b184:	9b0b2442 	madd	x2, x2, x11, x9
    b188:	8b020802 	add	x2, x0, x2, lsl #2
    b18c:	bc2a685a 	str	s26, [x2, x10]
    b190:	5e18079a 	mov	d26, v28.d[1]
    b194:	11000cc2 	add	w2, w6, #0x3
    b198:	93407c42 	sxtw	x2, w2
    b19c:	0e5c175a 	fadd	v26.4h, v26.4h, v28.4h
    b1a0:	0e217b5a 	fcvtl	v26.4s, v26.4h
    b1a4:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    b1a8:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    b1ac:	b4000f65 	cbz	x5, b398 <_Z8qk_clonePKcmiRK8DataInfo+0x9c8>
    b1b0:	d37df049 	lsl	x9, x2, #3
    b1b4:	8b020ca2 	add	x2, x5, x2, lsl #3
    b1b8:	f940186a 	ldr	x10, [x3, #48]
    b1bc:	b8a968a9 	ldrsw	x9, [x5, x9]
    b1c0:	b9800442 	ldrsw	x2, [x2, #4]
    b1c4:	9b017d29 	mul	x9, x9, x1
    b1c8:	9b0a2442 	madd	x2, x2, x10, x9
    b1cc:	8b020802 	add	x2, x0, x2, lsl #2
    b1d0:	bc28685a 	str	s26, [x2, x8]
    b1d4:	5e18077a 	mov	d26, v27.d[1]
    b1d8:	11000cc2 	add	w2, w6, #0x3
    b1dc:	93407c42 	sxtw	x2, w2
    b1e0:	0e5b175a 	fadd	v26.4h, v26.4h, v27.4h
    b1e4:	0e217b5a 	fcvtl	v26.4s, v26.4h
    b1e8:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    b1ec:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    b1f0:	b4000da5 	cbz	x5, b3a4 <_Z8qk_clonePKcmiRK8DataInfo+0x9d4>
    b1f4:	d37df048 	lsl	x8, x2, #3
    b1f8:	8b020ca2 	add	x2, x5, x2, lsl #3
    b1fc:	f9401869 	ldr	x9, [x3, #48]
    b200:	b8a868a8 	ldrsw	x8, [x5, x8]
    b204:	b9800442 	ldrsw	x2, [x2, #4]
    b208:	9b017d08 	mul	x8, x8, x1
    b20c:	9b092042 	madd	x2, x2, x9, x8
    b210:	8b020802 	add	x2, x0, x2, lsl #2
    b214:	bc27685a 	str	s26, [x2, x7]
    b218:	5e1805fa 	mov	d26, v15.d[1]
    b21c:	11000cc6 	add	w6, w6, #0x3
    b220:	93407cc6 	sxtw	x6, w6
    b224:	0e4f175a 	fadd	v26.4h, v26.4h, v15.4h
    b228:	0e217b5a 	fcvtl	v26.4s, v26.4h
    b22c:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    b230:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    b234:	b4000be5 	cbz	x5, b3b0 <_Z8qk_clonePKcmiRK8DataInfo+0x9e0>
    b238:	d37df0c2 	lsl	x2, x6, #3
    b23c:	f9401867 	ldr	x7, [x3, #48]
    b240:	8b060ca6 	add	x6, x5, x6, lsl #3
    b244:	b8a268a3 	ldrsw	x3, [x5, x2]
    b248:	b98004c2 	ldrsw	x2, [x6, #4]
    b24c:	fd400fef 	ldr	d15, [sp, #24]
    b250:	9b017c61 	mul	x1, x3, x1
    b254:	9b070441 	madd	x1, x2, x7, x1
    b258:	8b010800 	add	x0, x0, x1, lsl #2
    b25c:	bc24681a 	str	s26, [x0, x4]
    b260:	6d422be9 	ldp	d9, d10, [sp, #32]
    b264:	6d4333eb 	ldp	d11, d12, [sp, #48]
    b268:	6d443bed 	ldp	d13, d14, [sp, #64]
    b26c:	a8c57bfd 	ldp	x29, x30, [sp], #80
    b270:	d65f03c0 	ret
    b274:	93407cc7 	sxtw	x7, w6
    b278:	9b0a7ce7 	mul	x7, x7, x10
    b27c:	8b0a00f0 	add	x16, x7, x10
    b280:	8b070127 	add	x7, x9, x7
    b284:	8b0a0208 	add	x8, x16, x10
    b288:	8b100130 	add	x16, x9, x16
    b28c:	8b0a010a 	add	x10, x8, x10
    b290:	8b080128 	add	x8, x9, x8
    b294:	8b0a0129 	add	x9, x9, x10
    b298:	17fffe00 	b	aa98 <_Z8qk_clonePKcmiRK8DataInfo+0xc8>
    b29c:	9b017c84 	mul	x4, x4, x1
    b2a0:	8b040807 	add	x7, x0, x4, lsl #2
    b2a4:	17fffe65 	b	ac38 <_Z8qk_clonePKcmiRK8DataInfo+0x268>
    b2a8:	9b017c84 	mul	x4, x4, x1
    b2ac:	8b040807 	add	x7, x0, x4, lsl #2
    b2b0:	17fffe73 	b	ac7c <_Z8qk_clonePKcmiRK8DataInfo+0x2ac>
    b2b4:	9b017c84 	mul	x4, x4, x1
    b2b8:	8b040807 	add	x7, x0, x4, lsl #2
    b2bc:	17fffe81 	b	acc0 <_Z8qk_clonePKcmiRK8DataInfo+0x2f0>
    b2c0:	9b017c84 	mul	x4, x4, x1
    b2c4:	8b040807 	add	x7, x0, x4, lsl #2
    b2c8:	17fffe8f 	b	ad04 <_Z8qk_clonePKcmiRK8DataInfo+0x334>
    b2cc:	9b017c84 	mul	x4, x4, x1
    b2d0:	8b040809 	add	x9, x0, x4, lsl #2
    b2d4:	17fffe9d 	b	ad48 <_Z8qk_clonePKcmiRK8DataInfo+0x378>
    b2d8:	9b017c84 	mul	x4, x4, x1
    b2dc:	8b04080c 	add	x12, x0, x4, lsl #2
    b2e0:	17fffeab 	b	ad8c <_Z8qk_clonePKcmiRK8DataInfo+0x3bc>
    b2e4:	9b017d29 	mul	x9, x9, x1
    b2e8:	8b090809 	add	x9, x0, x9, lsl #2
    b2ec:	17fffeba 	b	add4 <_Z8qk_clonePKcmiRK8DataInfo+0x404>
    b2f0:	9b017d29 	mul	x9, x9, x1
    b2f4:	8b090809 	add	x9, x0, x9, lsl #2
    b2f8:	17fffec8 	b	ae18 <_Z8qk_clonePKcmiRK8DataInfo+0x448>
    b2fc:	9b017d29 	mul	x9, x9, x1
    b300:	8b090809 	add	x9, x0, x9, lsl #2
    b304:	17fffed6 	b	ae5c <_Z8qk_clonePKcmiRK8DataInfo+0x48c>
    b308:	9b017d29 	mul	x9, x9, x1
    b30c:	8b090809 	add	x9, x0, x9, lsl #2
    b310:	17fffee4 	b	aea0 <_Z8qk_clonePKcmiRK8DataInfo+0x4d0>
    b314:	9b017d29 	mul	x9, x9, x1
    b318:	8b090809 	add	x9, x0, x9, lsl #2
    b31c:	17fffef2 	b	aee4 <_Z8qk_clonePKcmiRK8DataInfo+0x514>
    b320:	9b017d29 	mul	x9, x9, x1
    b324:	8b090809 	add	x9, x0, x9, lsl #2
    b328:	17ffff00 	b	af28 <_Z8qk_clonePKcmiRK8DataInfo+0x558>
    b32c:	9b017d29 	mul	x9, x9, x1
    b330:	8b090809 	add	x9, x0, x9, lsl #2
    b334:	17ffff0e 	b	af6c <_Z8qk_clonePKcmiRK8DataInfo+0x59c>
    b338:	9b017d29 	mul	x9, x9, x1
    b33c:	8b090809 	add	x9, x0, x9, lsl #2
    b340:	17ffff1c 	b	afb0 <_Z8qk_clonePKcmiRK8DataInfo+0x5e0>
    b344:	9b017d29 	mul	x9, x9, x1
    b348:	8b090809 	add	x9, x0, x9, lsl #2
    b34c:	17ffff2a 	b	aff4 <_Z8qk_clonePKcmiRK8DataInfo+0x624>
    b350:	9b017d29 	mul	x9, x9, x1
    b354:	8b090809 	add	x9, x0, x9, lsl #2
    b358:	17ffff38 	b	b038 <_Z8qk_clonePKcmiRK8DataInfo+0x668>
    b35c:	9b017d29 	mul	x9, x9, x1
    b360:	8b090809 	add	x9, x0, x9, lsl #2
    b364:	17ffff46 	b	b07c <_Z8qk_clonePKcmiRK8DataInfo+0x6ac>
    b368:	9b017d29 	mul	x9, x9, x1
    b36c:	8b090809 	add	x9, x0, x9, lsl #2
    b370:	17ffff54 	b	b0c0 <_Z8qk_clonePKcmiRK8DataInfo+0x6f0>
    b374:	9b017d29 	mul	x9, x9, x1
    b378:	8b090809 	add	x9, x0, x9, lsl #2
    b37c:	17ffff62 	b	b104 <_Z8qk_clonePKcmiRK8DataInfo+0x734>
    b380:	9b017c42 	mul	x2, x2, x1
    b384:	8b020802 	add	x2, x0, x2, lsl #2
    b388:	17ffff70 	b	b148 <_Z8qk_clonePKcmiRK8DataInfo+0x778>
    b38c:	9b017c42 	mul	x2, x2, x1
    b390:	8b020802 	add	x2, x0, x2, lsl #2
    b394:	17ffff7e 	b	b18c <_Z8qk_clonePKcmiRK8DataInfo+0x7bc>
    b398:	9b017c42 	mul	x2, x2, x1
    b39c:	8b020802 	add	x2, x0, x2, lsl #2
    b3a0:	17ffff8c 	b	b1d0 <_Z8qk_clonePKcmiRK8DataInfo+0x800>
    b3a4:	9b017c42 	mul	x2, x2, x1
    b3a8:	8b020802 	add	x2, x0, x2, lsl #2
    b3ac:	17ffff9a 	b	b214 <_Z8qk_clonePKcmiRK8DataInfo+0x844>
    b3b0:	9b017cc6 	mul	x6, x6, x1
    b3b4:	fd400fef 	ldr	d15, [sp, #24]
    b3b8:	8b060800 	add	x0, x0, x6, lsl #2
    b3bc:	bc24681a 	str	s26, [x0, x4]
    b3c0:	6d422be9 	ldp	d9, d10, [sp, #32]
    b3c4:	6d4333eb 	ldp	d11, d12, [sp, #48]
    b3c8:	6d443bed 	ldp	d13, d14, [sp, #64]
    b3cc:	a8c57bfd 	ldp	x29, x30, [sp], #80
    b3d0:	d65f03c0 	ret

Disassembly of section .fini:
