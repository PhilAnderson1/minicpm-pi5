
/home/philip/minicpm-pi5/build-qk-scheduling/bench:     file format elf64-littleaarch64


Disassembly of section .init:

Disassembly of section .plt:

Disassembly of section .text:

000000000000d0f0 <_Z6qk_keyPKcmiRK8DataInfo>:
    d0f0:	a9bb7bfd 	stp	x29, x30, [sp, #-80]!
    d0f4:	910003fd 	mov	x29, sp
    d0f8:	6d022fea 	stp	d10, d11, [sp, #32]
    d0fc:	6d0337ec 	stp	d12, d13, [sp, #48]
    d100:	6d043fee 	stp	d14, d15, [sp, #64]
    d104:	f9401465 	ldr	x5, [x3, #40]
    d108:	f9400469 	ldr	x9, [x3, #8]
    d10c:	f9400c6a 	ldr	x10, [x3, #24]
    d110:	b9402066 	ldr	w6, [x3, #32]
    d114:	b40043e5 	cbz	x5, d990 <_Z6qk_keyPKcmiRK8DataInfo+0x8a0>
    d118:	937d7cc4 	sbfiz	x4, x6, #3, #32
    d11c:	91002087 	add	x7, x4, #0x8
    d120:	9100408b 	add	x11, x4, #0x10
    d124:	b86468be 	ldr	w30, [x5, x4]
    d128:	91006088 	add	x8, x4, #0x18
    d12c:	8b0700ae 	add	x14, x5, x7
    d130:	8b0b00ad 	add	x13, x5, x11
    d134:	8b0800ac 	add	x12, x5, x8
    d138:	b86b68b1 	ldr	w17, [x5, x11]
    d13c:	b86868af 	ldr	w15, [x5, x8]
    d140:	b9400592 	ldr	w18, [x12, #4]
    d144:	b94005a8 	ldr	w8, [x13, #4]
    d148:	b94005d0 	ldr	w16, [x14, #4]
    d14c:	f9000bf3 	str	x19, [sp, #16]
    d150:	b86768b3 	ldr	w19, [x5, x7]
    d154:	8b0400a7 	add	x7, x5, x4
    d158:	b9402464 	ldr	w4, [x3, #36]
    d15c:	b94004e7 	ldr	w7, [x7, #4]
    d160:	1ac40e6e 	sdiv	w14, w19, w4
    d164:	1ac40fcd 	sdiv	w13, w30, w4
    d168:	1ac40e2c 	sdiv	w12, w17, w4
    d16c:	1ac40deb 	sdiv	w11, w15, w4
    d170:	1b04cdce 	msub	w14, w14, w4, w19
    d174:	f9400bf3 	ldr	x19, [sp, #16]
    d178:	1b04f9ad 	msub	w13, w13, w4, w30
    d17c:	1b04c58c 	msub	w12, w12, w4, w17
    d180:	1b103890 	madd	w16, w4, w16, w14
    d184:	1b073487 	madd	w7, w4, w7, w13
    d188:	1b083088 	madd	w8, w4, w8, w12
    d18c:	1b04bd6b 	msub	w11, w11, w4, w15
    d190:	93407e10 	sxtw	x16, w16
    d194:	93407ce7 	sxtw	x7, w7
    d198:	93407d08 	sxtw	x8, w8
    d19c:	9b0a2610 	madd	x16, x16, x10, x9
    d1a0:	1b122c84 	madd	w4, w4, w18, w11
    d1a4:	9b0a2508 	madd	x8, x8, x10, x9
    d1a8:	9b0a24e7 	madd	x7, x7, x10, x9
    d1ac:	93407c84 	sxtw	x4, w4
    d1b0:	9b0a2489 	madd	x9, x4, x10, x9
    d1b4:	93407c42 	sxtw	x2, w2
    d1b8:	3dc000f9 	ldr	q25, [x7]
    d1bc:	d2800204 	mov	x4, #0x10                  	// #16
    d1c0:	9b017c4a 	mul	x10, x2, x1
    d1c4:	3dc00105 	ldr	q5, [x8]
    d1c8:	3dc0012f 	ldr	q15, [x9]
    d1cc:	8b0a002b 	add	x11, x1, x10
    d1d0:	8b0a000f 	add	x15, x0, x10
    d1d4:	8b0b0032 	add	x18, x1, x11
    d1d8:	3cea681f 	ldr	q31, [x0, x10]
    d1dc:	8b0b000e 	add	x14, x0, x11
    d1e0:	8b120031 	add	x17, x1, x18
    d1e4:	8b12000d 	add	x13, x0, x18
    d1e8:	8b11002a 	add	x10, x1, x17
    d1ec:	3dc00213 	ldr	q19, [x16]
    d1f0:	8b11000c 	add	x12, x0, x17
    d1f4:	8b0a0021 	add	x1, x1, x10
    d1f8:	3ceb681e 	ldr	q30, [x0, x11]
    d1fc:	8b0a000b 	add	x11, x0, x10
    d200:	3cea681b 	ldr	q27, [x0, x10]
    d204:	6e5f1f38 	fmul	v24.8h, v25.8h, v31.8h
    d208:	8b01000a 	add	x10, x0, x1
    d20c:	6e5f1ca4 	fmul	v4.8h, v5.8h, v31.8h
    d210:	3ce1681a 	ldr	q26, [x0, x1]
    d214:	6e5f1e72 	fmul	v18.8h, v19.8h, v31.8h
    d218:	6e5f1dff 	fmul	v31.8h, v15.8h, v31.8h
    d21c:	3cf2681d 	ldr	q29, [x0, x18]
    d220:	6e5e1f37 	fmul	v23.8h, v25.8h, v30.8h
    d224:	6e5e1ca3 	fmul	v3.8h, v5.8h, v30.8h
    d228:	3cf1681c 	ldr	q28, [x0, x17]
    d22c:	6e591f74 	fmul	v20.8h, v27.8h, v25.8h
    d230:	6e451f60 	fmul	v0.8h, v27.8h, v5.8h
    d234:	6e5e1e71 	fmul	v17.8h, v19.8h, v30.8h
    d238:	6e531f66 	fmul	v6.8h, v27.8h, v19.8h
    d23c:	6e5d1f36 	fmul	v22.8h, v25.8h, v29.8h
    d240:	6e5d1ca2 	fmul	v2.8h, v5.8h, v29.8h
    d244:	6e591f95 	fmul	v21.8h, v28.8h, v25.8h
    d248:	6e451f81 	fmul	v1.8h, v28.8h, v5.8h
    d24c:	6e5d1e70 	fmul	v16.8h, v19.8h, v29.8h
    d250:	6e531f87 	fmul	v7.8h, v28.8h, v19.8h
    d254:	6e4f1f7b 	fmul	v27.8h, v27.8h, v15.8h
    d258:	6e4f1f9c 	fmul	v28.8h, v28.8h, v15.8h
    d25c:	6e5d1dfd 	fmul	v29.8h, v15.8h, v29.8h
    d260:	6e5e1dfe 	fmul	v30.8h, v15.8h, v30.8h
    d264:	6e591f59 	fmul	v25.8h, v26.8h, v25.8h
    d268:	6e451f45 	fmul	v5.8h, v26.8h, v5.8h
    d26c:	6e531f53 	fmul	v19.8h, v26.8h, v19.8h
    d270:	6e4f1f4f 	fmul	v15.8h, v26.8h, v15.8h
    d274:	d503201f 	nop
    d278:	d503201f 	nop
    d27c:	d503201f 	nop
    d280:	3ce468ee 	ldr	q14, [x7, x4]
    d284:	3ce46a0d 	ldr	q13, [x16, x4]
    d288:	3ce4690c 	ldr	q12, [x8, x4]
    d28c:	3ce4692b 	ldr	q11, [x9, x4]
    d290:	3ce469ea 	ldr	q10, [x15, x4]
    d294:	3ce469da 	ldr	q26, [x14, x4]
    d298:	4e4a0dd8 	fmla	v24.8h, v14.8h, v10.8h
    d29c:	4e4a0db2 	fmla	v18.8h, v13.8h, v10.8h
    d2a0:	4e4a0d84 	fmla	v4.8h, v12.8h, v10.8h
    d2a4:	4e4a0d7f 	fmla	v31.8h, v11.8h, v10.8h
    d2a8:	3ce469aa 	ldr	q10, [x13, x4]
    d2ac:	4e5a0dd7 	fmla	v23.8h, v14.8h, v26.8h
    d2b0:	4e5a0db1 	fmla	v17.8h, v13.8h, v26.8h
    d2b4:	4e5a0d83 	fmla	v3.8h, v12.8h, v26.8h
    d2b8:	4e5a0d7e 	fmla	v30.8h, v11.8h, v26.8h
    d2bc:	3ce4699a 	ldr	q26, [x12, x4]
    d2c0:	4e4a0dd6 	fmla	v22.8h, v14.8h, v10.8h
    d2c4:	4e4a0db0 	fmla	v16.8h, v13.8h, v10.8h
    d2c8:	4e4a0d82 	fmla	v2.8h, v12.8h, v10.8h
    d2cc:	4e4a0d7d 	fmla	v29.8h, v11.8h, v10.8h
    d2d0:	3ce4696a 	ldr	q10, [x11, x4]
    d2d4:	4e5a0dd5 	fmla	v21.8h, v14.8h, v26.8h
    d2d8:	4e5a0da7 	fmla	v7.8h, v13.8h, v26.8h
    d2dc:	4e5a0d81 	fmla	v1.8h, v12.8h, v26.8h
    d2e0:	4e5a0d7c 	fmla	v28.8h, v11.8h, v26.8h
    d2e4:	3ce4695a 	ldr	q26, [x10, x4]
    d2e8:	91004084 	add	x4, x4, #0x10
    d2ec:	4e4a0dd4 	fmla	v20.8h, v14.8h, v10.8h
    d2f0:	4e4a0da6 	fmla	v6.8h, v13.8h, v10.8h
    d2f4:	4e4a0d80 	fmla	v0.8h, v12.8h, v10.8h
    d2f8:	4e4a0d7b 	fmla	v27.8h, v11.8h, v10.8h
    d2fc:	4e5a0dd9 	fmla	v25.8h, v14.8h, v26.8h
    d300:	4e5a0db3 	fmla	v19.8h, v13.8h, v26.8h
    d304:	4e5a0d85 	fmla	v5.8h, v12.8h, v26.8h
    d308:	4e5a0d6f 	fmla	v15.8h, v11.8h, v26.8h
    d30c:	f104009f 	cmp	x4, #0x100
    d310:	54fffb81 	b.ne	d280 <_Z6qk_keyPKcmiRK8DataInfo+0x190>  // b.any
    d314:	5e18071a 	mov	d26, v24.d[1]
    d318:	f9400060 	ldr	x0, [x3]
    d31c:	93407cc4 	sxtw	x4, w6
    d320:	f9400861 	ldr	x1, [x3, #16]
    d324:	0e58175a 	fadd	v26.4h, v26.4h, v24.4h
    d328:	0e217b5a 	fcvtl	v26.4s, v26.4h
    d32c:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    d330:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    d334:	b4003425 	cbz	x5, d9b8 <_Z6qk_keyPKcmiRK8DataInfo+0x8c8>
    d338:	d37df087 	lsl	x7, x4, #3
    d33c:	8b040ca4 	add	x4, x5, x4, lsl #3
    d340:	f9401869 	ldr	x9, [x3, #48]
    d344:	b8a768a8 	ldrsw	x8, [x5, x7]
    d348:	b9800487 	ldrsw	x7, [x4, #4]
    d34c:	9b017d04 	mul	x4, x8, x1
    d350:	9b0910e7 	madd	x7, x7, x9, x4
    d354:	8b070807 	add	x7, x0, x7, lsl #2
    d358:	d37ef442 	lsl	x2, x2, #2
    d35c:	93407cc4 	sxtw	x4, w6
    d360:	bc2268fa 	str	s26, [x7, x2]
    d364:	5e1806fa 	mov	d26, v23.d[1]
    d368:	0e57175a 	fadd	v26.4h, v26.4h, v23.4h
    d36c:	0e217b5a 	fcvtl	v26.4s, v26.4h
    d370:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    d374:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    d378:	b4003265 	cbz	x5, d9c4 <_Z6qk_keyPKcmiRK8DataInfo+0x8d4>
    d37c:	d37df087 	lsl	x7, x4, #3
    d380:	8b040ca4 	add	x4, x5, x4, lsl #3
    d384:	f9401869 	ldr	x9, [x3, #48]
    d388:	b8a768a8 	ldrsw	x8, [x5, x7]
    d38c:	b9800487 	ldrsw	x7, [x4, #4]
    d390:	9b017d04 	mul	x4, x8, x1
    d394:	9b0910e7 	madd	x7, x7, x9, x4
    d398:	8b070807 	add	x7, x0, x7, lsl #2
    d39c:	9100104b 	add	x11, x2, #0x4
    d3a0:	93407cc4 	sxtw	x4, w6
    d3a4:	bc2b68fa 	str	s26, [x7, x11]
    d3a8:	5e1806da 	mov	d26, v22.d[1]
    d3ac:	0e56175a 	fadd	v26.4h, v26.4h, v22.4h
    d3b0:	0e217b5a 	fcvtl	v26.4s, v26.4h
    d3b4:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    d3b8:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    d3bc:	b40030a5 	cbz	x5, d9d0 <_Z6qk_keyPKcmiRK8DataInfo+0x8e0>
    d3c0:	d37df087 	lsl	x7, x4, #3
    d3c4:	8b040ca4 	add	x4, x5, x4, lsl #3
    d3c8:	f9401869 	ldr	x9, [x3, #48]
    d3cc:	b8a768a8 	ldrsw	x8, [x5, x7]
    d3d0:	b9800487 	ldrsw	x7, [x4, #4]
    d3d4:	9b017d04 	mul	x4, x8, x1
    d3d8:	9b0910e7 	madd	x7, x7, x9, x4
    d3dc:	8b070807 	add	x7, x0, x7, lsl #2
    d3e0:	9100204a 	add	x10, x2, #0x8
    d3e4:	93407cc4 	sxtw	x4, w6
    d3e8:	bc2a68fa 	str	s26, [x7, x10]
    d3ec:	5e1806ba 	mov	d26, v21.d[1]
    d3f0:	0e55175a 	fadd	v26.4h, v26.4h, v21.4h
    d3f4:	0e217b5a 	fcvtl	v26.4s, v26.4h
    d3f8:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    d3fc:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    d400:	b4002ee5 	cbz	x5, d9dc <_Z6qk_keyPKcmiRK8DataInfo+0x8ec>
    d404:	d37df087 	lsl	x7, x4, #3
    d408:	8b040ca4 	add	x4, x5, x4, lsl #3
    d40c:	f9401869 	ldr	x9, [x3, #48]
    d410:	b8a768a8 	ldrsw	x8, [x5, x7]
    d414:	b9800487 	ldrsw	x7, [x4, #4]
    d418:	9b017d04 	mul	x4, x8, x1
    d41c:	9b0910e7 	madd	x7, x7, x9, x4
    d420:	8b070807 	add	x7, x0, x7, lsl #2
    d424:	91003048 	add	x8, x2, #0xc
    d428:	93407cc4 	sxtw	x4, w6
    d42c:	bc2868fa 	str	s26, [x7, x8]
    d430:	5e18069a 	mov	d26, v20.d[1]
    d434:	0e54175a 	fadd	v26.4h, v26.4h, v20.4h
    d438:	0e217b5a 	fcvtl	v26.4s, v26.4h
    d43c:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    d440:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    d444:	b4002d25 	cbz	x5, d9e8 <_Z6qk_keyPKcmiRK8DataInfo+0x8f8>
    d448:	d37df087 	lsl	x7, x4, #3
    d44c:	8b040ca4 	add	x4, x5, x4, lsl #3
    d450:	f940186c 	ldr	x12, [x3, #48]
    d454:	b8a768a7 	ldrsw	x7, [x5, x7]
    d458:	b9800489 	ldrsw	x9, [x4, #4]
    d45c:	9b017ce4 	mul	x4, x7, x1
    d460:	9b0c1129 	madd	x9, x9, x12, x4
    d464:	8b090809 	add	x9, x0, x9, lsl #2
    d468:	91004047 	add	x7, x2, #0x10
    d46c:	93407cc4 	sxtw	x4, w6
    d470:	bc27693a 	str	s26, [x9, x7]
    d474:	5e18073a 	mov	d26, v25.d[1]
    d478:	0e59175a 	fadd	v26.4h, v26.4h, v25.4h
    d47c:	0e217b5a 	fcvtl	v26.4s, v26.4h
    d480:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    d484:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    d488:	b4002b65 	cbz	x5, d9f4 <_Z6qk_keyPKcmiRK8DataInfo+0x904>
    d48c:	d37df089 	lsl	x9, x4, #3
    d490:	8b040ca4 	add	x4, x5, x4, lsl #3
    d494:	f940186d 	ldr	x13, [x3, #48]
    d498:	b8a968a9 	ldrsw	x9, [x5, x9]
    d49c:	b980048c 	ldrsw	x12, [x4, #4]
    d4a0:	9b017d24 	mul	x4, x9, x1
    d4a4:	9b0d118c 	madd	x12, x12, x13, x4
    d4a8:	8b0c080c 	add	x12, x0, x12, lsl #2
    d4ac:	91005044 	add	x4, x2, #0x14
    d4b0:	110004c9 	add	w9, w6, #0x1
    d4b4:	93407d29 	sxtw	x9, w9
    d4b8:	bc24699a 	str	s26, [x12, x4]
    d4bc:	5e18065a 	mov	d26, v18.d[1]
    d4c0:	0e52175a 	fadd	v26.4h, v26.4h, v18.4h
    d4c4:	0e217b5a 	fcvtl	v26.4s, v26.4h
    d4c8:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    d4cc:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    d4d0:	b4002985 	cbz	x5, da00 <_Z6qk_keyPKcmiRK8DataInfo+0x910>
    d4d4:	d37df12c 	lsl	x12, x9, #3
    d4d8:	8b090ca9 	add	x9, x5, x9, lsl #3
    d4dc:	f940186d 	ldr	x13, [x3, #48]
    d4e0:	b8ac68ac 	ldrsw	x12, [x5, x12]
    d4e4:	b9800529 	ldrsw	x9, [x9, #4]
    d4e8:	9b017d8c 	mul	x12, x12, x1
    d4ec:	9b0d3129 	madd	x9, x9, x13, x12
    d4f0:	8b090809 	add	x9, x0, x9, lsl #2
    d4f4:	bc22693a 	str	s26, [x9, x2]
    d4f8:	5e18063a 	mov	d26, v17.d[1]
    d4fc:	110004c9 	add	w9, w6, #0x1
    d500:	93407d29 	sxtw	x9, w9
    d504:	0e51175a 	fadd	v26.4h, v26.4h, v17.4h
    d508:	0e217b5a 	fcvtl	v26.4s, v26.4h
    d50c:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    d510:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    d514:	b40027c5 	cbz	x5, da0c <_Z6qk_keyPKcmiRK8DataInfo+0x91c>
    d518:	d37df12c 	lsl	x12, x9, #3
    d51c:	8b090ca9 	add	x9, x5, x9, lsl #3
    d520:	f940186d 	ldr	x13, [x3, #48]
    d524:	b8ac68ac 	ldrsw	x12, [x5, x12]
    d528:	b9800529 	ldrsw	x9, [x9, #4]
    d52c:	9b017d8c 	mul	x12, x12, x1
    d530:	9b0d3129 	madd	x9, x9, x13, x12
    d534:	8b090809 	add	x9, x0, x9, lsl #2
    d538:	bc2b693a 	str	s26, [x9, x11]
    d53c:	5e18061a 	mov	d26, v16.d[1]
    d540:	110004c9 	add	w9, w6, #0x1
    d544:	93407d29 	sxtw	x9, w9
    d548:	0e50175a 	fadd	v26.4h, v26.4h, v16.4h
    d54c:	0e217b5a 	fcvtl	v26.4s, v26.4h
    d550:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    d554:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    d558:	b4002605 	cbz	x5, da18 <_Z6qk_keyPKcmiRK8DataInfo+0x928>
    d55c:	d37df12c 	lsl	x12, x9, #3
    d560:	8b090ca9 	add	x9, x5, x9, lsl #3
    d564:	f940186d 	ldr	x13, [x3, #48]
    d568:	b8ac68ac 	ldrsw	x12, [x5, x12]
    d56c:	b9800529 	ldrsw	x9, [x9, #4]
    d570:	9b017d8c 	mul	x12, x12, x1
    d574:	9b0d3129 	madd	x9, x9, x13, x12
    d578:	8b090809 	add	x9, x0, x9, lsl #2
    d57c:	bc2a693a 	str	s26, [x9, x10]
    d580:	5e1804fa 	mov	d26, v7.d[1]
    d584:	110004c9 	add	w9, w6, #0x1
    d588:	93407d29 	sxtw	x9, w9
    d58c:	0e47175a 	fadd	v26.4h, v26.4h, v7.4h
    d590:	0e217b5a 	fcvtl	v26.4s, v26.4h
    d594:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    d598:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    d59c:	b4002445 	cbz	x5, da24 <_Z6qk_keyPKcmiRK8DataInfo+0x934>
    d5a0:	d37df12c 	lsl	x12, x9, #3
    d5a4:	8b090ca9 	add	x9, x5, x9, lsl #3
    d5a8:	f940186d 	ldr	x13, [x3, #48]
    d5ac:	b8ac68ac 	ldrsw	x12, [x5, x12]
    d5b0:	b9800529 	ldrsw	x9, [x9, #4]
    d5b4:	9b017d8c 	mul	x12, x12, x1
    d5b8:	9b0d3129 	madd	x9, x9, x13, x12
    d5bc:	8b090809 	add	x9, x0, x9, lsl #2
    d5c0:	bc28693a 	str	s26, [x9, x8]
    d5c4:	5e1804da 	mov	d26, v6.d[1]
    d5c8:	110004c9 	add	w9, w6, #0x1
    d5cc:	93407d29 	sxtw	x9, w9
    d5d0:	0e46175a 	fadd	v26.4h, v26.4h, v6.4h
    d5d4:	0e217b5a 	fcvtl	v26.4s, v26.4h
    d5d8:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    d5dc:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    d5e0:	b4002285 	cbz	x5, da30 <_Z6qk_keyPKcmiRK8DataInfo+0x940>
    d5e4:	d37df12c 	lsl	x12, x9, #3
    d5e8:	8b090ca9 	add	x9, x5, x9, lsl #3
    d5ec:	f940186d 	ldr	x13, [x3, #48]
    d5f0:	b8ac68ac 	ldrsw	x12, [x5, x12]
    d5f4:	b9800529 	ldrsw	x9, [x9, #4]
    d5f8:	9b017d8c 	mul	x12, x12, x1
    d5fc:	9b0d3129 	madd	x9, x9, x13, x12
    d600:	8b090809 	add	x9, x0, x9, lsl #2
    d604:	bc27693a 	str	s26, [x9, x7]
    d608:	5e18067a 	mov	d26, v19.d[1]
    d60c:	110004c9 	add	w9, w6, #0x1
    d610:	93407d29 	sxtw	x9, w9
    d614:	0e53175a 	fadd	v26.4h, v26.4h, v19.4h
    d618:	0e217b5a 	fcvtl	v26.4s, v26.4h
    d61c:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    d620:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    d624:	b40020c5 	cbz	x5, da3c <_Z6qk_keyPKcmiRK8DataInfo+0x94c>
    d628:	d37df12c 	lsl	x12, x9, #3
    d62c:	8b090ca9 	add	x9, x5, x9, lsl #3
    d630:	f940186d 	ldr	x13, [x3, #48]
    d634:	b8ac68ac 	ldrsw	x12, [x5, x12]
    d638:	b9800529 	ldrsw	x9, [x9, #4]
    d63c:	9b017d8c 	mul	x12, x12, x1
    d640:	9b0d3129 	madd	x9, x9, x13, x12
    d644:	8b090809 	add	x9, x0, x9, lsl #2
    d648:	bc24693a 	str	s26, [x9, x4]
    d64c:	5e18049a 	mov	d26, v4.d[1]
    d650:	110008c9 	add	w9, w6, #0x2
    d654:	93407d29 	sxtw	x9, w9
    d658:	0e44175a 	fadd	v26.4h, v26.4h, v4.4h
    d65c:	0e217b5a 	fcvtl	v26.4s, v26.4h
    d660:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    d664:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    d668:	b4001f05 	cbz	x5, da48 <_Z6qk_keyPKcmiRK8DataInfo+0x958>
    d66c:	d37df12c 	lsl	x12, x9, #3
    d670:	8b090ca9 	add	x9, x5, x9, lsl #3
    d674:	f940186d 	ldr	x13, [x3, #48]
    d678:	b8ac68ac 	ldrsw	x12, [x5, x12]
    d67c:	b9800529 	ldrsw	x9, [x9, #4]
    d680:	9b017d8c 	mul	x12, x12, x1
    d684:	9b0d3129 	madd	x9, x9, x13, x12
    d688:	8b090809 	add	x9, x0, x9, lsl #2
    d68c:	bc22693a 	str	s26, [x9, x2]
    d690:	5e18047a 	mov	d26, v3.d[1]
    d694:	110008c9 	add	w9, w6, #0x2
    d698:	93407d29 	sxtw	x9, w9
    d69c:	0e43175a 	fadd	v26.4h, v26.4h, v3.4h
    d6a0:	0e217b5a 	fcvtl	v26.4s, v26.4h
    d6a4:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    d6a8:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    d6ac:	b4001d45 	cbz	x5, da54 <_Z6qk_keyPKcmiRK8DataInfo+0x964>
    d6b0:	d37df12c 	lsl	x12, x9, #3
    d6b4:	8b090ca9 	add	x9, x5, x9, lsl #3
    d6b8:	f940186d 	ldr	x13, [x3, #48]
    d6bc:	b8ac68ac 	ldrsw	x12, [x5, x12]
    d6c0:	b9800529 	ldrsw	x9, [x9, #4]
    d6c4:	9b017d8c 	mul	x12, x12, x1
    d6c8:	9b0d3129 	madd	x9, x9, x13, x12
    d6cc:	8b090809 	add	x9, x0, x9, lsl #2
    d6d0:	bc2b693a 	str	s26, [x9, x11]
    d6d4:	5e18045a 	mov	d26, v2.d[1]
    d6d8:	110008c9 	add	w9, w6, #0x2
    d6dc:	93407d29 	sxtw	x9, w9
    d6e0:	0e42175a 	fadd	v26.4h, v26.4h, v2.4h
    d6e4:	0e217b5a 	fcvtl	v26.4s, v26.4h
    d6e8:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    d6ec:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    d6f0:	b4001b85 	cbz	x5, da60 <_Z6qk_keyPKcmiRK8DataInfo+0x970>
    d6f4:	d37df12c 	lsl	x12, x9, #3
    d6f8:	8b090ca9 	add	x9, x5, x9, lsl #3
    d6fc:	f940186d 	ldr	x13, [x3, #48]
    d700:	b8ac68ac 	ldrsw	x12, [x5, x12]
    d704:	b9800529 	ldrsw	x9, [x9, #4]
    d708:	9b017d8c 	mul	x12, x12, x1
    d70c:	9b0d3129 	madd	x9, x9, x13, x12
    d710:	8b090809 	add	x9, x0, x9, lsl #2
    d714:	bc2a693a 	str	s26, [x9, x10]
    d718:	5e18043a 	mov	d26, v1.d[1]
    d71c:	110008c9 	add	w9, w6, #0x2
    d720:	93407d29 	sxtw	x9, w9
    d724:	0e41175a 	fadd	v26.4h, v26.4h, v1.4h
    d728:	0e217b5a 	fcvtl	v26.4s, v26.4h
    d72c:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    d730:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    d734:	b40019c5 	cbz	x5, da6c <_Z6qk_keyPKcmiRK8DataInfo+0x97c>
    d738:	d37df12c 	lsl	x12, x9, #3
    d73c:	8b090ca9 	add	x9, x5, x9, lsl #3
    d740:	f940186d 	ldr	x13, [x3, #48]
    d744:	b8ac68ac 	ldrsw	x12, [x5, x12]
    d748:	b9800529 	ldrsw	x9, [x9, #4]
    d74c:	9b017d8c 	mul	x12, x12, x1
    d750:	9b0d3129 	madd	x9, x9, x13, x12
    d754:	8b090809 	add	x9, x0, x9, lsl #2
    d758:	bc28693a 	str	s26, [x9, x8]
    d75c:	5e18041a 	mov	d26, v0.d[1]
    d760:	110008c9 	add	w9, w6, #0x2
    d764:	93407d29 	sxtw	x9, w9
    d768:	0e40175a 	fadd	v26.4h, v26.4h, v0.4h
    d76c:	0e217b5a 	fcvtl	v26.4s, v26.4h
    d770:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    d774:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    d778:	b4001805 	cbz	x5, da78 <_Z6qk_keyPKcmiRK8DataInfo+0x988>
    d77c:	d37df12c 	lsl	x12, x9, #3
    d780:	8b090ca9 	add	x9, x5, x9, lsl #3
    d784:	f940186d 	ldr	x13, [x3, #48]
    d788:	b8ac68ac 	ldrsw	x12, [x5, x12]
    d78c:	b9800529 	ldrsw	x9, [x9, #4]
    d790:	9b017d8c 	mul	x12, x12, x1
    d794:	9b0d3129 	madd	x9, x9, x13, x12
    d798:	8b090809 	add	x9, x0, x9, lsl #2
    d79c:	bc27693a 	str	s26, [x9, x7]
    d7a0:	5e1804ba 	mov	d26, v5.d[1]
    d7a4:	110008c9 	add	w9, w6, #0x2
    d7a8:	93407d29 	sxtw	x9, w9
    d7ac:	0e45175a 	fadd	v26.4h, v26.4h, v5.4h
    d7b0:	0e217b5a 	fcvtl	v26.4s, v26.4h
    d7b4:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    d7b8:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    d7bc:	b4001645 	cbz	x5, da84 <_Z6qk_keyPKcmiRK8DataInfo+0x994>
    d7c0:	d37df12c 	lsl	x12, x9, #3
    d7c4:	8b090ca9 	add	x9, x5, x9, lsl #3
    d7c8:	f940186d 	ldr	x13, [x3, #48]
    d7cc:	b8ac68ac 	ldrsw	x12, [x5, x12]
    d7d0:	b9800529 	ldrsw	x9, [x9, #4]
    d7d4:	9b017d8c 	mul	x12, x12, x1
    d7d8:	9b0d3129 	madd	x9, x9, x13, x12
    d7dc:	8b090809 	add	x9, x0, x9, lsl #2
    d7e0:	bc24693a 	str	s26, [x9, x4]
    d7e4:	5e1807fa 	mov	d26, v31.d[1]
    d7e8:	11000cc9 	add	w9, w6, #0x3
    d7ec:	93407d29 	sxtw	x9, w9
    d7f0:	0e5f175a 	fadd	v26.4h, v26.4h, v31.4h
    d7f4:	0e217b5a 	fcvtl	v26.4s, v26.4h
    d7f8:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    d7fc:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    d800:	b4001485 	cbz	x5, da90 <_Z6qk_keyPKcmiRK8DataInfo+0x9a0>
    d804:	d37df12c 	lsl	x12, x9, #3
    d808:	8b090ca9 	add	x9, x5, x9, lsl #3
    d80c:	f940186d 	ldr	x13, [x3, #48]
    d810:	b8ac68ac 	ldrsw	x12, [x5, x12]
    d814:	b9800529 	ldrsw	x9, [x9, #4]
    d818:	9b017d8c 	mul	x12, x12, x1
    d81c:	9b0d3129 	madd	x9, x9, x13, x12
    d820:	8b090809 	add	x9, x0, x9, lsl #2
    d824:	bc22693a 	str	s26, [x9, x2]
    d828:	5e1807da 	mov	d26, v30.d[1]
    d82c:	11000cc2 	add	w2, w6, #0x3
    d830:	93407c42 	sxtw	x2, w2
    d834:	0e5e175a 	fadd	v26.4h, v26.4h, v30.4h
    d838:	0e217b5a 	fcvtl	v26.4s, v26.4h
    d83c:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    d840:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    d844:	b40012c5 	cbz	x5, da9c <_Z6qk_keyPKcmiRK8DataInfo+0x9ac>
    d848:	d37df049 	lsl	x9, x2, #3
    d84c:	8b020ca2 	add	x2, x5, x2, lsl #3
    d850:	f940186c 	ldr	x12, [x3, #48]
    d854:	b8a968a9 	ldrsw	x9, [x5, x9]
    d858:	b9800442 	ldrsw	x2, [x2, #4]
    d85c:	9b017d29 	mul	x9, x9, x1
    d860:	9b0c2442 	madd	x2, x2, x12, x9
    d864:	8b020802 	add	x2, x0, x2, lsl #2
    d868:	bc2b685a 	str	s26, [x2, x11]
    d86c:	5e1807ba 	mov	d26, v29.d[1]
    d870:	11000cc2 	add	w2, w6, #0x3
    d874:	93407c42 	sxtw	x2, w2
    d878:	0e5d175a 	fadd	v26.4h, v26.4h, v29.4h
    d87c:	0e217b5a 	fcvtl	v26.4s, v26.4h
    d880:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    d884:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    d888:	b4001105 	cbz	x5, daa8 <_Z6qk_keyPKcmiRK8DataInfo+0x9b8>
    d88c:	d37df049 	lsl	x9, x2, #3
    d890:	8b020ca2 	add	x2, x5, x2, lsl #3
    d894:	f940186b 	ldr	x11, [x3, #48]
    d898:	b8a968a9 	ldrsw	x9, [x5, x9]
    d89c:	b9800442 	ldrsw	x2, [x2, #4]
    d8a0:	9b017d29 	mul	x9, x9, x1
    d8a4:	9b0b2442 	madd	x2, x2, x11, x9
    d8a8:	8b020802 	add	x2, x0, x2, lsl #2
    d8ac:	bc2a685a 	str	s26, [x2, x10]
    d8b0:	5e18079a 	mov	d26, v28.d[1]
    d8b4:	11000cc2 	add	w2, w6, #0x3
    d8b8:	93407c42 	sxtw	x2, w2
    d8bc:	0e5c175a 	fadd	v26.4h, v26.4h, v28.4h
    d8c0:	0e217b5a 	fcvtl	v26.4s, v26.4h
    d8c4:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    d8c8:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    d8cc:	b4000f45 	cbz	x5, dab4 <_Z6qk_keyPKcmiRK8DataInfo+0x9c4>
    d8d0:	d37df049 	lsl	x9, x2, #3
    d8d4:	8b020ca2 	add	x2, x5, x2, lsl #3
    d8d8:	f940186a 	ldr	x10, [x3, #48]
    d8dc:	b8a968a9 	ldrsw	x9, [x5, x9]
    d8e0:	b9800442 	ldrsw	x2, [x2, #4]
    d8e4:	9b017d29 	mul	x9, x9, x1
    d8e8:	9b0a2442 	madd	x2, x2, x10, x9
    d8ec:	8b020802 	add	x2, x0, x2, lsl #2
    d8f0:	bc28685a 	str	s26, [x2, x8]
    d8f4:	5e18077a 	mov	d26, v27.d[1]
    d8f8:	11000cc2 	add	w2, w6, #0x3
    d8fc:	93407c42 	sxtw	x2, w2
    d900:	0e5b175a 	fadd	v26.4h, v26.4h, v27.4h
    d904:	0e217b5a 	fcvtl	v26.4s, v26.4h
    d908:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    d90c:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    d910:	b4000d85 	cbz	x5, dac0 <_Z6qk_keyPKcmiRK8DataInfo+0x9d0>
    d914:	d37df048 	lsl	x8, x2, #3
    d918:	8b020ca2 	add	x2, x5, x2, lsl #3
    d91c:	f9401869 	ldr	x9, [x3, #48]
    d920:	b8a868a8 	ldrsw	x8, [x5, x8]
    d924:	b9800442 	ldrsw	x2, [x2, #4]
    d928:	9b017d08 	mul	x8, x8, x1
    d92c:	9b092042 	madd	x2, x2, x9, x8
    d930:	8b020802 	add	x2, x0, x2, lsl #2
    d934:	bc27685a 	str	s26, [x2, x7]
    d938:	5e1805fa 	mov	d26, v15.d[1]
    d93c:	11000cc6 	add	w6, w6, #0x3
    d940:	93407cc6 	sxtw	x6, w6
    d944:	0e4f175a 	fadd	v26.4h, v26.4h, v15.4h
    d948:	0e217b5a 	fcvtl	v26.4s, v26.4h
    d94c:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    d950:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    d954:	b4000bc5 	cbz	x5, dacc <_Z6qk_keyPKcmiRK8DataInfo+0x9dc>
    d958:	d37df0c2 	lsl	x2, x6, #3
    d95c:	f9401867 	ldr	x7, [x3, #48]
    d960:	8b060ca6 	add	x6, x5, x6, lsl #3
    d964:	b8a268a3 	ldrsw	x3, [x5, x2]
    d968:	b98004c2 	ldrsw	x2, [x6, #4]
    d96c:	9b017c61 	mul	x1, x3, x1
    d970:	9b070441 	madd	x1, x2, x7, x1
    d974:	8b010800 	add	x0, x0, x1, lsl #2
    d978:	bc24681a 	str	s26, [x0, x4]
    d97c:	6d422fea 	ldp	d10, d11, [sp, #32]
    d980:	6d4337ec 	ldp	d12, d13, [sp, #48]
    d984:	6d443fee 	ldp	d14, d15, [sp, #64]
    d988:	a8c57bfd 	ldp	x29, x30, [sp], #80
    d98c:	d65f03c0 	ret
    d990:	93407cc7 	sxtw	x7, w6
    d994:	9b0a7ce7 	mul	x7, x7, x10
    d998:	8b0a00f0 	add	x16, x7, x10
    d99c:	8b070127 	add	x7, x9, x7
    d9a0:	8b0a0208 	add	x8, x16, x10
    d9a4:	8b100130 	add	x16, x9, x16
    d9a8:	8b0a010a 	add	x10, x8, x10
    d9ac:	8b080128 	add	x8, x9, x8
    d9b0:	8b0a0129 	add	x9, x9, x10
    d9b4:	17fffe00 	b	d1b4 <_Z6qk_keyPKcmiRK8DataInfo+0xc4>
    d9b8:	9b017c84 	mul	x4, x4, x1
    d9bc:	8b040807 	add	x7, x0, x4, lsl #2
    d9c0:	17fffe66 	b	d358 <_Z6qk_keyPKcmiRK8DataInfo+0x268>
    d9c4:	9b017c84 	mul	x4, x4, x1
    d9c8:	8b040807 	add	x7, x0, x4, lsl #2
    d9cc:	17fffe74 	b	d39c <_Z6qk_keyPKcmiRK8DataInfo+0x2ac>
    d9d0:	9b017c84 	mul	x4, x4, x1
    d9d4:	8b040807 	add	x7, x0, x4, lsl #2
    d9d8:	17fffe82 	b	d3e0 <_Z6qk_keyPKcmiRK8DataInfo+0x2f0>
    d9dc:	9b017c84 	mul	x4, x4, x1
    d9e0:	8b040807 	add	x7, x0, x4, lsl #2
    d9e4:	17fffe90 	b	d424 <_Z6qk_keyPKcmiRK8DataInfo+0x334>
    d9e8:	9b017c84 	mul	x4, x4, x1
    d9ec:	8b040809 	add	x9, x0, x4, lsl #2
    d9f0:	17fffe9e 	b	d468 <_Z6qk_keyPKcmiRK8DataInfo+0x378>
    d9f4:	9b017c84 	mul	x4, x4, x1
    d9f8:	8b04080c 	add	x12, x0, x4, lsl #2
    d9fc:	17fffeac 	b	d4ac <_Z6qk_keyPKcmiRK8DataInfo+0x3bc>
    da00:	9b017d29 	mul	x9, x9, x1
    da04:	8b090809 	add	x9, x0, x9, lsl #2
    da08:	17fffebb 	b	d4f4 <_Z6qk_keyPKcmiRK8DataInfo+0x404>
    da0c:	9b017d29 	mul	x9, x9, x1
    da10:	8b090809 	add	x9, x0, x9, lsl #2
    da14:	17fffec9 	b	d538 <_Z6qk_keyPKcmiRK8DataInfo+0x448>
    da18:	9b017d29 	mul	x9, x9, x1
    da1c:	8b090809 	add	x9, x0, x9, lsl #2
    da20:	17fffed7 	b	d57c <_Z6qk_keyPKcmiRK8DataInfo+0x48c>
    da24:	9b017d29 	mul	x9, x9, x1
    da28:	8b090809 	add	x9, x0, x9, lsl #2
    da2c:	17fffee5 	b	d5c0 <_Z6qk_keyPKcmiRK8DataInfo+0x4d0>
    da30:	9b017d29 	mul	x9, x9, x1
    da34:	8b090809 	add	x9, x0, x9, lsl #2
    da38:	17fffef3 	b	d604 <_Z6qk_keyPKcmiRK8DataInfo+0x514>
    da3c:	9b017d29 	mul	x9, x9, x1
    da40:	8b090809 	add	x9, x0, x9, lsl #2
    da44:	17ffff01 	b	d648 <_Z6qk_keyPKcmiRK8DataInfo+0x558>
    da48:	9b017d29 	mul	x9, x9, x1
    da4c:	8b090809 	add	x9, x0, x9, lsl #2
    da50:	17ffff0f 	b	d68c <_Z6qk_keyPKcmiRK8DataInfo+0x59c>
    da54:	9b017d29 	mul	x9, x9, x1
    da58:	8b090809 	add	x9, x0, x9, lsl #2
    da5c:	17ffff1d 	b	d6d0 <_Z6qk_keyPKcmiRK8DataInfo+0x5e0>
    da60:	9b017d29 	mul	x9, x9, x1
    da64:	8b090809 	add	x9, x0, x9, lsl #2
    da68:	17ffff2b 	b	d714 <_Z6qk_keyPKcmiRK8DataInfo+0x624>
    da6c:	9b017d29 	mul	x9, x9, x1
    da70:	8b090809 	add	x9, x0, x9, lsl #2
    da74:	17ffff39 	b	d758 <_Z6qk_keyPKcmiRK8DataInfo+0x668>
    da78:	9b017d29 	mul	x9, x9, x1
    da7c:	8b090809 	add	x9, x0, x9, lsl #2
    da80:	17ffff47 	b	d79c <_Z6qk_keyPKcmiRK8DataInfo+0x6ac>
    da84:	9b017d29 	mul	x9, x9, x1
    da88:	8b090809 	add	x9, x0, x9, lsl #2
    da8c:	17ffff55 	b	d7e0 <_Z6qk_keyPKcmiRK8DataInfo+0x6f0>
    da90:	9b017d29 	mul	x9, x9, x1
    da94:	8b090809 	add	x9, x0, x9, lsl #2
    da98:	17ffff63 	b	d824 <_Z6qk_keyPKcmiRK8DataInfo+0x734>
    da9c:	9b017c42 	mul	x2, x2, x1
    daa0:	8b020802 	add	x2, x0, x2, lsl #2
    daa4:	17ffff71 	b	d868 <_Z6qk_keyPKcmiRK8DataInfo+0x778>
    daa8:	9b017c42 	mul	x2, x2, x1
    daac:	8b020802 	add	x2, x0, x2, lsl #2
    dab0:	17ffff7f 	b	d8ac <_Z6qk_keyPKcmiRK8DataInfo+0x7bc>
    dab4:	9b017c42 	mul	x2, x2, x1
    dab8:	8b020802 	add	x2, x0, x2, lsl #2
    dabc:	17ffff8d 	b	d8f0 <_Z6qk_keyPKcmiRK8DataInfo+0x800>
    dac0:	9b017c42 	mul	x2, x2, x1
    dac4:	8b020802 	add	x2, x0, x2, lsl #2
    dac8:	17ffff9b 	b	d934 <_Z6qk_keyPKcmiRK8DataInfo+0x844>
    dacc:	9b017cc6 	mul	x6, x6, x1
    dad0:	8b060800 	add	x0, x0, x6, lsl #2
    dad4:	bc24681a 	str	s26, [x0, x4]
    dad8:	6d422fea 	ldp	d10, d11, [sp, #32]
    dadc:	6d4337ec 	ldp	d12, d13, [sp, #48]
    dae0:	6d443fee 	ldp	d14, d15, [sp, #64]
    dae4:	a8c57bfd 	ldp	x29, x30, [sp], #80
    dae8:	d65f03c0 	ret

Disassembly of section .fini:
