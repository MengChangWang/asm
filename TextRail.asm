assume cs:code

m_print  macro offs,attri,row,column
    xor cx,cx
    xor si,si
    mov si, offset offs
    mov cl, attri
    mov dh, row
    mov dl, column
    call f_display_text
endm

m_curse  macro row,col   
    mov       ah,2		    ;�ù��λ��
    mov       dh,row		;�к�
    mov       dl,col		;�к�
    mov       bh,0			;��ǰҳ
    int       10H
endm

m_sub_day macro value
    mov ax,role
    mov es,ax
    sub word ptr es:[days],value
endm

m_add_money macro value
    mov ax,role
    mov es,ax
    add word ptr es:[money],value
endm

;��ʱ
m_delay macro seconds
    local outer_loop, inner_loop   
    push cx
    push dx

    mov  cx, seconds
outer_loop:
    mov  dx, 0FFFFh
    
inner_loop:
    dec  dx           
    jnz  inner_loop   
    loop outer_loop 
    
    pop  dx
    pop  cx
endm
;-------------------------------
role segment
    days dw 5    ; ʣ������
    money  dw 0     ; ���õ�
role ends

login_interface segment
    login1 db '��ӭ���� ','$'
    login2 db '����:��������','$'
    login3 db '׼���õ����г�,��������֮������?','$'
    select1 db '1.�����г�','$'
    select2 db '2.�뿪�г�','$'
    hint1 db '����Ҫִ�еĲ�����:','$'
    hint4 db '����Ҫѡ���ί����:','$'
    hint2 db '����������������� ','$'
    hint3 db 'bye bye������','$'
    days_label db 'ʣ��������','$'
    money_label db '���õ㣺','$'
    l1_attribute db 00000111B
    l2_attribute db 11110000B
    s2_attribute db 00000100B
login_interface ends

d0 segment
    t1 db '������,�����ó̵��յ����ǳ��󺣡�����·�ϵ��˵������Ƚ���!','$'
    t2 db '����Ҫ�������ڳＯ','$'
    t3 db '50000','$'
    t4 db '���õ�','$'
    t5 db 'ÿ������յ�����ί��,��ͬ��ί�в�ͬ���ջ�,�뷢���������Ŀ���!','$'
    c db 00000111B
    c2 db 01110110B
d0 ends

d1 segment
    d1_t1 db '��һվ:�����ռ�վ��������ǵ����Դ�','$'
    d1_t2 db  '��������źͷ���֮�䷴������','$'
    d1_t3 db '1.�����ռ�վ��ĳλ���(����̫����)��ѧ���з��˻�˵��������Ͱ','$'
    d1_t4 db '��Ҫ־Ը�����ò���¼����','$'
    d1_t5 db '2.�ռ�վ������ʵ������,һֻ�Ǽʲ���л�����������ϵͳ,','$'
    d1_t6 db '���ڹܵ�������·,��Ҫ�����ץ����!','$'
    d1_c db 00000111B
d1 ends

d2 segment
    d2_t1 db '�ڶ�վ:�޸����ۡ�����������,�����ޱ�','$'
    d2_t2 db '����������,�򹤶�Ҫ����Ե','$'
    d2_t3 db '1.�����С����������ս�޸��������,������������,���Լ���������,','$'
    d2_t4 db '��Ҫ�㵱С���յ��ʼ�Ա','$'
    d2_t5 db '2.̫��˾����ȸ����������������������,��ʼ��������,����"����"��','$'
    d2_t6 db '������������ݵ���Ȼ:"��ѽ,������ô�Լ�����?"','$'
    d2_c db 00000111B
d2 ends

d3 segment
    d3_t1 db '����վ:ƥŵ���ᡪ������ʲô����,����ծ��','$'
    d3_t2 db '����������,��׬Ǯ����һ����','$'
    d3_t3 db '1.ƥŵ�������"֪����"��һλ��������ķ�˿����,���������αװ��','$'
    d3_t4 db '�Ƶ������,������������ȫ�෴�ķ���','$'
    d3_t5 db '2.�����ξƵ�Ĳ��ֿ��˻�͵͵¼���Լ�������,���ں����ϳ���','$'
    d3_t6 db '����Ҫ�ҵ���Щ����"����"����,��������Щ�ξ�','$'
    d3_c db 00000111B
d3 ends

d4 segment
    d4_t1 db '����վ:�̷���˹���������ڴ˳���,������Ĺ���','$'
    d4_t2 db '����������,�����㶼�ᱻ�̽���ʷ','$'
    d4_t3 db '1.�߷�ʥ�ǰº��겢̽�������ż�,���ܲ����ĺڳ�����,��������','$'
    d4_t4 db '���̩̹����,С������͵�����ս��Ʒ','$'
    d4_t5 db '2.������ڲ���������,�����������,���ܽ�������ί��,Ǳ����������','$'
    d4_t6 db '�ݵ�,̽Ѱ������ı������Ŀ��','$'
    d4_c db 00000111B
