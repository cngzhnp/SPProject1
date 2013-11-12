segment .text
global clear
clear:
	push ebp
	mov ebp,esp
	mov ebx,[ebp+8]				; Pointer of image.
	mov edx,[ebp+12]			; Width of image.
	mov eax,[ebp+16] 			; Height of image.
	mov ecx,[ebp+20]			; Value of setting every pixel.
	mul edx						; Width*height
loopClear:
	mov [ebx],byte cl			; Low byte of value is setting
	inc ebx						; to image.
	dec eax						; controlling width*height
	cmp eax,0					; if ( eax == 0 ) ?
	jne loopClear
	pop ebp
	ret
