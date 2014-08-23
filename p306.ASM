assume cs:code

code segment
	getstr:	push ax
				
	getstrs:	mov ah,0
				int 16h
				cmp al,20h		;ASCII��С��20H��˵�������ַ�
				jb	 nochar
				mov ah,0
				call charstack
				mov ah,2		;��ʾջ�е��ַ�
				call charstack
				jmp getstrs
				
	nochar:	cmp ah,0eh		;�˸����ɨ����
				je backspace
				cmp ah,1ch		;Enter����ɨ����
				je ente
				jmp getstrs
				
	backspace:mov ah,1
				 call charstack		;�ַ���ջ
				 mov ah,2
				 call charstack		;��ʾջ�е��ַ�
				 jmp getstrs
				 
	ente:	 	 mov al,0		;��0��ջ����Ϊ���ر�ʶ
				 mov ah,0		
				 call charstack
				 mov ah,2		;ah=2����Ӧ2����
				 call charstack
				 pop ax
				 ret
				 
	
	charstack:jmp short charstart
				 
		table		dw charpush,charpop,charshow
		top		dw 0
		
		charstart:push bx
					 push dx
					 push di
					 push es
					 
					 cmp ah,2
					 ja sret
					 mov bl,ah
					 mov bh,0
					 add bx,bx
					 jmp WORD ptr table[bx]
					 
		charpush: mov bx,top
					 mov [si][bx],al
					 inc top
					 jmp sret
					 
		charpop:	 cmp top,0
					 je sret
					 dec top
					 mov bx,top
					 mov al,[si][bx]
					 jmp sret
					 
		charshow: mov bx,0b800h
					 mov es,bx
					 mov al,160
					 mov ah,0
					 mul dh
					 mov di,ax		;�е�ƫ�Ƶ�ַ��di
					 add dl,dl		;�еĵ�ַ*2 = ƫ�Ƶ�ַ 
					 mov dh,0		;�е�ƫ�� + �е�ƫ��
					 add di,dx
					 
					 mov bx,0
					 
		charshows:cmp bx,top
					 jne noempty
					 mov BYTE ptr es:[di],' '
					 jmp sret
		noempty:	 mov al,[si][bx]
					 mov es:[di],al
					 mov BYTE ptr es:[di+2],' '
					 inc bx
					 add di,2
					 jmp charshows
					 
		sret:		pop es
					pop di
					pop dx
					pop bx
					ret
			
			mov ax,4c00h
			int 21h
	
	
code ends
end getstr