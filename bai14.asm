.Model Small
.Stack 100H
.Data
    crlf db 13, 10, '$'
    base_dec dw 10

    str1 db 13, 'so thu nhat = $'
    str2 db  10,13, 'so thu hai = $' 
    output_gcd db  10,13, 'uoc chung lon nhat la = $'
    output_lcm db  10,13, 'Boi chung nho nhat la = $'  
    
    x dw 0
    a dw 0
    b dw 0
    gcd dw 0
    lcm dw 0
   
     
.Code
Main Proc    
   mov ax, @data
   mov ds, ax
   
   mov ah, 9
   lea dx, str1
   int 21h
   call Input         
          
   mov ax, x   ;ax = x
   mov a, ax
   
   mov ah, 9
   lea dx, str2 
   int 21h 
   call Input
   
   mov ax, x      ;luu gia tri vua nhap vao b
   mov b, ax
   
   
   call gcdEuclid 
   mov gcd, ax
   mov x, ax
   call Output
   
   mov ah, 9
   lea dx, output_lcm
   int 21h
   
   mov ax, a              ;LCM(a, b) = (a * b) / GCD(a, b).
   mov bx, gcd
   mov dx, 0
   div bx
   
   mov bx, b
   mul bx
   
   mov x, ax
   call Output
   
   mov ah, 4ch
   int 21h
   
Main endp

gcdEuclid Proc                ;tim ucln
    mov ah, 9
    lea dx, output_gcd
    int 21h
    mov ax, a
    mov dx, b
euclid:
    cmp dx, 0
    je return_gcd
    mov bx, dx 
    mov dx, 0
    div bx
    mov ax, bx
    jmp euclid
return_gcd:
    ret     
        
gcdEuclid Endp

Input Proc          ;chuyen chuoi ki tu thanh so de tinh toan
    mov x, 0
loop_input:
    mov ah, 1       ; doc ki tu nhap tu ban phim
    int 21h
    cmp al, 13
    je end_input
    cmp al, ' '
    je end_input
    mov ah, 0
    sub al, '0'
    push ax         ;day len dau stack
    mov ax, x
    mul base_dec
    mov x, ax
    pop ax
    add x, ax
    jmp loop_input
end_input:
    ret
    
        
Input Endp

Output Proc         ; chuyen thanh ki tu de in ra man hinh
   mov ax, x
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
    
Output Endp

END MAIN