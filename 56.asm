assume cs:code

a segment

	dw 1,2,3,4,5,6,7,8,9,0ah,0bh,0ch,0dh,0eh,0fh,0ffh

a ends

b segment

	dw 0,0,0,0,0,0,0,0		;定义一个站段，mov ax,b  mov ss,ax  mov sp,10h  这个站段的偏移地址是从0开始的
	 
	 

b ends

code segment

   start: mov ax,a
	  mov ds,ax

	  mov ax,b
	  mov ss,ax
	  mov sp,10h

	  mov bx,0
	  mov cx,8
	s:mov ax,ds:[bx]
	  push ax
	  add bx,2

	  loop s

	  mov ax,4c00h
	  int 21h


code ends
end start

