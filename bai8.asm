
.model small
.stack 100h 
.data
tb1 db "Nhap so thap phan:$"  
tb2 db 10,13,"So vua nhap la:$"
x dw ?
y dw ?
.code
main proc
    mov ax,@data
    mov ds, ax
    
    mov ah,9 ;in ra chuoi ky tu
    lea dx,tb1 ;gan dia chi tb1 cho dx
    int 21h
    call nhapso
    
    mov ah,9
    lea dx,tb2
    int 21h
    call hienthi
    
    mov ah,4
    int 21h
    
    
main endp

nhapso proc
    
    mov x,0
    mov y,0
    mov bx,10
    
    nhap:
        mov ah,1
        int 21h
        cmp al,13      ;so sanh enter
        je thoat
        sub al,30h     ;chuyen thanh so
        xor ah,ah
        mov y,ax       ;luu ax vào y 
        mov ax,x       ;luu ax = x (0) 
        mul bx         ;ax *= 10
        add ax,y       ; ax += y
        mov x,ax       ;luu lai vao x
        jmp nhap
       
       
    thoat:
        ret ; return
        
nhapso endp

hienthi proc
    mov bx,16
    mov ax,x
    mov cx,0
    chia:           ; chia x cho 16 va luu du vao ngan xep
        mov dx,0
        div bx
        inc cx
        push dx
        cmp al,0
        je print
        jmp chia
        
    print:
        pop dx   ;gan dinh cua ngan xep = dx
        cmp dl,9
        jg hexa
        add dl,30h
        mov ah,2      ; in ra 1 ki dl
        int 21h
        jmp continue
        
        hexa:
            cmp dl,10
            jne B
            mov dl,'A'
            mov ah,2
            int 21h
            jmp continue
            
            B:   
                cmp dl,11
                jne C
                mov dl,'B'
                mov ah,2
                int 21h
                jmp continue
            
            C:   
                cmp dl,12
                jne D
                mov dl,'C'
                mov ah,2
                int 21h
                jmp continue 
                
            D:   
                cmp dl,13
                jne E
                mov dl,'D'
                mov ah,2
                int 21h
                jmp continue 
                
            E:   
                cmp dl,14
                jne F
                mov dl,'E'
                mov ah,2
                int 21h
                jmp continue 
                
                
            F:   
                mov dl,'F'
                mov ah,2
                int 21h
      continue:
        dec cx     
        cmp cx,0
        jne print
        ret
    
hienthi endp

end main
        