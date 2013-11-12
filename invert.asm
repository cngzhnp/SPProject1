segment .text
global invert
invert:
	push ebp
	mov ebp,esp
	mov ebx,[ebp+8]				; Pointer of image.
	mov edx,[ebp+12]			; Width of image.
	mov eax,[ebp+16] 			; Height of image.
	mul edx						; Width*height
loopInvert:
	neg byte[ebx]				; Every byte has to be changed
	inc ebx						; to 255-pixel.
	dec eax						; Decreased one by one size.
	cmp eax,0					; if size == 0 ?
	jne loopInvert
	pop ebp
	ret
