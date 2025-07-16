
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template,txt

org 100h

jmp start

msg: db "1-Sumar",0dh,0ah,"2-Multiplicar",0dh,0ah,"3-Restar",0dh,0ah,"4-Dividir",0dh,0ah,"$"
msg2: db ,0dh,oah, "Ingrese primer numero : $"
msg3: db ,0dh,oah, "Ingrese segundo numero : $"
msg4: db ,0dh,oah, "Error de eleccion $"
msg5: db ,0dh,oah, "Resultado : $"
msg6: db ,0dh,oah, "Gracias por usar esta distribucion"

start:  mov ah,9 ; dar el primer mensaje
        mov dx, offset msg
        int 21h
        mov ah,0
        int 16h ; ya que el usuario apretara un numero del 1 al 6 usamos la interrumpcion para el pulsado de tecla
        cmp al.31h ;comparar el valor de al, 31 significa la tecla S
        je Sumar ;Jump Equal si el valor 31h se presiona        
        cmp al.32h ;comparar el valor de al, 32 significa la tecla 2
        je Multiplicar ;Jump Equal si el valor 32h se presiona
        cmp al.33h ;comparar el valor de al, 33 significa la tecla 2
        je Restar ;Jump Equal si el valor 33h se presiona
        cmp al.34h ;comparar el valor de al, 34 significa la tecla 2
        je Dividir ;Jump Equal si el valor 34h se presiona
        mov ah,9
        mov dx,offset msg4 ;Mostrar mensaje de Error de eleccion en caso de que valor no sea 1-4
        int 21h
        mov ah,0
        int 16h ;Al presionar cualquier tecla regrasaremos devuelta al inicio
        jmp start
        
Sumar:

Multiplicar:

Restar:

Dividir:
        
         
        


ret     





