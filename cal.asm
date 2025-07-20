
org 100h

jmp start

msg: db "1-Sumar",0dh,0ah,"2-Multiplicar",0dh,0ah,"3-Restar",0dh,0ah,"4-Dividir",0dh,0ah,"$"
msg2: db ,0dh,0ah, "Ingrese primer numero : $"
msg3: db ,0dh,0ah, "Ingrese segundo numero : $"
msg4: db ,0dh,0ah, "Error de eleccion $"
msg5: db ,0dh,0ah, "Resultado : $"
msg6: db ,0dh,0ah, "Gracias por usar este repositorio, apreta cualquier tecla... $"

start:  mov ah,9 ; dar el primer mensaje
        mov dx, offset msg
        int 21h ;interrupcion bios de video
        mov ah,0
        int 16h ; interrupcion bios de teclado ya que el usuario apretara un numero del 1 al 6 usamos la interrumpcion para el pulsado de tecla
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
        int 21h ;interrupcion bios de video
        mov ah,0
        int 16h ; teclado, al presionar cualquier tecla regrasaremos devuelta al inicio
        jmp start
        
Sumar:      mov ah,09h
            mov dx, offset msg2 ;mostrar msg2 en pantalla
            int 21h
            mov cx,0 ;cuenta los digitos y la cantida de digitos se guarda en CX
            call InputNum ;mostrar la nueva variable de InputNum
            push dx ;devolver valor al stack el segundo numero
            mov ah,9 ;cargar segundo mensage msg3
            mov dx,offset msg3; mostrarlo msg en cmd
            int 21h
            mov cx,0 ;despues de ver el mensaje3 hacer cx a 0
            call InputNum
            pop bx ;traer el primer valor en bx
            add dx,bx ;traer ambos valores en dx
            push dx ;llevarlo a stack
            mov ah,9 
            mov dx,offset msg5
            int 21h
            pop dx ;regresar a dx
            mov cx,10000 ;maximo numero que se puede calcular
            call Ver
            jmp exit
            
exit:       mov dx, offset msg6
            mov ah,9
            int 21h
            mov ah,0
            int 16h            
            ret
            

Ver:            mov ax,dx ;valor guardado en DX pasa a ser AZ
                mov dx,0 ; deja el valor de DX como 0 para proxima operacion
                div cx ;dividir 10000
                call VerNum ;llama acccion VerNu
                mov bx,dx ;valor del cociente DX guardado en BX
                mov dx,0 ;
                mov ax,cx ; valor AX pasa a ser
                mov cx,10 ; setea el valor CX a 10
                div cx ;divide AX por el valor de CX (10)
                mov dx, bx; hecha la division copiar valor a DX
                mov cx,ax ; valor de AX copiado a CX
                cmp ax,0 ; compara si el valor de AX es 0  
                jne Ver ;JumpIfNoEqual a 0 ir a Ver
                ret ;return
                
            

InputNum:       mov ah,0 ;tomar un input del usuario y setear AHigh a 0
                int 16h ;interrupcion bios del teclado
                mov dx,0; registrador inicial al cual agregaremos los valores seteado a 0
                mov bx,1; primer valor multiplicado por 1, 10, 100, 1000
                cmp al,0dh ;comparar el input al apretar enter
                je FormNu ; al apretar enter se realizara el resultado
                sub ax,30h ;restar de ax a convertir el valor de al de la tecla presionada a un decimal
                call VerNum ;ver tecla presionada en la pantalla
                mov ah,0 ;seleccionar valor
                push ax ;subir el valor al stack 
                inc cx ;incorpora el valor en CX
                jmp InputNum
                
FormNu: pop ax ; guardar el primer numero en el stack en solo un byte
        push dx ; mover valor al stack
        mul bx ;input del usuario
        pop dx ; traerlo devuelta terminado el proceso de multiplicacion
        add dx,ax
        mov ax,bx; tomar el valor de bx
        mov bx,10
        push dx; mover el valor al stack
        mul bx; multiplicar el valor de bx por 10
        pop dx ;traer dx devueta
        mov bx,ax ;mover el nuevo valor a BX
        dec cx ;
        cmp cx,0 ;verificar el valor de cx si es igual a zero
        jne FormNu ;si es zero regresar al principio
        ret
                
                 
VerNum:         push ax ;mover ax y dx con sus valores al stack
                push dx
                mov dx,ax ;asegurarnos de que el valor se guarde en dx
                add dl,30h ;para convertir a
                mov ah,2
                int 21h
                pop dx
                pop ax
                ret
                 
                
Multiplicar:    mov ah,09h
                mov dx, offset msg2 ;mostrar msg2 en pantalla
                int 21h
                mov cx,0 ;cuenta los digitos y la cantida de digitos se guarda en CX
                call InputNum ;mostrar la nueva variable de InputNum
                push dx ;devolver valor al stack el segundo numero
                mov ah,9 ;cargar segundo mensage msg3
                mov dx,offset msg3; mostrarlo msg en cmd
                int 21h
                mov cx,0 ;despues de ver el mensaje3 hacer cx a 0
                call InputNum
                pop bx ;traer el primer valor en bx
                mov ax,dx ;copia el valor de dx a ax
                mul bx ; multiplica ax anteriormente seleccionado por bx
                mov dx,ax ;el resultado en ax de la operacion lo pasa a DX
                push dx ;llevarlo a stack
                mov ah,9 
                mov dx,offset msg5
                int 21h
                pop dx ;regresar a dx
                mov cx,10000 ;maximo numero que se puede calcular
                call Ver
                jmp exit

Restar:     mov ah,09h
            mov dx, offset msg2 ;mostrar msg2 en pantalla
            int 21h
            mov cx,0 ;cuenta los digitos y la cantida de digitos se guarda en CX
            call InputNum ;mostrar la nueva variable de InputNum
            push dx ;devolver valor al stack el segundo numero
            mov ah,9 ;cargar segundo mensage msg3
            mov dx,offset msg3; mostrarlo msg en cmd
            int 21h
            mov cx,0 ;despues de ver el mensaje3 hacer cx a 0
            call InputNum
            pop bx ;traer el primer valor en bx
            sub bx,dx ;hacer la resta entre el valor de BX y DX
            mov dx,bx ;
            push dx ;llevar a stack DX
            mov ah,9 
            mov dx,offset msg5
            int 21h
            pop dx ;regresar a dx
            mov cx,10000 ;maximo numero que se puede calcular
            call Ver
            jmp exit
      
      
      
      
      
      
Dividir:
        
         
        


ret 