d4 ends

d5 segment
    d5_t1 db '����վ:������-�������ڶ���������֮�䷴������','$'
    d5_t2 db '��������ķ��˵��,��˵:"�����,����"','$'
    d5_t3 db '1.����������ϲ�������������Ҿƺͷ�����,��������˿�ʼ���ˡ�','$'
    d5_t4 db '��������Ǵ��ż����������ǻ�ծ','$'
    d5_t5 db '2.�ѽ�������ѧ���˶�����,������Ҫ���˴��ŷ���װ���ڻ�Ұ����','$'
    d5_t6 db '����������','$'
    d5_c db 00000111B
d5 ends

finale segment
    fail1 db '�����Ӵ��˵��ź���Ļ��(�i�s^�t�i)','$'
    fail2_1 db '  ��ķ����һ����Ǯ��,����ʧ��:"������...���ǲ�һ���ʹ������...','$'
    fail2_2 db '��������һ��ȥ���ǿ���..."','$'
    success1 db '�����Ӽ������ʤ����^��^','$'
    success2_1 db '  ��ķ����ӫ����˷ܵرĳ���:"������!���ǲ���׬����50000���õ�,','$'
    success2_2 db '����׬��3������Ͱ����Ǯ��!���¿���ȥ�ú���ף��!"','$'
    f_c db 00000111B
finale ends


buffer segment
    db 8 dup('$')
buffer ends

code segment
main:
    mov ax,role
    mov es,ax
    call f_clear_screen
    call f_init_login
    call f_d0_wait_input

    mov ax,4c00h
    int 21h

;---------------
f_clear_screen:
    push ax
    push cx
    push di
    push es
    mov ax,0B800h
    mov es,ax
    xor di,di
    mov cx,80*25
    mov ax,0720h
    rep stosw
    pop es
    pop di
    pop cx
    pop ax
    ret

;----------------
f_init_login:
    mov ax,login_interface
    mov ds,ax
    m_print login1,l1_attribute,8,28
    m_print login2,l2_attribute,8,37
    m_print login3,l1_attribute,10,22
    m_print select1,l1_attribute,12,24
    m_print select2,s2_attribute,12,40
    ret
;---------------
f_show_hint:
    mov ax,login_interface
    mov ds,ax
    xor ax,ax
    m_print hint1,l1_attribute,24,0
    m_curse 24,19
    ret
;-----------------------
f_show_commission:
    mov ax,login_interface
    mov ds,ax
    xor ax,ax
    m_print hint4,l1_attribute,24,0
    m_curse 24,19
    ret
;-----------------------
f_d0_wait_input:
f_d0_wait_input_start:
    call f_show_hint  
    mov  ah, 01h           ; ��ȡ����
    int  21h
    
    cmp  al, '1'
    je   d0_option_1
    cmp  al, '2'
    je   d0_option_2
    jmp  d0_input_error        ; ��Ч�������

d0_option_1:
    call f_clear_screen
    mov ax,d0
    mov ds,ax
    m_print t1,c,6,13
    m_print t2,c,9,24
    m_print t3,c2,9,42
    m_print t4,c,9,47
    m_print t5,c,11,10
    m_delay 100
    call f_d1_wait_input
    jmp  d0_input_done

d0_option_2:
    m_delay 10                ; ��ʱ1��
    call f_clear_screen
    m_print hint3,s2_attribute,8,30

d0_input_done:
    ret

d0_input_error:
    call f_delete_char
    m_print hint2,s2_attribute,24,0
    m_delay 20
    jmp f_d0_wait_input_start

;-----------------------
f_d1_wait_input:
f_d1_wait_input_start:
    call f_clear_screen
    mov ax,d1
    mov ds,ax
    m_print d1_t1,d1_c,1,17  
    m_print d1_t2,d1_c,2,43  
    m_print d1_t3,d1_c,6,10  
    m_print d1_t4,d1_c,7,10  
    m_print d1_t5,d1_c,12,10  
    m_print d1_t6,d1_c,13,10  
    call f_show_status
    call f_show_commission
    mov  ah, 01h           ; ��ȡ����
    int  21h
    
    cmp  al, '1'
    je   d1_option_1
    cmp  al, '2'
    je   d1_option_2
    jmp  d1_input_error        ; ��Ч�������

d1_option_1:
    m_add_money 12000
    jmp  d1_input_done

d1_option_2:
   m_add_money 8000
   jmp d1_input_done

d1_input_done:
    m_sub_day 1
    m_delay 30
    call f_d2_wait_input
    ret

