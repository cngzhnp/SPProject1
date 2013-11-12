segment .text
global atleast
atleast:
	push ebp
	mov ebp,esp
	mov ebx,[ebp+8]				; Pointer of image.
	mov edx,[ebp+12]			; Width of image.
	mov eax,[ebp+16] 			; Height of image.
	mov ecx,[ebp+20]			; Value of setting every pixel.
	mul edx						; Width*height
	xor edx,edx
atleastLoop:
	cmp byte[ebx],byte cl		; Low byte of value is setting
	jb  counterloop				; value < image[i] branch counterloop
	inc edx						; otherwise atleast increases.
counterloop:
	inc ebx						; to image.
	dec eax						; size decreases until reach to 0.
	cmp eax,0					; if size == 0 ?
	jne atleastLoop
	mov eax,edx					; return value is moved to eax.
	pop ebp
	ret
