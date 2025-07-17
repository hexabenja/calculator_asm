
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template,txt

org 100h

jmp start

msg: db "1-Sumar",0dh,0ah,"2-Multiplicar",0dh,0ah,"3-Restar",0dh,0ah,"4-Dividir",0dh,0ah,"$"
msg2: db ,0dh,0ah, "Ingrese primer numero : $"
msg3: db ,0dh,0ah, "Ingrese segundo numero : $"
msg4: db ,0dh,0ah, "Error de eleccion $"
msg5: db ,0dh,0ah, "Resultado : $"
msg6: db ,0dh,0ah, "Gracias por usar este repositorio, apreta cualquier tecla..."

start:  mov ah,9 ; dar el primer mensaje
        mov dx, offset msg
        int 21h
        mov ah,0
        int 16h ; ya que el usuario apretara un numero del 1 al 6 usamos la interrumpcion para el pulsado de tecla
        cmp al,31h ;comparar el valor de al, 31 significa la tecla 1
        je Sumar ;Jump Equal si el valor 31h se presiona        
        cmp al,32h ;comparar el valor de al, 32 significa la tecla 2
        je Multiplicar ;Jump Equal si el valor 32h se presiona
        cmp al,33h ;comparar el valor de al, 33 significa la tecla 3
        je Restar ;Jump Equal si el valor 33h se presiona
        cmp al,34h ;comparar el valor de al, 34 significa la tecla 4
        je Dividir ;Jump Equal si el valor 34h se presiona
        mov ah,9
        mov dx,offset msg4 ;Mostrar mensaje de Error de eleccion en caso de que valor no sea 1-4
        int 21h
        mov ah,0
        int 16h ;Al presionar cualquier tecla regrasaremos devuelta al inicio
        jmp start
        
Sumar:      mov ah,09h
            mov dx, offset msg2 ;mostrar msg2 en pantalla
            int 21h
            mov cx,0 ;cuenta los digitos y la cantida de digitos se guarda en CX
            call IngresarNumero ;mostrar la nueva variable de IngresarNumero

IngresarNumero: mov ah,0 ;tomar un input del usuario
                int 16h            
                cmp al,0dh ;comparar el input al apretar enter
                ;je FormNo ; al apretar enter se realizara el resultado
                sub ax,30h ;restar de ax a convertir el valor de al de la tecla presionada a un decimal
                call VerNumero ;ver tecla presionada en la pantalla
                 
VerNumero:      push ax ;mover ax y dx con sus valores al stack
                push dx
                mov dx,ax ;asegurarnos de que el valor se guarde en dx
                add dl,30h ;para convertir a
                mov ah,2
                int 21h
                pop dx
                pop ax
                ret 
                
Multiplicar:

Restar:

Dividir:
        
         
        


ret     





