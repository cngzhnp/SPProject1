segment .text
global contrast
contrast:
	push ebp
	mov ebp,esp
	mov ecx,[ebp+8]			; Pointer of image.
	mov edx,[ebp+12]		; Width of image.
	mov eax,[ebp+16]		; Height of image.
	mov ebx,[ebp+20]		; Value of contrast.
	mul edx					; size = width * height
	mov edx,eax				; size is assigned to edx
	xor eax,eax 			; eax = 0
loopContr:
	mov eax,ebx				; value of contrast assigned to eax.
	mul byte[ecx]			; current pixel value multiplied by eax.
	shr eax,6				; after multiplying result is divided by 64.
	cmp eax,255				; if eax value not greater than 255 
	jna regularContr		; jump regularContr otherwise value is 
	mov byte[ecx],255		; set up to maximum value which means 255.
	jmp doneContr
regularContr:
	mov byte[ecx],byte al	; result is assigned to current pixel value.
doneContr:
	inc ecx					; address is increased.
	dec edx					; size is decreased one by one.
	cmp edx,0				; if size == 0 ?
	jne loopContr
	pop ebp
	ret
