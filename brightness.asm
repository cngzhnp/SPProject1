segment .text
global brightness
brightness:
	push ebp
	mov ebp,esp
	mov ebx,[ebp+8]			; Pointer of image.
	mov ecx,[ebp+12]		; Width of image.
	mov eax,[ebp+16]		; Height of image.
	mul ecx					; size = width * height
	mov edx,[ebp+20]		; Value of brightness.
loopBright:
	mov cl,byte[ebx]
	add ecx,edx
	cmp ecx,255
	jg editPos
	cmp ecx,0
	jl editNeg
	mov byte[ebx],cl
	jmp done
editPos:
	mov byte[ebx],255
	jmp done
editNeg:
	mov byte[ebx],0
done:
	inc ebx					; address of image is increased.
	xor ecx,ecx
	dec eax					; size is increased.
	cmp eax,0				; if size == 0 ?
	jne loopBright
	pop ebp
	ret
