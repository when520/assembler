assume cs:code

code segment

	showbyte:	jmp short show
					
					table db '0123456789ABCDEF'	;�ַ���
		
		show:		push bx
					push es
					
					mov ah,al
					shr ah,1
					shr ah,1
					shr ah,1
					shr ah,1
					and al,00001111b		;����4λ��ah�еõ���4λ��al��ʣ�µ�4λ
					
					mov bl,ah
					mov bh,0
					mov ah,table[bx]	;�ø�4λ��ֵ��Ϊ�����table��ƫ�ƣ�ȡ�ö�Ӧ���ַ�
					
					mov bx,0b800h
					mov es,bx
					mov es:[160*12+40*2],ah
					
					mov bl,al
					mov bh,0
					mov al,table[bx]		;�õ�4λ��ֵ��Ϊ�����table��ƫ�ƣ�ȡ�ö�Ӧ���ַ�
					
					mov es:[160*12+40*2+2],al
					
					pop es
					pop bx
					
					ret
code ends
end showbyte