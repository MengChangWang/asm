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
    mov       ah,2		    ;置光标位置
    mov       dh,row		;行号
    mov       dl,col		;列号
    mov       bh,0			;当前页
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

;延时
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
    days dw 5    ; 剩余天数
    money  dw 0     ; 信用点
role ends

login_interface segment
    login1 db '欢迎来到 ','$'
    login2 db '崩坏:文字铁道','$'
    login3 db '准备好登上列车,开启开拓之旅了吗?','$'
    select1 db '1.登上列车','$'
    select2 db '2.离开列车','$'
    hint1 db '您想要执行的操作是:','$'
    hint4 db '您想要选择的委托是:','$'
    hint2 db '输入错误请重新输入 ','$'
    hint3 db 'bye bye！！！','$'
    days_label db '剩余天数：','$'
    money_label db '信用点：','$'
    l1_attribute db 00000111B
    l2_attribute db 11110000B
    s2_attribute db 00000100B
login_interface ends

d0 segment
    t1 db '开拓者,这趟旅程的终点是星辰大海……但路上的账单还得先结清!','$'
    t2 db '你需要在五天内筹集','$'
    t3 db '50000','$'
    t4 db '信用点','$'
    t5 db '每天你会收到两个委托,不同的委托不同的收获,请发挥运气完成目标吧!','$'
    c db 00000111B
    c2 db 01110110B
d0 ends

d1 segment
    d1_t1 db '第一站:黑塔空间站——天才们的任性打工','$'
    d1_t2 db  '——在天才和疯子之间反复横跳','$'
    d1_t3 db '1.黑塔空间站的某位天才(但不太靠谱)科学家研发了会说话的垃圾桶','$'
    d1_t4 db '需要志愿者试用并记录反馈','$'
    d1_t5 db '2.空间站的生物实验室里,一只星际仓鼠啃坏了重力控制系统,','$'
    d1_t6 db '正在管道里疯狂跑路,需要你把它抓回来!','$'
    d1_c db 00000111B
d1 ends

d2 segment
    d2_t1 db '第二站:罗浮仙舟——赛博修仙,法力无边','$'
    d2_t2 db '——在仙舟,打工都要讲仙缘','$'
    d2_t3 db '1.云骑军小将彦卿想挑战罗浮各大高手,精进自身剑技术,但自己懒得送信,','$'
    d2_t4 db '需要你当小剑痴的邮寄员','$'
    d2_t5 db '2.太卜司的青雀大人最近摸鱼打牌总是输牌,开始怀疑牌生,急需"菜鸟"重','$'
    d2_t6 db '建信心你必须演得自然:"哎呀,这牌怎么自己糊了?"','$'
    d2_c db 00000111B
d2 ends

d3 segment
    d3_t1 db '第三站:匹诺康尼——梦里什么都有,包括债务','$'
    d3_t2 db '——在这里,连赚钱都像一场梦','$'
    d3_t3 db '1.匹诺康尼歌星"知更鸟"被一位过于热情的粉丝纠缠,你的任务是伪装成','$'
    d3_t4 db '酒店服务生,引导他走向完全相反的方向','$'
    d3_t5 db '2.白日梦酒店的部分客人会偷偷录制自己的美梦,并在黑市上出售','$'
    d3_t6 db '你需要找到这些盗版"美梦"卖家,并回收这些梦境','$'
    d3_c db 00000111B
d3 ends

d4 segment
    d4_t1 db '第四站:翁法洛斯——永恒在此沉淀,包括你的工资','$'
    d4_t2 db '——在这里,连摸鱼都会被刻进历史','$'
    d4_t3 db '1.走访圣城奥赫玛并探索郊外遗迹,击败残留的黑潮势力,净化区域','$'
    d4_t4 db '获得泰坦遗物,小心贼灵偷走你的战利品','$'
    d4_t5 db '2.悬锋城内部发生叛乱,城市陷入混乱,你受金线秘密委托,潜入叛乱势力','$'
    d4_t6 db '据点,探寻叛乱主谋及背后目的','$'
    d4_c db 00000111B
d4 ends

d5 segment
    d5_t1 db '第五站:雅利洛-Ⅵ——在冻死和穷死之间反复横跳','$'
    d5_t2 db '——这里的风会说话,它说:"别出门,会死"','$'
    d5_t3 db '1.矿区工人总喜欢赊账买劣质烈酒和防寒膏,但最近有人开始赖账。','$'
    d5_t4 db '你的任务是带着计量仪找他们还债','$'
    d5_t5 db '2.裂界怪物最近学会了躲避侦察,铁卫需要有人穿着发热装甲在荒野晃悠','$'
    d5_t6 db '引它们现身','$'
    d5_c db 00000111B
d5 ends

