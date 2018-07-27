section .data
msg1:	db "unsorted array : ", 0
msg2: 	db "  sorted array : ", 0
num:	dq 632, 209, 382, 124, 875, 760, 999, 458, 527, 911, 0
i:	dq 10
fmt:	db "%lld ", 0
ent:	db "", 10, 0

section .text
extern	printf
extern 	exit
global 	main, _start

prn:
	; printf("??sorted : ");
	call	printf

	mov	rcx, [i]
	mov	rbx, num
_for:	; printf("%lld ");
	push	rcx
	mov 	rsi, [rbx]
	mov	rdi, fmt
	xor	rax, rax
	call	printf
	add	rbx, 8
	pop	rcx
	dec	rcx
	cmp	rcx, 0
	jg	_for

	; printf("\n");
	mov	rdi, ent
	xor	rax, rax
	call 	printf
	ret

bubble:
	push	rbp
	mov 	rbp, rsp
	mov	rcx, [i]
	dec	rcx
L1:
	mov	rdx, rcx ; rdx Assistance rcx
	mov	rsi, num
	mov	rdi, rsi
	push	rcx
	push	1 ; end flag

L2:
	cmp	rcx, rdx
	jz	L2_1
	add	rsi, 8
L2_1:	add	rdi, 8
	mov	rax, [rsi]
	mov	rbx, [rdi]
	cmp	rax, rbx
	jle	L2_2
	mov	[rsi], rbx
	mov	[rdi], rax
	pop	rbx ; flag change
	push	0 ; run flag
L2_2:	dec	rcx
	cmp	rcx, 0
	jg	L2
	pop	rbx
	pop	rcx
	cmp	rbx, 1 ; checking flag	
	jnz	sorted
	mov	rcx, 1
sorted:	dec	rcx
	cmp	rcx, 0
	jg	L1
	pop	rbp
	ret

main:
_start:
	; printf("unsorted : %lld ...");
	mov	rdi, msg1
	xor	rax, rax
	call	prn

	; bubble(num);
	call	bubble

	; printf("  sorted : %lld ...");
	mov	rdi, msg2
	xor	rax, rax
	call	prn
	call	exit
	ret
