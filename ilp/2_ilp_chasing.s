	.file	"2_ilp_chasing.c"
	.abiversion 2
	.section	".text"
	.align 2
	.globl initialize
	.type	initialize, @function
initialize:
	std %r31,-8(%r1)
	stdu %r1,-80(%r1)
	mr %r31,%r1
	std %r3,40(%r31)
	li %r9,0
	stw %r9,60(%r31)
	b .L2
.L3:
	lwz %r9,60(%r31)
	addi %r9,%r9,1
	extsw %r8,%r9
	lwa %r9,60(%r31)
	sldi %r9,%r9,3
	ld %r10,40(%r31)
	add %r9,%r10,%r9
	mr %r10,%r8
	std %r10,0(%r9)
	lwz %r9,60(%r31)
	addi %r9,%r9,1
	stw %r9,60(%r31)
.L2:
	lwz %r10,60(%r31)
	lis %r9,0x5f5
	ori %r9,%r9,0xe0ff
	cmpw %cr7,%r10,%r9
	ble %cr7,.L3
	ld %r9,40(%r31)
	addis %r9,%r9,0x2faf
	addi %r9,%r9,2040
	li %r10,0
	std %r10,0(%r9)
	nop
	addi %r1,%r31,80
	ld %r31,-8(%r1)
	blr
	.long 0
	.byte 0,0,0,0,128,1,0,1
	.size	initialize,.-initialize
	.align 2
	.globl shuffle
	.type	shuffle, @function
shuffle:
.LCF1:
0:	addis 2,12,.TOC.-.LCF1@ha
	addi 2,2,.TOC.-.LCF1@l
	.localentry	shuffle,.-shuffle
	mflr %r0
	std %r0,16(%r1)
	std %r31,-8(%r1)
	stdu %r1,-80(%r1)
	mr %r31,%r1
	std %r3,40(%r31)
	li %r3,0
	bl time
	nop
	mr %r9,%r3
	rldicl %r9,%r9,0,32
	mr %r3,%r9
	bl srand
	nop
	lis %r9,0x5f5
	ori %r9,%r9,0xe0ff
	stw %r9,48(%r31)
	b .L5
.L10:
	bl rand
	nop
	mr %r9,%r3
	mr %r8,%r9
	lis %r9,0x5f5
	ori %r10,%r9,0xe100
	lwz %r9,48(%r31)
	subf %r9,%r9,%r10
	extsw %r10,%r9
	mr %r9,%r8
	mr %r8,%r10
	divw %r8,%r9,%r8
	mullw %r10,%r8,%r10
	subf %r9,%r10,%r9
	stw %r9,52(%r31)
	lwa %r9,48(%r31)
	sldi %r9,%r9,3
	ld %r10,40(%r31)
	add %r9,%r10,%r9
	ld %r10,0(%r9)
	lwa %r9,52(%r31)
	cmpd %cr7,%r10,%r9
	beq %cr7,.L11
	lwa %r9,52(%r31)
	sldi %r9,%r9,3
	ld %r10,40(%r31)
	add %r9,%r10,%r9
	ld %r10,0(%r9)
	lwa %r9,48(%r31)
	cmpd %cr7,%r10,%r9
	beq %cr7,.L11
	lwa %r9,48(%r31)
	sldi %r9,%r9,3
	ld %r10,40(%r31)
	add %r9,%r10,%r9
	ld %r9,0(%r9)
	sldi %r9,%r9,3
	ld %r10,40(%r31)
	add %r9,%r10,%r9
	ld %r10,0(%r9)
	lwa %r9,52(%r31)
	cmpd %cr7,%r10,%r9
	beq %cr7,.L12
	lwa %r9,48(%r31)
	sldi %r9,%r9,3
	ld %r10,40(%r31)
	add %r9,%r10,%r9
	ld %r9,0(%r9)
	std %r9,56(%r31)
	lwa %r9,52(%r31)
	sldi %r9,%r9,3
	ld %r10,40(%r31)
	add %r10,%r10,%r9
	lwa %r9,48(%r31)
	sldi %r9,%r9,3
	ld %r8,40(%r31)
	add %r9,%r8,%r9
	ld %r10,0(%r10)
	std %r10,0(%r9)
	lwa %r9,52(%r31)
	sldi %r9,%r9,3
	ld %r10,40(%r31)
	add %r9,%r10,%r9
	ld %r10,56(%r31)
	std %r10,0(%r9)
	b .L8
