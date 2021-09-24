         
         
         
.model small
.stack

.data       
    
    ecuacionF db '+(((1)x^(2))/1)+(((1)y^(2))/1)+(((1)z^(2))/1)=1600',100 dup(0),"$"
    linfx db 5 dup(0),"$"
    lsupx db 5 dup(0),"$"
    linfy db 5 dup(0),"$"
    lsupy db 5 dup(0),"$"
    linfz db 5 dup(0),"$"
    lsupz db 5 dup(0),"$"  
    
    
    ;ecuacion db '[','+(((1)x^(2))/1)+(((1)y^(2))/1)+(((1)z^(2))/1)=1600','{',40,'{',-40,'{',40,'{',-40,'{',40,'{',-40,']';,'$'
   
    ecuacion db '[',200 dup(0)
   
    tecuacion dw 1
   
   
    
    
    ;Variables Nuevas
     
    
    numerox dw 0
    longitud dw 0
    
.code       
Real Macro numero,longitud
    ;65535 sin signo
    ;61439?? con
    push ax
    push bx
    push cx
    push di
    
    
    mov cx,longitud
    mov di,0
    mov numerox,0
    
    ciclo:
      
         
        push bx
        mov bx,numero[di]
        mov bh,0
        sub bx,'0' 
        
        pot5:
        cmp cx,5
        jne pot4
             mov ax,10000  
             mul bx
             add numerox,ax
        jmp siguiente
        pot4:
        cmp cx,4
        jne pot3
             mov ax,1000  
             mul bx
             add numerox,ax
        jmp siguiente
        pot3:
        cmp cx,3
        jne pot2
             mov ax,100  
             mul bl
             add numerox,ax
        jmp siguiente
        pot2:
        cmp cx,2
        jne pot1
             mov ax,10  
             mul bl
             add numerox,ax
        jmp siguiente
        pot1:
        cmp cx,1
        jne siguiente
             mov ax,1  
             mul bl
             add numerox,ax

        siguiente:
      inc di  
      ;inc di
      pop bx  
    loop ciclo
     
 jmp Final
 ErrorF:
   mov numerox,0
 
 Final:
    
    
    pop di
    pop cx 
    pop bx 
    pop ax
       
endM 

    ;INICIAN LAS OPERACIONES-----------++++++++
     mov ax,@data
     mov ds,ax
    
              
     
      call EmpaquetaEcua
     
     mov ah,9
     mov dx,offset ecuacion
     int 21h
     
.exit
 
;Manejo de la ecuacion  
       
       
       
ChartoReal proc
   ;en bx offset numero 
   push di
   push bx
   
   mov numerox,0
   mov di,0
   mov longitud,0
   
   cmp byte ptr[bx],'-'
   jne positivoN      
      mov di,1
   jmp FinaAnaliza
   positivoN:
      
   FinaAnaliza: 
      add bx,di
      call longitudNum 
      
      Real bx+di,longitud       
      mov longitud,0
   
   cmp di,1
   jne finalProc 
      push ax
      push bx
         mov bx,numerox
         mov ax,-1
         imul bx
         mov numerox,ax
      pop bx
      pop ax
   
   finalProc:
    
   pop bx
   pop di 
ret
endp
    
 
 
 
           
proc longitudNum
  push di
      mov di,0
      cuentaf:  
    
      cmp byte ptr[bx+di],0
      je salecuenta 
       inc longitud
       inc di 
       
      jmp cuentaf
      salecuenta: 
  
  pop di 
ret
endp 




EmpaquetaEcua proc
   
   
   push ax
   push bx
   push cx
   push dx
   push di
   
   
   
   mov bx,offset ecuacionF 
   
   mov longitud,0
   
   call longitudNum
   
   mov cx,longitud
   mov di,0
    
   traslaE:
    mov bx,offset ecuacionF
    mov al,byte ptr[bx+di] 
    
    push bx
        mov bx,offset ecuacion
        mov byte ptr[bx+di+1],al
    pop bx
    inc tecuacion
    inc di
   loop traslaE 
   
   ;Termina de guardar ecuacion
   ;inicia a generar parametros
   
   mov di,tecuacion
   mov bx,offset ecuacion
   
   push ax
   
         mov ah,1
         int 21h
   
   pop ax
   
   mov byte ptr[bx+di],'{'
   inc tecuacion
   inc di
      
       mov bx,offset lsupx        
         call ChartoReal
       mov ax,numerox
       mov bx,offset ecuacion
       mov byte ptr[bx+di],al
       inc tecuacion
       inc di   
   
   mov byte ptr[bx+di],'{'
   inc tecuacion
   inc di
   
       mov bx,offset linfx        
         call ChartoReal
       mov ax,numerox
       mov bx,offset ecuacion
       mov byte ptr[bx+di],al
       inc tecuacion
       inc di
   
   mov byte ptr[bx+di],'{'
   inc tecuacion
   inc di
   
   
       mov bx,offset lsupy        
         call ChartoReal
       mov ax,numerox
       mov bx,offset ecuacion
       mov byte ptr[bx+di],al
       inc tecuacion
       inc di
   
   mov byte ptr[bx+di],'{'
   inc tecuacion
   inc di
       
       mov bx,offset linfy        
         call ChartoReal
       mov ax,numerox
       mov bx,offset ecuacion
       mov byte ptr[bx+di],al
       inc tecuacion
       inc di
   
   mov byte ptr[bx+di],'{'
   inc tecuacion
   inc di
   
   
       mov bx,offset lsupz        
         call ChartoReal
       mov ax,numerox
       mov bx,offset ecuacion
       mov byte ptr[bx+di],al
       inc tecuacion
       inc di
   
   mov byte ptr[bx+di],'{'
   inc tecuacion
   inc di
   
       mov bx,offset linfz        
         call ChartoReal
       mov ax,numerox
       mov bx,offset ecuacion
       mov byte ptr[bx+di],al
       inc tecuacion
       inc di
   mov byte ptr[bx+di],']'
   inc tecuacion
   inc di
   
   
    
   mov byte ptr[bx+di],'$'
   ;inc tecuacion
;   inc di
   
   pop di
   pop dx
   pop cx
   pop bx
   pop ax
       
ret
endp

end         
         
          
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         