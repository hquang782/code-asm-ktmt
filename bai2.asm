.Model Small
.Stack 100H
.Data
    crlf db 13, 10, '$'       
    str1 db 'nhap 1 ky tu: $'
    str2 db 'ki tu do la: $'
    char db ? 
.Code
Main Proc 
    
    mov ax, @data   
    mov ds, ax   

    lea dx, str1 ; Hien thi thong bao "nhap 1 ky tu: "
    mov ah, 9
    int 21h
    
    mov ah, 1    ; doc mot ki tu tu b�n phim
    int 21h
    mov char, al ; Luu ki tu doc duoc v�o bien char
    
    lea dx, crlf ; Xuong dong
    mov ah, 9
    int 21h
    
    lea dx, str2 ; Hien thi thong bao "ki tu do la: "
    mov ah, 9
    int 21h

    mov dl, char ; Lay ki tu tu bien char v� in ra m�n hinh
    mov ah, 2
    int 21h
    
    mov ah, 4ch  ; Ket thuc chuong tr�nh
    int 21h
   
Main endp 

END Main