d1_input_error:
    call f_delete_char
    m_print hint2,s2_attribute,24,0
    m_delay 20
    jmp f_d1_wait_input_start


f_d2_wait_input:
f_d2_wait_input_start:
    call f_clear_screen
    mov ax,d2
    mov ds,ax
    m_print d2_t1,d2_c,1,17
    m_print d2_t2,d2_c,2,43     
    m_print d2_t3,d2_c,6,10     
    m_print d2_t4,d2_c,7,10     
    m_print d2_t5,d2_c,12,10
    m_print d2_t6,d2_c,13,10

    call f_show_status
    call f_show_commission
    mov  ah, 01h           ; ��ȡ����
    int  21h
    
    cmp  al, '1'
    je   d2_option_1
    cmp  al, '2'
    je   d2_option_2
    jmp  d2_input_error        ; ��Ч�������

d2_option_1:
    m_add_money 5000
    jmp  d2_input_done

d2_option_2:
    m_add_money 10000
    jmp d2_input_done

d2_input_done:
    m_sub_day 1
    m_delay 30
    call f_d3_wait_input
    ret

d2_input_error:
    call f_delete_char
    m_print hint2,s2_attribute,24,0
    m_delay 20
    jmp f_d2_wait_input_start
;-----------------------
f_d3_wait_input:
f_d3_wait_input_start:
    call f_clear_screen
    mov ax,d3
    mov ds,ax
    m_print d3_t1,d3_c,1,17 
    m_print d3_t2,d3_c,2,43 
    m_print d3_t3,d3_c,6,12 
    m_print d3_t4,d3_c,7,12
    m_print d3_t5,d3_c,12,12
    m_print d3_t6,d3_c,13,12


    call f_show_status
    call f_show_commission
    mov  ah, 01h           ; ��ȡ����
    int  21h
    
    cmp  al, '1'
    je   d3_option_1
    cmp  al, '2'
    je   d3_option_2
    jmp  d3_input_error        ; ��Ч�������

d3_option_1:
    m_add_money 15000
    jmp  d3_input_done

d3_option_2:
    m_add_money 8000
    jmp d3_input_done

d3_input_done:
    m_sub_day 1
    m_delay 30
    call f_d4_wait_input
    ret

d3_input_error:
    call f_delete_char
    m_print hint2,s2_attribute,24,0
    m_delay 20
    jmp f_d3_wait_input_start

;-----------------------
f_d4_wait_input:
f_d4_wait_input_start:
    call f_clear_screen
    mov ax,d4
    mov ds,ax
    m_print d4_t1,d4_c,1,17 
    m_print d4_t2,d4_c,2,43 
    m_print d4_t3,d4_c,6,12 
    m_print d4_t4,d4_c,7,12 
    m_print d4_t5,d4_c,12,12
    m_print d4_t6,d4_c,13,12

    call f_show_status
    call f_show_commission
    mov  ah, 01h           ; ��ȡ����
    int  21h
    
    cmp  al, '1'
    je   d4_option_1
    cmp  al, '2'
    je   d4_option_2
    jmp  d4_input_error        ; ��Ч�������

d4_option_1:
    m_add_money 7000
    jmp  d4_input_done

d4_option_2:
    m_add_money 10000
    jmp d4_input_done

d4_input_done:
    m_sub_day 1
    m_delay 30
    call f_d5_wait_input
    ret

d4_input_error:
    call f_delete_char
    m_print hint2,s2_attribute,24,0
    m_delay 20
    jmp f_d4_wait_input_start

;-----------------------
f_d5_wait_input:
f_d5_wait_input_start:
    call f_clear_screen
    mov ax,d5
    mov ds,ax
    m_print d5_t1,d5_c,1,17 
    m_print d5_t2,d5_c,2,40 
    m_print d5_t3,d5_c,6,12 
    m_print d5_t4,d5_c,7,12
    m_print d5_t5,d5_c,12,12
    m_print d5_t6,d5_c,13,12

    call f_show_status
    call f_show_commission
    mov  ah, 01h           ; ��ȡ����
    int  21h
    
    cmp  al, '1'
    je   d5_option_1
    cmp  al, '2'
    je   d5_option_2
    jmp  d5_input_error        ; ��Ч�������

d5_option_1:
    m_add_money 5000
    jmp  d5_input_done

d5_option_2:
    m_add_money 15000
    jmp d5_input_done
d5_input_done:
    ; ����Ƿ�ﵽĿ��
    mov ax,role
    mov es,ax
    mov ax,es:[money]
    cmp ax,50000
    jl game_over
    ; ��ʾʤ����Ϣ
    call f_clear_screen
    mov ax,finale
    mov ds,ax
    m_print success1,f_c,5,25
    m_print success2_1,f_c,7,10
    m_print success2_2,f_c,8,10
    jmp exit_game

