
/home/philip/minicpm-pi5/build-qk-scheduling/bench:     file format elf64-littleaarch64


Disassembly of section .init:

Disassembly of section .plt:

Disassembly of section .text:

000000000000b830 <_Z8qk_aheadPKcmiRK8DataInfo>:
    b830:	a9ba7bfd 	stp	x29, x30, [sp, #-96]!
    b834:	910003fd 	mov	x29, sp
    b838:	6d0227e8 	stp	d8, d9, [sp, #32]
    b83c:	6d032fea 	stp	d10, d11, [sp, #48]
    b840:	6d0437ec 	stp	d12, d13, [sp, #64]
    b844:	6d053fee 	stp	d14, d15, [sp, #80]
    b848:	f9401465 	ldr	x5, [x3, #40]
    b84c:	f9400469 	ldr	x9, [x3, #8]
    b850:	f9400c6a 	ldr	x10, [x3, #24]
    b854:	b9402066 	ldr	w6, [x3, #32]
    b858:	b40043e5 	cbz	x5, c0d4 <_Z8qk_aheadPKcmiRK8DataInfo+0x8a4>
    b85c:	937d7cc4 	sbfiz	x4, x6, #3, #32
    b860:	91002087 	add	x7, x4, #0x8
    b864:	9100408b 	add	x11, x4, #0x10
    b868:	b86468be 	ldr	w30, [x5, x4]
    b86c:	91006088 	add	x8, x4, #0x18
    b870:	8b0700ae 	add	x14, x5, x7
    b874:	8b0b00ad 	add	x13, x5, x11
    b878:	8b0800ac 	add	x12, x5, x8
    b87c:	b86b68b1 	ldr	w17, [x5, x11]
    b880:	b86868af 	ldr	w15, [x5, x8]
    b884:	b9400592 	ldr	w18, [x12, #4]
    b888:	b94005a8 	ldr	w8, [x13, #4]
    b88c:	b94005d0 	ldr	w16, [x14, #4]
    b890:	f9000bf3 	str	x19, [sp, #16]
    b894:	b86768b3 	ldr	w19, [x5, x7]
    b898:	8b0400a7 	add	x7, x5, x4
    b89c:	b9402464 	ldr	w4, [x3, #36]
    b8a0:	b94004e7 	ldr	w7, [x7, #4]
    b8a4:	1ac40e6e 	sdiv	w14, w19, w4
    b8a8:	1ac40fcd 	sdiv	w13, w30, w4
    b8ac:	1ac40e2c 	sdiv	w12, w17, w4
    b8b0:	1ac40deb 	sdiv	w11, w15, w4
    b8b4:	1b04cdce 	msub	w14, w14, w4, w19
    b8b8:	f9400bf3 	ldr	x19, [sp, #16]
    b8bc:	1b04f9ad 	msub	w13, w13, w4, w30
    b8c0:	1b04c58c 	msub	w12, w12, w4, w17
    b8c4:	1b103890 	madd	w16, w4, w16, w14
    b8c8:	1b073487 	madd	w7, w4, w7, w13
    b8cc:	1b083088 	madd	w8, w4, w8, w12
    b8d0:	1b04bd6b 	msub	w11, w11, w4, w15
    b8d4:	93407e10 	sxtw	x16, w16
    b8d8:	93407ce7 	sxtw	x7, w7
    b8dc:	93407d08 	sxtw	x8, w8
    b8e0:	9b0a2610 	madd	x16, x16, x10, x9
    b8e4:	1b122c84 	madd	w4, w4, w18, w11
    b8e8:	9b0a2508 	madd	x8, x8, x10, x9
    b8ec:	9b0a24e7 	madd	x7, x7, x10, x9
    b8f0:	93407c84 	sxtw	x4, w4
    b8f4:	9b0a2489 	madd	x9, x4, x10, x9
    b8f8:	93407c42 	sxtw	x2, w2
    b8fc:	3dc000f9 	ldr	q25, [x7]
    b900:	d2800204 	mov	x4, #0x10                  	// #16
    b904:	9b017c4a 	mul	x10, x2, x1
    b908:	3dc00105 	ldr	q5, [x8]
    b90c:	3dc0012f 	ldr	q15, [x9]
    b910:	8b0a002b 	add	x11, x1, x10
    b914:	8b0a000f 	add	x15, x0, x10
    b918:	8b0b0032 	add	x18, x1, x11
    b91c:	3cea681f 	ldr	q31, [x0, x10]
    b920:	8b0b000e 	add	x14, x0, x11
    b924:	8b120031 	add	x17, x1, x18
    b928:	8b12000d 	add	x13, x0, x18
    b92c:	8b11002a 	add	x10, x1, x17
    b930:	3dc00213 	ldr	q19, [x16]
    b934:	8b11000c 	add	x12, x0, x17
    b938:	8b0a0021 	add	x1, x1, x10
    b93c:	3ceb681e 	ldr	q30, [x0, x11]
    b940:	8b0a000b 	add	x11, x0, x10
    b944:	3cea681b 	ldr	q27, [x0, x10]
    b948:	6e5f1f38 	fmul	v24.8h, v25.8h, v31.8h
    b94c:	8b01000a 	add	x10, x0, x1
    b950:	6e5f1ca4 	fmul	v4.8h, v5.8h, v31.8h
    b954:	3ce1681a 	ldr	q26, [x0, x1]
    b958:	6e5f1e72 	fmul	v18.8h, v19.8h, v31.8h
    b95c:	6e5f1dff 	fmul	v31.8h, v15.8h, v31.8h
    b960:	3cf2681d 	ldr	q29, [x0, x18]
    b964:	6e5e1f37 	fmul	v23.8h, v25.8h, v30.8h
    b968:	6e5e1ca3 	fmul	v3.8h, v5.8h, v30.8h
    b96c:	3cf1681c 	ldr	q28, [x0, x17]
    b970:	6e591f74 	fmul	v20.8h, v27.8h, v25.8h
    b974:	6e451f60 	fmul	v0.8h, v27.8h, v5.8h
    b978:	6e5e1e71 	fmul	v17.8h, v19.8h, v30.8h
    b97c:	6e531f66 	fmul	v6.8h, v27.8h, v19.8h
    b980:	6e5d1f36 	fmul	v22.8h, v25.8h, v29.8h
    b984:	6e5d1ca2 	fmul	v2.8h, v5.8h, v29.8h
    b988:	6e591f95 	fmul	v21.8h, v28.8h, v25.8h
    b98c:	6e451f81 	fmul	v1.8h, v28.8h, v5.8h
    b990:	6e5d1e70 	fmul	v16.8h, v19.8h, v29.8h
    b994:	6e531f87 	fmul	v7.8h, v28.8h, v19.8h
    b998:	6e4f1f7b 	fmul	v27.8h, v27.8h, v15.8h
    b99c:	6e4f1f9c 	fmul	v28.8h, v28.8h, v15.8h
    b9a0:	6e5d1dfd 	fmul	v29.8h, v15.8h, v29.8h
    b9a4:	6e5e1dfe 	fmul	v30.8h, v15.8h, v30.8h
    b9a8:	6e591f59 	fmul	v25.8h, v26.8h, v25.8h
    b9ac:	6e451f45 	fmul	v5.8h, v26.8h, v5.8h
    b9b0:	6e531f53 	fmul	v19.8h, v26.8h, v19.8h
    b9b4:	6e4f1f4f 	fmul	v15.8h, v26.8h, v15.8h
    b9b8:	d503201f 	nop
    b9bc:	d503201f 	nop
    b9c0:	3ce468e8 	ldr	q8, [x7, x4]
    b9c4:	3ce46a1a 	ldr	q26, [x16, x4]
    b9c8:	3ce469ee 	ldr	q14, [x15, x4]
    b9cc:	3ce469cd 	ldr	q13, [x14, x4]
    b9d0:	3ce469ac 	ldr	q12, [x13, x4]
    b9d4:	3ce4698b 	ldr	q11, [x12, x4]
    b9d8:	4e4e0d18 	fmla	v24.8h, v8.8h, v14.8h
    b9dc:	3ce4696a 	ldr	q10, [x11, x4]
    b9e0:	4e4d0d17 	fmla	v23.8h, v8.8h, v13.8h
    b9e4:	3ce46949 	ldr	q9, [x10, x4]
    b9e8:	4e4c0d16 	fmla	v22.8h, v8.8h, v12.8h
    b9ec:	4e4b0d15 	fmla	v21.8h, v8.8h, v11.8h
    b9f0:	4e4a0d14 	fmla	v20.8h, v8.8h, v10.8h
    b9f4:	4e490d19 	fmla	v25.8h, v8.8h, v9.8h
    b9f8:	3ce46908 	ldr	q8, [x8, x4]
    b9fc:	4e4e0f52 	fmla	v18.8h, v26.8h, v14.8h
    ba00:	4e4d0f51 	fmla	v17.8h, v26.8h, v13.8h
    ba04:	4e4c0f50 	fmla	v16.8h, v26.8h, v12.8h
    ba08:	4e4b0f47 	fmla	v7.8h, v26.8h, v11.8h
    ba0c:	4e4a0f46 	fmla	v6.8h, v26.8h, v10.8h
    ba10:	4e490f53 	fmla	v19.8h, v26.8h, v9.8h
    ba14:	3ce4693a 	ldr	q26, [x9, x4]
    ba18:	91004084 	add	x4, x4, #0x10
    ba1c:	4e4e0d04 	fmla	v4.8h, v8.8h, v14.8h
    ba20:	4e4d0d03 	fmla	v3.8h, v8.8h, v13.8h
    ba24:	4e4c0d02 	fmla	v2.8h, v8.8h, v12.8h
    ba28:	4e4b0d01 	fmla	v1.8h, v8.8h, v11.8h
    ba2c:	4e4a0d00 	fmla	v0.8h, v8.8h, v10.8h
    ba30:	4e490d05 	fmla	v5.8h, v8.8h, v9.8h
    ba34:	4e4e0f5f 	fmla	v31.8h, v26.8h, v14.8h
    ba38:	4e4d0f5e 	fmla	v30.8h, v26.8h, v13.8h
    ba3c:	4e4c0f5d 	fmla	v29.8h, v26.8h, v12.8h
    ba40:	4e4b0f5c 	fmla	v28.8h, v26.8h, v11.8h
    ba44:	4e4a0f5b 	fmla	v27.8h, v26.8h, v10.8h
    ba48:	4e490f4f 	fmla	v15.8h, v26.8h, v9.8h
    ba4c:	f104009f 	cmp	x4, #0x100
    ba50:	54fffb81 	b.ne	b9c0 <_Z8qk_aheadPKcmiRK8DataInfo+0x190>  // b.any
    ba54:	5e18071a 	mov	d26, v24.d[1]
    ba58:	f9400060 	ldr	x0, [x3]
    ba5c:	93407cc4 	sxtw	x4, w6
    ba60:	f9400861 	ldr	x1, [x3, #16]
    ba64:	0e58175a 	fadd	v26.4h, v26.4h, v24.4h
    ba68:	0e217b5a 	fcvtl	v26.4s, v26.4h
    ba6c:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    ba70:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    ba74:	b4003445 	cbz	x5, c0fc <_Z8qk_aheadPKcmiRK8DataInfo+0x8cc>
    ba78:	d37df087 	lsl	x7, x4, #3
    ba7c:	8b040ca4 	add	x4, x5, x4, lsl #3
    ba80:	f9401869 	ldr	x9, [x3, #48]
    ba84:	b8a768a8 	ldrsw	x8, [x5, x7]
    ba88:	b9800487 	ldrsw	x7, [x4, #4]
    ba8c:	9b017d04 	mul	x4, x8, x1
    ba90:	9b0910e7 	madd	x7, x7, x9, x4
    ba94:	8b070807 	add	x7, x0, x7, lsl #2
    ba98:	d37ef442 	lsl	x2, x2, #2
    ba9c:	93407cc4 	sxtw	x4, w6
    baa0:	bc2268fa 	str	s26, [x7, x2]
    baa4:	5e1806fa 	mov	d26, v23.d[1]
    baa8:	0e57175a 	fadd	v26.4h, v26.4h, v23.4h
    baac:	0e217b5a 	fcvtl	v26.4s, v26.4h
    bab0:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    bab4:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    bab8:	b4003285 	cbz	x5, c108 <_Z8qk_aheadPKcmiRK8DataInfo+0x8d8>
    babc:	d37df087 	lsl	x7, x4, #3
    bac0:	8b040ca4 	add	x4, x5, x4, lsl #3
    bac4:	f9401869 	ldr	x9, [x3, #48]
    bac8:	b8a768a8 	ldrsw	x8, [x5, x7]
    bacc:	b9800487 	ldrsw	x7, [x4, #4]
    bad0:	9b017d04 	mul	x4, x8, x1
    bad4:	9b0910e7 	madd	x7, x7, x9, x4
    bad8:	8b070807 	add	x7, x0, x7, lsl #2
    badc:	9100104b 	add	x11, x2, #0x4
    bae0:	93407cc4 	sxtw	x4, w6
    bae4:	bc2b68fa 	str	s26, [x7, x11]
    bae8:	5e1806da 	mov	d26, v22.d[1]
    baec:	0e56175a 	fadd	v26.4h, v26.4h, v22.4h
    baf0:	0e217b5a 	fcvtl	v26.4s, v26.4h
    baf4:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    baf8:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    bafc:	b40030c5 	cbz	x5, c114 <_Z8qk_aheadPKcmiRK8DataInfo+0x8e4>
    bb00:	d37df087 	lsl	x7, x4, #3
    bb04:	8b040ca4 	add	x4, x5, x4, lsl #3
    bb08:	f9401869 	ldr	x9, [x3, #48]
    bb0c:	b8a768a8 	ldrsw	x8, [x5, x7]
    bb10:	b9800487 	ldrsw	x7, [x4, #4]
    bb14:	9b017d04 	mul	x4, x8, x1
    bb18:	9b0910e7 	madd	x7, x7, x9, x4
    bb1c:	8b070807 	add	x7, x0, x7, lsl #2
    bb20:	9100204a 	add	x10, x2, #0x8
    bb24:	93407cc4 	sxtw	x4, w6
    bb28:	bc2a68fa 	str	s26, [x7, x10]
    bb2c:	5e1806ba 	mov	d26, v21.d[1]
    bb30:	0e55175a 	fadd	v26.4h, v26.4h, v21.4h
    bb34:	0e217b5a 	fcvtl	v26.4s, v26.4h
    bb38:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    bb3c:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    bb40:	b4002f05 	cbz	x5, c120 <_Z8qk_aheadPKcmiRK8DataInfo+0x8f0>
    bb44:	d37df087 	lsl	x7, x4, #3
    bb48:	8b040ca4 	add	x4, x5, x4, lsl #3
    bb4c:	f9401869 	ldr	x9, [x3, #48]
    bb50:	b8a768a8 	ldrsw	x8, [x5, x7]
    bb54:	b9800487 	ldrsw	x7, [x4, #4]
    bb58:	9b017d04 	mul	x4, x8, x1
    bb5c:	9b0910e7 	madd	x7, x7, x9, x4
    bb60:	8b070807 	add	x7, x0, x7, lsl #2
    bb64:	91003048 	add	x8, x2, #0xc
    bb68:	93407cc4 	sxtw	x4, w6
    bb6c:	bc2868fa 	str	s26, [x7, x8]
    bb70:	5e18069a 	mov	d26, v20.d[1]
    bb74:	0e54175a 	fadd	v26.4h, v26.4h, v20.4h
    bb78:	0e217b5a 	fcvtl	v26.4s, v26.4h
    bb7c:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    bb80:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    bb84:	b4002d45 	cbz	x5, c12c <_Z8qk_aheadPKcmiRK8DataInfo+0x8fc>
    bb88:	d37df087 	lsl	x7, x4, #3
    bb8c:	8b040ca4 	add	x4, x5, x4, lsl #3
    bb90:	f940186c 	ldr	x12, [x3, #48]
    bb94:	b8a768a7 	ldrsw	x7, [x5, x7]
    bb98:	b9800489 	ldrsw	x9, [x4, #4]
    bb9c:	9b017ce4 	mul	x4, x7, x1
    bba0:	9b0c1129 	madd	x9, x9, x12, x4
    bba4:	8b090809 	add	x9, x0, x9, lsl #2
    bba8:	91004047 	add	x7, x2, #0x10
    bbac:	93407cc4 	sxtw	x4, w6
    bbb0:	bc27693a 	str	s26, [x9, x7]
    bbb4:	5e18073a 	mov	d26, v25.d[1]
    bbb8:	0e59175a 	fadd	v26.4h, v26.4h, v25.4h
    bbbc:	0e217b5a 	fcvtl	v26.4s, v26.4h
    bbc0:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    bbc4:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    bbc8:	b4002b85 	cbz	x5, c138 <_Z8qk_aheadPKcmiRK8DataInfo+0x908>
    bbcc:	d37df089 	lsl	x9, x4, #3
    bbd0:	8b040ca4 	add	x4, x5, x4, lsl #3
    bbd4:	f940186d 	ldr	x13, [x3, #48]
    bbd8:	b8a968a9 	ldrsw	x9, [x5, x9]
    bbdc:	b980048c 	ldrsw	x12, [x4, #4]
    bbe0:	9b017d24 	mul	x4, x9, x1
    bbe4:	9b0d118c 	madd	x12, x12, x13, x4
    bbe8:	8b0c080c 	add	x12, x0, x12, lsl #2
    bbec:	91005044 	add	x4, x2, #0x14
    bbf0:	110004c9 	add	w9, w6, #0x1
    bbf4:	93407d29 	sxtw	x9, w9
    bbf8:	bc24699a 	str	s26, [x12, x4]
    bbfc:	5e18065a 	mov	d26, v18.d[1]
    bc00:	0e52175a 	fadd	v26.4h, v26.4h, v18.4h
    bc04:	0e217b5a 	fcvtl	v26.4s, v26.4h
    bc08:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    bc0c:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    bc10:	b40029a5 	cbz	x5, c144 <_Z8qk_aheadPKcmiRK8DataInfo+0x914>
    bc14:	d37df12c 	lsl	x12, x9, #3
    bc18:	8b090ca9 	add	x9, x5, x9, lsl #3
    bc1c:	f940186d 	ldr	x13, [x3, #48]
    bc20:	b8ac68ac 	ldrsw	x12, [x5, x12]
    bc24:	b9800529 	ldrsw	x9, [x9, #4]
    bc28:	9b017d8c 	mul	x12, x12, x1
    bc2c:	9b0d3129 	madd	x9, x9, x13, x12
    bc30:	8b090809 	add	x9, x0, x9, lsl #2
    bc34:	bc22693a 	str	s26, [x9, x2]
    bc38:	5e18063a 	mov	d26, v17.d[1]
    bc3c:	110004c9 	add	w9, w6, #0x1
    bc40:	93407d29 	sxtw	x9, w9
    bc44:	0e51175a 	fadd	v26.4h, v26.4h, v17.4h
    bc48:	0e217b5a 	fcvtl	v26.4s, v26.4h
    bc4c:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    bc50:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    bc54:	b40027e5 	cbz	x5, c150 <_Z8qk_aheadPKcmiRK8DataInfo+0x920>
    bc58:	d37df12c 	lsl	x12, x9, #3
    bc5c:	8b090ca9 	add	x9, x5, x9, lsl #3
    bc60:	f940186d 	ldr	x13, [x3, #48]
    bc64:	b8ac68ac 	ldrsw	x12, [x5, x12]
    bc68:	b9800529 	ldrsw	x9, [x9, #4]
    bc6c:	9b017d8c 	mul	x12, x12, x1
    bc70:	9b0d3129 	madd	x9, x9, x13, x12
    bc74:	8b090809 	add	x9, x0, x9, lsl #2
    bc78:	bc2b693a 	str	s26, [x9, x11]
    bc7c:	5e18061a 	mov	d26, v16.d[1]
    bc80:	110004c9 	add	w9, w6, #0x1
    bc84:	93407d29 	sxtw	x9, w9
    bc88:	0e50175a 	fadd	v26.4h, v26.4h, v16.4h
    bc8c:	0e217b5a 	fcvtl	v26.4s, v26.4h
    bc90:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    bc94:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    bc98:	b4002625 	cbz	x5, c15c <_Z8qk_aheadPKcmiRK8DataInfo+0x92c>
    bc9c:	d37df12c 	lsl	x12, x9, #3
    bca0:	8b090ca9 	add	x9, x5, x9, lsl #3
    bca4:	f940186d 	ldr	x13, [x3, #48]
    bca8:	b8ac68ac 	ldrsw	x12, [x5, x12]
    bcac:	b9800529 	ldrsw	x9, [x9, #4]
    bcb0:	9b017d8c 	mul	x12, x12, x1
    bcb4:	9b0d3129 	madd	x9, x9, x13, x12
    bcb8:	8b090809 	add	x9, x0, x9, lsl #2
    bcbc:	bc2a693a 	str	s26, [x9, x10]
    bcc0:	5e1804fa 	mov	d26, v7.d[1]
    bcc4:	110004c9 	add	w9, w6, #0x1
    bcc8:	93407d29 	sxtw	x9, w9
    bccc:	0e47175a 	fadd	v26.4h, v26.4h, v7.4h
    bcd0:	0e217b5a 	fcvtl	v26.4s, v26.4h
    bcd4:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    bcd8:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    bcdc:	b4002465 	cbz	x5, c168 <_Z8qk_aheadPKcmiRK8DataInfo+0x938>
    bce0:	d37df12c 	lsl	x12, x9, #3
    bce4:	8b090ca9 	add	x9, x5, x9, lsl #3
    bce8:	f940186d 	ldr	x13, [x3, #48]
    bcec:	b8ac68ac 	ldrsw	x12, [x5, x12]
    bcf0:	b9800529 	ldrsw	x9, [x9, #4]
    bcf4:	9b017d8c 	mul	x12, x12, x1
    bcf8:	9b0d3129 	madd	x9, x9, x13, x12
    bcfc:	8b090809 	add	x9, x0, x9, lsl #2
    bd00:	bc28693a 	str	s26, [x9, x8]
    bd04:	5e1804da 	mov	d26, v6.d[1]
    bd08:	110004c9 	add	w9, w6, #0x1
    bd0c:	93407d29 	sxtw	x9, w9
    bd10:	0e46175a 	fadd	v26.4h, v26.4h, v6.4h
    bd14:	0e217b5a 	fcvtl	v26.4s, v26.4h
    bd18:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    bd1c:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    bd20:	b40022a5 	cbz	x5, c174 <_Z8qk_aheadPKcmiRK8DataInfo+0x944>
    bd24:	d37df12c 	lsl	x12, x9, #3
    bd28:	8b090ca9 	add	x9, x5, x9, lsl #3
    bd2c:	f940186d 	ldr	x13, [x3, #48]
    bd30:	b8ac68ac 	ldrsw	x12, [x5, x12]
    bd34:	b9800529 	ldrsw	x9, [x9, #4]
    bd38:	9b017d8c 	mul	x12, x12, x1
    bd3c:	9b0d3129 	madd	x9, x9, x13, x12
    bd40:	8b090809 	add	x9, x0, x9, lsl #2
    bd44:	bc27693a 	str	s26, [x9, x7]
    bd48:	5e18067a 	mov	d26, v19.d[1]
    bd4c:	110004c9 	add	w9, w6, #0x1
    bd50:	93407d29 	sxtw	x9, w9
    bd54:	0e53175a 	fadd	v26.4h, v26.4h, v19.4h
    bd58:	0e217b5a 	fcvtl	v26.4s, v26.4h
    bd5c:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    bd60:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    bd64:	b40020e5 	cbz	x5, c180 <_Z8qk_aheadPKcmiRK8DataInfo+0x950>
    bd68:	d37df12c 	lsl	x12, x9, #3
    bd6c:	8b090ca9 	add	x9, x5, x9, lsl #3
    bd70:	f940186d 	ldr	x13, [x3, #48]
    bd74:	b8ac68ac 	ldrsw	x12, [x5, x12]
    bd78:	b9800529 	ldrsw	x9, [x9, #4]
    bd7c:	9b017d8c 	mul	x12, x12, x1
    bd80:	9b0d3129 	madd	x9, x9, x13, x12
    bd84:	8b090809 	add	x9, x0, x9, lsl #2
    bd88:	bc24693a 	str	s26, [x9, x4]
    bd8c:	5e18049a 	mov	d26, v4.d[1]
    bd90:	110008c9 	add	w9, w6, #0x2
    bd94:	93407d29 	sxtw	x9, w9
    bd98:	0e44175a 	fadd	v26.4h, v26.4h, v4.4h
    bd9c:	0e217b5a 	fcvtl	v26.4s, v26.4h
    bda0:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    bda4:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    bda8:	b4001f25 	cbz	x5, c18c <_Z8qk_aheadPKcmiRK8DataInfo+0x95c>
    bdac:	d37df12c 	lsl	x12, x9, #3
    bdb0:	8b090ca9 	add	x9, x5, x9, lsl #3
    bdb4:	f940186d 	ldr	x13, [x3, #48]
    bdb8:	b8ac68ac 	ldrsw	x12, [x5, x12]
    bdbc:	b9800529 	ldrsw	x9, [x9, #4]
    bdc0:	9b017d8c 	mul	x12, x12, x1
    bdc4:	9b0d3129 	madd	x9, x9, x13, x12
    bdc8:	8b090809 	add	x9, x0, x9, lsl #2
    bdcc:	bc22693a 	str	s26, [x9, x2]
    bdd0:	5e18047a 	mov	d26, v3.d[1]
    bdd4:	110008c9 	add	w9, w6, #0x2
    bdd8:	93407d29 	sxtw	x9, w9
    bddc:	0e43175a 	fadd	v26.4h, v26.4h, v3.4h
    bde0:	0e217b5a 	fcvtl	v26.4s, v26.4h
    bde4:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    bde8:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    bdec:	b4001d65 	cbz	x5, c198 <_Z8qk_aheadPKcmiRK8DataInfo+0x968>
    bdf0:	d37df12c 	lsl	x12, x9, #3
    bdf4:	8b090ca9 	add	x9, x5, x9, lsl #3
    bdf8:	f940186d 	ldr	x13, [x3, #48]
    bdfc:	b8ac68ac 	ldrsw	x12, [x5, x12]
    be00:	b9800529 	ldrsw	x9, [x9, #4]
    be04:	9b017d8c 	mul	x12, x12, x1
    be08:	9b0d3129 	madd	x9, x9, x13, x12
    be0c:	8b090809 	add	x9, x0, x9, lsl #2
    be10:	bc2b693a 	str	s26, [x9, x11]
    be14:	5e18045a 	mov	d26, v2.d[1]
    be18:	110008c9 	add	w9, w6, #0x2
    be1c:	93407d29 	sxtw	x9, w9
    be20:	0e42175a 	fadd	v26.4h, v26.4h, v2.4h
    be24:	0e217b5a 	fcvtl	v26.4s, v26.4h
    be28:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    be2c:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    be30:	b4001ba5 	cbz	x5, c1a4 <_Z8qk_aheadPKcmiRK8DataInfo+0x974>
    be34:	d37df12c 	lsl	x12, x9, #3
    be38:	8b090ca9 	add	x9, x5, x9, lsl #3
    be3c:	f940186d 	ldr	x13, [x3, #48]
    be40:	b8ac68ac 	ldrsw	x12, [x5, x12]
    be44:	b9800529 	ldrsw	x9, [x9, #4]
    be48:	9b017d8c 	mul	x12, x12, x1
    be4c:	9b0d3129 	madd	x9, x9, x13, x12
    be50:	8b090809 	add	x9, x0, x9, lsl #2
    be54:	bc2a693a 	str	s26, [x9, x10]
    be58:	5e18043a 	mov	d26, v1.d[1]
    be5c:	110008c9 	add	w9, w6, #0x2
    be60:	93407d29 	sxtw	x9, w9
    be64:	0e41175a 	fadd	v26.4h, v26.4h, v1.4h
    be68:	0e217b5a 	fcvtl	v26.4s, v26.4h
    be6c:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    be70:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    be74:	b40019e5 	cbz	x5, c1b0 <_Z8qk_aheadPKcmiRK8DataInfo+0x980>
    be78:	d37df12c 	lsl	x12, x9, #3
    be7c:	8b090ca9 	add	x9, x5, x9, lsl #3
    be80:	f940186d 	ldr	x13, [x3, #48]
    be84:	b8ac68ac 	ldrsw	x12, [x5, x12]
    be88:	b9800529 	ldrsw	x9, [x9, #4]
    be8c:	9b017d8c 	mul	x12, x12, x1
    be90:	9b0d3129 	madd	x9, x9, x13, x12
    be94:	8b090809 	add	x9, x0, x9, lsl #2
    be98:	bc28693a 	str	s26, [x9, x8]
    be9c:	5e18041a 	mov	d26, v0.d[1]
    bea0:	110008c9 	add	w9, w6, #0x2
    bea4:	93407d29 	sxtw	x9, w9
    bea8:	0e40175a 	fadd	v26.4h, v26.4h, v0.4h
    beac:	0e217b5a 	fcvtl	v26.4s, v26.4h
    beb0:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    beb4:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    beb8:	b4001825 	cbz	x5, c1bc <_Z8qk_aheadPKcmiRK8DataInfo+0x98c>
    bebc:	d37df12c 	lsl	x12, x9, #3
    bec0:	8b090ca9 	add	x9, x5, x9, lsl #3
    bec4:	f940186d 	ldr	x13, [x3, #48]
    bec8:	b8ac68ac 	ldrsw	x12, [x5, x12]
    becc:	b9800529 	ldrsw	x9, [x9, #4]
    bed0:	9b017d8c 	mul	x12, x12, x1
    bed4:	9b0d3129 	madd	x9, x9, x13, x12
    bed8:	8b090809 	add	x9, x0, x9, lsl #2
    bedc:	bc27693a 	str	s26, [x9, x7]
    bee0:	5e1804ba 	mov	d26, v5.d[1]
    bee4:	110008c9 	add	w9, w6, #0x2
    bee8:	93407d29 	sxtw	x9, w9
    beec:	0e45175a 	fadd	v26.4h, v26.4h, v5.4h
    bef0:	0e217b5a 	fcvtl	v26.4s, v26.4h
    bef4:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    bef8:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    befc:	b4001665 	cbz	x5, c1c8 <_Z8qk_aheadPKcmiRK8DataInfo+0x998>
    bf00:	d37df12c 	lsl	x12, x9, #3
    bf04:	8b090ca9 	add	x9, x5, x9, lsl #3
    bf08:	f940186d 	ldr	x13, [x3, #48]
    bf0c:	b8ac68ac 	ldrsw	x12, [x5, x12]
    bf10:	b9800529 	ldrsw	x9, [x9, #4]
    bf14:	9b017d8c 	mul	x12, x12, x1
    bf18:	9b0d3129 	madd	x9, x9, x13, x12
    bf1c:	8b090809 	add	x9, x0, x9, lsl #2
    bf20:	bc24693a 	str	s26, [x9, x4]
    bf24:	5e1807fa 	mov	d26, v31.d[1]
    bf28:	11000cc9 	add	w9, w6, #0x3
    bf2c:	93407d29 	sxtw	x9, w9
    bf30:	0e5f175a 	fadd	v26.4h, v26.4h, v31.4h
    bf34:	0e217b5a 	fcvtl	v26.4s, v26.4h
    bf38:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    bf3c:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    bf40:	b40014a5 	cbz	x5, c1d4 <_Z8qk_aheadPKcmiRK8DataInfo+0x9a4>
    bf44:	d37df12c 	lsl	x12, x9, #3
    bf48:	8b090ca9 	add	x9, x5, x9, lsl #3
    bf4c:	f940186d 	ldr	x13, [x3, #48]
    bf50:	b8ac68ac 	ldrsw	x12, [x5, x12]
    bf54:	b9800529 	ldrsw	x9, [x9, #4]
    bf58:	9b017d8c 	mul	x12, x12, x1
    bf5c:	9b0d3129 	madd	x9, x9, x13, x12
    bf60:	8b090809 	add	x9, x0, x9, lsl #2
    bf64:	bc22693a 	str	s26, [x9, x2]
    bf68:	5e1807da 	mov	d26, v30.d[1]
    bf6c:	11000cc2 	add	w2, w6, #0x3
    bf70:	93407c42 	sxtw	x2, w2
    bf74:	0e5e175a 	fadd	v26.4h, v26.4h, v30.4h
    bf78:	0e217b5a 	fcvtl	v26.4s, v26.4h
    bf7c:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    bf80:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    bf84:	b40012e5 	cbz	x5, c1e0 <_Z8qk_aheadPKcmiRK8DataInfo+0x9b0>
    bf88:	d37df049 	lsl	x9, x2, #3
    bf8c:	8b020ca2 	add	x2, x5, x2, lsl #3
    bf90:	f940186c 	ldr	x12, [x3, #48]
    bf94:	b8a968a9 	ldrsw	x9, [x5, x9]
    bf98:	b9800442 	ldrsw	x2, [x2, #4]
    bf9c:	9b017d29 	mul	x9, x9, x1
    bfa0:	9b0c2442 	madd	x2, x2, x12, x9
    bfa4:	8b020802 	add	x2, x0, x2, lsl #2
    bfa8:	bc2b685a 	str	s26, [x2, x11]
    bfac:	5e1807ba 	mov	d26, v29.d[1]
    bfb0:	11000cc2 	add	w2, w6, #0x3
    bfb4:	93407c42 	sxtw	x2, w2
    bfb8:	0e5d175a 	fadd	v26.4h, v26.4h, v29.4h
    bfbc:	0e217b5a 	fcvtl	v26.4s, v26.4h
    bfc0:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    bfc4:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    bfc8:	b4001125 	cbz	x5, c1ec <_Z8qk_aheadPKcmiRK8DataInfo+0x9bc>
    bfcc:	d37df049 	lsl	x9, x2, #3
    bfd0:	8b020ca2 	add	x2, x5, x2, lsl #3
    bfd4:	f940186b 	ldr	x11, [x3, #48]
    bfd8:	b8a968a9 	ldrsw	x9, [x5, x9]
    bfdc:	b9800442 	ldrsw	x2, [x2, #4]
    bfe0:	9b017d29 	mul	x9, x9, x1
    bfe4:	9b0b2442 	madd	x2, x2, x11, x9
    bfe8:	8b020802 	add	x2, x0, x2, lsl #2
    bfec:	bc2a685a 	str	s26, [x2, x10]
    bff0:	5e18079a 	mov	d26, v28.d[1]
    bff4:	11000cc2 	add	w2, w6, #0x3
    bff8:	93407c42 	sxtw	x2, w2
    bffc:	0e5c175a 	fadd	v26.4h, v26.4h, v28.4h
    c000:	0e217b5a 	fcvtl	v26.4s, v26.4h
    c004:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    c008:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    c00c:	b4000f65 	cbz	x5, c1f8 <_Z8qk_aheadPKcmiRK8DataInfo+0x9c8>
    c010:	d37df049 	lsl	x9, x2, #3
    c014:	8b020ca2 	add	x2, x5, x2, lsl #3
    c018:	f940186a 	ldr	x10, [x3, #48]
    c01c:	b8a968a9 	ldrsw	x9, [x5, x9]
    c020:	b9800442 	ldrsw	x2, [x2, #4]
    c024:	9b017d29 	mul	x9, x9, x1
    c028:	9b0a2442 	madd	x2, x2, x10, x9
    c02c:	8b020802 	add	x2, x0, x2, lsl #2
    c030:	bc28685a 	str	s26, [x2, x8]
    c034:	5e18077a 	mov	d26, v27.d[1]
    c038:	11000cc2 	add	w2, w6, #0x3
    c03c:	93407c42 	sxtw	x2, w2
    c040:	0e5b175a 	fadd	v26.4h, v26.4h, v27.4h
    c044:	0e217b5a 	fcvtl	v26.4s, v26.4h
    c048:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    c04c:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    c050:	b4000da5 	cbz	x5, c204 <_Z8qk_aheadPKcmiRK8DataInfo+0x9d4>
    c054:	d37df048 	lsl	x8, x2, #3
    c058:	8b020ca2 	add	x2, x5, x2, lsl #3
    c05c:	f9401869 	ldr	x9, [x3, #48]
    c060:	b8a868a8 	ldrsw	x8, [x5, x8]
    c064:	b9800442 	ldrsw	x2, [x2, #4]
    c068:	9b017d08 	mul	x8, x8, x1
    c06c:	9b092042 	madd	x2, x2, x9, x8
    c070:	8b020802 	add	x2, x0, x2, lsl #2
    c074:	bc27685a 	str	s26, [x2, x7]
    c078:	5e1805fa 	mov	d26, v15.d[1]
    c07c:	11000cc6 	add	w6, w6, #0x3
    c080:	93407cc6 	sxtw	x6, w6
    c084:	0e4f175a 	fadd	v26.4h, v26.4h, v15.4h
    c088:	0e217b5a 	fcvtl	v26.4s, v26.4h
    c08c:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    c090:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    c094:	b4000be5 	cbz	x5, c210 <_Z8qk_aheadPKcmiRK8DataInfo+0x9e0>
    c098:	d37df0c2 	lsl	x2, x6, #3
    c09c:	f9401867 	ldr	x7, [x3, #48]
    c0a0:	8b060ca6 	add	x6, x5, x6, lsl #3
    c0a4:	b8a268a3 	ldrsw	x3, [x5, x2]
    c0a8:	b98004c2 	ldrsw	x2, [x6, #4]
    c0ac:	9b017c61 	mul	x1, x3, x1
    c0b0:	9b070441 	madd	x1, x2, x7, x1
    c0b4:	8b010800 	add	x0, x0, x1, lsl #2
    c0b8:	bc24681a 	str	s26, [x0, x4]
    c0bc:	6d4227e8 	ldp	d8, d9, [sp, #32]
    c0c0:	6d432fea 	ldp	d10, d11, [sp, #48]
    c0c4:	6d4437ec 	ldp	d12, d13, [sp, #64]
    c0c8:	6d453fee 	ldp	d14, d15, [sp, #80]
    c0cc:	a8c67bfd 	ldp	x29, x30, [sp], #96
    c0d0:	d65f03c0 	ret
    c0d4:	93407cc7 	sxtw	x7, w6
    c0d8:	9b0a7ce7 	mul	x7, x7, x10
    c0dc:	8b0a00f0 	add	x16, x7, x10
    c0e0:	8b070127 	add	x7, x9, x7
    c0e4:	8b0a0208 	add	x8, x16, x10
    c0e8:	8b100130 	add	x16, x9, x16
    c0ec:	8b0a010a 	add	x10, x8, x10
    c0f0:	8b080128 	add	x8, x9, x8
    c0f4:	8b0a0129 	add	x9, x9, x10
    c0f8:	17fffe00 	b	b8f8 <_Z8qk_aheadPKcmiRK8DataInfo+0xc8>
    c0fc:	9b017c84 	mul	x4, x4, x1
    c100:	8b040807 	add	x7, x0, x4, lsl #2
    c104:	17fffe65 	b	ba98 <_Z8qk_aheadPKcmiRK8DataInfo+0x268>
    c108:	9b017c84 	mul	x4, x4, x1
    c10c:	8b040807 	add	x7, x0, x4, lsl #2
    c110:	17fffe73 	b	badc <_Z8qk_aheadPKcmiRK8DataInfo+0x2ac>
    c114:	9b017c84 	mul	x4, x4, x1
    c118:	8b040807 	add	x7, x0, x4, lsl #2
    c11c:	17fffe81 	b	bb20 <_Z8qk_aheadPKcmiRK8DataInfo+0x2f0>
    c120:	9b017c84 	mul	x4, x4, x1
    c124:	8b040807 	add	x7, x0, x4, lsl #2
    c128:	17fffe8f 	b	bb64 <_Z8qk_aheadPKcmiRK8DataInfo+0x334>
    c12c:	9b017c84 	mul	x4, x4, x1
    c130:	8b040809 	add	x9, x0, x4, lsl #2
    c134:	17fffe9d 	b	bba8 <_Z8qk_aheadPKcmiRK8DataInfo+0x378>
    c138:	9b017c84 	mul	x4, x4, x1
    c13c:	8b04080c 	add	x12, x0, x4, lsl #2
    c140:	17fffeab 	b	bbec <_Z8qk_aheadPKcmiRK8DataInfo+0x3bc>
    c144:	9b017d29 	mul	x9, x9, x1
    c148:	8b090809 	add	x9, x0, x9, lsl #2
    c14c:	17fffeba 	b	bc34 <_Z8qk_aheadPKcmiRK8DataInfo+0x404>
    c150:	9b017d29 	mul	x9, x9, x1
    c154:	8b090809 	add	x9, x0, x9, lsl #2
    c158:	17fffec8 	b	bc78 <_Z8qk_aheadPKcmiRK8DataInfo+0x448>
    c15c:	9b017d29 	mul	x9, x9, x1
    c160:	8b090809 	add	x9, x0, x9, lsl #2
    c164:	17fffed6 	b	bcbc <_Z8qk_aheadPKcmiRK8DataInfo+0x48c>
    c168:	9b017d29 	mul	x9, x9, x1
    c16c:	8b090809 	add	x9, x0, x9, lsl #2
    c170:	17fffee4 	b	bd00 <_Z8qk_aheadPKcmiRK8DataInfo+0x4d0>
    c174:	9b017d29 	mul	x9, x9, x1
    c178:	8b090809 	add	x9, x0, x9, lsl #2
    c17c:	17fffef2 	b	bd44 <_Z8qk_aheadPKcmiRK8DataInfo+0x514>
    c180:	9b017d29 	mul	x9, x9, x1
    c184:	8b090809 	add	x9, x0, x9, lsl #2
    c188:	17ffff00 	b	bd88 <_Z8qk_aheadPKcmiRK8DataInfo+0x558>
    c18c:	9b017d29 	mul	x9, x9, x1
    c190:	8b090809 	add	x9, x0, x9, lsl #2
    c194:	17ffff0e 	b	bdcc <_Z8qk_aheadPKcmiRK8DataInfo+0x59c>
    c198:	9b017d29 	mul	x9, x9, x1
    c19c:	8b090809 	add	x9, x0, x9, lsl #2
    c1a0:	17ffff1c 	b	be10 <_Z8qk_aheadPKcmiRK8DataInfo+0x5e0>
    c1a4:	9b017d29 	mul	x9, x9, x1
    c1a8:	8b090809 	add	x9, x0, x9, lsl #2
    c1ac:	17ffff2a 	b	be54 <_Z8qk_aheadPKcmiRK8DataInfo+0x624>
    c1b0:	9b017d29 	mul	x9, x9, x1
    c1b4:	8b090809 	add	x9, x0, x9, lsl #2
    c1b8:	17ffff38 	b	be98 <_Z8qk_aheadPKcmiRK8DataInfo+0x668>
    c1bc:	9b017d29 	mul	x9, x9, x1
    c1c0:	8b090809 	add	x9, x0, x9, lsl #2
    c1c4:	17ffff46 	b	bedc <_Z8qk_aheadPKcmiRK8DataInfo+0x6ac>
    c1c8:	9b017d29 	mul	x9, x9, x1
    c1cc:	8b090809 	add	x9, x0, x9, lsl #2
    c1d0:	17ffff54 	b	bf20 <_Z8qk_aheadPKcmiRK8DataInfo+0x6f0>
    c1d4:	9b017d29 	mul	x9, x9, x1
    c1d8:	8b090809 	add	x9, x0, x9, lsl #2
    c1dc:	17ffff62 	b	bf64 <_Z8qk_aheadPKcmiRK8DataInfo+0x734>
    c1e0:	9b017c42 	mul	x2, x2, x1
    c1e4:	8b020802 	add	x2, x0, x2, lsl #2
    c1e8:	17ffff70 	b	bfa8 <_Z8qk_aheadPKcmiRK8DataInfo+0x778>
    c1ec:	9b017c42 	mul	x2, x2, x1
    c1f0:	8b020802 	add	x2, x0, x2, lsl #2
    c1f4:	17ffff7e 	b	bfec <_Z8qk_aheadPKcmiRK8DataInfo+0x7bc>
    c1f8:	9b017c42 	mul	x2, x2, x1
    c1fc:	8b020802 	add	x2, x0, x2, lsl #2
    c200:	17ffff8c 	b	c030 <_Z8qk_aheadPKcmiRK8DataInfo+0x800>
    c204:	9b017c42 	mul	x2, x2, x1
    c208:	8b020802 	add	x2, x0, x2, lsl #2
    c20c:	17ffff9a 	b	c074 <_Z8qk_aheadPKcmiRK8DataInfo+0x844>
    c210:	9b017cc6 	mul	x6, x6, x1
    c214:	8b060800 	add	x0, x0, x6, lsl #2
    c218:	bc24681a 	str	s26, [x0, x4]
    c21c:	6d4227e8 	ldp	d8, d9, [sp, #32]
    c220:	6d432fea 	ldp	d10, d11, [sp, #48]
    c224:	6d4437ec 	ldp	d12, d13, [sp, #64]
    c228:	6d453fee 	ldp	d14, d15, [sp, #80]
    c22c:	a8c67bfd 	ldp	x29, x30, [sp], #96
    c230:	d65f03c0 	ret

Disassembly of section .fini:
