assume cs:code,ds:data

data segment

	db 'BaSiC'
	db 'iNfOrMaTiOn'

data ends

code segment

   start: mov ax,data
	  mov ds,ax

	  mov bx,0
	  mov cx,5

	s:mov al,ds:[bx]
	  and al,11011111b
	  mov ds:[bx],al
	  inc bx

	  loop s

	  mov bx,5
	  mov cx,11
       s0:mov al,ds:[bx]
          or al,00100000b
	  mov ds:[bx],al
	  inc bx

	  loop s0

	  mov ax,4c00h
	  int 21h



code ends
end start