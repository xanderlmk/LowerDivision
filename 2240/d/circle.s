	.file	"circle.c"
	.text
	.globl	dpy
	.bss
	.align 8
	.type	dpy, @object
	.size	dpy, 8
dpy:
	.zero	8
	.globl	win
	.align 8
	.type	win, @object
	.size	win, 8
win:
	.zero	8
	.globl	gc
	.align 8
	.type	gc, @object
	.size	gc, 8
gc:
	.zero	8
	.globl	backBuffer
	.align 8
	.type	backBuffer, @object
	.size	backBuffer, 8
backBuffer:
	.zero	8
	.globl	swapInfo
	.align 16
	.type	swapInfo, @object
	.size	swapInfo, 16
swapInfo:
	.zero	16
	.globl	xres
	.data
	.align 4
	.type	xres, @object
	.size	xres, 4
xres:
	.long	640
	.globl	yres
	.align 4
	.type	yres, @object
	.size	yres, 4
yres:
	.long	480
	.globl	gravity
	.align 8
	.type	gravity, @object
	.size	gravity, 8
gravity:
	.long	721554506
	.long	1069094535
	.globl	friction
	.align 8
	.type	friction, @object
	.size	friction, 8
friction:
	.long	-755914244
	.long	1062232653
	.globl	smallx
	.align 8
	.type	smallx, @object
	.size	smallx, 8
smallx:
	.long	0
	.long	1080623104
	.globl	smally
	.align 8
	.type	smally, @object
	.size	smally, 8
smally:
	.long	0
	.long	1080623104
	.globl	smallvx
	.align 8
	.type	smallvx, @object
	.size	smallvx, 8
smallvx:
	.long	0
	.long	1072168960
	.globl	smallvy
	.align 8
	.type	smallvy, @object
	.size	smallvy, 8
smallvy:
	.long	0
	.long	1076166656
	.globl	bigradius
	.align 8
	.type	bigradius, @object
	.size	bigradius, 8
bigradius:
	.long	0
	.long	1080295424
	.text
	.globl	main
	.type	main, @function
main:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$208, %rsp
	movl	$0, -4(%rbp)
	movl	$0, %edi
	call	time@PLT
	movl	%eax, %edi
	call	srand@PLT
	movl	$0, %eax
	call	initializeX11
	jmp	.L2
