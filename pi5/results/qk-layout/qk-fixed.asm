
/home/philip/minicpm-pi5/build-qk-layout/bench:     file format elf64-littleaarch64


Disassembly of section .init:

Disassembly of section .plt:

Disassembly of section .text:

0000000000009f80 <_Z8qk_fixedPKDhS0_Pfm.constprop.0>:
    9f80:	3dc00039 	ldr	q25, [x1]
    9f84:	91004024 	add	x4, x1, #0x10
    9f88:	91004003 	add	x3, x0, #0x10
    9f8c:	6dbc2be9 	stp	d9, d10, [sp, #-64]!
    9f90:	91040005 	add	x5, x0, #0x100
    9f94:	3dc0001f 	ldr	q31, [x0]
    9f98:	fd001bef 	str	d15, [sp, #48]
    9f9c:	3dc04033 	ldr	q19, [x1, #256]
    9fa0:	6d0133eb 	stp	d11, d12, [sp, #16]
    9fa4:	3dc0401e 	ldr	q30, [x0, #256]
    9fa8:	6d023bed 	stp	d13, d14, [sp, #32]
    9fac:	3dc08025 	ldr	q5, [x1, #512]
    9fb0:	6e591ff8 	fmul	v24.8h, v31.8h, v25.8h
    9fb4:	3dc0801d 	ldr	q29, [x0, #512]
    9fb8:	6e531ff2 	fmul	v18.8h, v31.8h, v19.8h
    9fbc:	3dc0c02f 	ldr	q15, [x1, #768]
    9fc0:	6e591fd7 	fmul	v23.8h, v30.8h, v25.8h
    9fc4:	6e531fd1 	fmul	v17.8h, v30.8h, v19.8h
    9fc8:	3dc0c01c 	ldr	q28, [x0, #768]
    9fcc:	6e451fe4 	fmul	v4.8h, v31.8h, v5.8h
    9fd0:	6e451fc3 	fmul	v3.8h, v30.8h, v5.8h
    9fd4:	3dc1001b 	ldr	q27, [x0, #1024]
    9fd8:	6e591fb6 	fmul	v22.8h, v29.8h, v25.8h
    9fdc:	6e531fb0 	fmul	v16.8h, v29.8h, v19.8h
    9fe0:	3dc1401a 	ldr	q26, [x0, #1280]
    9fe4:	6e451fa2 	fmul	v2.8h, v29.8h, v5.8h
    9fe8:	6e4f1fff 	fmul	v31.8h, v31.8h, v15.8h
    9fec:	6e591f95 	fmul	v21.8h, v28.8h, v25.8h
    9ff0:	6e531f87 	fmul	v7.8h, v28.8h, v19.8h
    9ff4:	6e451f81 	fmul	v1.8h, v28.8h, v5.8h
    9ff8:	6e591f74 	fmul	v20.8h, v27.8h, v25.8h
    9ffc:	6e531f66 	fmul	v6.8h, v27.8h, v19.8h
    a000:	6e451f60 	fmul	v0.8h, v27.8h, v5.8h
    a004:	6e4f1fde 	fmul	v30.8h, v30.8h, v15.8h
    a008:	6e4f1fbd 	fmul	v29.8h, v29.8h, v15.8h
    a00c:	6e4f1f9c 	fmul	v28.8h, v28.8h, v15.8h
    a010:	6e4f1f7b 	fmul	v27.8h, v27.8h, v15.8h
    a014:	6e591f59 	fmul	v25.8h, v26.8h, v25.8h
    a018:	6e531f53 	fmul	v19.8h, v26.8h, v19.8h
    a01c:	6e451f45 	fmul	v5.8h, v26.8h, v5.8h
    a020:	6e4f1f4f 	fmul	v15.8h, v26.8h, v15.8h
    a024:	3dc0009a 	ldr	q26, [x4]
    a028:	91004063 	add	x3, x3, #0x10
    a02c:	91004084 	add	x4, x4, #0x10
    a030:	3cdf006e 	ldur	q14, [x3, #-16]
    a034:	3dc03c6d 	ldr	q13, [x3, #240]
    a038:	3dc07c6c 	ldr	q12, [x3, #496]
    a03c:	3dc0bc6b 	ldr	q11, [x3, #752]
    a040:	4e4e0f58 	fmla	v24.8h, v26.8h, v14.8h
    a044:	3dc0fc6a 	ldr	q10, [x3, #1008]
    a048:	4e4d0f57 	fmla	v23.8h, v26.8h, v13.8h
    a04c:	3dc13c69 	ldr	q9, [x3, #1264]
    a050:	4e4c0f56 	fmla	v22.8h, v26.8h, v12.8h
    a054:	4e4b0f55 	fmla	v21.8h, v26.8h, v11.8h
    a058:	4e4a0f54 	fmla	v20.8h, v26.8h, v10.8h
    a05c:	4e490f59 	fmla	v25.8h, v26.8h, v9.8h
    a060:	3dc03c9a 	ldr	q26, [x4, #240]
    a064:	4e4e0f52 	fmla	v18.8h, v26.8h, v14.8h
    a068:	4e4d0f51 	fmla	v17.8h, v26.8h, v13.8h
    a06c:	4e4c0f50 	fmla	v16.8h, v26.8h, v12.8h
    a070:	4e4b0f47 	fmla	v7.8h, v26.8h, v11.8h
    a074:	4e4a0f46 	fmla	v6.8h, v26.8h, v10.8h
    a078:	4e490f53 	fmla	v19.8h, v26.8h, v9.8h
    a07c:	3dc07c9a 	ldr	q26, [x4, #496]
    a080:	4e4e0f44 	fmla	v4.8h, v26.8h, v14.8h
    a084:	4e4d0f43 	fmla	v3.8h, v26.8h, v13.8h
    a088:	4e4c0f42 	fmla	v2.8h, v26.8h, v12.8h
    a08c:	4e4b0f41 	fmla	v1.8h, v26.8h, v11.8h
    a090:	4e4a0f40 	fmla	v0.8h, v26.8h, v10.8h
    a094:	4e490f45 	fmla	v5.8h, v26.8h, v9.8h
    a098:	3dc0bc9a 	ldr	q26, [x4, #752]
    a09c:	4e4e0f5f 	fmla	v31.8h, v26.8h, v14.8h
    a0a0:	4e4d0f5e 	fmla	v30.8h, v26.8h, v13.8h
    a0a4:	4e4c0f5d 	fmla	v29.8h, v26.8h, v12.8h
    a0a8:	4e4b0f5c 	fmla	v28.8h, v26.8h, v11.8h
    a0ac:	4e4a0f5b 	fmla	v27.8h, v26.8h, v10.8h
    a0b0:	4e490f4f 	fmla	v15.8h, v26.8h, v9.8h
    a0b4:	eb0300bf 	cmp	x5, x3
    a0b8:	54fffb61 	b.ne	a024 <_Z8qk_fixedPKDhS0_Pfm.constprop.0+0xa4>  // b.any
    a0bc:	5e18071a 	mov	d26, v24.d[1]
    a0c0:	6d4133eb 	ldp	d11, d12, [sp, #16]
    a0c4:	6d423bed 	ldp	d13, d14, [sp, #32]
    a0c8:	0e58175a 	fadd	v26.4h, v26.4h, v24.4h
    a0cc:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a0d0:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a0d4:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a0d8:	bd00005a 	str	s26, [x2]
    a0dc:	5e1806fa 	mov	d26, v23.d[1]
    a0e0:	0e57175a 	fadd	v26.4h, v26.4h, v23.4h
    a0e4:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a0e8:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a0ec:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a0f0:	bd00045a 	str	s26, [x2, #4]
    a0f4:	5e1806da 	mov	d26, v22.d[1]
    a0f8:	0e56175a 	fadd	v26.4h, v26.4h, v22.4h
    a0fc:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a100:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a104:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a108:	bd00085a 	str	s26, [x2, #8]
    a10c:	5e1806ba 	mov	d26, v21.d[1]
    a110:	0e55175a 	fadd	v26.4h, v26.4h, v21.4h
    a114:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a118:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a11c:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a120:	bd000c5a 	str	s26, [x2, #12]
    a124:	5e18069a 	mov	d26, v20.d[1]
    a128:	0e54175a 	fadd	v26.4h, v26.4h, v20.4h
    a12c:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a130:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a134:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a138:	bd00105a 	str	s26, [x2, #16]
    a13c:	5e18073a 	mov	d26, v25.d[1]
    a140:	0e59175a 	fadd	v26.4h, v26.4h, v25.4h
    a144:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a148:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a14c:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a150:	bd00145a 	str	s26, [x2, #20]
    a154:	5e18065a 	mov	d26, v18.d[1]
    a158:	0e52175a 	fadd	v26.4h, v26.4h, v18.4h
    a15c:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a160:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a164:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a168:	bd02005a 	str	s26, [x2, #512]
    a16c:	5e18063a 	mov	d26, v17.d[1]
    a170:	0e51175a 	fadd	v26.4h, v26.4h, v17.4h
    a174:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a178:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a17c:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a180:	bd02045a 	str	s26, [x2, #516]
    a184:	5e18061a 	mov	d26, v16.d[1]
    a188:	0e50175a 	fadd	v26.4h, v26.4h, v16.4h
    a18c:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a190:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a194:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a198:	bd02085a 	str	s26, [x2, #520]
    a19c:	5e1804fa 	mov	d26, v7.d[1]
    a1a0:	0e47175a 	fadd	v26.4h, v26.4h, v7.4h
    a1a4:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a1a8:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a1ac:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a1b0:	bd020c5a 	str	s26, [x2, #524]
    a1b4:	5e1804da 	mov	d26, v6.d[1]
    a1b8:	0e46175a 	fadd	v26.4h, v26.4h, v6.4h
    a1bc:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a1c0:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a1c4:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a1c8:	bd02105a 	str	s26, [x2, #528]
    a1cc:	5e18067a 	mov	d26, v19.d[1]
    a1d0:	0e53175a 	fadd	v26.4h, v26.4h, v19.4h
    a1d4:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a1d8:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a1dc:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a1e0:	bd02145a 	str	s26, [x2, #532]
    a1e4:	5e18049a 	mov	d26, v4.d[1]
    a1e8:	0e44175a 	fadd	v26.4h, v26.4h, v4.4h
    a1ec:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a1f0:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a1f4:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a1f8:	bd04005a 	str	s26, [x2, #1024]
    a1fc:	5e18047a 	mov	d26, v3.d[1]
    a200:	0e43175a 	fadd	v26.4h, v26.4h, v3.4h
    a204:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a208:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a20c:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a210:	bd04045a 	str	s26, [x2, #1028]
    a214:	5e18045a 	mov	d26, v2.d[1]
    a218:	0e42175a 	fadd	v26.4h, v26.4h, v2.4h
    a21c:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a220:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a224:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a228:	bd04085a 	str	s26, [x2, #1032]
    a22c:	5e18043a 	mov	d26, v1.d[1]
    a230:	0e41175a 	fadd	v26.4h, v26.4h, v1.4h
    a234:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a238:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a23c:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a240:	bd040c5a 	str	s26, [x2, #1036]
    a244:	5e18041a 	mov	d26, v0.d[1]
    a248:	0e40175a 	fadd	v26.4h, v26.4h, v0.4h
    a24c:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a250:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a254:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a258:	bd04105a 	str	s26, [x2, #1040]
    a25c:	5e1804ba 	mov	d26, v5.d[1]
    a260:	0e45175a 	fadd	v26.4h, v26.4h, v5.4h
    a264:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a268:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a26c:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a270:	bd04145a 	str	s26, [x2, #1044]
    a274:	5e1807fa 	mov	d26, v31.d[1]
    a278:	0e5f175a 	fadd	v26.4h, v26.4h, v31.4h
    a27c:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a280:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a284:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a288:	bd06005a 	str	s26, [x2, #1536]
    a28c:	5e1807da 	mov	d26, v30.d[1]
    a290:	0e5e175a 	fadd	v26.4h, v26.4h, v30.4h
    a294:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a298:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a29c:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a2a0:	bd06045a 	str	s26, [x2, #1540]
    a2a4:	5e1807ba 	mov	d26, v29.d[1]
    a2a8:	0e5d175a 	fadd	v26.4h, v26.4h, v29.4h
    a2ac:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a2b0:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a2b4:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a2b8:	bd06085a 	str	s26, [x2, #1544]
    a2bc:	5e18079a 	mov	d26, v28.d[1]
    a2c0:	0e5c175a 	fadd	v26.4h, v26.4h, v28.4h
    a2c4:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a2c8:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a2cc:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a2d0:	bd060c5a 	str	s26, [x2, #1548]
    a2d4:	5e18077a 	mov	d26, v27.d[1]
    a2d8:	0e5b175a 	fadd	v26.4h, v26.4h, v27.4h
    a2dc:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a2e0:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a2e4:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a2e8:	bd06105a 	str	s26, [x2, #1552]
    a2ec:	5e1805fa 	mov	d26, v15.d[1]
    a2f0:	0e4f175a 	fadd	v26.4h, v26.4h, v15.4h
    a2f4:	fd401bef 	ldr	d15, [sp, #48]
    a2f8:	6cc42be9 	ldp	d9, d10, [sp], #64
    a2fc:	0e217b5a 	fcvtl	v26.4s, v26.4h
    a300:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a304:	6e3ad75a 	faddp	v26.4s, v26.4s, v26.4s
    a308:	bd06145a 	str	s26, [x2, #1556]
    a30c:	d65f03c0 	ret

Disassembly of section .fini:
