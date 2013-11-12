segment .bss
width resd 1
counter resd 1

segment .text
global grow
grow:
	push ebp
	mov ebp,esp
	mov edx,[ebp+8]			; Address of image1 is assigned to edx.
	mov ebx,[ebp+12]		; Address of image2 is assigned to ebx.
	mov eax,[ebp+16]		; Value of width is moved to eax.
	mov ecx,[ebp+20]		; Value of height is hold in ecx.
	mov dword[width],eax 	; width variable = eax
	shl eax,1				; Value of width multiplied by 2.
loopGrow1:
	push ecx				; Ecx push into stack.
	mov ecx,[width]			; width variable is assigned to ecx.
	mov dword[counter],ecx	; counter and width value is equal to ecx.
	mov dword[width],ecx	;
loopGrow2:	
	mov ecx,dword[edx]		; Ecx hold on the value of current pixel
	mov dword[ebx],ecx		; This value moved into new image pixel.
	mov dword[ebx+eax],ecx 	; This value moved into next row of the same column.
	inc ebx					; Shift one pixel right.
	mov dword[ebx],ecx		; This value moved into right pixel.
	mov dword[ebx+eax],ecx 	; This value assigned to next row of the right pixel.
	inc ebx					; 
	inc edx					; Shift next pixel of the new image. 
	dec dword[counter]		
	cmp dword[counter],0
	jne loopGrow2			; Current row finished? If its not, keep living on loop.
	
	add ebx,eax				; Passing next row of new image.
	pop ecx					; Pop ecx.
	dec ecx					; Decreased ecx one by one.
	cmp ecx,0				; if width == 0 ?
	jne loopGrow1			; Next row of old image.
	pop ebp
	ret
