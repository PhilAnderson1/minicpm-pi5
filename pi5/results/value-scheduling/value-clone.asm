0000000000009f00 <value_clone(half*, (anonymous namespace)::HelperF16 const&, (anonymous namespace)::FlashMS<64, 128, true> const&)>:
    9f00:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
    9f04:	910003fd 	mov	x29, sp
    9f08:	aa0203f1 	mov	x17, x2
    9f0c:	4f00041e 	movi	v30.4s, #0x0
    9f10:	aa0003f2 	mov	x18, x0
    9f14:	91082042 	add	x2, x2, #0x208
    9f18:	aa0103ef 	mov	x15, x1
    9f1c:	91401003 	add	x3, x0, #0x4, lsl #12
    9f20:	6d0137ec 	stp	d12, d13, [sp, #16]
    9f24:	6d023fee 	stp	d14, d15, [sp, #32]
    9f28:	14000007 	b	9f44 <value_clone(half*, (anonymous namespace)::HelperF16 const&, (anonymous namespace)::FlashMS<64, 128, true> const&)+0x44>
    9f2c:	7100043f 	cmp	w1, #0x1
    9f30:	540015e0 	b.eq	a1ec <value_clone(half*, (anonymous namespace)::HelperF16 const&, (anonymous namespace)::FlashMS<64, 128, true> const&)+0x2ec>  // b.none
    9f34:	91040000 	add	x0, x0, #0x100
    9f38:	91001042 	add	x2, x2, #0x4
    9f3c:	eb03001f 	cmp	x0, x3
    9f40:	54000200 	b.eq	9f80 <value_clone(half*, (anonymous namespace)::HelperF16 const&, (anonymous namespace)::FlashMS<64, 128, true> const&)+0x80>  // b.none
    9f44:	b9400041 	ldr	w1, [x2]
    9f48:	7100083f 	cmp	w1, #0x2
    9f4c:	54ffff01 	b.ne	9f2c <value_clone(half*, (anonymous namespace)::HelperF16 const&, (anonymous namespace)::FlashMS<64, 128, true> const&)+0x2c>  // b.any
    9f50:	91040000 	add	x0, x0, #0x100
    9f54:	91001042 	add	x2, x2, #0x4
    9f58:	ad38781e 	stp	q30, q30, [x0, #-256]
    9f5c:	ad39781e 	stp	q30, q30, [x0, #-224]
    9f60:	ad3a781e 	stp	q30, q30, [x0, #-192]
    9f64:	ad3b781e 	stp	q30, q30, [x0, #-160]
    9f68:	ad3c781e 	stp	q30, q30, [x0, #-128]
    9f6c:	ad3d781e 	stp	q30, q30, [x0, #-96]
    9f70:	ad3e781e 	stp	q30, q30, [x0, #-64]
    9f74:	ad3f781e 	stp	q30, q30, [x0, #-32]
    9f78:	eb03001f 	cmp	x0, x3
    9f7c:	54fffe41 	b.ne	9f44 <value_clone(half*, (anonymous namespace)::HelperF16 const&, (anonymous namespace)::FlashMS<64, 128, true> const&)+0x44>  // b.any
    9f80:	d280001e 	mov	x30, #0x0                   	// #0
    9f84:	d37e7fd0 	ubfiz	x16, x30, #2, #32
    9f88:	aa1203ee 	mov	x14, x18
    9f8c:	d2800206 	mov	x6, #0x10                  	// #16
    9f90:	ad4075de 	ldp	q30, q29, [x14]
    9f94:	52800002 	mov	w2, #0x0                   	// #0
    9f98:	d10040cb 	sub	x11, x6, #0x10
    9f9c:	910040ca 	add	x10, x6, #0x10
    9fa0:	910080c9 	add	x9, x6, #0x20
    9fa4:	ad416ddc 	ldp	q28, q27, [x14, #32]
    9fa8:	aa1003e8 	mov	x8, x16
    9fac:	ad4865da 	ldp	q26, q25, [x14, #256]
    9fb0:	ad497dd8 	ldp	q24, q31, [x14, #288]
    9fb4:	ad5059d7 	ldp	q23, q22, [x14, #512]
    9fb8:	ad5151d5 	ldp	q21, q20, [x14, #544]
    9fbc:	ad5849d3 	ldp	q19, q18, [x14, #768]
    9fc0:	ad5941d1 	ldp	q17, q16, [x14, #800]
    9fc4:	f940022d 	ldr	x13, [x17]
    9fc8:	f94005e7 	ldr	x7, [x15, #8]
    9fcc:	b94011e5 	ldr	w5, [x15, #16]
    9fd0:	8b0801ac 	add	x12, x13, x8
    9fd4:	1b057c44 	mul	w4, w2, w5
    9fd8:	8b24c0e4 	add	x4, x7, w4, sxtw
    9fdc:	3ce869a7 	ldr	q7, [x13, x8]
    9fe0:	1b051443 	madd	w3, w2, w5, w5
    9fe4:	8b23c0e3 	add	x3, x7, w3, sxtw
    9fe8:	11000841 	add	w1, w2, #0x2
    9fec:	11000c40 	add	w0, w2, #0x3
    9ff0:	3dc08186 	ldr	q6, [x12, #512]
    9ff4:	11001042 	add	w2, w2, #0x4
    9ff8:	91004108 	add	x8, x8, #0x10
    9ffc:	1b057c21 	mul	w1, w1, w5
    a000:	8b21c0e1 	add	x1, x7, w1, sxtw
    a004:	3dc10185 	ldr	q5, [x12, #1024]
    a008:	1b057c00 	mul	w0, w0, w5
    a00c:	8b20c0e0 	add	x0, x7, w0, sxtw
    a010:	3dc18184 	ldr	q4, [x12, #1536]
    a014:	0e2168e7 	fcvtn	v7.4h, v7.4s
    a018:	3ceb6883 	ldr	q3, [x4, x11]
    a01c:	0e2168c6 	fcvtn	v6.4h, v6.4s
    a020:	3ce66882 	ldr	q2, [x4, x6]
    a024:	0e2168a5 	fcvtn	v5.4h, v5.4s
    a028:	3cea6881 	ldr	q1, [x4, x10]
    a02c:	0e216884 	fcvtn	v4.4h, v4.4s
    a030:	3ce96880 	ldr	q0, [x4, x9]
    a034:	4f07107e 	fmla	v30.8h, v3.8h, v7.h[0]
    a038:	3ceb686f 	ldr	q15, [x3, x11]
    a03c:	4f07105d 	fmla	v29.8h, v2.8h, v7.h[0]
    a040:	3ce6686e 	ldr	q14, [x3, x6]
    a044:	3cea686d 	ldr	q13, [x3, x10]
    a048:	4f07103c 	fmla	v28.8h, v1.8h, v7.h[0]
    a04c:	3ce9686c 	ldr	q12, [x3, x9]
    a050:	4f07101b 	fmla	v27.8h, v0.8h, v7.h[0]
    a054:	4f06107a 	fmla	v26.8h, v3.8h, v6.h[0]
    a058:	4f061059 	fmla	v25.8h, v2.8h, v6.h[0]
    a05c:	4f061038 	fmla	v24.8h, v1.8h, v6.h[0]
    a060:	4f06101f 	fmla	v31.8h, v0.8h, v6.h[0]
    a064:	4f051077 	fmla	v23.8h, v3.8h, v5.h[0]
    a068:	4f051056 	fmla	v22.8h, v2.8h, v5.h[0]
    a06c:	4f051035 	fmla	v21.8h, v1.8h, v5.h[0]
    a070:	4f051014 	fmla	v20.8h, v0.8h, v5.h[0]
    a074:	4f041073 	fmla	v19.8h, v3.8h, v4.h[0]
    a078:	4e0604e3 	dup	v3.8h, v7.h[1]
    a07c:	4f041052 	fmla	v18.8h, v2.8h, v4.h[0]
    a080:	4e0604c2 	dup	v2.8h, v6.h[1]
    a084:	4f041031 	fmla	v17.8h, v1.8h, v4.h[0]
    a088:	4e0604a1 	dup	v1.8h, v5.h[1]
    a08c:	4f041010 	fmla	v16.8h, v0.8h, v4.h[0]
    a090:	4e060480 	dup	v0.8h, v4.h[1]
    a094:	4e430dfe 	fmla	v30.8h, v15.8h, v3.8h
    a098:	4e430ddd 	fmla	v29.8h, v14.8h, v3.8h
    a09c:	4e430dbc 	fmla	v28.8h, v13.8h, v3.8h
    a0a0:	4e430d9b 	fmla	v27.8h, v12.8h, v3.8h
    a0a4:	4e0a04e3 	dup	v3.8h, v7.h[2]
    a0a8:	4e0e04e7 	dup	v7.8h, v7.h[3]
    a0ac:	4e420dfa 	fmla	v26.8h, v15.8h, v2.8h
    a0b0:	4e420dd9 	fmla	v25.8h, v14.8h, v2.8h
    a0b4:	4e420db8 	fmla	v24.8h, v13.8h, v2.8h
    a0b8:	4e420d9f 	fmla	v31.8h, v12.8h, v2.8h
    a0bc:	4e0a04c2 	dup	v2.8h, v6.h[2]
    a0c0:	4e0e04c6 	dup	v6.8h, v6.h[3]
    a0c4:	4e410df7 	fmla	v23.8h, v15.8h, v1.8h
    a0c8:	4e410dd6 	fmla	v22.8h, v14.8h, v1.8h
    a0cc:	4e410db5 	fmla	v21.8h, v13.8h, v1.8h
    a0d0:	4e410d94 	fmla	v20.8h, v12.8h, v1.8h
    a0d4:	4e0a04a1 	dup	v1.8h, v5.h[2]
    a0d8:	4e0e04a5 	dup	v5.8h, v5.h[3]
    a0dc:	4e400df3 	fmla	v19.8h, v15.8h, v0.8h
    a0e0:	3ceb682f 	ldr	q15, [x1, x11]
    a0e4:	4e400dd2 	fmla	v18.8h, v14.8h, v0.8h
    a0e8:	3ce6682e 	ldr	q14, [x1, x6]
    a0ec:	4e400db1 	fmla	v17.8h, v13.8h, v0.8h
    a0f0:	3cea682d 	ldr	q13, [x1, x10]
    a0f4:	4e400d90 	fmla	v16.8h, v12.8h, v0.8h
    a0f8:	3ce9682c 	ldr	q12, [x1, x9]
    a0fc:	4e0a0480 	dup	v0.8h, v4.h[2]
    a100:	4e0e0484 	dup	v4.8h, v4.h[3]
    a104:	4e430dfe 	fmla	v30.8h, v15.8h, v3.8h
    a108:	4e430ddd 	fmla	v29.8h, v14.8h, v3.8h
    a10c:	4e430dbc 	fmla	v28.8h, v13.8h, v3.8h
    a110:	4e430d9b 	fmla	v27.8h, v12.8h, v3.8h
    a114:	3ceb6803 	ldr	q3, [x0, x11]
    a118:	4e420dfa 	fmla	v26.8h, v15.8h, v2.8h
    a11c:	4e420dd9 	fmla	v25.8h, v14.8h, v2.8h
    a120:	4e420db8 	fmla	v24.8h, v13.8h, v2.8h
    a124:	4e420d9f 	fmla	v31.8h, v12.8h, v2.8h
    a128:	3ce66802 	ldr	q2, [x0, x6]
    a12c:	4e410df7 	fmla	v23.8h, v15.8h, v1.8h
    a130:	4e410dd6 	fmla	v22.8h, v14.8h, v1.8h
    a134:	4e410db5 	fmla	v21.8h, v13.8h, v1.8h
    a138:	4e410d94 	fmla	v20.8h, v12.8h, v1.8h
    a13c:	3cea6801 	ldr	q1, [x0, x10]
    a140:	4e400df3 	fmla	v19.8h, v15.8h, v0.8h
    a144:	4e400dd2 	fmla	v18.8h, v14.8h, v0.8h
    a148:	4e400db1 	fmla	v17.8h, v13.8h, v0.8h
    a14c:	4e400d90 	fmla	v16.8h, v12.8h, v0.8h
    a150:	3ce96800 	ldr	q0, [x0, x9]
    a154:	4e470c7e 	fmla	v30.8h, v3.8h, v7.8h
    a158:	4e460c7a 	fmla	v26.8h, v3.8h, v6.8h
    a15c:	4e450c77 	fmla	v23.8h, v3.8h, v5.8h
    a160:	4e440c73 	fmla	v19.8h, v3.8h, v4.8h
    a164:	4e470c5d 	fmla	v29.8h, v2.8h, v7.8h
    a168:	4e460c59 	fmla	v25.8h, v2.8h, v6.8h
    a16c:	4e450c56 	fmla	v22.8h, v2.8h, v5.8h
    a170:	4e440c52 	fmla	v18.8h, v2.8h, v4.8h
    a174:	4e470c3c 	fmla	v28.8h, v1.8h, v7.8h
    a178:	4e460c38 	fmla	v24.8h, v1.8h, v6.8h
    a17c:	4e450c35 	fmla	v21.8h, v1.8h, v5.8h
    a180:	4e440c31 	fmla	v17.8h, v1.8h, v4.8h
    a184:	4e470c1b 	fmla	v27.8h, v0.8h, v7.8h
    a188:	4e460c1f 	fmla	v31.8h, v0.8h, v6.8h
    a18c:	4e450c14 	fmla	v20.8h, v0.8h, v5.8h
    a190:	4e440c10 	fmla	v16.8h, v0.8h, v4.8h
    a194:	7102005f 	cmp	w2, #0x80
    a198:	54fff1c1 	b.ne	9fd0 <value_clone(half*, (anonymous namespace)::HelperF16 const&, (anonymous namespace)::FlashMS<64, 128, true> const&)+0xd0>  // b.any
    a19c:	910100c6 	add	x6, x6, #0x40
    a1a0:	910101ce 	add	x14, x14, #0x40
    a1a4:	ad3e75de 	stp	q30, q29, [x14, #-64]
    a1a8:	ad3f6ddc 	stp	q28, q27, [x14, #-32]
    a1ac:	ad0665da 	stp	q26, q25, [x14, #192]
    a1b0:	ad077dd8 	stp	q24, q31, [x14, #224]
    a1b4:	ad0e59d7 	stp	q23, q22, [x14, #448]
    a1b8:	ad0f51d5 	stp	q21, q20, [x14, #480]
    a1bc:	ad1649d3 	stp	q19, q18, [x14, #704]
    a1c0:	ad1741d1 	stp	q17, q16, [x14, #736]
    a1c4:	f10440df 	cmp	x6, #0x110
    a1c8:	54ffee41 	b.ne	9f90 <value_clone(half*, (anonymous namespace)::HelperF16 const&, (anonymous namespace)::FlashMS<64, 128, true> const&)+0x90>  // b.any
    a1cc:	910803de 	add	x30, x30, #0x200
    a1d0:	91100252 	add	x18, x18, #0x400
    a1d4:	f1400bdf 	cmp	x30, #0x2, lsl #12
    a1d8:	54ffed61 	b.ne	9f84 <value_clone(half*, (anonymous namespace)::HelperF16 const&, (anonymous namespace)::FlashMS<64, 128, true> const&)+0x84>  // b.any
    a1dc:	6d4137ec 	ldp	d12, d13, [sp, #16]
    a1e0:	6d423fee 	ldp	d14, d15, [sp, #32]
    a1e4:	a8c37bfd 	ldp	x29, x30, [sp], #48
    a1e8:	d65f03c0 	ret
    a1ec:	bd410047 	ldr	s7, [x2, #256]
    a1f0:	ad405817 	ldp	q23, q22, [x0]
    a1f4:	ad415015 	ldp	q21, q20, [x0, #32]
    a1f8:	ad424813 	ldp	q19, q18, [x0, #64]
    a1fc:	1e23c0e7 	fcvt	h7, s7
    a200:	ad434011 	ldp	q17, q16, [x0, #96]
    a204:	ad441406 	ldp	q6, q5, [x0, #128]
    a208:	ad450c04 	ldp	q4, q3, [x0, #160]
    a20c:	4f0792f7 	fmul	v23.8h, v23.8h, v7.h[0]
    a210:	ad460402 	ldp	q2, q1, [x0, #192]
    a214:	4f0792d6 	fmul	v22.8h, v22.8h, v7.h[0]
    a218:	ad477c00 	ldp	q0, q31, [x0, #224]
    a21c:	4f0792b5 	fmul	v21.8h, v21.8h, v7.h[0]
    a220:	4f079294 	fmul	v20.8h, v20.8h, v7.h[0]
    a224:	4f079273 	fmul	v19.8h, v19.8h, v7.h[0]
    a228:	4f079252 	fmul	v18.8h, v18.8h, v7.h[0]
    a22c:	4f079231 	fmul	v17.8h, v17.8h, v7.h[0]
    a230:	4f079210 	fmul	v16.8h, v16.8h, v7.h[0]
    a234:	4f0790c6 	fmul	v6.8h, v6.8h, v7.h[0]
    a238:	4f0790a5 	fmul	v5.8h, v5.8h, v7.h[0]
    a23c:	4f079084 	fmul	v4.8h, v4.8h, v7.h[0]
    a240:	4f079063 	fmul	v3.8h, v3.8h, v7.h[0]
    a244:	4f079042 	fmul	v2.8h, v2.8h, v7.h[0]
    a248:	4f079021 	fmul	v1.8h, v1.8h, v7.h[0]
    a24c:	4f079000 	fmul	v0.8h, v0.8h, v7.h[0]
    a250:	4f0793ff 	fmul	v31.8h, v31.8h, v7.h[0]
    a254:	ad005817 	stp	q23, q22, [x0]
    a258:	ad015015 	stp	q21, q20, [x0, #32]
    a25c:	ad024813 	stp	q19, q18, [x0, #64]
    a260:	ad034011 	stp	q17, q16, [x0, #96]
    a264:	ad041406 	stp	q6, q5, [x0, #128]
    a268:	ad050c04 	stp	q4, q3, [x0, #160]
    a26c:	ad060402 	stp	q2, q1, [x0, #192]
    a270:	ad077c00 	stp	q0, q31, [x0, #224]
    a274:	17ffff30 	b	9f34 <value_clone(half*, (anonymous namespace)::HelperF16 const&, (anonymous namespace)::FlashMS<64, 128, true> const&)+0x34>
    a278:	d503201f 	nop
    a27c:	d503201f 	nop