.L11:
	nop
	b .L8
.L12:
	nop
.L8:
	lwz %r9,48(%r31)
	addi %r9,%r9,-1
	stw %r9,48(%r31)
.L5:
	lwz %r9,48(%r31)
	cmpwi %cr7,%r9,0
	bge %cr7,.L10
	nop
	addi %r1,%r31,80
	ld %r0,16(%r1)
	mtlr %r0
	ld %r31,-8(%r1)
	blr
	.long 0
	.byte 0,0,0,1,128,1,0,1
	.size	shuffle,.-shuffle
	.section	.rodata
	.align 3
.LC0:
	.string	"########## Start Chasing ##########"
	.section	".text"
	.align 2
	.globl chase
	.type	chase, @function
chase:
.LCF2:
0:	addis 2,12,.TOC.-.LCF2@ha
	addi 2,2,.TOC.-.LCF2@l
	.localentry	chase,.-chase
	mflr %r0
	std %r0,16(%r1)
	std %r31,-8(%r1)
	stdu %r1,-80(%r1)
	mr %r31,%r1
	std %r3,40(%r31)
	addis %r3,%r2,.LC0@toc@ha
	addi %r3,%r3,.LC0@toc@l
	bl puts
	nop
	ld %r9,40(%r31)
	ld %r9,0(%r9)
	std %r9,56(%r31)
#APP
 # 34 "2_ilp_chasing.c" 1
	Start_Loop:
 # 0 "" 2
#NO_APP
	b .L14
.L17:
	li %r9,0
	stw %r9,52(%r31)
	b .L15
.L16:
	ld %r9,56(%r31)
	sldi %r9,%r9,3
	ld %r10,40(%r31)
	add %r9,%r10,%r9
	ld %r9,0(%r9)
	std %r9,56(%r31)
	lwz %r9,52(%r31)
	addi %r9,%r9,1
	stw %r9,52(%r31)
.L15:
	lwz %r10,52(%r31)
	lis %r9,0x5f5
	ori %r9,%r9,0xe0ff
	cmpw %cr7,%r10,%r9
	ble %cr7,.L16
	lwz %r9,48(%r31)
	addi %r9,%r9,1
	stw %r9,48(%r31)
.L14:
	lwz %r9,48(%r31)
	cmpwi %cr7,%r9,9
	ble %cr7,.L17
#APP
 # 40 "2_ilp_chasing.c" 1
	End_Loop:
 # 0 "" 2
#NO_APP
	ld %r9,56(%r31)
	mr %r3,%r9
	addi %r1,%r31,80
	ld %r0,16(%r1)
	mtlr %r0
	ld %r31,-8(%r1)
	blr
	.long 0
	.byte 0,0,0,1,128,1,0,1
	.size	chase,.-chase
	.align 2
	.globl main
	.type	main, @function
main:
.LCF3:
0:	addis 2,12,.TOC.-.LCF3@ha
	addi 2,2,.TOC.-.LCF3@l
	.localentry	main,.-main
	mflr %r0
	std %r0,16(%r1)
	std %r31,-8(%r1)
	stdu %r1,-64(%r1)
	mr %r31,%r1
	lis %r9,0x2faf
	ori %r3,%r9,0x800
	bl malloc
	nop
	mr %r9,%r3
	std %r9,32(%r31)
	ld %r3,32(%r31)
	bl initialize
	ld %r3,32(%r31)
	bl shuffle
	ld %r3,32(%r31)
	bl chase
	std %r3,40(%r31)
	ld %r9,40(%r31)
	extsw %r9,%r9
	mr %r3,%r9
	addi %r1,%r31,64
	ld %r0,16(%r1)
	mtlr %r0
	ld %r31,-8(%r1)
	blr
	.long 0
	.byte 0,0,0,1,128,1,0,1
	.size	main,.-main
	.ident	"GCC: (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0"
	.section	.note.GNU-stack,"",@progbits
