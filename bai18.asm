.Model Small           
.Stack 100H            
.Data                  

    crlf db 13, 10, '$'     ; Dong moi (carrige return - 13, line feed - 10) và ki tu ket thuc chuoi ('$')
    str db 100 dup('$')     ; Khai bao mang chuoi 'str' voi kich thuoc 100, duoc khoi tao bang ki tu '$'
    childStr db 'ktmt'      ; Khai bao mot chuoi con 'childStr' voi gia tri 'ktmt'
    strCount db 13, 10, 'so lan suat hien: $' 
    last dw 0               ; Bien 'last' là mot tu (word) co gia tri ban dau là 0
    count dw 0              ; Bien 'count' là mot tu (word) co gia tri ban dau là 0
    base_dec dw 10          ; Bien 'base_dec' là mot tu (word) co gia tri 10 (dung de chia so thap phan)

.Code                 
Main Proc              

    mov ax, @data      
    mov ds, ax          ; dat Data Segment bang gia tri cua AX (là dia chi cua Data Segment)
    
    mov ah, 10          ;input
    lea dx, str         ; dat con tro DX tro toi chuoi 'str'
    int 21h             
    
    mov ah, 9           ;output
    lea dx, crlf        ; dat con tro DX tro toi chuoi 'crlf' (xuong dong)
    int 21h             
  
    mov al, str + 1     ; dat gia tri cua ki tu thu 2 (index 1) cua chuoi 'str' vào thanh ghi AL
    sub al, 4           ; Tru di 4 tu gia tri ki tu o tren (vi du: 'k' - 4 = 'g')
    mov ah, 0           ; dat gia tri 0 vào thanh ghi AH
    
    mov last, ax        ; Di chuyen gia tri cua thanh ghi AX vào bien 'last'
    lea si, str + 2     ; dat con tro SI tro toi chuoi 'str' bat dau tu ki tu thu 3 (index 2)
    lea di, str         ; dat con tro DI tro toi chuoi 'str' (giu nguyen dia chi ban dau)
    mov dx, 0           ; dat gia tri 0 vào thanh ghi DX (dem so lan xuat hien chuoi con 'ktmt')
    mov cx, 0           ; dat gia tri 0 vào thanh ghi CX (dem so ki tu de kiem tra)

Lap:
    cmp [si], '$'       ; kiem tra xem den cuoi chuoi chua
    je Done
    cmp [si], 'k'
    jne continue 
    cmp [si + 1], 't'
    jne continue
    cmp [si + 2], 'm'
    jne continue
    cmp [si + 3], 't'
    jne continue 
    cmp [si + 3], '$'
    je Done
    inc dx
continue:
    inc si
    inc cx
    jmp Lap
    
    
Done: 
    mov count , dx 
    mov ah, 9 
    lea dx, strCount
    int 21h
    
    call Output
        
    mov ah, 4ch
    int 21h
   
Main endp
Output Proc
   mov ax, count
   mov cx, 0
Divide:
    mov dx, 0
    div base_dec
    push dx
    inc cx
    cmp ax, 0
    je show
    jmp Divide
show:
    mov ah, 2
    pop dx
    add dl, '0'
    int 21h
    dec cx
    cmp cx, 0
    jne show
ret

END MAIN