.L4:
	movq	dpy(%rip), %rax
	leaq	-208(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	XNextEvent@PLT
	leaq	-208(%rbp), %rax
	movq	%rax, %rdi
	call	checkResize
	leaq	-208(%rbp), %rax
	movq	%rax, %rdi
	call	checkMouse
	leaq	-208(%rbp), %rax
	movq	%rax, %rdi
	call	checkKeys
	movl	%eax, -4(%rbp)
.L3:
	movq	dpy(%rip), %rax
	movq	%rax, %rdi
	call	XPending@PLT
	testl	%eax, %eax
	jne	.L4
	movl	$0, %eax
	call	physics
	movl	$0, %eax
	call	render
	movq	dpy(%rip), %rax
	movl	$1, %edx
	leaq	swapInfo(%rip), %rsi
	movq	%rax, %rdi
	call	XdbeSwapBuffers@PLT
	movl	$2000, %edi
	call	usleep@PLT
.L2:
	cmpl	$0, -4(%rbp)
	je	.L3
	movl	$0, %eax
	call	cleanupX11
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	main, .-main
	.section	.rodata
.LC0:
	.string	"2240 lab"
	.text
	.globl	setWindowTitle
	.type	setWindowTitle, @function
setWindowTitle:
.LFB7:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	win(%rip), %rcx
	movq	dpy(%rip), %rax
	leaq	.LC0(%rip), %rdx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	XStoreName@PLT
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	setWindowTitle, .-setWindowTitle
	.section	.rodata
	.align 8
.LC1:
	.string	"Error: unable to fetch Xdbe Version."
	.text
	.globl	initializeX11
	.type	initializeX11, @function
initializeX11:
.LFB8:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$144, %rsp
	movl	$0, %edi
	call	XOpenDisplay@PLT
	movq	%rax, dpy(%rip)
	movq	$163919, -56(%rbp)
	movl	$2, -88(%rbp)
	movl	$1, -64(%rbp)
	movl	$0, -40(%rbp)
	movq	$0, -120(%rbp)
	movq	dpy(%rip), %rax
	movq	232(%rax), %rdx
	movq	dpy(%rip), %rax
	movl	224(%rax), %eax
	cltq
	salq	$7, %rax
	addq	%rdx, %rax
	movq	16(%rax), %rax
	movq	%rax, -8(%rbp)
	movl	yres(%rip), %eax
	movl	%eax, %edi
	movl	xres(%rip), %eax
	movl	%eax, %ecx
	movq	dpy(%rip), %rax
	movq	-8(%rbp), %rsi
	leaq	-128(%rbp), %rdx
	pushq	%rdx
	pushq	$3650
	pushq	$0
	pushq	$1
	pushq	$0
	pushq	$0
	movl	%edi, %r9d
	movl	%ecx, %r8d
	movl	$0, %ecx
	movl	$0, %edx
	movq	%rax, %rdi
	call	XCreateWindow@PLT
	addq	$48, %rsp
	movq	%rax, win(%rip)
	movq	win(%rip), %rsi
	movq	dpy(%rip), %rax
	movl	$0, %ecx
	movl	$0, %edx
	movq	%rax, %rdi
	call	XCreateGC@PLT
	movq	%rax, gc(%rip)
	movq	dpy(%rip), %rax
	leaq	-136(%rbp), %rdx
	leaq	-132(%rbp), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	XdbeQueryExtension@PLT
	testl	%eax, %eax
	jne	.L9
	leaq	.LC1(%rip), %rdi
	call	puts@PLT
	movq	gc(%rip), %rdx
	movq	dpy(%rip), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	XFreeGC@PLT
	movq	win(%rip), %rdx
	movq	dpy(%rip), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	XDestroyWindow@PLT
	movq	dpy(%rip), %rax
	movq	%rax, %rdi
	call	XCloseDisplay@PLT
	movl	$1, %edi
	call	exit@PLT
.L9:
	movq	win(%rip), %rcx
	movq	dpy(%rip), %rax
	movl	$0, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	XdbeAllocateBackBufferName@PLT
	movq	%rax, backBuffer(%rip)
	movq	backBuffer(%rip), %rdx
	movq	dpy(%rip), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	XdbeGetBackBufferAttributes@PLT
	movq	%rax, -16(%rbp)
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, swapInfo(%rip)
	movb	$0, 8+swapInfo(%rip)
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	XFree@PLT
	movl	$0, %eax
	call	setWindowTitle
	movq	win(%rip), %rdx
	movq	dpy(%rip), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	XMapWindow@PLT
	movq	win(%rip), %rdx
	movq	dpy(%rip), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	XRaiseWindow@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	initializeX11, .-initializeX11
	.section	.rodata
	.align 8
.LC2:
	.string	"Error: deallocating backBuffer!"
	.text
	.globl	cleanupX11
	.type	cleanupX11, @function
cleanupX11:
.LFB9:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	backBuffer(%rip), %rdx
	movq	dpy(%rip), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	XdbeDeallocateBackBufferName@PLT
	testl	%eax, %eax
	jne	.L11
	leaq	.LC2(%rip), %rdi
	call	puts@PLT
.L11:
	movq	gc(%rip), %rdx
	movq	dpy(%rip), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	XFreeGC@PLT
	movq	win(%rip), %rdx
	movq	dpy(%rip), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	XDestroyWindow@PLT
	movq	dpy(%rip), %rax
	movq	%rax, %rdi
	call	XCloseDisplay@PLT
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	cleanupX11, .-cleanupX11
	.globl	checkResize
	.type	checkResize, @function
checkResize:
.LFB10:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$120, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -120(%rbp)
	movq	-120(%rbp), %rax
	movl	(%rax), %eax
	cmpl	$22, %eax
	jne	.L15
	movq	-120(%rbp), %rax
	movq	(%rax), %rcx
	movq	8(%rax), %rbx
	movq	%rcx, -112(%rbp)
	movq	%rbx, -104(%rbp)
	movq	16(%rax), %rcx
	movq	24(%rax), %rbx
	movq	%rcx, -96(%rbp)
	movq	%rbx, -88(%rbp)
	movq	32(%rax), %rcx
	movq	40(%rax), %rbx
	movq	%rcx, -80(%rbp)
	movq	%rbx, -72(%rbp)
	movq	48(%rax), %rcx
	movq	56(%rax), %rbx
	movq	%rcx, -64(%rbp)
	movq	%rbx, -56(%rbp)
	movq	64(%rax), %rcx
	movq	72(%rax), %rbx
	movq	%rcx, -48(%rbp)
	movq	%rbx, -40(%rbp)
	movq	80(%rax), %rax
	movq	%rax, -32(%rbp)
	movl	-56(%rbp), %eax
	movl	%eax, xres(%rip)
	movl	-52(%rbp), %eax
	movl	%eax, yres(%rip)
	movl	$0, %eax
	call	setWindowTitle
	jmp	.L12
.L15:
	nop
.L12:
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	checkResize, .-checkResize
	.globl	clearScreen
	.type	clearScreen, @function
clearScreen:
.LFB11:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	gc(%rip), %rcx
	movq	dpy(%rip), %rax
	movl	$0, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	XSetForeground@PLT
	movl	yres(%rip), %eax
	movl	%eax, %ecx
	movl	xres(%rip), %eax
	movl	%eax, %edi
	movq	gc(%rip), %rdx
	movq	backBuffer(%rip), %rsi
	movq	dpy(%rip), %rax
	subq	$8, %rsp
	pushq	%rcx
	movl	%edi, %r9d
	movl	$0, %r8d
	movl	$0, %ecx
	movq	%rax, %rdi
	call	XFillRectangle@PLT
	addq	$16, %rsp
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	clearScreen, .-clearScreen
	.globl	setColor
	.type	setColor, @function
setColor:
.LFB12:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	%edi, -20(%rbp)
	movl	%esi, -24(%rbp)
	movl	%edx, -28(%rbp)
	movq	$0, -8(%rbp)
	movl	-20(%rbp), %eax
	cltq
	addq	%rax, -8(%rbp)
	salq	$8, -8(%rbp)
	movl	-24(%rbp), %eax
	cltq
	addq	%rax, -8(%rbp)
	salq	$8, -8(%rbp)
	movl	-28(%rbp), %eax
	cltq
	addq	%rax, -8(%rbp)
	movq	gc(%rip), %rcx
	movq	dpy(%rip), %rax
	movq	-8(%rbp), %rdx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	XSetForeground@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	setColor, .-setColor
	.globl	checkMouse
	.type	checkMouse, @function
checkMouse:
.LFB13:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movl	(%rax), %eax
	cmpl	$5, %eax
	je	.L23
	movq	-8(%rbp), %rax
	movl	(%rax), %eax
	cmpl	$4, %eax
	movq	-8(%rbp), %rax
	movl	64(%rax), %edx
	movl	savex.2(%rip), %eax
	cmpl	%eax, %edx
	jne	.L22
	movq	-8(%rbp), %rax
	movl	68(%rax), %edx
	movl	savey.1(%rip), %eax
	cmpl	%eax, %edx
	je	.L18
.L22:
	movq	-8(%rbp), %rax
	movl	64(%rax), %eax
	movl	%eax, savex.2(%rip)
	movq	-8(%rbp), %rax
	movl	68(%rax), %eax
	movl	%eax, savey.1(%rip)
	jmp	.L18
.L23:
	nop
.L18:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE13:
	.size	checkMouse, .-checkMouse
	.globl	checkKeys
	.type	checkKeys, @function
checkKeys:
.LFB14:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	-24(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	XLookupKeysym@PLT
	movl	%eax, -4(%rbp)
	cmpl	$65364, -4(%rbp)
	jg	.L25
	cmpl	$65361, -4(%rbp)
	jge	.L30
	cmpl	$97, -4(%rbp)
	je	.L31
	cmpl	$65307, -4(%rbp)
	jne	.L25
	movl	$1, %eax
	jmp	.L29
.L30:
	nop
	jmp	.L25
.L31:
	nop
.L25:
	movl	$0, %eax
.L29:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE14:
	.size	checkKeys, .-checkKeys
	.globl	setPixel
	.type	setPixel, @function
setPixel:
.LFB15:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movq	gc(%rip), %rdx
	movq	backBuffer(%rip), %rsi
	movq	dpy(%rip), %rax
	movl	-8(%rbp), %edi
	movl	-4(%rbp), %ecx
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	XDrawPoint@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE15:
	.size	setPixel, .-setPixel
	.globl	BresenhamCircle
	.type	BresenhamCircle, @function
BresenhamCircle:
.LFB16:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movl	%edi, -52(%rbp)
	movl	%esi, -56(%rbp)
	movl	%edx, -60(%rbp)
	movl	$0, -4(%rbp)
	movl	-60(%rbp), %eax
	movl	%eax, -8(%rbp)
	movl	-60(%rbp), %eax
	leal	(%rax,%rax), %edx
	movl	$3, %eax
	subl	%edx, %eax
	movl	%eax, -12(%rbp)
	jmp	.L34
.L37:
	movl	-56(%rbp), %edx
	movl	-4(%rbp), %eax
	addl	%edx, %eax
	movl	%eax, -16(%rbp)
	movl	-56(%rbp), %eax
	subl	-4(%rbp), %eax
	movl	%eax, -20(%rbp)
	movl	-56(%rbp), %edx
	movl	-8(%rbp), %eax
	addl	%edx, %eax
	movl	%eax, -24(%rbp)
	movl	-56(%rbp), %eax
	subl	-8(%rbp), %eax
	movl	%eax, -28(%rbp)
	movl	-52(%rbp), %edx
	movl	-4(%rbp), %eax
	addl	%edx, %eax
	movl	%eax, -32(%rbp)
	movl	-52(%rbp), %eax
	subl	-4(%rbp), %eax
	movl	%eax, -36(%rbp)
	movl	-52(%rbp), %edx
	movl	-8(%rbp), %eax
	addl	%edx, %eax
	movl	%eax, -40(%rbp)
	movl	-52(%rbp), %eax
	subl	-8(%rbp), %eax
	movl	%eax, -44(%rbp)
	movl	-16(%rbp), %edx
	movl	-40(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	setPixel
	movl	-16(%rbp), %edx
	movl	-44(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	setPixel
	movl	-20(%rbp), %edx
	movl	-40(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	setPixel
	movl	-20(%rbp), %edx
	movl	-44(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	setPixel
	movl	-24(%rbp), %edx
	movl	-32(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	setPixel
	movl	-24(%rbp), %edx
	movl	-36(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	setPixel
	movl	-28(%rbp), %edx
	movl	-32(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	setPixel
	movl	-28(%rbp), %edx
	movl	-36(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	setPixel
	cmpl	$0, -12(%rbp)
	jns	.L35
	movl	-4(%rbp), %eax
	sall	$2, %eax
	addl	$6, %eax
	addl	%eax, -12(%rbp)
	jmp	.L36
.L35:
	movl	-8(%rbp), %eax
	leal	-1(%rax), %edx
	movl	%edx, -8(%rbp)
	movl	-4(%rbp), %edx
	subl	%eax, %edx
	leal	0(,%rdx,4), %eax
	addl	$10, %eax
	addl	%eax, -12(%rbp)
.L36:
	addl	$1, -4(%rbp)
.L34:
	movl	-4(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jle	.L37
	nop
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE16:
	.size	BresenhamCircle, .-BresenhamCircle
#APP
	.globl func1
	.type func1, @function
	func1:
	.cfi_startproc
	movl $7, %eax
	ret
	.cfi_endproc
	.globl func2
	.type func2, @function
	func2:
	.cfi_startproc
	movl %edi, %eax
	movl %esi, %ebx
	add %ebx, %eax
	ret
	.cfi_endproc
	.globl func3
	.type func3, @function
	func3:
	.cfi_startproc
	cmpl $0, (%rdx)
	jl lessthan
	mov (%rdi), %eax
	sub (%rsi), %eax
	shl $2, %eax
	add $10, %eax
	decl (%rsi)
	jmp bottom
	lessthan:
	mov (%rdi), %eax
	shl $2, %eax
	add $6,%eax
	bottom:
	add (%rdx), %eax
	incl (%rdi)
	ret
	.cfi_endproc
#NO_APP
	.globl	inlineBresenhamCircle
	.type	inlineBresenhamCircle, @function
inlineBresenhamCircle:
.LFB17:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movl	%edi, -52(%rbp)
	movl	%esi, -56(%rbp)
	movl	%edx, -60(%rbp)
	movl	$0, -36(%rbp)
	movl	-60(%rbp), %eax
	movl	%eax, -40(%rbp)
	movl	-60(%rbp), %eax
	movl	$1, %edx
	movl	%eax, %esi
	movl	$3, %edi
	call	func1@PLT
	movl	%eax, -44(%rbp)
	jmp	.L39
.L40:
	movl	-36(%rbp), %edx
	movl	-52(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	func2@PLT
	movl	%eax, -4(%rbp)
	movl	-36(%rbp), %eax
	negl	%eax
	movl	%eax, %edx
	movl	-52(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	func2@PLT
	movl	%eax, -8(%rbp)
	movl	-40(%rbp), %edx
	movl	-52(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	func2@PLT
	movl	%eax, -12(%rbp)
	movl	-40(%rbp), %eax
	negl	%eax
	movl	%eax, %edx
	movl	-52(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	func2@PLT
	movl	%eax, -16(%rbp)
	movl	-36(%rbp), %edx
	movl	-56(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	func2@PLT
	movl	%eax, -20(%rbp)
	movl	-36(%rbp), %eax
	negl	%eax
	movl	%eax, %edx
	movl	-56(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	func2@PLT
	movl	%eax, -24(%rbp)
	movl	-40(%rbp), %edx
	movl	-56(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	func2@PLT
	movl	%eax, -28(%rbp)
	movl	-40(%rbp), %eax
	negl	%eax
	movl	%eax, %edx
	movl	-56(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	func2@PLT
	movl	%eax, -32(%rbp)
	movl	-4(%rbp), %edx
	movl	-28(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	setPixel
	movl	-4(%rbp), %edx
	movl	-32(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	setPixel
	movl	-8(%rbp), %edx
	movl	-28(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	setPixel
	movl	-8(%rbp), %edx
	movl	-32(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	setPixel
	movl	-12(%rbp), %edx
	movl	-20(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	setPixel
	movl	-12(%rbp), %edx
	movl	-24(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	setPixel
	movl	-16(%rbp), %edx
	movl	-20(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	setPixel
	movl	-16(%rbp), %edx
	movl	-24(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	setPixel
	leaq	-44(%rbp), %rdx
	leaq	-40(%rbp), %rcx
	leaq	-36(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	func3@PLT
	movl	%eax, -44(%rbp)
.L39:
	movl	-36(%rbp), %edx
	movl	-40(%rbp), %eax
	cmpl	%eax, %edx
	jle	.L40
	nop
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE17:
	.size	inlineBresenhamCircle, .-inlineBresenhamCircle
#APP
	.globl func4
	.type func4, @function
	func4:
	.cfi_startproc
	mov (%rdi), %eax
	mov (%rsi), %ebx
	sub %ebx, %eax
	ret
	.cfi_endproc
	.globl func5
	.type func5, @function
	func5:
	.cfi_startproc
	mov (%rdi), %eax
	mov (%rsi), %ebx
	add %ebx, %eax
	ret
	.cfi_endproc
	.globl func6
	.type func6, @function
	func6:
	.cfi_startproc
	cmp %rdi, %rsi
	jl lessthan1
	mov $-1, %eax
	jmp bottom1
	lessthan1:
	mov $1, %eax
	bottom1:
	ret
	.cfi_endproc
	.globl func7
	.type func7, @function
	func7:
	.cfi_startproc
	mov (%rdi), %eax
	mov (%rsi), %ebx
	sub %ebx, %eax
	cmp $0, %eax
	jg bottom2
	imul $-1, %eax 
	bottom2:
	ret
	.cfi_endproc
#NO_APP
	.globl	myBresenhamLine
	.type	myBresenhamLine, @function
myBresenhamLine:
.LFB18:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movl	%edi, -36(%rbp)
	movl	%esi, -40(%rbp)
	movl	%edx, -44(%rbp)
	movl	%ecx, -48(%rbp)
	movl	-48(%rbp), %eax
	movl	-40(%rbp), %edx
	subl	%edx, %eax
	movl	%eax, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %eax
	movl	%eax, %edx
	subl	%ecx, %edx
	movl	-44(%rbp), %eax
	subl	-36(%rbp), %eax
	movl	%eax, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %eax
	subl	%ecx, %eax
	cmpl	%eax, %edx
	setg	%al
	movzbl	%al, %eax
	movl	%eax, -8(%rbp)
	cmpl	$0, -8(%rbp)
	je	.L42
	movl	-40(%rbp), %eax
	xorl	%eax, -36(%rbp)
	movl	-40(%rbp), %eax
	xorl	-36(%rbp), %eax
	movl	%eax, -40(%rbp)
	movl	-40(%rbp), %eax
	xorl	%eax, -36(%rbp)
	movl	-48(%rbp), %eax
	xorl	%eax, -44(%rbp)
	movl	-48(%rbp), %eax
	xorl	-44(%rbp), %eax
	movl	%eax, -48(%rbp)
	movl	-48(%rbp), %eax
	xorl	%eax, -44(%rbp)
.L42:
	movl	-36(%rbp), %eax
	cmpl	-44(%rbp), %eax
	jle	.L43
	movl	-44(%rbp), %eax
	xorl	%eax, -36(%rbp)
	movl	-36(%rbp), %eax
	xorl	%eax, -44(%rbp)
	movl	-44(%rbp), %eax
	xorl	%eax, -36(%rbp)
	movl	-40(%rbp), %edx
	movl	-48(%rbp), %eax
	xorl	%edx, %eax
	movl	%eax, -40(%rbp)
	movl	-48(%rbp), %edx
	movl	-40(%rbp), %eax
	xorl	%edx, %eax
	movl	%eax, -48(%rbp)
	movl	-40(%rbp), %edx
	movl	-48(%rbp), %eax
	xorl	%edx, %eax
	movl	%eax, -40(%rbp)
.L43:
	movl	-40(%rbp), %edx
	movl	-48(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	func6@PLT
	movl	%eax, -12(%rbp)
	leaq	-40(%rbp), %rdx
	leaq	-48(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	func7@PLT
	movl	%eax, -16(%rbp)
	movl	-44(%rbp), %eax
	subl	-36(%rbp), %eax
	movl	%eax, -20(%rbp)
	movl	-20(%rbp), %eax
	sarl	%eax
	movl	%eax, -24(%rbp)
	movl	-40(%rbp), %eax
	movl	%eax, -28(%rbp)
	movl	-36(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.L44
.L48:
	cmpl	$0, -8(%rbp)
	je	.L45
	movl	-28(%rbp), %eax
	movl	-4(%rbp), %edx
	movl	%edx, %esi
	movl	%eax, %edi
	call	setPixel
	jmp	.L46
.L45:
	movl	-28(%rbp), %edx
	movl	-4(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	setPixel
.L46:
	leaq	-16(%rbp), %rdx
	leaq	-24(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	func4@PLT
	movl	%eax, -24(%rbp)
	movl	-24(%rbp), %eax
	testl	%eax, %eax
	jg	.L47
	leaq	-12(%rbp), %rdx
	leaq	-28(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	func5@PLT
	movl	%eax, -28(%rbp)
	leaq	-20(%rbp), %rdx
	leaq	-24(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	func5@PLT
	movl	%eax, -24(%rbp)
.L47:
	addl	$1, -4(%rbp)
.L44:
	movl	-4(%rbp), %eax
	cmpl	-44(%rbp), %eax
	jle	.L48
	nop
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE18:
	.size	myBresenhamLine, .-myBresenhamLine
	.globl	physics
	.type	physics, @function
physics:
.LFB19:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movsd	smallx(%rip), %xmm1
	movsd	smallvx(%rip), %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, smallx(%rip)
	movsd	smally(%rip), %xmm1
	movsd	smallvy(%rip), %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, smally(%rip)
	movsd	smallvy(%rip), %xmm1
	movsd	gravity(%rip), %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, smallvy(%rip)
	movsd	smally(%rip), %xmm1
	movsd	.LC3(%rip), %xmm0
	addsd	%xmm1, %xmm0
	movl	yres(%rip), %eax
	pxor	%xmm1, %xmm1
	cvtsi2sdl	%eax, %xmm1
	comisd	%xmm1, %xmm0
	jbe	.L50
	movl	yres(%rip), %eax
	subl	$10, %eax
	pxor	%xmm0, %xmm0
	cvtsi2sdl	%eax, %xmm0
	movsd	%xmm0, smally(%rip)
	movsd	smallvy(%rip), %xmm1
	movsd	.LC4(%rip), %xmm0
	subsd	%xmm1, %xmm0
	movsd	%xmm0, smallvy(%rip)
	movsd	smallvx(%rip), %xmm0
	pxor	%xmm1, %xmm1
	comisd	%xmm1, %xmm0
	jbe	.L50
	movsd	smallvx(%rip), %xmm0
	movsd	friction(%rip), %xmm1
	subsd	%xmm1, %xmm0
	movsd	%xmm0, smallvx(%rip)
.L50:
	movsd	smally(%rip), %xmm1
	movsd	.LC3(%rip), %xmm0
	addsd	%xmm0, %xmm1
	pxor	%xmm0, %xmm0
	comisd	%xmm1, %xmm0
	jbe	.L53
	movsd	smally(%rip), %xmm1
	movsd	.LC3(%rip), %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, smally(%rip)
	movsd	smallvy(%rip), %xmm0
	movq	.LC6(%rip), %xmm1
	xorpd	%xmm1, %xmm0
	movsd	%xmm0, smallvy(%rip)
.L53:
	movsd	smallx(%rip), %xmm1
	movsd	.LC3(%rip), %xmm0
	addsd	%xmm1, %xmm0
	movl	xres(%rip), %eax
	pxor	%xmm1, %xmm1
	cvtsi2sdl	%eax, %xmm1
	comisd	%xmm1, %xmm0
	jbe	.L55
	movl	xres(%rip), %eax
	subl	$10, %eax
	pxor	%xmm0, %xmm0
	cvtsi2sdl	%eax, %xmm0
	movsd	%xmm0, smallx(%rip)
	movsd	smallvx(%rip), %xmm0
	movq	.LC6(%rip), %xmm1
	xorpd	%xmm1, %xmm0
	movsd	%xmm0, smallvx(%rip)
.L55:
	movsd	smallx(%rip), %xmm1
	movsd	.LC3(%rip), %xmm0
	addsd	%xmm0, %xmm1
	pxor	%xmm0, %xmm0
	comisd	%xmm1, %xmm0
	ja	.L63
	jmp	.L64
.L63:
	movsd	smallx(%rip), %xmm1
	movsd	.LC3(%rip), %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, smallx(%rip)
	movsd	smallvx(%rip), %xmm0
	movq	.LC6(%rip), %xmm1
	xorpd	%xmm1, %xmm0
	movsd	%xmm0, smallvx(%rip)
.L64:
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE19:
	.size	physics, .-physics
	.globl	render
	.type	render, @function
render:
.LFB20:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$144, %rsp
	movl	$0, %eax
	call	clearScreen
	movl	$200, -32(%rbp)
	movl	$200, -36(%rbp)
	movl	$255, %edx
	movl	$255, %esi
	movl	$255, %edi
	call	setColor
	movl	-36(%rbp), %edx
	movl	-32(%rbp), %eax
	movl	%eax, %esi
	movl	$0, %edi
	call	showDot@PLT
	movl	$255, %edx
	movl	$200, %esi
	movl	$160, %edi
	call	setColor
	movabsq	$7944666621902217548, %rax
	movabsq	$2336927755366657385, %rdx
	movq	%rax, -128(%rbp)
	movq	%rdx, -120(%rbp)
	movabsq	$3617065739165643314, %rax
	movq	%rax, -112(%rbp)
	movb	$0, -104(%rbp)
	leaq	-128(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movl	%eax, %edi
	movq	gc(%rip), %rdx
	movq	backBuffer(%rip), %rsi
	movq	dpy(%rip), %rax
	leaq	-128(%rbp), %rcx
	subq	$8, %rsp
	pushq	%rdi
	movq	%rcx, %r9
	movl	$15, %r8d
	movl	$15, %ecx
	movq	%rax, %rdi
	call	XDrawString@PLT
	addq	$16, %rsp
	movl	$0, %edx
	movl	$255, %esi
	movl	$255, %edi
	call	setColor
	movq	angle1.0(%rip), %rax
	movq	%rax, %xmm0
	call	sin@PLT
	movsd	.LC7(%rip), %xmm1
	mulsd	%xmm0, %xmm1
	movsd	bigradius(%rip), %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -48(%rbp)
	movsd	-48(%rbp), %xmm0
	cvttsd2sil	%xmm0, %edx
	movl	-36(%rbp), %ecx
	movl	-32(%rbp), %eax
	movl	%ecx, %esi
	movl	%eax, %edi
	call	BresenhamCircle
	movsd	angle1.0(%rip), %xmm1
	movsd	.LC8(%rip), %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, angle1.0(%rip)
	movsd	smally(%rip), %xmm0
	cvttsd2sil	%xmm0, %ecx
	movsd	smallx(%rip), %xmm0
	cvttsd2sil	%xmm0, %eax
	movl	$10, %edx
	movl	%ecx, %esi
	movl	%eax, %edi
	call	BresenhamCircle
	movl	$100, %edx
	movl	$255, %esi
	movl	$100, %edi
	call	setColor
	movl	-36(%rbp), %ecx
	movl	-32(%rbp), %eax
	movl	$148, %edx
	movl	%ecx, %esi
	movl	%eax, %edi
	call	inlineBresenhamCircle
	movl	$0, %edx
	movl	$0, %esi
	movl	$2550, %edi
	call	setColor
	movl	-36(%rbp), %ecx
	movl	-32(%rbp), %eax
	movl	$132, %edx
	movl	%ecx, %esi
	movl	%eax, %edi
	call	inlineBresenhamCircle
	movl	$255, %edx
	movl	$0, %esi
	movl	$0, %edi
	call	setColor
	movl	-36(%rbp), %ecx
	movl	-32(%rbp), %eax
	movl	$110, %edx
	movl	%ecx, %esi
	movl	%eax, %edi
	call	inlineBresenhamCircle
	movl	$255, %edx
	movl	$0, %esi
	movl	$255, %edi
	call	setColor
	movl	-36(%rbp), %ecx
	movl	-32(%rbp), %eax
	movl	$110, %edx
	movl	%ecx, %esi
	movl	%eax, %edi
	call	inlineBresenhamCircle
	movl	$255, %edx
	movl	$255, %esi
	movl	$255, %edi
	call	setColor
	movl	-36(%rbp), %ecx
	movl	-32(%rbp), %eax
	movl	$98, %edx
	movl	%ecx, %esi
	movl	%eax, %edi
	call	inlineBresenhamCircle
	movl	$200, -136(%rbp)
	movl	$200, -132(%rbp)
	movsd	.LC9(%rip), %xmm0
	movsd	%xmm0, -56(%rbp)
	pxor	%xmm0, %xmm0
	movsd	%xmm0, -8(%rbp)
	movl	$40, -60(%rbp)
	pxor	%xmm1, %xmm1
	cvtsi2sdl	-60(%rbp), %xmm1
	movsd	.LC10(%rip), %xmm0
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -72(%rbp)
	movl	$0, -28(%rbp)
	jmp	.L66
.L68:
	movq	-8(%rbp), %rax
	movq	%rax, %xmm0
	call	cos@PLT
	movq	%xmm0, %rax
	movq	%rax, %xmm1
	mulsd	-56(%rbp), %xmm1
	movl	-136(%rbp), %eax
	pxor	%xmm0, %xmm0
	cvtsi2sdl	%eax, %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -80(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %xmm0
	call	sin@PLT
	movq	%xmm0, %rax
	movq	%rax, %xmm1
	mulsd	-56(%rbp), %xmm1
	movl	-132(%rbp), %eax
	pxor	%xmm0, %xmm0
	cvtsi2sdl	%eax, %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -88(%rbp)
	movsd	-8(%rbp), %xmm0
	addsd	-72(%rbp), %xmm0
	movsd	%xmm0, -8(%rbp)
	movsd	-88(%rbp), %xmm0
	cvttsd2sil	%xmm0, %edx
	movsd	-80(%rbp), %xmm0
	cvttsd2sil	%xmm0, %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	setPixel
	cmpl	$0, -28(%rbp)
	jle	.L67
	movsd	-88(%rbp), %xmm0
	cvttsd2sil	%xmm0, %ecx
	movsd	-80(%rbp), %xmm0
	cvttsd2sil	%xmm0, %edx
	movsd	-24(%rbp), %xmm0
	cvttsd2sil	%xmm0, %esi
	movsd	-16(%rbp), %xmm0
	cvttsd2sil	%xmm0, %eax
	movl	%eax, %edi
	call	myBresenhamLine
.L67:
	movsd	-80(%rbp), %xmm0
	movsd	%xmm0, -16(%rbp)
	movsd	-88(%rbp), %xmm0
	movsd	%xmm0, -24(%rbp)
	addl	$1, -28(%rbp)
.L66:
	movl	-28(%rbp), %eax
	cmpl	-60(%rbp), %eax
	jle	.L68
	nop
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE20:
	.size	render, .-render
	.local	savex.2
	.comm	savex.2,4,4
	.local	savey.1
	.comm	savey.1,4,4
	.local	angle1.0
	.comm	angle1.0,8,8
	.section	.rodata
	.align 8
.LC3:
	.long	0
	.long	1076101120
	.align 8
.LC4:
	.long	0
	.long	1071644672
	.align 16
.LC6:
	.long	0
	.long	-2147483648
	.long	0
	.long	0
	.align 8
.LC7:
	.long	0
	.long	1076756480
	.align 8
.LC8:
	.long	1202590843
	.long	1065646817
	.align 8
.LC9:
	.long	0
	.long	1080541184
	.align 8
.LC10:
	.long	1413754129
	.long	1075388923
	.ident	"GCC: (Debian 10.2.1-6) 10.2.1 20210110"
	.section	.note.GNU-stack,"",@progbits
