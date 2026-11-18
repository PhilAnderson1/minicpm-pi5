000000000000a280 <value_ahead(half*, (anonymous namespace)::HelperF16 const&, (anonymous namespace)::FlashMS<64, 128, true> const&)>:
    a280:	a9bb7bfd 	stp	x29, x30, [sp, #-80]!
    a284:	910003fd 	mov	x29, sp
    a288:	aa0203f1 	mov	x17, x2
    a28c:	4f00041e 	movi	v30.4s, #0x0
    a290:	aa0003f2 	mov	x18, x0
    a294:	91082042 	add	x2, x2, #0x208
    a298:	aa0103ef 	mov	x15, x1
    a29c:	91401003 	add	x3, x0, #0x4, lsl #12
    a2a0:	6d0127e8 	stp	d8, d9, [sp, #16]
    a2a4:	6d022fea 	stp	d10, d11, [sp, #32]
    a2a8:	6d0337ec 	stp	d12, d13, [sp, #48]
    a2ac:	6d043fee 	stp	d14, d15, [sp, #64]
    a2b0:	14000007 	b	a2cc <value_ahead(half*, (anonymous namespace)::HelperF16 const&, (anonymous namespace)::FlashMS<64, 128, true> const&)+0x4c>
    a2b4:	7100043f 	cmp	w1, #0x1
    a2b8:	54001660 	b.eq	a584 <value_ahead(half*, (anonymous namespace)::HelperF16 const&, (anonymous namespace)::FlashMS<64, 128, true> const&)+0x304>  // b.none
    a2bc:	91040000 	add	x0, x0, #0x100
    a2c0:	91001042 	add	x2, x2, #0x4
    a2c4:	eb03001f 	cmp	x0, x3
    a2c8:	54000200 	b.eq	a308 <value_ahead(half*, (anonymous namespace)::HelperF16 const&, (anonymous namespace)::FlashMS<64, 128, true> const&)+0x88>  // b.none
    a2cc:	b9400041 	ldr	w1, [x2]
    a2d0:	7100083f 	cmp	w1, #0x2
    a2d4:	54ffff01 	b.ne	a2b4 <value_ahead(half*, (anonymous namespace)::HelperF16 const&, (anonymous namespace)::FlashMS<64, 128, true> const&)+0x34>  // b.any
    a2d8:	91040000 	add	x0, x0, #0x100
    a2dc:	91001042 	add	x2, x2, #0x4
    a2e0:	ad38781e 	stp	q30, q30, [x0, #-256]
    a2e4:	ad39781e 	stp	q30, q30, [x0, #-224]
    a2e8:	ad3a781e 	stp	q30, q30, [x0, #-192]
    a2ec:	ad3b781e 	stp	q30, q30, [x0, #-160]
    a2f0:	ad3c781e 	stp	q30, q30, [x0, #-128]
    a2f4:	ad3d781e 	stp	q30, q30, [x0, #-96]
    a2f8:	ad3e781e 	stp	q30, q30, [x0, #-64]
    a2fc:	ad3f781e 	stp	q30, q30, [x0, #-32]
    a300:	eb03001f 	cmp	x0, x3
    a304:	54fffe41 	b.ne	a2cc <value_ahead(half*, (anonymous namespace)::HelperF16 const&, (anonymous namespace)::FlashMS<64, 128, true> const&)+0x4c>  // b.any
    a308:	d280001e 	mov	x30, #0x0                   	// #0
    a30c:	d37e7fd0 	ubfiz	x16, x30, #2, #32
    a310:	aa1203ee 	mov	x14, x18
    a314:	d2800206 	mov	x6, #0x10                  	// #16
    a318:	ad4075de 	ldp	q30, q29, [x14]
    a31c:	52800002 	mov	w2, #0x0                   	// #0
    a320:	d10040cb 	sub	x11, x6, #0x10
    a324:	910040ca 	add	x10, x6, #0x10
    a328:	910080c9 	add	x9, x6, #0x20
    a32c:	ad416ddc 	ldp	q28, q27, [x14, #32]
    a330:	aa1003e8 	mov	x8, x16
    a334:	ad4865da 	ldp	q26, q25, [x14, #256]
    a338:	ad497dd8 	ldp	q24, q31, [x14, #288]
    a33c:	ad5059d7 	ldp	q23, q22, [x14, #512]
    a340:	ad5151d5 	ldp	q21, q20, [x14, #544]
    a344:	ad5849d3 	ldp	q19, q18, [x14, #768]
    a348:	ad5941d1 	ldp	q17, q16, [x14, #800]
    a34c:	f940022d 	ldr	x13, [x17]
    a350:	f94005e7 	ldr	x7, [x15, #8]
    a354:	b94011e5 	ldr	w5, [x15, #16]
    a358:	d503201f 	nop
    a35c:	d503201f 	nop
    a360:	8b0801ac 	add	x12, x13, x8
    a364:	1b027ca4 	mul	w4, w5, w2
    a368:	8b24c0e4 	add	x4, x7, w4, sxtw
    a36c:	3ce869a7 	ldr	q7, [x13, x8]
    a370:	1b051443 	madd	w3, w2, w5, w5
    a374:	8b23c0e3 	add	x3, x7, w3, sxtw
    a378:	11000841 	add	w1, w2, #0x2
    a37c:	11000c40 	add	w0, w2, #0x3
    a380:	3dc08186 	ldr	q6, [x12, #512]
    a384:	11001042 	add	w2, w2, #0x4
    a388:	91004108 	add	x8, x8, #0x10
    a38c:	1b057c21 	mul	w1, w1, w5
    a390:	8b21c0e1 	add	x1, x7, w1, sxtw
    a394:	3dc10185 	ldr	q5, [x12, #1024]
    a398:	1b057c00 	mul	w0, w0, w5
    a39c:	8b20c0e0 	add	x0, x7, w0, sxtw
    a3a0:	3dc18184 	ldr	q4, [x12, #1536]
    a3a4:	0e2168e7 	fcvtn	v7.4h, v7.4s
    a3a8:	3ce96880 	ldr	q0, [x4, x9]
    a3ac:	0e2168c6 	fcvtn	v6.4h, v6.4s
    a3b0:	3ceb6883 	ldr	q3, [x4, x11]
    a3b4:	0e2168a5 	fcvtn	v5.4h, v5.4s
    a3b8:	3ce66882 	ldr	q2, [x4, x6]
    a3bc:	0e216884 	fcvtn	v4.4h, v4.4s
    a3c0:	3cea6881 	ldr	q1, [x4, x10]
    a3c4:	4f07101b 	fmla	v27.8h, v0.8h, v7.h[0]
    a3c8:	3ce9686c 	ldr	q12, [x3, x9]
    a3cc:	4f07107e 	fmla	v30.8h, v3.8h, v7.h[0]
    a3d0:	3ceb686f 	ldr	q15, [x3, x11]
    a3d4:	3ce6686e 	ldr	q14, [x3, x6]
    a3d8:	4f07105d 	fmla	v29.8h, v2.8h, v7.h[0]
    a3dc:	3cea686d 	ldr	q13, [x3, x10]
    a3e0:	4f07103c 	fmla	v28.8h, v1.8h, v7.h[0]
    a3e4:	3ceb682b 	ldr	q11, [x1, x11]
    a3e8:	4f041010 	fmla	v16.8h, v0.8h, v4.h[0]
    a3ec:	3ce6682a 	ldr	q10, [x1, x6]
    a3f0:	3cea6829 	ldr	q9, [x1, x10]
    a3f4:	4f041073 	fmla	v19.8h, v3.8h, v4.h[0]
    a3f8:	3ce96828 	ldr	q8, [x1, x9]
    a3fc:	4f06107a 	fmla	v26.8h, v3.8h, v6.h[0]
    a400:	4f051077 	fmla	v23.8h, v3.8h, v5.h[0]
    a404:	4e0604e3 	dup	v3.8h, v7.h[1]
    a408:	4f041052 	fmla	v18.8h, v2.8h, v4.h[0]
    a40c:	4f041031 	fmla	v17.8h, v1.8h, v4.h[0]
    a410:	4f06101f 	fmla	v31.8h, v0.8h, v6.h[0]
    a414:	4f051014 	fmla	v20.8h, v0.8h, v5.h[0]
    a418:	4e060480 	dup	v0.8h, v4.h[1]
    a41c:	4f061059 	fmla	v25.8h, v2.8h, v6.h[0]
    a420:	4f061038 	fmla	v24.8h, v1.8h, v6.h[0]
    a424:	4f051056 	fmla	v22.8h, v2.8h, v5.h[0]
    a428:	4e0604c2 	dup	v2.8h, v6.h[1]
    a42c:	4e430d9b 	fmla	v27.8h, v12.8h, v3.8h
    a430:	4e430dfe 	fmla	v30.8h, v15.8h, v3.8h
    a434:	4e430ddd 	fmla	v29.8h, v14.8h, v3.8h
    a438:	4e430dbc 	fmla	v28.8h, v13.8h, v3.8h
    a43c:	3ce66803 	ldr	q3, [x0, x6]
    a440:	4e400d90 	fmla	v16.8h, v12.8h, v0.8h
    a444:	4e400df3 	fmla	v19.8h, v15.8h, v0.8h
    a448:	4e400dd2 	fmla	v18.8h, v14.8h, v0.8h
    a44c:	4e400db1 	fmla	v17.8h, v13.8h, v0.8h
    a450:	4e0a04e0 	dup	v0.8h, v7.h[2]
    a454:	4e0e04e7 	dup	v7.8h, v7.h[3]
    a458:	4f051035 	fmla	v21.8h, v1.8h, v5.h[0]
    a45c:	4e0604a1 	dup	v1.8h, v5.h[1]
    a460:	4e420d9f 	fmla	v31.8h, v12.8h, v2.8h
    a464:	4e420dfa 	fmla	v26.8h, v15.8h, v2.8h
    a468:	4e420dd9 	fmla	v25.8h, v14.8h, v2.8h
    a46c:	4e420db8 	fmla	v24.8h, v13.8h, v2.8h
    a470:	3cea6802 	ldr	q2, [x0, x10]
    a474:	4e400d7e 	fmla	v30.8h, v11.8h, v0.8h
    a478:	4e400d5d 	fmla	v29.8h, v10.8h, v0.8h
    a47c:	4e400d3c 	fmla	v28.8h, v9.8h, v0.8h
    a480:	4e400d1b 	fmla	v27.8h, v8.8h, v0.8h
    a484:	4e0a04c0 	dup	v0.8h, v6.h[2]
    a488:	4e0e04c6 	dup	v6.8h, v6.h[3]
    a48c:	4e410d94 	fmla	v20.8h, v12.8h, v1.8h
    a490:	3ceb680c 	ldr	q12, [x0, x11]
    a494:	4e410df7 	fmla	v23.8h, v15.8h, v1.8h
    a498:	4e410dd6 	fmla	v22.8h, v14.8h, v1.8h
    a49c:	4e410db5 	fmla	v21.8h, v13.8h, v1.8h
    a4a0:	3ce96801 	ldr	q1, [x0, x9]
    a4a4:	4e400d7a 	fmla	v26.8h, v11.8h, v0.8h
    a4a8:	4e400d59 	fmla	v25.8h, v10.8h, v0.8h
    a4ac:	4e400d38 	fmla	v24.8h, v9.8h, v0.8h
    a4b0:	4e400d1f 	fmla	v31.8h, v8.8h, v0.8h
    a4b4:	4e0a04a0 	dup	v0.8h, v5.h[2]
    a4b8:	4e0e04a5 	dup	v5.8h, v5.h[3]
    a4bc:	4e470d9e 	fmla	v30.8h, v12.8h, v7.8h
    a4c0:	4e400d77 	fmla	v23.8h, v11.8h, v0.8h
    a4c4:	4e400d56 	fmla	v22.8h, v10.8h, v0.8h
    a4c8:	4e400d35 	fmla	v21.8h, v9.8h, v0.8h
    a4cc:	4e400d14 	fmla	v20.8h, v8.8h, v0.8h
    a4d0:	4e0a0480 	dup	v0.8h, v4.h[2]
    a4d4:	4e0e0484 	dup	v4.8h, v4.h[3]
    a4d8:	4e460d9a 	fmla	v26.8h, v12.8h, v6.8h
    a4dc:	4e400d73 	fmla	v19.8h, v11.8h, v0.8h
    a4e0:	4e400d52 	fmla	v18.8h, v10.8h, v0.8h
    a4e4:	4e400d31 	fmla	v17.8h, v9.8h, v0.8h
    a4e8:	4e400d10 	fmla	v16.8h, v8.8h, v0.8h
    a4ec:	4e450d97 	fmla	v23.8h, v12.8h, v5.8h
    a4f0:	4e440d93 	fmla	v19.8h, v12.8h, v4.8h
    a4f4:	4e470c7d 	fmla	v29.8h, v3.8h, v7.8h
    a4f8:	4e460c79 	fmla	v25.8h, v3.8h, v6.8h
    a4fc:	4e450c76 	fmla	v22.8h, v3.8h, v5.8h
    a500:	4e440c72 	fmla	v18.8h, v3.8h, v4.8h
    a504:	4e470c5c 	fmla	v28.8h, v2.8h, v7.8h
    a508:	4e460c58 	fmla	v24.8h, v2.8h, v6.8h
    a50c:	4e450c55 	fmla	v21.8h, v2.8h, v5.8h
    a510:	4e440c51 	fmla	v17.8h, v2.8h, v4.8h
    a514:	4e470c3b 	fmla	v27.8h, v1.8h, v7.8h
    a518:	4e460c3f 	fmla	v31.8h, v1.8h, v6.8h
    a51c:	4e450c34 	fmla	v20.8h, v1.8h, v5.8h
    a520:	4e440c30 	fmla	v16.8h, v1.8h, v4.8h
    a524:	7102005f 	cmp	w2, #0x80
    a528:	54fff1c1 	b.ne	a360 <value_ahead(half*, (anonymous namespace)::HelperF16 const&, (anonymous namespace)::FlashMS<64, 128, true> const&)+0xe0>  // b.any
    a52c:	910100c6 	add	x6, x6, #0x40
    a530:	910101ce 	add	x14, x14, #0x40
    a534:	ad3e75de 	stp	q30, q29, [x14, #-64]
    a538:	ad3f6ddc 	stp	q28, q27, [x14, #-32]
    a53c:	ad0665da 	stp	q26, q25, [x14, #192]
    a540:	ad077dd8 	stp	q24, q31, [x14, #224]
    a544:	ad0e59d7 	stp	q23, q22, [x14, #448]
    a548:	ad0f51d5 	stp	q21, q20, [x14, #480]
    a54c:	ad1649d3 	stp	q19, q18, [x14, #704]
    a550:	ad1741d1 	stp	q17, q16, [x14, #736]
    a554:	f10440df 	cmp	x6, #0x110
    a558:	54ffee01 	b.ne	a318 <value_ahead(half*, (anonymous namespace)::HelperF16 const&, (anonymous namespace)::FlashMS<64, 128, true> const&)+0x98>  // b.any
    a55c:	910803de 	add	x30, x30, #0x200
    a560:	91100252 	add	x18, x18, #0x400
    a564:	f1400bdf 	cmp	x30, #0x2, lsl #12
    a568:	54ffed21 	b.ne	a30c <value_ahead(half*, (anonymous namespace)::HelperF16 const&, (anonymous namespace)::FlashMS<64, 128, true> const&)+0x8c>  // b.any
    a56c:	6d4127e8 	ldp	d8, d9, [sp, #16]
    a570:	6d422fea 	ldp	d10, d11, [sp, #32]
    a574:	6d4337ec 	ldp	d12, d13, [sp, #48]
    a578:	6d443fee 	ldp	d14, d15, [sp, #64]
    a57c:	a8c57bfd 	ldp	x29, x30, [sp], #80
    a580:	d65f03c0 	ret
    a584:	bd410047 	ldr	s7, [x2, #256]
    a588:	ad405817 	ldp	q23, q22, [x0]
    a58c:	ad415015 	ldp	q21, q20, [x0, #32]
    a590:	ad424813 	ldp	q19, q18, [x0, #64]
    a594:	1e23c0e7 	fcvt	h7, s7
    a598:	ad434011 	ldp	q17, q16, [x0, #96]
    a59c:	ad441406 	ldp	q6, q5, [x0, #128]
    a5a0:	ad450c04 	ldp	q4, q3, [x0, #160]
    a5a4:	4f0792f7 	fmul	v23.8h, v23.8h, v7.h[0]
    a5a8:	ad460402 	ldp	q2, q1, [x0, #192]
    a5ac:	4f0792d6 	fmul	v22.8h, v22.8h, v7.h[0]
    a5b0:	ad477c00 	ldp	q0, q31, [x0, #224]
    a5b4:	4f0792b5 	fmul	v21.8h, v21.8h, v7.h[0]
    a5b8:	4f079294 	fmul	v20.8h, v20.8h, v7.h[0]
    a5bc:	4f079273 	fmul	v19.8h, v19.8h, v7.h[0]
    a5c0:	4f079252 	fmul	v18.8h, v18.8h, v7.h[0]
    a5c4:	4f079231 	fmul	v17.8h, v17.8h, v7.h[0]
    a5c8:	4f079210 	fmul	v16.8h, v16.8h, v7.h[0]
    a5cc:	4f0790c6 	fmul	v6.8h, v6.8h, v7.h[0]
    a5d0:	4f0790a5 	fmul	v5.8h, v5.8h, v7.h[0]
    a5d4:	4f079084 	fmul	v4.8h, v4.8h, v7.h[0]
    a5d8:	4f079063 	fmul	v3.8h, v3.8h, v7.h[0]
    a5dc:	4f079042 	fmul	v2.8h, v2.8h, v7.h[0]
    a5e0:	4f079021 	fmul	v1.8h, v1.8h, v7.h[0]
    a5e4:	4f079000 	fmul	v0.8h, v0.8h, v7.h[0]
    a5e8:	4f0793ff 	fmul	v31.8h, v31.8h, v7.h[0]
    a5ec:	ad005817 	stp	q23, q22, [x0]
    a5f0:	ad015015 	stp	q21, q20, [x0, #32]
    a5f4:	ad024813 	stp	q19, q18, [x0, #64]
    a5f8:	ad034011 	stp	q17, q16, [x0, #96]
    a5fc:	ad041406 	stp	q6, q5, [x0, #128]
    a600:	ad050c04 	stp	q4, q3, [x0, #160]
    a604:	ad060402 	stp	q2, q1, [x0, #192]
    a608:	ad077c00 	stp	q0, q31, [x0, #224]
    a60c:	17ffff2c 	b	a2bc <value_ahead(half*, (anonymous namespace)::HelperF16 const&, (anonymous namespace)::FlashMS<64, 128, true> const&)+0x3c>
