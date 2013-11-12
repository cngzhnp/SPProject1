segment .bss

width resd 1 			
hold resd 1			 		; value holder
width2 resd 1				; width/2

segment .text
global shrink
shrink:
	push ebp
	mov ebp,esp	
	mov edx,[ebp+8]			; Address of image1 is assigned to edx.
	mov ebx,[ebp+12]		; Address of image2 is assigned to ebx.
	mov eax,[ebp+16]		; Value of width is moved to eax.
	mov ecx,[ebp+20]		; Value of height is hold in ecx.
	mov dword[width],eax	; width variable = eax
	shr eax,1				; eax divided by 2.
	mov dword[width2],eax	; new width is assigned to width2.
	shr ecx,1				; height is divided by 2.
loopShrink1:
	push ecx
	mov ecx,dword[width2]
	mov eax,ecx				; eax is equal to half of the original width.
	mov dword[width2],ecx	
loopShrink2:
	mov ecx,dword[edx]		; the value of current pixel is moved to ecx.
	mov dword[ebx],ecx		; the pixel of new image
	inc edx					
	inc edx					; next 2 pixels of old image
	inc ebx					; next pixel of new image
	dec eax
	cmp eax,0				; if ( height == heightsize) ?
	jne loopShrink2			; if is not  
	mov eax,dword[width]
	add edx,eax				; next row
	mov dword[width],eax	
	pop ecx
	dec ecx
	cmp ecx,0
	jne loopShrink1			
	pop ebp
	ret
