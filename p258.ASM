assume cs:code

data segment
		db 'conversation',0
data ends

code segment
	start: mov ax,data
			 mov ds,ax
			 mov si,0
			 mov ax,0b800h
			 mov es,ax
			 mov di,12*160
			 
		s:  cmp BYTE ptr ds:[si],0
			 je ok							;�����0����ѭ��
			 mov al,ds:[si]
			 mov es:[di],al
			 inc si
			 add di,2
			 mov bx,offset s-offset ok		;���ôӱ��ok�����s��ת��λ��
			 int 7ch								;ת�Ƶ����s��
		ok: mov ax,4c00h
			 int 21h
code ends
end start