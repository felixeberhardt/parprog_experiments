	.file	"1_ilp_acc.c"
	.abiversion 2
	.section	".text"
	.align 2
	.globl main
	.type	main, @function
main:
.LCF0:
0:	addis 2,12,.TOC.-.LCF0@ha
	addi 2,2,.TOC.-.LCF0@l
	.localentry	main,.-main
	std %r31,-8(%r1)
	stdu %r1,-64(%r1)
	mr %r31,%r1
	addis %r9,%r2,.LC0@toc@ha
	addi %r9,%r9,.LC0@toc@l
	lfs %f0,0(%r9)
	stfs %f0,40(%r31)
#APP
 # 7 "1_ilp_acc.c" 1
	Start_Loop:
 # 0 "" 2
#NO_APP
	li %r9,0
	stw %r9,44(%r31)
.L2:
	lfs %f12,40(%r31)
	lfs %f0,40(%r31)
	fmuls %f12,%f12,%f0
	addi %r9,%r31,44
	lfiwax %f0,0,%r9
	fcfids %f0,%f0
	fmuls %f12,%f12,%f0
	addi %r9,%r31,44
	lfiwax %f0,0,%r9
	fcfids %f11,%f0
	lfs %f0,40(%r31)
	fmuls %f0,%f11,%f0
	fadds %f12,%f12,%f0
	lfs %f0,40(%r31)
	fadds %f0,%f12,%f0
	stfs %f0,40(%r31)
	lwz %r9,44(%r31)
	addi %r9,%r9,1
	stw %r9,44(%r31)
	b .L2
	.long 0
	.byte 0,0,0,0,128,1,0,1
	.size	main,.-main
	.section	.rodata
	.align 2
.LC0:
	.long	1065353216
	.ident	"GCC: (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0"
	.section	.note.GNU-stack,"",@progbits
