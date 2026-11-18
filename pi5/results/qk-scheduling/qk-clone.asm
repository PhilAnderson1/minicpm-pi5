
/home/philip/minicpm-pi5/build-qk-scheduling/bench:     file format elf64-littleaarch64


Disassembly of section .init:

Disassembly of section .plt:

Disassembly of section .text:

0000000000009f80 <_Z8qk_clonePKcmiRK8DataInfo>:
    9f80:	a9bb7bfd 	stp	x29, x30, [sp, #-80]!
    9f84:	910003fd 	mov	x29, sp
    9f88:	6d022be9 	stp	d9, d10, [sp, #32]
    9f8c:	6d0333eb 	stp	d11, d12, [sp, #48]
    9f90:	6d043bed 	stp	d13, d14, [sp, #64]
    9f94:	f9400469 	ldr	x9, [x3, #8]
    9f98:	f9400c6a 	ldr	x10, [x3, #24]
    9f9c:	f9401465 	ldr	x5, [x3, #40]
    9fa0:	b9402066 	ldr	w6, [x3, #32]
    9fa4:	fd000fef 	str	d15, [sp, #24]
    9fa8:	b40043a5 	cbz	x5, a81c <_Z8qk_clonePKcmiRK8DataInfo+0x89c>
    9fac:	937d7cc4 	sbfiz	x4, x6, #3, #32
    9fb0:	91002087 	add	x7, x4, #0x8
    9fb4:	9100408b 	add	x11, x4, #0x10
    9fb8:	b86468be 	ldr	w30, [x5, x4]
    9fbc:	91006088 	add	x8, x4, #0x18
    9fc0:	8b0700ae 	add	x14, x5, x7
    9fc4:	8b0b00ad 	add	x13, x5, x11
    9fc8:	8b0800ac 	add	x12, x5, x8
    9fcc:	b86b68b1 	ldr	w17, [x5, x11]
    9fd0:	b86868af 	ldr	w15, [x5, x8]
    9fd4:	b9400592 	ldr	w18, [x12, #4]
    9fd8:	b94005a8 	ldr	w8, [x13, #4]
    9fdc:	b94005d0 	ldr	w16, [x14, #4]
    9fe0:	f9000bf3 	str	x19, [sp, #16]
    9fe4:	b86768b3 	ldr	w19, [x5, x7]
    9fe8:	8b0400a7 	add	x7, x5, x4
    9fec:	b9402464 	ldr	w4, [x3, #36]
    9ff0:	b94004e7 	ldr	w7, [x7, #4]
    9ff4:	1ac40e6e 	sdiv	w14, w19, w4
    9ff8:	1ac40fcd 	sdiv	w13, w30, w4
    9ffc:	1ac40e2c 	sdiv	w12, w17, w4
    a000:	1ac40deb 	sdiv	w11, w15, w4
    a004:	1b04cdce 	msub	w14, w14, w4, w19
    a008:	f9400bf3 	ldr	x19, [sp, #16]
    a00c:	1b04f9ad 	msub	w13, w13, w4, w30
    a010:	1b04c58c 	msub	w12, w12, w4, w17
    a014:	1b103890 	madd	w16, w4, w16, w14
    a018:	1b073487 	madd	w7, w4, w7, w13
    a01c:	1b083088 	madd	w8, w4, w8, w12
    a020:	1b04bd6b 	msub	w11, w11, w4, w15
    a024:	93407e10 	sxtw	x16, w16
    a028:	93407ce7 	sxtw	x7, w7
    a02c:	93407d08 	sxtw	x8, w8
    a030:	9b0a2610 	madd	x16, x16, x10, x9
    a034:	1b122c84 	madd	w4, w4, w18, w11
    a038:	9b0a2508 	madd	x8, x8, x10, x9
    a03c:	9b0a24e7 	madd	x7, x7, x10, x9
    a040:	93407c84 	sxtw	x4, w4
    a044:	9b0a2489 	madd	x9, x4, x10, x9
    a048:	93407c42 	sxtw	x2, w2
    a04c:	3dc000f9 	ldr	q25, [x7]
    a050:	d2800204 	mov	x4, #0x10                  	// #16
    a054:	9b017c4a 	mul	x10, x2, x1
    a058:	3dc00105 	ldr	q5, [x8]
    a05c:	3dc0012f 	ldr	q15, [x9]
    a060:	8b0a002b 	add	x11, x1, x10
    a064:	8b0a000f 	add	x15, x0, x10
    a068:	8b0b0032 	add	x18, x1, x11
    a06c:	3cea681f 	ldr	q31, [x0, x10]
    a070:	8b0b000e 	add	x14, x0, x11
    a074:	8b120031 	add	x17, x1, x18
    a078:	8b12000d 	add	x13, x0, x18
    a07c:	8b11002a 	add	x10, x1, x17
    a080:	3dc00213 	ldr	q19, [x16]
    a084:	8b11000c 	add	x12, x0, x17
    a088:	8b0a0021 	add	x1, x1, x10
    a08c:	3ceb681e 	ldr	q30, [x0, x11]
    a090:	8b0a000b 	add	x11, x0, x10
    a094:	3cea681b 	ldr	q27, [x0, x10]
    a098:	6e5f1f38 	fmul	v24.8h, v25.8h, v31.8h
    a09c:	8b01000a 	add	x10, x0, x1
    a0a0:	6e5f1ca4 	fmul	v4.8h, v5.8h, v31.8h
    a0a4:	3ce1681a 	ldr	q26, [x0, x1]
    a0a8:	6e5f1e72 	fmul	v18.8h, v19.8h, v31.8h
    a0ac:	6e5f1dff 	fmul	v31.8h, v15.8h, v31.8h
    a0b0:	3cf2681d 	ldr	q29, [x0, x18]
    a0b4:	6e5e1f37 	fmul	v23.8h, v25.8h, v30.8h
    a0b8:	6e5e1ca3 	fmul	v3.8h, v5.8h, v30.8h
    a0bc:	3cf1681c 	ldr	q28, [x0, x17]
    a0c0:	6e591f74 	fmul	v20.8h, v27.8h, v25.8h
    a0c4:	6e451f60 	fmul	v0.8h, v27.8h, v5.8h
    a0c8:	6e5e1e71 	fmul	v17.8h, v19.8h, v30.8h
    a0cc:	6e531f66 	fmul	v6.8h, v27.8h, v19.8h
    a0d0:	6e5d1f36 	fmul	v22.8h, v25.8h, v29.8h
    a0d4:	6e5d1ca2 	fmul	v2.8h, v5.8h, v29.8h
    a0d8:	6e591f95 	fmul	v21.8h, v28.8h, v25.8h
    a0dc:	6e451f81 	fmul	v1.8h, v28.8h, v5.8h
    a0e0:	6e5d1e70 	fmul	v16.8h, v19.8h, v29.8h
    a0e4:	6e531f87 	fmul	v7.8h, v28.8h, v19.8h
    a0e8:	6e4f1f7b 	fmul	v27.8h, v27.8h, v15.8h
    a0ec:	6e4f1f9c 	fmul	v28.8h, v28.8h, v15.8h
    a0f0:	6e5d1dfd 	fmul	v29.8h, v15.8h, v29.8h
    a0f4:	6e5e1dfe 	fmul	v30.8h, v15.8h, v30.8h
    a0f8:	6e591f59 	fmul	v25.8h, v26.8h, v25.8h
    a0fc:	6e451f45 	fmul	v5.8h, v26.8h, v5.8h
    a100:	6e531f53 	fmul	v19.8h, v26.8h, v19.8h
    a104:	6e4f1f4f 	fmul	v15.8h, v26.8h, v15.8h
    a108:	3ce468fa 	ldr	q26, [x7, x4]
    a10c:	3ce469ee 	ldr	q14, [x15, x4]
    a110:	3ce469cd 	ldr	q13, [x14, x4]
    a114:	3ce469ac 	ldr	q12, [x13, x4]
    a118:	3ce4698b 	ldr	q11, [x12, x4]
    a11c:	4e4e0f58 	fmla	v24.8h, v26.8h, v14.8h
    a120:	3ce4696a 	ldr	q10, [x11, x4]
    a124:	4e4d0f57 	fmla	v23.8h, v26.8h, v13.8h
    a128:	3ce46949 	ldr	q9, [x10, x4]
    a12c:	4e4c0f56 	fmla	v22.8h, v26.8h, v12.8h
    a130:	4e4b0f55 	fmla	v21.8h, v26.8h, v11.8h
    a134:	4e4a0f54 	fmla	v20.8h, v26.8h, v10.8h
    a138:	4e490f59 	fmla	v25.8h, v26.8h, v9.8h
    a13c:	3ce46a1a 	ldr	q26, [x16, x4]
    a140:	4e4e0f52 	fmla	v18.8h, v26.8h, v14.8h
    a144:	4e4d0f51 	fmla	v17.8h, v26.8h, v13.8h
    a148:	4e4c0f50 	fmla	v16.8h, v26.8h, v12.8h
    a14c:	4e4b0f47 	fmla	v7.8h, v26.8h, v11.8h
    a150:	4e4a0f46 	fmla	v6.8h, v26.8h, v10.8h
    a154:	4e490f53 	fmla	v19.8h, v26.8h, v9.8h
    a158:	3ce4691a 	ldr	q26, [x8, x4]
    a15c:	4e4e0f44 	fmla	v4.8h, v26.8h, v14.8h
    a160:	4e4d0f43 	fmla	v3.8h, v26.8h, v13.8h
    a164:	4e4c0f42 	fmla	v2.8h, v26.8h, v12.8h
    a168:	4e4b0f41 	fmla	v1.8h, v26.8h, v11.8h
    a16c:	4e4a0f40 	fmla	v0.8h, v26.8h, v10.8h
    a170:	4e490f45 	fmla	v5.8h, v26.8h, v9.8h
    a174:	3ce4693a 	ldr	q26, [x9, x4]
    a178:	91004084 	add	x4, x4, #0x10
    a17c:	4e4e0f5f 	fmla	v31.8h, v26.8h, v14.8h
    a180:	4e4d0f5e 	fmla	v30.8h, v26.8h, v13.8h
    a184:	4e4c0f5d 	fmla	v29.8h, v26.8h, v12.8h
    a188:	4e4b0f5c 	fmla	v28.8h, v26.8h, v11.8h
    a18c:	4e4a0f5b 	fmla	v27.8h, v26.8h, v10.8h
    a190:	4e490f4f 	fmla	v15.8h, v26.8h, v9.8h
    a194:	f104009f 	cmp	x4, #0x100
    a198:	54fffb81 	b.ne	a108 <_Z8qk_clonePKcmiRK8DataInfo+0x188>  // b.any
    a19c:	5e18071a 	mov	d26, v24.d[1]
    a1a0:	f9400060 	ldr	x0, [x3]
    a1a4:	93407cc4 	sxtw	x4, w6
    a1a8:	f9400861 	ldr	x1, [x3, #16]
    a1ac:	0e58175a 	fadd	v26.4h, v26.4h, v24.4h
    a1b0:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a1b4:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a1b8:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a1bc:	b4003445 	cbz	x5, a844 <_Z8qk_clonePKcmiRK8DataInfo+0x8c4>
    a1c0:	d37df087 	lsl	x7, x4, #3
    a1c4:	8b040ca4 	add	x4, x5, x4, lsl #3
    a1c8:	f9401869 	ldr	x9, [x3, #48]
    a1cc:	b8a768a8 	ldrsw	x8, [x5, x7]
    a1d0:	b9800487 	ldrsw	x7, [x4, #4]
    a1d4:	9b017d04 	mul	x4, x8, x1
    a1d8:	9b0910e7 	madd	x7, x7, x9, x4
    a1dc:	8b070807 	add	x7, x0, x7, lsl #2
    a1e0:	d37ef442 	lsl	x2, x2, #2
    a1e4:	93407cc4 	sxtw	x4, w6
    a1e8:	bc2268fa 	str	s26, [x7, x2]
    a1ec:	5e1806fa 	mov	d26, v23.d[1]
    a1f0:	0e57175a 	fadd	v26.4h, v26.4h, v23.4h
    a1f4:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a1f8:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a1fc:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a200:	b4003285 	cbz	x5, a850 <_Z8qk_clonePKcmiRK8DataInfo+0x8d0>
    a204:	d37df087 	lsl	x7, x4, #3
    a208:	8b040ca4 	add	x4, x5, x4, lsl #3
    a20c:	f9401869 	ldr	x9, [x3, #48]
    a210:	b8a768a8 	ldrsw	x8, [x5, x7]
    a214:	b9800487 	ldrsw	x7, [x4, #4]
    a218:	9b017d04 	mul	x4, x8, x1
    a21c:	9b0910e7 	madd	x7, x7, x9, x4
    a220:	8b070807 	add	x7, x0, x7, lsl #2
    a224:	9100104b 	add	x11, x2, #0x4
    a228:	93407cc4 	sxtw	x4, w6
    a22c:	bc2b68fa 	str	s26, [x7, x11]
    a230:	5e1806da 	mov	d26, v22.d[1]
    a234:	0e56175a 	fadd	v26.4h, v26.4h, v22.4h
    a238:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a23c:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a240:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a244:	b40030c5 	cbz	x5, a85c <_Z8qk_clonePKcmiRK8DataInfo+0x8dc>
    a248:	d37df087 	lsl	x7, x4, #3
    a24c:	8b040ca4 	add	x4, x5, x4, lsl #3
    a250:	f9401869 	ldr	x9, [x3, #48]
    a254:	b8a768a8 	ldrsw	x8, [x5, x7]
    a258:	b9800487 	ldrsw	x7, [x4, #4]
    a25c:	9b017d04 	mul	x4, x8, x1
    a260:	9b0910e7 	madd	x7, x7, x9, x4
    a264:	8b070807 	add	x7, x0, x7, lsl #2
    a268:	9100204a 	add	x10, x2, #0x8
    a26c:	93407cc4 	sxtw	x4, w6
    a270:	bc2a68fa 	str	s26, [x7, x10]
    a274:	5e1806ba 	mov	d26, v21.d[1]
    a278:	0e55175a 	fadd	v26.4h, v26.4h, v21.4h
    a27c:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a280:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a284:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a288:	b4002f05 	cbz	x5, a868 <_Z8qk_clonePKcmiRK8DataInfo+0x8e8>
    a28c:	d37df087 	lsl	x7, x4, #3
    a290:	8b040ca4 	add	x4, x5, x4, lsl #3
    a294:	f9401869 	ldr	x9, [x3, #48]
    a298:	b8a768a8 	ldrsw	x8, [x5, x7]
    a29c:	b9800487 	ldrsw	x7, [x4, #4]
    a2a0:	9b017d04 	mul	x4, x8, x1
    a2a4:	9b0910e7 	madd	x7, x7, x9, x4
    a2a8:	8b070807 	add	x7, x0, x7, lsl #2
    a2ac:	91003048 	add	x8, x2, #0xc
    a2b0:	93407cc4 	sxtw	x4, w6
    a2b4:	bc2868fa 	str	s26, [x7, x8]
    a2b8:	5e18069a 	mov	d26, v20.d[1]
    a2bc:	0e54175a 	fadd	v26.4h, v26.4h, v20.4h
    a2c0:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a2c4:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a2c8:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a2cc:	b4002d45 	cbz	x5, a874 <_Z8qk_clonePKcmiRK8DataInfo+0x8f4>
    a2d0:	d37df087 	lsl	x7, x4, #3
    a2d4:	8b040ca4 	add	x4, x5, x4, lsl #3
    a2d8:	f940186c 	ldr	x12, [x3, #48]
    a2dc:	b8a768a7 	ldrsw	x7, [x5, x7]
    a2e0:	b9800489 	ldrsw	x9, [x4, #4]
    a2e4:	9b017ce4 	mul	x4, x7, x1
    a2e8:	9b0c1129 	madd	x9, x9, x12, x4
    a2ec:	8b090809 	add	x9, x0, x9, lsl #2
    a2f0:	91004047 	add	x7, x2, #0x10
    a2f4:	93407cc4 	sxtw	x4, w6
    a2f8:	bc27693a 	str	s26, [x9, x7]
    a2fc:	5e18073a 	mov	d26, v25.d[1]
    a300:	0e59175a 	fadd	v26.4h, v26.4h, v25.4h
    a304:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a308:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a30c:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a310:	b4002b85 	cbz	x5, a880 <_Z8qk_clonePKcmiRK8DataInfo+0x900>
    a314:	d37df089 	lsl	x9, x4, #3
    a318:	8b040ca4 	add	x4, x5, x4, lsl #3
    a31c:	f940186d 	ldr	x13, [x3, #48]
    a320:	b8a968a9 	ldrsw	x9, [x5, x9]
    a324:	b980048c 	ldrsw	x12, [x4, #4]
    a328:	9b017d24 	mul	x4, x9, x1
    a32c:	9b0d118c 	madd	x12, x12, x13, x4
    a330:	8b0c080c 	add	x12, x0, x12, lsl #2
    a334:	91005044 	add	x4, x2, #0x14
    a338:	110004c9 	add	w9, w6, #0x1
    a33c:	93407d29 	sxtw	x9, w9
    a340:	bc24699a 	str	s26, [x12, x4]
    a344:	5e18065a 	mov	d26, v18.d[1]
    a348:	0e52175a 	fadd	v26.4h, v26.4h, v18.4h
    a34c:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a350:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a354:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a358:	b40029a5 	cbz	x5, a88c <_Z8qk_clonePKcmiRK8DataInfo+0x90c>
    a35c:	d37df12c 	lsl	x12, x9, #3
    a360:	8b090ca9 	add	x9, x5, x9, lsl #3
    a364:	f940186d 	ldr	x13, [x3, #48]
    a368:	b8ac68ac 	ldrsw	x12, [x5, x12]
    a36c:	b9800529 	ldrsw	x9, [x9, #4]
    a370:	9b017d8c 	mul	x12, x12, x1
    a374:	9b0d3129 	madd	x9, x9, x13, x12
    a378:	8b090809 	add	x9, x0, x9, lsl #2
    a37c:	bc22693a 	str	s26, [x9, x2]
    a380:	5e18063a 	mov	d26, v17.d[1]
    a384:	110004c9 	add	w9, w6, #0x1
    a388:	93407d29 	sxtw	x9, w9
    a38c:	0e51175a 	fadd	v26.4h, v26.4h, v17.4h
    a390:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a394:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a398:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a39c:	b40027e5 	cbz	x5, a898 <_Z8qk_clonePKcmiRK8DataInfo+0x918>
    a3a0:	d37df12c 	lsl	x12, x9, #3
    a3a4:	8b090ca9 	add	x9, x5, x9, lsl #3
    a3a8:	f940186d 	ldr	x13, [x3, #48]
    a3ac:	b8ac68ac 	ldrsw	x12, [x5, x12]
    a3b0:	b9800529 	ldrsw	x9, [x9, #4]
    a3b4:	9b017d8c 	mul	x12, x12, x1
    a3b8:	9b0d3129 	madd	x9, x9, x13, x12
    a3bc:	8b090809 	add	x9, x0, x9, lsl #2
    a3c0:	bc2b693a 	str	s26, [x9, x11]
    a3c4:	5e18061a 	mov	d26, v16.d[1]
    a3c8:	110004c9 	add	w9, w6, #0x1
    a3cc:	93407d29 	sxtw	x9, w9
    a3d0:	0e50175a 	fadd	v26.4h, v26.4h, v16.4h
    a3d4:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a3d8:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a3dc:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a3e0:	b4002625 	cbz	x5, a8a4 <_Z8qk_clonePKcmiRK8DataInfo+0x924>
    a3e4:	d37df12c 	lsl	x12, x9, #3
    a3e8:	8b090ca9 	add	x9, x5, x9, lsl #3
    a3ec:	f940186d 	ldr	x13, [x3, #48]
    a3f0:	b8ac68ac 	ldrsw	x12, [x5, x12]
    a3f4:	b9800529 	ldrsw	x9, [x9, #4]
    a3f8:	9b017d8c 	mul	x12, x12, x1
    a3fc:	9b0d3129 	madd	x9, x9, x13, x12
    a400:	8b090809 	add	x9, x0, x9, lsl #2
    a404:	bc2a693a 	str	s26, [x9, x10]
    a408:	5e1804fa 	mov	d26, v7.d[1]
    a40c:	110004c9 	add	w9, w6, #0x1
    a410:	93407d29 	sxtw	x9, w9
    a414:	0e47175a 	fadd	v26.4h, v26.4h, v7.4h
    a418:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a41c:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a420:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a424:	b4002465 	cbz	x5, a8b0 <_Z8qk_clonePKcmiRK8DataInfo+0x930>
    a428:	d37df12c 	lsl	x12, x9, #3
    a42c:	8b090ca9 	add	x9, x5, x9, lsl #3
    a430:	f940186d 	ldr	x13, [x3, #48]
    a434:	b8ac68ac 	ldrsw	x12, [x5, x12]
    a438:	b9800529 	ldrsw	x9, [x9, #4]
    a43c:	9b017d8c 	mul	x12, x12, x1
    a440:	9b0d3129 	madd	x9, x9, x13, x12
    a444:	8b090809 	add	x9, x0, x9, lsl #2
    a448:	bc28693a 	str	s26, [x9, x8]
    a44c:	5e1804da 	mov	d26, v6.d[1]
    a450:	110004c9 	add	w9, w6, #0x1
    a454:	93407d29 	sxtw	x9, w9
    a458:	0e46175a 	fadd	v26.4h, v26.4h, v6.4h
    a45c:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a460:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a464:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a468:	b40022a5 	cbz	x5, a8bc <_Z8qk_clonePKcmiRK8DataInfo+0x93c>
    a46c:	d37df12c 	lsl	x12, x9, #3
    a470:	8b090ca9 	add	x9, x5, x9, lsl #3
    a474:	f940186d 	ldr	x13, [x3, #48]
    a478:	b8ac68ac 	ldrsw	x12, [x5, x12]
    a47c:	b9800529 	ldrsw	x9, [x9, #4]
    a480:	9b017d8c 	mul	x12, x12, x1
    a484:	9b0d3129 	madd	x9, x9, x13, x12
    a488:	8b090809 	add	x9, x0, x9, lsl #2
    a48c:	bc27693a 	str	s26, [x9, x7]
    a490:	5e18067a 	mov	d26, v19.d[1]
    a494:	110004c9 	add	w9, w6, #0x1
    a498:	93407d29 	sxtw	x9, w9
    a49c:	0e53175a 	fadd	v26.4h, v26.4h, v19.4h
    a4a0:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a4a4:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a4a8:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a4ac:	b40020e5 	cbz	x5, a8c8 <_Z8qk_clonePKcmiRK8DataInfo+0x948>
    a4b0:	d37df12c 	lsl	x12, x9, #3
    a4b4:	8b090ca9 	add	x9, x5, x9, lsl #3
    a4b8:	f940186d 	ldr	x13, [x3, #48]
    a4bc:	b8ac68ac 	ldrsw	x12, [x5, x12]
    a4c0:	b9800529 	ldrsw	x9, [x9, #4]
    a4c4:	9b017d8c 	mul	x12, x12, x1
    a4c8:	9b0d3129 	madd	x9, x9, x13, x12
    a4cc:	8b090809 	add	x9, x0, x9, lsl #2
    a4d0:	bc24693a 	str	s26, [x9, x4]
    a4d4:	5e18049a 	mov	d26, v4.d[1]
    a4d8:	110008c9 	add	w9, w6, #0x2
    a4dc:	93407d29 	sxtw	x9, w9
    a4e0:	0e44175a 	fadd	v26.4h, v26.4h, v4.4h
    a4e4:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a4e8:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a4ec:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a4f0:	b4001f25 	cbz	x5, a8d4 <_Z8qk_clonePKcmiRK8DataInfo+0x954>
    a4f4:	d37df12c 	lsl	x12, x9, #3
    a4f8:	8b090ca9 	add	x9, x5, x9, lsl #3
    a4fc:	f940186d 	ldr	x13, [x3, #48]
    a500:	b8ac68ac 	ldrsw	x12, [x5, x12]
    a504:	b9800529 	ldrsw	x9, [x9, #4]
    a508:	9b017d8c 	mul	x12, x12, x1
    a50c:	9b0d3129 	madd	x9, x9, x13, x12
    a510:	8b090809 	add	x9, x0, x9, lsl #2
    a514:	bc22693a 	str	s26, [x9, x2]
    a518:	5e18047a 	mov	d26, v3.d[1]
    a51c:	110008c9 	add	w9, w6, #0x2
    a520:	93407d29 	sxtw	x9, w9
    a524:	0e43175a 	fadd	v26.4h, v26.4h, v3.4h
    a528:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a52c:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a530:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a534:	b4001d65 	cbz	x5, a8e0 <_Z8qk_clonePKcmiRK8DataInfo+0x960>
    a538:	d37df12c 	lsl	x12, x9, #3
    a53c:	8b090ca9 	add	x9, x5, x9, lsl #3
    a540:	f940186d 	ldr	x13, [x3, #48]
    a544:	b8ac68ac 	ldrsw	x12, [x5, x12]
    a548:	b9800529 	ldrsw	x9, [x9, #4]
    a54c:	9b017d8c 	mul	x12, x12, x1
    a550:	9b0d3129 	madd	x9, x9, x13, x12
    a554:	8b090809 	add	x9, x0, x9, lsl #2
    a558:	bc2b693a 	str	s26, [x9, x11]
    a55c:	5e18045a 	mov	d26, v2.d[1]
    a560:	110008c9 	add	w9, w6, #0x2
    a564:	93407d29 	sxtw	x9, w9
    a568:	0e42175a 	fadd	v26.4h, v26.4h, v2.4h
    a56c:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a570:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a574:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a578:	b4001ba5 	cbz	x5, a8ec <_Z8qk_clonePKcmiRK8DataInfo+0x96c>
    a57c:	d37df12c 	lsl	x12, x9, #3
    a580:	8b090ca9 	add	x9, x5, x9, lsl #3
    a584:	f940186d 	ldr	x13, [x3, #48]
    a588:	b8ac68ac 	ldrsw	x12, [x5, x12]
    a58c:	b9800529 	ldrsw	x9, [x9, #4]
    a590:	9b017d8c 	mul	x12, x12, x1
    a594:	9b0d3129 	madd	x9, x9, x13, x12
    a598:	8b090809 	add	x9, x0, x9, lsl #2
    a59c:	bc2a693a 	str	s26, [x9, x10]
    a5a0:	5e18043a 	mov	d26, v1.d[1]
    a5a4:	110008c9 	add	w9, w6, #0x2
    a5a8:	93407d29 	sxtw	x9, w9
    a5ac:	0e41175a 	fadd	v26.4h, v26.4h, v1.4h
    a5b0:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a5b4:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a5b8:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a5bc:	b40019e5 	cbz	x5, a8f8 <_Z8qk_clonePKcmiRK8DataInfo+0x978>
    a5c0:	d37df12c 	lsl	x12, x9, #3
    a5c4:	8b090ca9 	add	x9, x5, x9, lsl #3
    a5c8:	f940186d 	ldr	x13, [x3, #48]
    a5cc:	b8ac68ac 	ldrsw	x12, [x5, x12]
    a5d0:	b9800529 	ldrsw	x9, [x9, #4]
    a5d4:	9b017d8c 	mul	x12, x12, x1
    a5d8:	9b0d3129 	madd	x9, x9, x13, x12
    a5dc:	8b090809 	add	x9, x0, x9, lsl #2
    a5e0:	bc28693a 	str	s26, [x9, x8]
    a5e4:	5e18041a 	mov	d26, v0.d[1]
    a5e8:	110008c9 	add	w9, w6, #0x2
    a5ec:	93407d29 	sxtw	x9, w9
    a5f0:	0e40175a 	fadd	v26.4h, v26.4h, v0.4h
    a5f4:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a5f8:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a5fc:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a600:	b4001825 	cbz	x5, a904 <_Z8qk_clonePKcmiRK8DataInfo+0x984>
    a604:	d37df12c 	lsl	x12, x9, #3
    a608:	8b090ca9 	add	x9, x5, x9, lsl #3
    a60c:	f940186d 	ldr	x13, [x3, #48]
    a610:	b8ac68ac 	ldrsw	x12, [x5, x12]
    a614:	b9800529 	ldrsw	x9, [x9, #4]
    a618:	9b017d8c 	mul	x12, x12, x1
    a61c:	9b0d3129 	madd	x9, x9, x13, x12
    a620:	8b090809 	add	x9, x0, x9, lsl #2
    a624:	bc27693a 	str	s26, [x9, x7]
    a628:	5e1804ba 	mov	d26, v5.d[1]
    a62c:	110008c9 	add	w9, w6, #0x2
    a630:	93407d29 	sxtw	x9, w9
    a634:	0e45175a 	fadd	v26.4h, v26.4h, v5.4h
    a638:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a63c:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a640:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a644:	b4001665 	cbz	x5, a910 <_Z8qk_clonePKcmiRK8DataInfo+0x990>
    a648:	d37df12c 	lsl	x12, x9, #3
    a64c:	8b090ca9 	add	x9, x5, x9, lsl #3
    a650:	f940186d 	ldr	x13, [x3, #48]
    a654:	b8ac68ac 	ldrsw	x12, [x5, x12]
    a658:	b9800529 	ldrsw	x9, [x9, #4]
    a65c:	9b017d8c 	mul	x12, x12, x1
    a660:	9b0d3129 	madd	x9, x9, x13, x12
    a664:	8b090809 	add	x9, x0, x9, lsl #2
    a668:	bc24693a 	str	s26, [x9, x4]
    a66c:	5e1807fa 	mov	d26, v31.d[1]
    a670:	11000cc9 	add	w9, w6, #0x3
    a674:	93407d29 	sxtw	x9, w9
    a678:	0e5f175a 	fadd	v26.4h, v26.4h, v31.4h
    a67c:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a680:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a684:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a688:	b40014a5 	cbz	x5, a91c <_Z8qk_clonePKcmiRK8DataInfo+0x99c>
    a68c:	d37df12c 	lsl	x12, x9, #3
    a690:	8b090ca9 	add	x9, x5, x9, lsl #3
    a694:	f940186d 	ldr	x13, [x3, #48]
    a698:	b8ac68ac 	ldrsw	x12, [x5, x12]
    a69c:	b9800529 	ldrsw	x9, [x9, #4]
    a6a0:	9b017d8c 	mul	x12, x12, x1
    a6a4:	9b0d3129 	madd	x9, x9, x13, x12
    a6a8:	8b090809 	add	x9, x0, x9, lsl #2
    a6ac:	bc22693a 	str	s26, [x9, x2]
    a6b0:	5e1807da 	mov	d26, v30.d[1]
    a6b4:	11000cc2 	add	w2, w6, #0x3
    a6b8:	93407c42 	sxtw	x2, w2
    a6bc:	0e5e175a 	fadd	v26.4h, v26.4h, v30.4h
    a6c0:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a6c4:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a6c8:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a6cc:	b40012e5 	cbz	x5, a928 <_Z8qk_clonePKcmiRK8DataInfo+0x9a8>
    a6d0:	d37df049 	lsl	x9, x2, #3
    a6d4:	8b020ca2 	add	x2, x5, x2, lsl #3
    a6d8:	f940186c 	ldr	x12, [x3, #48]
    a6dc:	b8a968a9 	ldrsw	x9, [x5, x9]
    a6e0:	b9800442 	ldrsw	x2, [x2, #4]
    a6e4:	9b017d29 	mul	x9, x9, x1
    a6e8:	9b0c2442 	madd	x2, x2, x12, x9
    a6ec:	8b020802 	add	x2, x0, x2, lsl #2
    a6f0:	bc2b685a 	str	s26, [x2, x11]
    a6f4:	5e1807ba 	mov	d26, v29.d[1]
    a6f8:	11000cc2 	add	w2, w6, #0x3
    a6fc:	93407c42 	sxtw	x2, w2
    a700:	0e5d175a 	fadd	v26.4h, v26.4h, v29.4h
    a704:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a708:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a70c:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a710:	b4001125 	cbz	x5, a934 <_Z8qk_clonePKcmiRK8DataInfo+0x9b4>
    a714:	d37df049 	lsl	x9, x2, #3
    a718:	8b020ca2 	add	x2, x5, x2, lsl #3
    a71c:	f940186b 	ldr	x11, [x3, #48]
    a720:	b8a968a9 	ldrsw	x9, [x5, x9]
    a724:	b9800442 	ldrsw	x2, [x2, #4]
    a728:	9b017d29 	mul	x9, x9, x1
    a72c:	9b0b2442 	madd	x2, x2, x11, x9
    a730:	8b020802 	add	x2, x0, x2, lsl #2
    a734:	bc2a685a 	str	s26, [x2, x10]
    a738:	5e18079a 	mov	d26, v28.d[1]
    a73c:	11000cc2 	add	w2, w6, #0x3
    a740:	93407c42 	sxtw	x2, w2
    a744:	0e5c175a 	fadd	v26.4h, v26.4h, v28.4h
    a748:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a74c:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a750:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a754:	b4000f65 	cbz	x5, a940 <_Z8qk_clonePKcmiRK8DataInfo+0x9c0>
    a758:	d37df049 	lsl	x9, x2, #3
    a75c:	8b020ca2 	add	x2, x5, x2, lsl #3
    a760:	f940186a 	ldr	x10, [x3, #48]
    a764:	b8a968a9 	ldrsw	x9, [x5, x9]
    a768:	b9800442 	ldrsw	x2, [x2, #4]
    a76c:	9b017d29 	mul	x9, x9, x1
    a770:	9b0a2442 	madd	x2, x2, x10, x9
    a774:	8b020802 	add	x2, x0, x2, lsl #2
    a778:	bc28685a 	str	s26, [x2, x8]
    a77c:	5e18077a 	mov	d26, v27.d[1]
    a780:	11000cc2 	add	w2, w6, #0x3
    a784:	93407c42 	sxtw	x2, w2
    a788:	0e5b175a 	fadd	v26.4h, v26.4h, v27.4h
    a78c:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a790:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a794:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a798:	b4000da5 	cbz	x5, a94c <_Z8qk_clonePKcmiRK8DataInfo+0x9cc>
    a79c:	d37df048 	lsl	x8, x2, #3
    a7a0:	8b020ca2 	add	x2, x5, x2, lsl #3
    a7a4:	f9401869 	ldr	x9, [x3, #48]
    a7a8:	b8a868a8 	ldrsw	x8, [x5, x8]
    a7ac:	b9800442 	ldrsw	x2, [x2, #4]
    a7b0:	9b017d08 	mul	x8, x8, x1
    a7b4:	9b092042 	madd	x2, x2, x9, x8
    a7b8:	8b020802 	add	x2, x0, x2, lsl #2
    a7bc:	bc27685a 	str	s26, [x2, x7]
    a7c0:	5e1805fa 	mov	d26, v15.d[1]
    a7c4:	11000cc6 	add	w6, w6, #0x3
    a7c8:	93407cc6 	sxtw	x6, w6
    a7cc:	0e4f175a 	fadd	v26.4h, v26.4h, v15.4h
    a7d0:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a7d4:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a7d8:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a7dc:	b4000be5 	cbz	x5, a958 <_Z8qk_clonePKcmiRK8DataInfo+0x9d8>
    a7e0:	d37df0c2 	lsl	x2, x6, #3
    a7e4:	f9401867 	ldr	x7, [x3, #48]
    a7e8:	8b060ca6 	add	x6, x5, x6, lsl #3
    a7ec:	b8a268a3 	ldrsw	x3, [x5, x2]
    a7f0:	b98004c2 	ldrsw	x2, [x6, #4]
    a7f4:	fd400fef 	ldr	d15, [sp, #24]
    a7f8:	9b017c61 	mul	x1, x3, x1
    a7fc:	9b070441 	madd	x1, x2, x7, x1
    a800:	8b010800 	add	x0, x0, x1, lsl #2
    a804:	bc24681a 	str	s26, [x0, x4]
    a808:	6d422be9 	ldp	d9, d10, [sp, #32]
    a80c:	6d4333eb 	ldp	d11, d12, [sp, #48]
    a810:	6d443bed 	ldp	d13, d14, [sp, #64]
    a814:	a8c57bfd 	ldp	x29, x30, [sp], #80
    a818:	d65f03c0 	ret
    a81c:	93407cc7 	sxtw	x7, w6
    a820:	9b0a7ce7 	mul	x7, x7, x10
    a824:	8b0a00f0 	add	x16, x7, x10
    a828:	8b070127 	add	x7, x9, x7
    a82c:	8b0a0208 	add	x8, x16, x10
    a830:	8b100130 	add	x16, x9, x16
    a834:	8b0a010a 	add	x10, x8, x10
    a838:	8b080128 	add	x8, x9, x8
    a83c:	8b0a0129 	add	x9, x9, x10
    a840:	17fffe02 	b	a048 <_Z8qk_clonePKcmiRK8DataInfo+0xc8>
    a844:	9b017c84 	mul	x4, x4, x1
    a848:	8b040807 	add	x7, x0, x4, lsl #2
    a84c:	17fffe65 	b	a1e0 <_Z8qk_clonePKcmiRK8DataInfo+0x260>
    a850:	9b017c84 	mul	x4, x4, x1
    a854:	8b040807 	add	x7, x0, x4, lsl #2
    a858:	17fffe73 	b	a224 <_Z8qk_clonePKcmiRK8DataInfo+0x2a4>
    a85c:	9b017c84 	mul	x4, x4, x1
    a860:	8b040807 	add	x7, x0, x4, lsl #2
    a864:	17fffe81 	b	a268 <_Z8qk_clonePKcmiRK8DataInfo+0x2e8>
    a868:	9b017c84 	mul	x4, x4, x1
    a86c:	8b040807 	add	x7, x0, x4, lsl #2
    a870:	17fffe8f 	b	a2ac <_Z8qk_clonePKcmiRK8DataInfo+0x32c>
    a874:	9b017c84 	mul	x4, x4, x1
    a878:	8b040809 	add	x9, x0, x4, lsl #2
    a87c:	17fffe9d 	b	a2f0 <_Z8qk_clonePKcmiRK8DataInfo+0x370>
    a880:	9b017c84 	mul	x4, x4, x1
    a884:	8b04080c 	add	x12, x0, x4, lsl #2
    a888:	17fffeab 	b	a334 <_Z8qk_clonePKcmiRK8DataInfo+0x3b4>
    a88c:	9b017d29 	mul	x9, x9, x1
    a890:	8b090809 	add	x9, x0, x9, lsl #2
    a894:	17fffeba 	b	a37c <_Z8qk_clonePKcmiRK8DataInfo+0x3fc>
    a898:	9b017d29 	mul	x9, x9, x1
    a89c:	8b090809 	add	x9, x0, x9, lsl #2
    a8a0:	17fffec8 	b	a3c0 <_Z8qk_clonePKcmiRK8DataInfo+0x440>
    a8a4:	9b017d29 	mul	x9, x9, x1
    a8a8:	8b090809 	add	x9, x0, x9, lsl #2
    a8ac:	17fffed6 	b	a404 <_Z8qk_clonePKcmiRK8DataInfo+0x484>
    a8b0:	9b017d29 	mul	x9, x9, x1
    a8b4:	8b090809 	add	x9, x0, x9, lsl #2
    a8b8:	17fffee4 	b	a448 <_Z8qk_clonePKcmiRK8DataInfo+0x4c8>
    a8bc:	9b017d29 	mul	x9, x9, x1
    a8c0:	8b090809 	add	x9, x0, x9, lsl #2
    a8c4:	17fffef2 	b	a48c <_Z8qk_clonePKcmiRK8DataInfo+0x50c>
    a8c8:	9b017d29 	mul	x9, x9, x1
    a8cc:	8b090809 	add	x9, x0, x9, lsl #2
    a8d0:	17ffff00 	b	a4d0 <_Z8qk_clonePKcmiRK8DataInfo+0x550>
    a8d4:	9b017d29 	mul	x9, x9, x1
    a8d8:	8b090809 	add	x9, x0, x9, lsl #2
    a8dc:	17ffff0e 	b	a514 <_Z8qk_clonePKcmiRK8DataInfo+0x594>
    a8e0:	9b017d29 	mul	x9, x9, x1
    a8e4:	8b090809 	add	x9, x0, x9, lsl #2
    a8e8:	17ffff1c 	b	a558 <_Z8qk_clonePKcmiRK8DataInfo+0x5d8>
    a8ec:	9b017d29 	mul	x9, x9, x1
    a8f0:	8b090809 	add	x9, x0, x9, lsl #2
    a8f4:	17ffff2a 	b	a59c <_Z8qk_clonePKcmiRK8DataInfo+0x61c>
    a8f8:	9b017d29 	mul	x9, x9, x1
    a8fc:	8b090809 	add	x9, x0, x9, lsl #2
    a900:	17ffff38 	b	a5e0 <_Z8qk_clonePKcmiRK8DataInfo+0x660>
    a904:	9b017d29 	mul	x9, x9, x1
    a908:	8b090809 	add	x9, x0, x9, lsl #2
    a90c:	17ffff46 	b	a624 <_Z8qk_clonePKcmiRK8DataInfo+0x6a4>
    a910:	9b017d29 	mul	x9, x9, x1
    a914:	8b090809 	add	x9, x0, x9, lsl #2
    a918:	17ffff54 	b	a668 <_Z8qk_clonePKcmiRK8DataInfo+0x6e8>
    a91c:	9b017d29 	mul	x9, x9, x1
    a920:	8b090809 	add	x9, x0, x9, lsl #2
    a924:	17ffff62 	b	a6ac <_Z8qk_clonePKcmiRK8DataInfo+0x72c>
    a928:	9b017c42 	mul	x2, x2, x1
    a92c:	8b020802 	add	x2, x0, x2, lsl #2
    a930:	17ffff70 	b	a6f0 <_Z8qk_clonePKcmiRK8DataInfo+0x770>
    a934:	9b017c42 	mul	x2, x2, x1
    a938:	8b020802 	add	x2, x0, x2, lsl #2
    a93c:	17ffff7e 	b	a734 <_Z8qk_clonePKcmiRK8DataInfo+0x7b4>
    a940:	9b017c42 	mul	x2, x2, x1
    a944:	8b020802 	add	x2, x0, x2, lsl #2
    a948:	17ffff8c 	b	a778 <_Z8qk_clonePKcmiRK8DataInfo+0x7f8>
    a94c:	9b017c42 	mul	x2, x2, x1
    a950:	8b020802 	add	x2, x0, x2, lsl #2
    a954:	17ffff9a 	b	a7bc <_Z8qk_clonePKcmiRK8DataInfo+0x83c>
    a958:	9b017cc6 	mul	x6, x6, x1
    a95c:	fd400fef 	ldr	d15, [sp, #24]
    a960:	8b060800 	add	x0, x0, x6, lsl #2
    a964:	bc24681a 	str	s26, [x0, x4]
    a968:	6d422be9 	ldp	d9, d10, [sp, #32]
    a96c:	6d4333eb 	ldp	d11, d12, [sp, #48]
    a970:	6d443bed 	ldp	d13, d14, [sp, #64]
    a974:	a8c57bfd 	ldp	x29, x30, [sp], #80
    a978:	d65f03c0 	ret

Disassembly of section .fini:
