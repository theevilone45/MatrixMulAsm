.686
.model flat
public _pomnoz
.data

	x dd ?
	y dd ?
	z dd ?

	matrix1_ptr dd ?
	matrix2_ptr dd ?
	result_ptr	dd 0

.code

pomnoz_wiersz_przez_kolumne PROC
	push ebp
	mov ebp, esp

	push ebx
	push ecx
	push edx
	push edi
	push esi

	mov eax, 0	;result
	mov ebx, 0	;i
	mov ecx, 0
	mov edx, 0
	mov esi, matrix1_ptr	; base 1
	mov edi, matrix2_ptr	; base 2
	
	for_loop:
		push ebx
		push eax
		
		mov eax, [ebp+8]
		mul dword PTR y
		add eax,ebx
		mov ecx, eax

		mov eax, dword PTR z
		mul ebx
		add eax, dword PTR [ebp+12]
		mov ebx, eax

		mov eax, [esi+4*ecx]
		mov edx, 0
		mul dword PTR [edi+4*ebx]

		mov ebx, eax
		pop eax

		add eax,ebx

		pop ebx
	inc ebx
	cmp ebx, y
	jb for_loop

	pop esi
	pop edi
	pop edx
	pop ecx
	pop ebx
	pop ebp
	ret
pomnoz_wiersz_przez_kolumne ENDP

_pomnoz PROC
	push ebp
	mov ebp, esp

	mov ebx, dword PTR [ebp+8]
	mov x, ebx
	mov ebx, dword PTR [ebp+12]
	mov y, ebx
	mov ebx, dword PTR [ebp+16]
	mov z, ebx
	mov ebx, dword PTR [ebp+20]
	mov matrix1_ptr, ebx
	mov ebx, dword PTR [ebp+24]
	mov matrix2_ptr, ebx
	mov ebx, dword PTR [ebp+28]
	mov result_ptr, ebx

	
	mov edi, result_ptr

	mov ebx, 0	;i
	height_loop:

		mov ecx, 0	;j
		width_loop:

			push ecx
			push ebx
			call pomnoz_wiersz_przez_kolumne
			add esp, 8

			push ebx
			push eax

			mov eax, dword PTR z
			mul ebx
			add eax, ecx
			mov ebx, eax 

			pop eax
			mov [edi+4*ebx], eax
			pop ebx

		inc ecx
		cmp ecx, z
		jb width_loop

	inc ebx
	cmp ebx, x
	jb height_loop 

	pop ebp
	ret
_pomnoz ENDP

END