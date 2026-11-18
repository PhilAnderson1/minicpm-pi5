0000000000009bc0 <value_lane(half*, (anonymous namespace)::HelperF16 const&, (anonymous namespace)::FlashMS<64, 128, true> const&)>:
    9bc0:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
    9bc4:	aa0203f1 	mov	x17, x2
    9bc8:	910003fd 	mov	x29, sp
    9bcc:	4f00041e 	movi	v30.4s, #0x0
    9bd0:	aa0003f2 	mov	x18, x0
    9bd4:	91082042 	add	x2, x2, #0x208
    9bd8:	aa0103ef 	mov	x15, x1
    9bdc:	91401003 	add	x3, x0, #0x4, lsl #12
    9be0:	14000007 	b	9bfc <value_lane(half*, (anonymous namespace)::HelperF16 const&, (anonymous namespace)::FlashMS<64, 128, true> const&)+0x3c>
    9be4:	7100043f 	cmp	w1, #0x1
    9be8:	54001420 	b.eq	9e6c <value_lane(half*, (anonymous namespace)::HelperF16 const&, (anonymous namespace)::FlashMS<64, 128, true> const&)+0x2ac>  // b.none
    9bec:	91040000 	add	x0, x0, #0x100
    9bf0:	91001042 	add	x2, x2, #0x4
    9bf4:	eb03001f 	cmp	x0, x3
    9bf8:	54000200 	b.eq	9c38 <value_lane(half*, (anonymous namespace)::HelperF16 const&, (anonymous namespace)::FlashMS<64, 128, true> const&)+0x78>  // b.none
    9bfc:	b9400041 	ldr	w1, [x2]
    9c00:	7100083f 	cmp	w1, #0x2
    9c04:	54ffff01 	b.ne	9be4 <value_lane(half*, (anonymous namespace)::HelperF16 const&, (anonymous namespace)::FlashMS<64, 128, true> const&)+0x24>  // b.any
    9c08:	91040000 	add	x0, x0, #0x100
    9c0c:	91001042 	add	x2, x2, #0x4
    9c10:	ad38781e 	stp	q30, q30, [x0, #-256]
    9c14:	ad39781e 	stp	q30, q30, [x0, #-224]
    9c18:	ad3a781e 	stp	q30, q30, [x0, #-192]
    9c1c:	ad3b781e 	stp	q30, q30, [x0, #-160]
    9c20:	ad3c781e 	stp	q30, q30, [x0, #-128]
    9c24:	ad3d781e 	stp	q30, q30, [x0, #-96]
    9c28:	ad3e781e 	stp	q30, q30, [x0, #-64]
    9c2c:	ad3f781e 	stp	q30, q30, [x0, #-32]
    9c30:	eb03001f 	cmp	x0, x3
    9c34:	54fffe41 	b.ne	9bfc <value_lane(half*, (anonymous namespace)::HelperF16 const&, (anonymous namespace)::FlashMS<64, 128, true> const&)+0x3c>  // b.any
    9c38:	d280001e 	mov	x30, #0x0                   	// #0
    9c3c:	d37e7fd0 	ubfiz	x16, x30, #2, #32
    9c40:	aa1203ee 	mov	x14, x18
    9c44:	d2800206 	mov	x6, #0x10                  	// #16
    9c48:	ad4075de 	ldp	q30, q29, [x14]
    9c4c:	52800002 	mov	w2, #0x0                   	// #0
    9c50:	d10040cb 	sub	x11, x6, #0x10
    9c54:	910040ca 	add	x10, x6, #0x10
    9c58:	910080c9 	add	x9, x6, #0x20
    9c5c:	ad416ddc 	ldp	q28, q27, [x14, #32]
    9c60:	aa1003e8 	mov	x8, x16
    9c64:	ad4865da 	ldp	q26, q25, [x14, #256]
    9c68:	ad497dd8 	ldp	q24, q31, [x14, #288]
    9c6c:	ad5059d7 	ldp	q23, q22, [x14, #512]
    9c70:	ad5151d5 	ldp	q21, q20, [x14, #544]
    9c74:	ad5849d3 	ldp	q19, q18, [x14, #768]
    9c78:	ad5941d1 	ldp	q17, q16, [x14, #800]
    9c7c:	f940022d 	ldr	x13, [x17]
    9c80:	f94005e7 	ldr	x7, [x15, #8]
    9c84:	b94011e5 	ldr	w5, [x15, #16]
    9c88:	8b0801ac 	add	x12, x13, x8
    9c8c:	1b027ca4 	mul	w4, w5, w2
    9c90:	11000841 	add	w1, w2, #0x2
    9c94:	3ce869a7 	ldr	q7, [x13, x8]
    9c98:	8b24c0e4 	add	x4, x7, w4, sxtw
    9c9c:	1b051443 	madd	w3, w2, w5, w5
    9ca0:	11000c40 	add	w0, w2, #0x3
    9ca4:	8b23c0e3 	add	x3, x7, w3, sxtw
    9ca8:	1b057c21 	mul	w1, w1, w5
    9cac:	3dc08186 	ldr	q6, [x12, #512]
    9cb0:	8b21c0e1 	add	x1, x7, w1, sxtw
    9cb4:	11001042 	add	w2, w2, #0x4
    9cb8:	1b057c00 	mul	w0, w0, w5
    9cbc:	91004108 	add	x8, x8, #0x10
    9cc0:	8b20c0e0 	add	x0, x7, w0, sxtw
    9cc4:	3dc10185 	ldr	q5, [x12, #1024]
    9cc8:	3dc18184 	ldr	q4, [x12, #1536]
    9ccc:	0e2168e7 	fcvtn	v7.4h, v7.4s
    9cd0:	3ceb6883 	ldr	q3, [x4, x11]
    9cd4:	0e2168c6 	fcvtn	v6.4h, v6.4s
    9cd8:	4f07107e 	fmla	v30.8h, v3.8h, v7.h[0]
    9cdc:	3ce66882 	ldr	q2, [x4, x6]
    9ce0:	0e2168a5 	fcvtn	v5.4h, v5.4s
    9ce4:	4f07105d 	fmla	v29.8h, v2.8h, v7.h[0]
    9ce8:	3cea6881 	ldr	q1, [x4, x10]
    9cec:	0e216884 	fcvtn	v4.4h, v4.4s
    9cf0:	4f07103c 	fmla	v28.8h, v1.8h, v7.h[0]
    9cf4:	3ce96880 	ldr	q0, [x4, x9]
    9cf8:	4f06107a 	fmla	v26.8h, v3.8h, v6.h[0]
    9cfc:	4f07101b 	fmla	v27.8h, v0.8h, v7.h[0]
    9d00:	4f061059 	fmla	v25.8h, v2.8h, v6.h[0]
    9d04:	4f061038 	fmla	v24.8h, v1.8h, v6.h[0]
    9d08:	4f06101f 	fmla	v31.8h, v0.8h, v6.h[0]
    9d0c:	4f051077 	fmla	v23.8h, v3.8h, v5.h[0]
    9d10:	4f051056 	fmla	v22.8h, v2.8h, v5.h[0]
    9d14:	4f051035 	fmla	v21.8h, v1.8h, v5.h[0]
    9d18:	4f051014 	fmla	v20.8h, v0.8h, v5.h[0]
    9d1c:	4f041073 	fmla	v19.8h, v3.8h, v4.h[0]
    9d20:	3ceb6863 	ldr	q3, [x3, x11]
    9d24:	4f041052 	fmla	v18.8h, v2.8h, v4.h[0]
    9d28:	3ce66862 	ldr	q2, [x3, x6]
    9d2c:	4f041031 	fmla	v17.8h, v1.8h, v4.h[0]
    9d30:	3cea6861 	ldr	q1, [x3, x10]
    9d34:	4f041010 	fmla	v16.8h, v0.8h, v4.h[0]
    9d38:	3ce96860 	ldr	q0, [x3, x9]
    9d3c:	4f17107e 	fmla	v30.8h, v3.8h, v7.h[1]
    9d40:	4f16107a 	fmla	v26.8h, v3.8h, v6.h[1]
    9d44:	4f151077 	fmla	v23.8h, v3.8h, v5.h[1]
    9d48:	4f141073 	fmla	v19.8h, v3.8h, v4.h[1]
    9d4c:	3ceb6823 	ldr	q3, [x1, x11]
    9d50:	4f17105d 	fmla	v29.8h, v2.8h, v7.h[1]
    9d54:	4f161059 	fmla	v25.8h, v2.8h, v6.h[1]
    9d58:	4f151056 	fmla	v22.8h, v2.8h, v5.h[1]
    9d5c:	4f141052 	fmla	v18.8h, v2.8h, v4.h[1]
    9d60:	3ce66822 	ldr	q2, [x1, x6]
    9d64:	4f17103c 	fmla	v28.8h, v1.8h, v7.h[1]
    9d68:	4f161038 	fmla	v24.8h, v1.8h, v6.h[1]
    9d6c:	4f151035 	fmla	v21.8h, v1.8h, v5.h[1]
    9d70:	4f141031 	fmla	v17.8h, v1.8h, v4.h[1]
    9d74:	3cea6821 	ldr	q1, [x1, x10]
    9d78:	4f17101b 	fmla	v27.8h, v0.8h, v7.h[1]
    9d7c:	4f16101f 	fmla	v31.8h, v0.8h, v6.h[1]
    9d80:	4f151014 	fmla	v20.8h, v0.8h, v5.h[1]
    9d84:	4f141010 	fmla	v16.8h, v0.8h, v4.h[1]
    9d88:	3ce96820 	ldr	q0, [x1, x9]
    9d8c:	4f27107e 	fmla	v30.8h, v3.8h, v7.h[2]
    9d90:	4f26107a 	fmla	v26.8h, v3.8h, v6.h[2]
    9d94:	4f251077 	fmla	v23.8h, v3.8h, v5.h[2]
    9d98:	4f241073 	fmla	v19.8h, v3.8h, v4.h[2]
    9d9c:	3ceb6803 	ldr	q3, [x0, x11]
    9da0:	4f27105d 	fmla	v29.8h, v2.8h, v7.h[2]
    9da4:	4f261059 	fmla	v25.8h, v2.8h, v6.h[2]
    9da8:	4f251056 	fmla	v22.8h, v2.8h, v5.h[2]
    9dac:	4f241052 	fmla	v18.8h, v2.8h, v4.h[2]
    9db0:	3ce66802 	ldr	q2, [x0, x6]
    9db4:	4f27103c 	fmla	v28.8h, v1.8h, v7.h[2]
    9db8:	4f261038 	fmla	v24.8h, v1.8h, v6.h[2]
    9dbc:	4f251035 	fmla	v21.8h, v1.8h, v5.h[2]
    9dc0:	4f241031 	fmla	v17.8h, v1.8h, v4.h[2]
    9dc4:	3cea6801 	ldr	q1, [x0, x10]
    9dc8:	4f27101b 	fmla	v27.8h, v0.8h, v7.h[2]
    9dcc:	4f26101f 	fmla	v31.8h, v0.8h, v6.h[2]
    9dd0:	4f251014 	fmla	v20.8h, v0.8h, v5.h[2]
    9dd4:	4f241010 	fmla	v16.8h, v0.8h, v4.h[2]
    9dd8:	3ce96800 	ldr	q0, [x0, x9]
    9ddc:	4f37107e 	fmla	v30.8h, v3.8h, v7.h[3]
    9de0:	4f36107a 	fmla	v26.8h, v3.8h, v6.h[3]
    9de4:	4f351077 	fmla	v23.8h, v3.8h, v5.h[3]
    9de8:	4f341073 	fmla	v19.8h, v3.8h, v4.h[3]
    9dec:	4f37105d 	fmla	v29.8h, v2.8h, v7.h[3]
    9df0:	4f361059 	fmla	v25.8h, v2.8h, v6.h[3]
    9df4:	4f351056 	fmla	v22.8h, v2.8h, v5.h[3]
    9df8:	4f341052 	fmla	v18.8h, v2.8h, v4.h[3]
    9dfc:	4f37103c 	fmla	v28.8h, v1.8h, v7.h[3]
    9e00:	4f361038 	fmla	v24.8h, v1.8h, v6.h[3]
    9e04:	4f351035 	fmla	v21.8h, v1.8h, v5.h[3]
    9e08:	4f341031 	fmla	v17.8h, v1.8h, v4.h[3]
    9e0c:	4f37101b 	fmla	v27.8h, v0.8h, v7.h[3]
    9e10:	4f36101f 	fmla	v31.8h, v0.8h, v6.h[3]
    9e14:	4f351014 	fmla	v20.8h, v0.8h, v5.h[3]
    9e18:	4f341010 	fmla	v16.8h, v0.8h, v4.h[3]
    9e1c:	7102005f 	cmp	w2, #0x80
    9e20:	54fff341 	b.ne	9c88 <value_lane(half*, (anonymous namespace)::HelperF16 const&, (anonymous namespace)::FlashMS<64, 128, true> const&)+0xc8>  // b.any
    9e24:	910100c6 	add	x6, x6, #0x40
    9e28:	910101ce 	add	x14, x14, #0x40
    9e2c:	ad3e75de 	stp	q30, q29, [x14, #-64]
    9e30:	ad3f6ddc 	stp	q28, q27, [x14, #-32]
    9e34:	ad0665da 	stp	q26, q25, [x14, #192]
    9e38:	ad077dd8 	stp	q24, q31, [x14, #224]
    9e3c:	ad0e59d7 	stp	q23, q22, [x14, #448]
    9e40:	ad0f51d5 	stp	q21, q20, [x14, #480]
    9e44:	ad1649d3 	stp	q19, q18, [x14, #704]
    9e48:	ad1741d1 	stp	q17, q16, [x14, #736]
    9e4c:	f10440df 	cmp	x6, #0x110
    9e50:	54ffefc1 	b.ne	9c48 <value_lane(half*, (anonymous namespace)::HelperF16 const&, (anonymous namespace)::FlashMS<64, 128, true> const&)+0x88>  // b.any
    9e54:	910803de 	add	x30, x30, #0x200
    9e58:	91100252 	add	x18, x18, #0x400
    9e5c:	f1400bdf 	cmp	x30, #0x2, lsl #12
    9e60:	54ffeee1 	b.ne	9c3c <value_lane(half*, (anonymous namespace)::HelperF16 const&, (anonymous namespace)::FlashMS<64, 128, true> const&)+0x7c>  // b.any
    9e64:	a8c17bfd 	ldp	x29, x30, [sp], #16
    9e68:	d65f03c0 	ret
    9e6c:	bd410047 	ldr	s7, [x2, #256]
    9e70:	ad405817 	ldp	q23, q22, [x0]
    9e74:	ad415015 	ldp	q21, q20, [x0, #32]
    9e78:	ad424813 	ldp	q19, q18, [x0, #64]
    9e7c:	1e23c0e7 	fcvt	h7, s7
    9e80:	ad434011 	ldp	q17, q16, [x0, #96]
    9e84:	ad441406 	ldp	q6, q5, [x0, #128]
    9e88:	ad450c04 	ldp	q4, q3, [x0, #160]
    9e8c:	4f0792f7 	fmul	v23.8h, v23.8h, v7.h[0]
    9e90:	ad460402 	ldp	q2, q1, [x0, #192]
    9e94:	4f0792d6 	fmul	v22.8h, v22.8h, v7.h[0]
    9e98:	ad477c00 	ldp	q0, q31, [x0, #224]
    9e9c:	4f0792b5 	fmul	v21.8h, v21.8h, v7.h[0]
    9ea0:	4f079294 	fmul	v20.8h, v20.8h, v7.h[0]
    9ea4:	4f079273 	fmul	v19.8h, v19.8h, v7.h[0]
    9ea8:	4f079252 	fmul	v18.8h, v18.8h, v7.h[0]
    9eac:	4f079231 	fmul	v17.8h, v17.8h, v7.h[0]
    9eb0:	4f079210 	fmul	v16.8h, v16.8h, v7.h[0]
    9eb4:	4f0790c6 	fmul	v6.8h, v6.8h, v7.h[0]
    9eb8:	4f0790a5 	fmul	v5.8h, v5.8h, v7.h[0]
    9ebc:	4f079084 	fmul	v4.8h, v4.8h, v7.h[0]
    9ec0:	4f079063 	fmul	v3.8h, v3.8h, v7.h[0]
    9ec4:	4f079042 	fmul	v2.8h, v2.8h, v7.h[0]
    9ec8:	4f079021 	fmul	v1.8h, v1.8h, v7.h[0]
    9ecc:	4f079000 	fmul	v0.8h, v0.8h, v7.h[0]
    9ed0:	4f0793ff 	fmul	v31.8h, v31.8h, v7.h[0]
    9ed4:	ad005817 	stp	q23, q22, [x0]
    9ed8:	ad015015 	stp	q21, q20, [x0, #32]
    9edc:	ad024813 	stp	q19, q18, [x0, #64]
    9ee0:	ad034011 	stp	q17, q16, [x0, #96]
    9ee4:	ad041406 	stp	q6, q5, [x0, #128]
    9ee8:	ad050c04 	stp	q4, q3, [x0, #160]
    9eec:	ad060402 	stp	q2, q1, [x0, #192]
    9ef0:	ad077c00 	stp	q0, q31, [x0, #224]
    9ef4:	17ffff3e 	b	9bec <value_lane(half*, (anonymous namespace)::HelperF16 const&, (anonymous namespace)::FlashMS<64, 128, true> const&)+0x2c>
    9ef8:	d503201f 	nop
    9efc:	d503201f 	nop