game_over:
    ; ��ʾʧ����Ϣ
    call f_clear_screen
    mov ax,finale
    mov ds,ax
    m_print fail1,f_c,5,23
    m_print fail2_1,f_c,7,10
    m_print fail2_2,f_c,8,10
    jmp exit_game

exit_game:
    m_delay 100         
    mov ax,4c00h
    int 21H

d5_input_error:
    call f_delete_char
    m_print hint2,s2_attribute,24,0
    m_delay 20
    jmp f_d5_wait_input_start
;-----------------------------    
; ���룺DS:SI=�ַ�����ַ��CL=���ԣ�DH=�У�DL=��
f_display_text:
    push ax
    push bx
    push cx
    push dx
    push si
    push es
    push di
    
    ; ������ʾλ��
    mov al,160
    mul dh
    mov di,ax
    mov al,2
    mul dl
    add di,ax
    
    mov ax,0B800h
    mov es,ax
    
display_loop:
    mov bl,ds:[si]
    cmp bl,'$'
    je exit_display
    mov bh,cl
    mov es:[di],bx
    inc si
    add di,2
    jmp display_loop
    
exit_display:
    pop di
    pop es
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret

;------------------
; AX=Ҫת�������֣�DS:SI=��������ַ
f_itoa:
    push bx
    push cx
    push dx
    push si
    
    xor si,si     ; ����������
    mov cx,10       ; ����
    
    ; ����0���������
    test ax,ax
    jnz not_zero
    mov byte ptr [si],'0'
    inc si
    jmp store_end
    
not_zero:
    xor bx,bx       
divide_loop:
    xor dx,dx
    div cx         ; AX=�̣�DX=����
    push dx        ; ��������
    inc bx
    test ax,ax
    jnz divide_loop
    
store_loop:
    pop ax
    add al,'0'
    mov [si],al
    inc si
    dec bx
    jnz store_loop
    
store_end:
    mov byte ptr [si],'$'
    pop si
    pop dx
    pop cx
    pop bx
    ret
;--------------------

;---------------------
f_show_status:
    push ax
    push bx
    push cx
    push dx
    push si
    push ds
    
    ; ��ʾʣ��������ǩ
    mov ax,login_interface
    mov ds,ax
    m_print days_label,l1_attribute,22,10
    
    ; ��ȡ��ת��ʣ������
    mov ax,role
    mov ds,ax
    mov ax,days  
    mov bx,buffer
    mov ds,bx      ; DSָ��buffer��
    call f_itoa
    
    ; ��ʾʣ������
    mov ax,login_interface
    mov ds,ax
    xor cx,cx
    mov cl,l1_attribute
    mov ax,buffer
    mov ds,ax
    mov dh,22
    mov dl,20
    xor si,si
    call f_display_text
      
    ; ��ʾ���õ��ǩ
    mov ax,login_interface
    mov ds,ax
    m_print money_label,l1_attribute,22,55
    
    ; ��ȡ��ת�����õ�
    mov ax,role
    mov ds,ax
    mov ax,money
    mov bx,buffer
    mov ds,bx
    call f_itoa
    
    ; ��ʾ���õ���ֵ
    mov ax,login_interface
    mov ds,ax
    xor cx,cx
    mov cl,l1_attribute
    mov ax,buffer
    mov ds,ax
    mov dh,22
    mov dl,63
    xor si,si
    call f_display_text
    

    pop ds
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
;-----------
; ɾ����ǰ���λ�õ��ַ�
f_delete_char:
    push ax
    push bx
    push cx
    push dx

    mov ah, 03h        ; ��ȡ���λ�ù��ܺ�
    mov bh, 0           ; ҳ��Ϊ0
    int 10h             ; DHΪ�У�DLΪ��

    mov ah, 02h        ; ���ù��λ�ù��ܺ�
    mov bh, 0           ; ҳ��Ϊ0
    dec dl             ;�Ƶ�Ҫɾ���ַ���λ��
    int 10h            

    mov ah, 09h        ; �ڵ�ǰ���λ����ʾ�ַ����ܺ�
    mov al, ' '        ; ��ʾ�ո�
    mov bl, 07h        
    mov cx, 1          
    int 10h             ; ����BIOS�ж���ʾ�ո�ʵ��ɾ���ַ���Ч��

    mov ah, 03h        ; �ٴλ�ȡ���λ��
    mov bh, 0
    int 10h
    inc dl             ; ������ƻ�ԭ����λ��
    mov ah, 02h
    mov bh, 0
    int 10h

    pop dx
    pop cx
    pop bx
    pop ax
    ret

code ends
end main