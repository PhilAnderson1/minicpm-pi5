
/home/philip/minicpm-pi5/build-qk-layout/bench:     file format elf64-littleaarch64


Disassembly of section .init:

Disassembly of section .plt:

Disassembly of section .text:

000000000000a310 <_Z9qk_directPKDhS0_Pfm.constprop.0>:
    a310:	3dc00039 	ldr	q25, [x1]
    a314:	91004024 	add	x4, x1, #0x10
    a318:	91004003 	add	x3, x0, #0x10
    a31c:	6dbc2be9 	stp	d9, d10, [sp, #-64]!
    a320:	91040005 	add	x5, x0, #0x100
    a324:	3dc0001f 	ldr	q31, [x0]
    a328:	fd001bef 	str	d15, [sp, #48]
    a32c:	3dc04033 	ldr	q19, [x1, #256]
    a330:	6d0133eb 	stp	d11, d12, [sp, #16]
    a334:	3dc0401e 	ldr	q30, [x0, #256]
    a338:	6d023bed 	stp	d13, d14, [sp, #32]
    a33c:	3dc08025 	ldr	q5, [x1, #512]
    a340:	6e591ff8 	fmul	v24.8h, v31.8h, v25.8h
    a344:	3dc0801d 	ldr	q29, [x0, #512]
    a348:	6e531ff2 	fmul	v18.8h, v31.8h, v19.8h
    a34c:	3dc0c02f 	ldr	q15, [x1, #768]
    a350:	6e591fd7 	fmul	v23.8h, v30.8h, v25.8h
    a354:	6e531fd1 	fmul	v17.8h, v30.8h, v19.8h
    a358:	3dc0c01c 	ldr	q28, [x0, #768]
    a35c:	6e451fe4 	fmul	v4.8h, v31.8h, v5.8h
    a360:	6e451fc3 	fmul	v3.8h, v30.8h, v5.8h
    a364:	3dc1001b 	ldr	q27, [x0, #1024]
    a368:	6e591fb6 	fmul	v22.8h, v29.8h, v25.8h
    a36c:	6e531fb0 	fmul	v16.8h, v29.8h, v19.8h
    a370:	3dc1401a 	ldr	q26, [x0, #1280]
    a374:	6e451fa2 	fmul	v2.8h, v29.8h, v5.8h
    a378:	6e4f1fff 	fmul	v31.8h, v31.8h, v15.8h
    a37c:	6e591f95 	fmul	v21.8h, v28.8h, v25.8h
    a380:	6e531f87 	fmul	v7.8h, v28.8h, v19.8h
    a384:	6e451f81 	fmul	v1.8h, v28.8h, v5.8h
    a388:	6e591f74 	fmul	v20.8h, v27.8h, v25.8h
    a38c:	6e531f66 	fmul	v6.8h, v27.8h, v19.8h
    a390:	6e451f60 	fmul	v0.8h, v27.8h, v5.8h
    a394:	6e4f1fde 	fmul	v30.8h, v30.8h, v15.8h
    a398:	6e4f1fbd 	fmul	v29.8h, v29.8h, v15.8h
    a39c:	6e4f1f9c 	fmul	v28.8h, v28.8h, v15.8h
    a3a0:	6e4f1f7b 	fmul	v27.8h, v27.8h, v15.8h
    a3a4:	6e591f59 	fmul	v25.8h, v26.8h, v25.8h
    a3a8:	6e531f53 	fmul	v19.8h, v26.8h, v19.8h
    a3ac:	6e451f45 	fmul	v5.8h, v26.8h, v5.8h
    a3b0:	6e4f1f4f 	fmul	v15.8h, v26.8h, v15.8h
    a3b4:	d503201f 	nop
    a3b8:	d503201f 	nop
    a3bc:	d503201f 	nop
    a3c0:	3dc0009a 	ldr	q26, [x4]
    a3c4:	91004063 	add	x3, x3, #0x10
    a3c8:	91004084 	add	x4, x4, #0x10
    a3cc:	3cdf006e 	ldur	q14, [x3, #-16]
    a3d0:	3dc03c6d 	ldr	q13, [x3, #240]
    a3d4:	3dc07c6c 	ldr	q12, [x3, #496]
    a3d8:	3dc0bc6b 	ldr	q11, [x3, #752]
    a3dc:	4e4e0f58 	fmla	v24.8h, v26.8h, v14.8h
    a3e0:	3dc0fc6a 	ldr	q10, [x3, #1008]
    a3e4:	4e4d0f57 	fmla	v23.8h, v26.8h, v13.8h
    a3e8:	3dc13c69 	ldr	q9, [x3, #1264]
    a3ec:	4e4c0f56 	fmla	v22.8h, v26.8h, v12.8h
    a3f0:	4e4b0f55 	fmla	v21.8h, v26.8h, v11.8h
    a3f4:	4e4a0f54 	fmla	v20.8h, v26.8h, v10.8h
    a3f8:	4e490f59 	fmla	v25.8h, v26.8h, v9.8h
    a3fc:	3dc03c9a 	ldr	q26, [x4, #240]
    a400:	4e4e0f52 	fmla	v18.8h, v26.8h, v14.8h
    a404:	4e4d0f51 	fmla	v17.8h, v26.8h, v13.8h
    a408:	4e4c0f50 	fmla	v16.8h, v26.8h, v12.8h
    a40c:	4e4b0f47 	fmla	v7.8h, v26.8h, v11.8h
    a410:	4e4a0f46 	fmla	v6.8h, v26.8h, v10.8h
    a414:	4e490f53 	fmla	v19.8h, v26.8h, v9.8h
    a418:	3dc07c9a 	ldr	q26, [x4, #496]
    a41c:	4e4e0f44 	fmla	v4.8h, v26.8h, v14.8h
    a420:	4e4d0f43 	fmla	v3.8h, v26.8h, v13.8h
    a424:	4e4c0f42 	fmla	v2.8h, v26.8h, v12.8h
    a428:	4e4b0f41 	fmla	v1.8h, v26.8h, v11.8h
    a42c:	4e4a0f40 	fmla	v0.8h, v26.8h, v10.8h
    a430:	4e490f45 	fmla	v5.8h, v26.8h, v9.8h
    a434:	3dc0bc9a 	ldr	q26, [x4, #752]
    a438:	4e4e0f5f 	fmla	v31.8h, v26.8h, v14.8h
    a43c:	4e4d0f5e 	fmla	v30.8h, v26.8h, v13.8h
    a440:	4e4c0f5d 	fmla	v29.8h, v26.8h, v12.8h
    a444:	4e4b0f5c 	fmla	v28.8h, v26.8h, v11.8h
    a448:	4e4a0f5b 	fmla	v27.8h, v26.8h, v10.8h
    a44c:	4e490f4f 	fmla	v15.8h, v26.8h, v9.8h
    a450:	eb0300bf 	cmp	x5, x3
    a454:	54fffb61 	b.ne	a3c0 <_Z9qk_directPKDhS0_Pfm.constprop.0+0xb0>  // b.any
    a458:	5e18071a 	mov	d26, v24.d[1]
    a45c:	6d4133eb 	ldp	d11, d12, [sp, #16]
    a460:	6d423bed 	ldp	d13, d14, [sp, #32]
    a464:	0e58175a 	fadd	v26.4h, v26.4h, v24.4h
    a468:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a46c:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a470:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a474:	bd00005a 	str	s26, [x2]
    a478:	5e1806fa 	mov	d26, v23.d[1]
    a47c:	0e57175a 	fadd	v26.4h, v26.4h, v23.4h
    a480:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a484:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a488:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a48c:	bd00045a 	str	s26, [x2, #4]
    a490:	5e1806da 	mov	d26, v22.d[1]
    a494:	0e56175a 	fadd	v26.4h, v26.4h, v22.4h
    a498:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a49c:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a4a0:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a4a4:	bd00085a 	str	s26, [x2, #8]
    a4a8:	5e1806ba 	mov	d26, v21.d[1]
    a4ac:	0e55175a 	fadd	v26.4h, v26.4h, v21.4h
    a4b0:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a4b4:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a4b8:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a4bc:	bd000c5a 	str	s26, [x2, #12]
    a4c0:	5e18069a 	mov	d26, v20.d[1]
    a4c4:	0e54175a 	fadd	v26.4h, v26.4h, v20.4h
    a4c8:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a4cc:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a4d0:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a4d4:	bd00105a 	str	s26, [x2, #16]
    a4d8:	5e18073a 	mov	d26, v25.d[1]
    a4dc:	0e59175a 	fadd	v26.4h, v26.4h, v25.4h
    a4e0:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a4e4:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a4e8:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a4ec:	bd00145a 	str	s26, [x2, #20]
    a4f0:	5e18065a 	mov	d26, v18.d[1]
    a4f4:	0e52175a 	fadd	v26.4h, v26.4h, v18.4h
    a4f8:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a4fc:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a500:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a504:	bd02005a 	str	s26, [x2, #512]
    a508:	5e18063a 	mov	d26, v17.d[1]
    a50c:	0e51175a 	fadd	v26.4h, v26.4h, v17.4h
    a510:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a514:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a518:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a51c:	bd02045a 	str	s26, [x2, #516]
    a520:	5e18061a 	mov	d26, v16.d[1]
    a524:	0e50175a 	fadd	v26.4h, v26.4h, v16.4h
    a528:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a52c:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a530:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a534:	bd02085a 	str	s26, [x2, #520]
    a538:	5e1804fa 	mov	d26, v7.d[1]
    a53c:	0e47175a 	fadd	v26.4h, v26.4h, v7.4h
    a540:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a544:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a548:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a54c:	bd020c5a 	str	s26, [x2, #524]
    a550:	5e1804da 	mov	d26, v6.d[1]
    a554:	0e46175a 	fadd	v26.4h, v26.4h, v6.4h
    a558:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a55c:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a560:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a564:	bd02105a 	str	s26, [x2, #528]
    a568:	5e18067a 	mov	d26, v19.d[1]
    a56c:	0e53175a 	fadd	v26.4h, v26.4h, v19.4h
    a570:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a574:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a578:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a57c:	bd02145a 	str	s26, [x2, #532]
    a580:	5e18049a 	mov	d26, v4.d[1]
    a584:	0e44175a 	fadd	v26.4h, v26.4h, v4.4h
    a588:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a58c:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a590:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a594:	bd04005a 	str	s26, [x2, #1024]
    a598:	5e18047a 	mov	d26, v3.d[1]
    a59c:	0e43175a 	fadd	v26.4h, v26.4h, v3.4h
    a5a0:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a5a4:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a5a8:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a5ac:	bd04045a 	str	s26, [x2, #1028]
    a5b0:	5e18045a 	mov	d26, v2.d[1]
    a5b4:	0e42175a 	fadd	v26.4h, v26.4h, v2.4h
    a5b8:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a5bc:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a5c0:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a5c4:	bd04085a 	str	s26, [x2, #1032]
    a5c8:	5e18043a 	mov	d26, v1.d[1]
    a5cc:	0e41175a 	fadd	v26.4h, v26.4h, v1.4h
    a5d0:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a5d4:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a5d8:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a5dc:	bd040c5a 	str	s26, [x2, #1036]
    a5e0:	5e18041a 	mov	d26, v0.d[1]
    a5e4:	0e40175a 	fadd	v26.4h, v26.4h, v0.4h
    a5e8:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a5ec:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a5f0:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a5f4:	bd04105a 	str	s26, [x2, #1040]
    a5f8:	5e1804ba 	mov	d26, v5.d[1]
    a5fc:	0e45175a 	fadd	v26.4h, v26.4h, v5.4h
    a600:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a604:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a608:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a60c:	bd04145a 	str	s26, [x2, #1044]
    a610:	5e1807fa 	mov	d26, v31.d[1]
    a614:	0e5f175a 	fadd	v26.4h, v26.4h, v31.4h
    a618:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a61c:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a620:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a624:	bd06005a 	str	s26, [x2, #1536]
    a628:	5e1807da 	mov	d26, v30.d[1]
    a62c:	0e5e175a 	fadd	v26.4h, v26.4h, v30.4h
    a630:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a634:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a638:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a63c:	bd06045a 	str	s26, [x2, #1540]
    a640:	5e1807ba 	mov	d26, v29.d[1]
    a644:	0e5d175a 	fadd	v26.4h, v26.4h, v29.4h
    a648:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a64c:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a650:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a654:	bd06085a 	str	s26, [x2, #1544]
    a658:	5e18079a 	mov	d26, v28.d[1]
    a65c:	0e5c175a 	fadd	v26.4h, v26.4h, v28.4h
    a660:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a664:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a668:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a66c:	bd060c5a 	str	s26, [x2, #1548]
    a670:	5e18077a 	mov	d26, v27.d[1]
    a674:	0e5b175a 	fadd	v26.4h, v26.4h, v27.4h
    a678:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a67c:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a680:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a684:	bd06105a 	str	s26, [x2, #1552]
    a688:	5e1805fa 	mov	d26, v15.d[1]
    a68c:	0e4f175a 	fadd	v26.4h, v26.4h, v15.4h
    a690:	fd401bef 	ldr	d15, [sp, #48]
    a694:	6cc42be9 	ldp	d9, d10, [sp], #64
    a698:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a69c:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a6a0:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a6a4:	bd06145a 	str	s26, [x2, #1556]
    a6a8:	d65f03c0 	ret

Disassembly of section .fini:
