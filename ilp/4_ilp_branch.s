	.file	"4_ilp_branch.c"
	.abiversion 2
	.section	".text"
	.align 2
	.globl initialize
	.type	initialize, @function
initialize:
.LCF0:
0:	addis 2,12,.TOC.-.LCF0@ha
	addi 2,2,.TOC.-.LCF0@l
	.localentry	initialize,.-initialize
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
	li %r9,0
	stw %r9,60(%r31)
	b .L2
.L3:
	bl rand
	nop
	mr %r9,%r3
	rldicl %r9,%r9,0,32
	mr %r8,%r9
	lwa %r9,60(%r31)
	sldi %r9,%r9,3
	ld %r10,40(%r31)
	add %r9,%r10,%r9
	rldicl %r10,%r8,0,63
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
	nop
	addi %r1,%r31,80
	ld %r0,16(%r1)
	mtlr %r0
	ld %r31,-8(%r1)
	blr
	.long 0
	.byte 0,0,0,1,128,1,0,1
	.size	initialize,.-initialize
	.section	.rodata
	.align 3
.LC0:
	.string	"########## Start Array Branch Sum ##########"
	.section	".text"
	.align 2
	.globl array_branch_sum
	.type	array_branch_sum, @function
array_branch_sum:
.LCF1:
0:	addis 2,12,.TOC.-.LCF1@ha
	addi 2,2,.TOC.-.LCF1@l
	.localentry	array_branch_sum,.-array_branch_sum
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
	li %r9,0
	std %r9,56(%r31)
#APP
 # 18 "4_ilp_branch.c" 1
	Start_Loop:
 # 0 "" 2
#NO_APP
	b .L5
.L9:
	li %r9,0
	stw %r9,52(%r31)
	b .L6
.L8:
	lwa %r9,52(%r31)
	sldi %r9,%r9,3
	ld %r10,40(%r31)
	add %r9,%r10,%r9
	ld %r9,0(%r9)
	cmpdi %cr7,%r9,1
	bne %cr7,.L7
	lwa %r9,52(%r31)
	sldi %r9,%r9,3
	ld %r10,40(%r31)
	add %r9,%r10,%r9
	ld %r10,0(%r9)
	ld %r9,56(%r31)
	add %r9,%r10,%r9
	std %r9,56(%r31)
.L7:
	lwz %r9,52(%r31)
	addi %r9,%r9,1
	stw %r9,52(%r31)
.L6:
	lwz %r10,52(%r31)
	lis %r9,0x5f5
	ori %r9,%r9,0xe0fc
	cmpw %cr7,%r10,%r9
	ble %cr7,.L8
	lwz %r9,48(%r31)
	addi %r9,%r9,1
	stw %r9,48(%r31)
.L5:
	lwz %r9,48(%r31)
	cmpwi %cr7,%r9,9
	ble %cr7,.L9
#APP
 # 26 "4_ilp_branch.c" 1
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
	.size	array_branch_sum,.-array_branch_sum
	.align 2
	.globl main
	.type	main, @function
main:
.LCF2:
0:	addis 2,12,.TOC.-.LCF2@ha
	addi 2,2,.TOC.-.LCF2@l
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
	bl array_branch_sum
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
