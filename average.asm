segment .text
global average
average:
	push ebp
	mov ebp,esp	
	sub esp,4	
	mov eax,[ebp+16]		; Height of image.
	mov ecx,[ebp+20]		; Width  of image.
	mul ecx
	mov [ebp-4],eax			; size = width * height
	mov edx,[ebp+8]			; Pointer of image1.
	mov eax,[ebp+12]		; Pointer of image2.
	xor ecx,ecx
loopAvg:
	add byte cl,byte[edx]	; Value of image1 assign to ecx
	add byte cl,byte[eax]	; Value of image2 assign to ecx
	add byte cl,1			; Add 1 to value 
	shr cx,1				; Divide by 2
	mov byte[edx],byte cl	; Calculated value assign to image.
	inc edx					; Next address of image1
	inc eax					; Next address of image2
	xor ecx,ecx				; ecx = 0
	dec dword[ebp-4]		; Decreases size.
	cmp dword[ebp-4],0		; if size == 0 ?
	jne loopAvg
	mov esp,ebp
	pop ebp
	ret