finale segment
    fail1 db '《银河打工人的遗憾落幕》(╥╯^╰╥)','$'
    fail2_1 db '  帕姆抱着一堆零钱袋,眼神失落:"开拓者...我们差一点点就达标了帕...','$'
    fail2_2 db '本来还能一起去看星空呢..."','$'
    success1 db '《银河级社畜的胜利》^ω^','$'
    success2_1 db '  帕姆举着荧光棒兴奋地蹦出来:"开拓者!我们不仅赚够了50000信用点,','$'
    success2_2 db '还多赚了3个垃圾桶的零钱帕!这下可以去好好庆祝啦!"','$'
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
    mov  ah, 01h           ; 读取输入
    int  21h
    
    cmp  al, '1'
    je   d0_option_1
    cmp  al, '2'
    je   d0_option_2
    jmp  d0_input_error        ; 无效输入忽略

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
    m_delay 10                ; 延时1秒
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
    mov  ah, 01h           ; 读取输入
    int  21h
    
    cmp  al, '1'
    je   d1_option_1
    cmp  al, '2'
    je   d1_option_2
    jmp  d1_input_error        ; 无效输入忽略

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
    mov  ah, 01h           ; 读取输入
    int  21h
    
    cmp  al, '1'
    je   d2_option_1
    cmp  al, '2'
    je   d2_option_2
    jmp  d2_input_error        ; 无效输入忽略

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
    mov  ah, 01h           ; 读取输入
    int  21h
    
    cmp  al, '1'
    je   d3_option_1
    cmp  al, '2'
    je   d3_option_2
    jmp  d3_input_error        ; 无效输入忽略

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
    mov  ah, 01h           ; 读取输入
    int  21h
    
    cmp  al, '1'
    je   d4_option_1
    cmp  al, '2'
    je   d4_option_2
    jmp  d4_input_error        ; 无效输入忽略

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
    mov  ah, 01h           ; 读取输入
    int  21h
    
    cmp  al, '1'
    je   d5_option_1
    cmp  al, '2'
    je   d5_option_2
    jmp  d5_input_error        ; 无效输入忽略

d5_option_1:
    m_add_money 5000
    jmp  d5_input_done

d5_option_2:
    m_add_money 15000
    jmp d5_input_done
d5_input_done:
    ; 检查是否达到目标
    mov ax,role
    mov es,ax
    mov ax,es:[money]
    cmp ax,50000
    jl game_over
    ; 显示胜利信息
    call f_clear_screen
    mov ax,finale
    mov ds,ax
    m_print success1,f_c,5,25
    m_print success2_1,f_c,7,10
    m_print success2_2,f_c,8,10
    jmp exit_game

game_over:
    ; 显示失败信息
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
; 输入：DS:SI=字符串地址，CL=属性，DH=行，DL=列
f_display_text:
    push ax
    push bx
    push cx
    push dx
    push si
    push es
    push di
    
    ; 计算显示位置
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
; AX=要转换的数字，DS:SI=缓冲区地址
f_itoa:
    push bx
    push cx
    push dx
    push si
    
    xor si,si     ; 缓冲区索引
    mov cx,10       ; 除数
    
    ; 处理0的特殊情况
    test ax,ax
    jnz not_zero
    mov byte ptr [si],'0'
    inc si
    jmp store_end
    
not_zero:
    xor bx,bx       
divide_loop:
    xor dx,dx
    div cx         ; AX=商，DX=余数
    push dx        ; 保存余数
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
    
    ; 显示剩余天数标签
    mov ax,login_interface
    mov ds,ax
    m_print days_label,l1_attribute,22,10
    
    ; 读取并转换剩余天数
    mov ax,role
    mov ds,ax
    mov ax,days  
    mov bx,buffer
    mov ds,bx      ; DS指向buffer段
    call f_itoa
    
    ; 显示剩余天数
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
      
    ; 显示信用点标签
    mov ax,login_interface
    mov ds,ax
    m_print money_label,l1_attribute,22,55
    
    ; 读取并转换信用点
    mov ax,role
    mov ds,ax
    mov ax,money
    mov bx,buffer
    mov ds,bx
    call f_itoa
    
    ; 显示信用点数值
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
; 删除当前光标位置的字符
f_delete_char:
    push ax
    push bx
    push cx
    push dx

    mov ah, 03h        ; 获取光标位置功能号
    mov bh, 0           ; 页码为0
    int 10h             ; DH为行，DL为列

    mov ah, 02h        ; 设置光标位置功能号
    mov bh, 0           ; 页码为0
    dec dl             ;移到要删除字符的位置
    int 10h            

    mov ah, 09h        ; 在当前光标位置显示字符功能号
    mov al, ' '        ; 显示空格
    mov bl, 07h        
    mov cx, 1          
    int 10h             ; 调用BIOS中断显示空格，实现删除字符的效果

    mov ah, 03h        ; 再次获取光标位置
    mov bh, 0
    int 10h
    inc dl             ; 将光标移回原来的位置
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