
   
;.model small
;.stack

 ;limite de un char parametros                                        ;x y z
;.data
   ; ecuacionF db '+(((1)x^(2))/1)+(((1)y^(2))/1)+(((1)z^(2))/1)=1600',100 dup(0),"$"
                                                                    ; ;mayor inferior, mayor inferior
   ; ;serial avalible
   ; ecuacion db '[',200 dup(0)
   
   ; tecuacion dw 1
   
   ; numerox dw 0
   ; longitud dw 0
   
   
             
   ; xyar db 350 dup(0) 
   ; xzar db 350 dup(0) 
   ; yzar db 350 dup(0)           
   
   ; auxar db 350 dup(0)          
   ; ttarr db 0          
   
   ; ParEx db 0
   
   ; ParEy db 0
   
   ; ParEz db 0
   
   
    ; linfx db 5 dup(0),"$"
    ; lsupx db 5 dup(0),"$"
    ; linfy db 5 dup(0),"$"
    ; lsupy db 5 dup(0),"$"
    ; linfz db 5 dup(0),"$"
    ; lsupz db 5 dup(0),"$" 
   
   
   
   
   ; SelecEje db 10,13,'xy(1),xz(2),yz(3),x(4)','$'
   ; incorrm db 10,13,'Seleccion Incorrecta','$'
   
   ; colorP db 5h
             
   ; saxl db 10,13,'$'          
             
   ; espac db ' ','$'
   
   ; paraDib dw 0,0,0,0
   

   
   
             
   
   ; parami db '-----------$'
   
   ; imprimeT db '0','$' 
   ; guarr db 'Guarda',10,13,'$'
   ; setea db 'setea',10,13,'$'
; .code     

    ; MOV AX,@DATA
    ; MOV DS,AX


   Mens Macro Mensajex
    push ax
    push dx
    
     mov dx,offset mensajex
     mov ah,9h
     int 21h
    pop dx
    pop ax 
   endm
   Mens2 Macro Mensajexv
    push ax
    push dx
    
     mov dx,mensajexv
     mov ah,9h
     int 21h
    pop dx
    pop ax 
   endm
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
   ;INICIAN LAS OPERACIONES-----------+++++++++++++++++++++++++++++++++++++++++++
     ;mov linfx,'9'
;     mov linfy,'7'
;     mov linfz,'2'


     ;mov xyar[0],190
;     mov xyar[32],50
;     mov xyar[64],50
;     mov xyar[96],25
;     mov xyar[128],10
;     mov xyar[160],0
;     mov xyar[192],25
;     mov xyar[224],50
;     mov xyar[256],50
;     mov xyar[318],150
;     
;     
;     ;ParEx
;     mov bx, offset xyar
;     call ReflejoFun
            
            
            
            
     ; call BorraPantalla 
    
     ; call IniGrafi 
     ; ;25x40
     ; call EmpaquetaEcua
	  
     ; call EnviaEcuacion
     
     ; call RecibeDatax
     
     ; call MenuPaint 
     
     
     
     ; Mens parami
     ; Mens saxl  
     ; mov  al,xyar[0]
     ; mov imprimeT,al
     ; Mens imprimeT
     ; Mens saxl 
     ; mov  al,xyar[318]
     ; mov imprimeT,al
     ; Mens imprimeT
     ; Mens saxl
     
     ; mov  al,xzar[0]
     ; mov imprimeT,al
     ; Mens imprimeT
     ; Mens saxl 
     ; mov  al,xzar[318]
     ; mov imprimeT,al
     ; Mens imprimeT
     ; Mens saxl
     
     ; mov  al,yzar[0]
     ; mov imprimeT,al
     ; Mens imprimeT
     ; Mens saxl 
     ; mov  al,yzar[318]
     ; mov imprimeT,al
     ; Mens imprimeT
     ; Mens saxl  
     ; Mens parami 
     
     ; cmp yzar[318],62
     ; jne hj
     ; Mens guarr
     
     ; call LChar 
     
     ; hj:
; ;     
; ;     jmp hj
     
          
; ; .exit  
; LChar proc
   ; mov ah,1
   ; int 21h    
; ret
; endp


; EnviaEcuacion proc  
    
 ; push ax
 ; push dx
 ; push cx
 ; push di
 
 ; mov cx,tecuacion
 ; mov di,0 
    
 ; cmp cx,0
 ; je EsCeroEcu 
 
    ; envi:
        ; xor   dx, dx        ; Select COM1
        ; mov   ah, 00h       ; InitializeCommunicationsPort
        ; mov   al, 11100011b ; 9600, odd, 1, 8
        ; int   14h
        
        ; mov   ah, 01h       ; WriteCharacterToCommunicationsPort
        ; mov   al, ecuacion[di]
        ; int   14h
        ; inc di  
    ; loop envi 

 
 ; EsCeroEcu:
 
 ; pop di 
 ; pop cx      
 ; pop dx      
 ; pop ax
 
    
; ret
; endp   

      
      
      
      
      
      
; RecibeDatax proc
   ; push ax
   ; push dx
   ; push di
   ; push si
   ; push di
   ; push cx
   
   
   
   ; mov di,0
   ; mov si,0
    
    ; LeeSerial:
    
      ; MOV AH,00 ;inicializar el puerto 
      ; MOV AL,11100011b ; velocidad 9600, N,un bit de stop, 8 bit de datos....
      ; xor DX,dx ; puerto com1
      ; INT 14H
       ; ;11101011b
    
    ; Esperar:  
      ; mov dx,0000
      ; mov ah,03h
      ; int 14h
  
      ; test ah,01h; si el bit 1(dato listo) esta puesto a cero no hay dato listo  
    ; jz Esperar ;salta y vuelve a verificar
      ; mov dx,0000
      ; mov ah,02h
      ; int 14h
      
     
     ; ; mov imprimeT,al
     ; ; Mens imprimeT
        
           ; ;Cuando ya leyo un char pasa a analizarlo
            ; Cabrec:
            ; cmp al,'[' 
             ; jne Ccierra
                ; mov di,1  ;habilita el cargar informacion
             ; jmp NoGuardaSerial 
            ; Ccierra:
            ; cmp al,']' 
             ; jne Continua
                  
             ; jmp SaleSerialFin 
            ; Continua:
            
    ; ;Si ya recibio el char de inicio comienza a guardar info
    ; cmp di,1
    ; jne NoGuardaSerial
           ; cmp si,319 ; si ya guardo a tope el array
           ; je NoSigueGuar
            ; ;Mens guarr     
                ; proyx:
                ; cmp ttarr,0
                ; jne proxz
                  ; mov xyar[si],al   
                ; jmp FinGuardaArr 
                ; proxz:
                ; cmp ttarr,1
                ; jne proyz
                  ; mov xzar[si],al 
                ; jmp FinGuardaArr        
                ; proyz:
                ; cmp ttarr,2
                ; jne proxz
                  ; mov yzar[si],al 
                ; jmp FinGuardaArr
                ; FinGuardaArr:
                         
           ; jmp GuardoChar
           ; NoSigueGuar:
           ; Mens setea 
                ; proyxP:
                ; cmp ttarr,0
                ; jne proxzP
                  ; mov ParEy,al   
                ; jmp FinGuardaArrP 
                ; proxzP:
                ; cmp ttarr,1
                ; jne FinGuardaArrP
                  ; mov ParEz,al 
                ; jmp FinGuardaArrP        

                ; FinGuardaArrP:
           ; ;cuando llegue aqui , llegara con el char ;que no lo analizara
            ; mov si,0    ;pasa a guardar al otro arreglo
            ; dec si      ;porque incrementa despues abajo
            ; inc ttarr   ;y reinicia el contador
           ; GuardoChar:   
       ; inc si  ; si esta guardando se mueve de posicion arreglo             
    ; NoGuardaSerial:  
    
     
     
    ; jmp LeeSerial
    
    ; SaleSerialFin:
   
   ; pop cx
   ; pop di
   ; pop si
   ; pop di 
   ; pop dx 
   ; pop ax
   
   
; ret
; endp

 ; ;INICIA PROC DE DIBUJO------

; IniGrafi proc 
 ; push ax
     ; mov ah,00 ;set mode
     ; mov al,13h ;mode=13(CGA High resolution)
     ; int 10h ;invoke the interrupt to change mode    
 ; pop ax
; ret
; endp



; BorraPantalla proc 
    ; push ax
    ; push bx
    ; push cx
    ; push dx
    
    ; mov ax,0
    ; mov bx,0
    ; mov cx,0
    ; mov dx,0
    
    ; mov ax,0600h ;scroll the screen
    ; mov bh,00 ;normal attribute
    ; mov cx,0000 ;from row=00,column=00
    ; mov dx,184fh ;to row=18h, column=4fh
    ; int 10h ;invoke the interrupt to clear screen 
    
    
    
    ; pop dx
    ; pop cx
    ; pop bx
    ; pop ax
 
 ; ret
; endp  
                
               
; dibujaPunto proc 
    
    ; push ax
    ; push cx
    ; push dx
      ; mov ah,0ch ;ah=0ch to draw a line
      ; mov al,colorP ;pixels=light grey 
      ; ;mov cx,0  posx
      ; ;mov dx,0  posy
      ; int 10h     
    ; pop dx
    ; pop cx
    ; pop ax
 
; ret
; endp  


; MenuPaint proc
 ; push ax
 ; push bx      
 
 ; call IniGrafi   
 
 ; Ipaint:
 ; ;call IniGrafi  
 ; Mens SelecEje
 ; call LChar   
 
 
 
    ; opcionxh1:
    ; cmp al,'1' ;xy
     ; jne opcionxh2
         ; call IniGrafi  
         ; mov bx,offset xyar
         ; call ImprimerADIB 
         
         ; cmp ParEy,0   ;0par 1impar
         ; jne hnnn
             ; mov bx, offset xyar
             ; call ReflejoFun
             ; mov bx, offset auxar
             ; call ImprimerADIB 
                 ; push ax
                 ; push bx
                   ; mov ax,offset lsupy 
                   ; mov paraDib[0],ax 
                   ; mov ax,offset lsupx  
                   ; mov paraDib[2],ax 
                   ; mov ax,offset linfy 
                   ; mov paraDib[4],ax 
                   ; mov ax,offset linfx  
                   ; mov paraDib[6],ax
                 ; pop bx  
                 ; pop ax
              
         ; hnnn:
             ; call ejesdibu
     ; jmp fopcionxh
    ; opcionxh2:
    ; cmp al,'2' ;xz
     ; jne opcionxh3  
         ; call IniGrafi 
         ; mov bx,offset xzar
         ; call ImprimerADIB
         
         ; cmp ParEz,0   ;0par 1impar
         ; jne hnnnx
             ; mov bx, offset xzar
             ; call ReflejoFun
             ; mov bx, offset auxar
             ; call ImprimerADIB
                 ; push ax
                 ; push bx
                   ; mov ax,offset lsupz 
                   ; mov paraDib[0],ax 
                   ; mov ax,offset lsupx  
                   ; mov paraDib[2],ax 
                   ; mov ax,offset linfz 
                   ; mov paraDib[4],ax 
                   ; mov ax,offset linfx  
                   ; mov paraDib[6],ax
                 ; pop bx  
                 ; pop ax

              
         ; hnnnx:
             ; call ejesdibu
     ; jmp fopcionxh
    ; opcionxh3:
    ; cmp al,'3' ;yz
     ; jne opcionxh4
         ; call IniGrafi 
         ; mov bx,offset yzar
         ; call ImprimerADIB
         
         ; cmp ParEz,0   ;0par 1impar
         ; jne hnnnxx
             ; mov bx, offset yzar
             ; call ReflejoFun
             ; mov bx, offset auxar
             ; call ImprimerADIB
                 ; push ax
                 ; push bx
                   ; mov ax,offset lsupz 
                   ; mov paraDib[0],ax 
                   ; mov ax,offset lsupy  
                   ; mov paraDib[2],ax 
                   ; mov ax,offset linfz 
                   ; mov paraDib[4],ax 
                   ; mov ax,offset linfy  
                   ; mov paraDib[6],ax
                 ; pop bx  
                 ; pop ax

              
         ; hnnnxx:
            ; call ejesdibu
     ; jmp fopcionxh
    ; opcionxh4:          
    ; cmp al,'4' ;salir
     ; jne opcionxh5
     
     ; jmp Slirx
    ; opcionxh5: 
     ; Mens incorrm          
              
    ; fopcionxh:
    
 ; jmp Ipaint
 
   ; Slirx: 
 
 ; call LChar

 
 ; pop bx
 ; pop ax
    
; ret
; endp
 

; ImprimerADIB proc
  ; ;en bx recibe offset  
 ; push cx
 ; push di
  
  
  ; mov cx,319
  ; mov di,0
  
  ; ccicclo:
    ; push cx
    ; push bx
        ; mov cx,di
        ; mov dh,0
        ; mov dl,byte ptr[bx+di] ;columna       
        ; call dibujaPunto
    ; pop bx
    ; pop cx
   ; inc di
  ; loop ccicclo
  
 ; mov bx,0 
 ; pop di
 ; pop cx
       
; ret
; endp


; numMayort proc
 ; push bx
 ; push cx
 ; push di
 ; ;en dx guarda el numero mas grande
    
 ; ;en bx recibe offset arreglo      
 ; mov cx,319
 ; mov dx,0
 
 ; mov di,0
 ; bbma:
      ; cmp byte ptr[bx+di],dl
      ; jna noActuali
         ; mov dl,byte ptr[bx+di]
      ; noActuali:
    ; inc di
 ; loop bbma      
       
       
 ; pop di      
 ; pop cx      
 ; pop bx   
; ret
; endp



  
  
; ReflejoFun proc
  ; push ax
  ; push bx
  ; push dx
  ; push cx
  ; push di
  
  ; ;trae en bx el offset arreglo
    
  ; call numMayort
  ; ;obtiene numero mayor en dx
  
  
  ; mov cx,319
  ; mov di,0
  ; mov dh,0
  
  ; refleha:
  ; push dx
   ; mov ax,dx;numero mayor para hacer reflejo
   ; sub al,byte ptr[bx+di]
   ; add ax,dx
   
       ; push bx
        ; mov bx, offset auxar
        ; cmp ax,200
         ; ja guarcerof; si supera los 200 salta
            
            ; mov byte ptr[bx+di],al
       
         ; jmp finalgues
         ; guarcerof:
            ; mov byte ptr[bx+di],0
       
         ; finalgues:
       ; pop bx
   
   ; inc di
  ; pop dx
  ; loop refleha
   
   
  ; pop di 
  ; pop cx 
  ; pop dx 
  ; pop bx 
  ; pop ax 
  
   
; ret
; endp  
  

; ejesdibu proc
  ; push cx
  ; push dx
  ; push bx
  
  
 ; call ventesp  
 
 ; Mens2 paraDib[0];arriba
 
 ; call docsal
 
 ; Mens2 paraDib[6];izq
 
 ; call cuaresp
 
 ; Mens2 paraDib[2];der
 
 ; call docsal
 
 ; call ventesp  
 
 ; Mens2 paraDib[4];abajo
  
  
  
  
  
  ; mov cx,200
  ; mov dx,0 
  ; dciclox:
    ; push cx
    ; mov cx,160
    ; ;mov dx,di 
         ; mov colorP,7h
         ; call dibujaPunto
    ; pop cx 
   ; inc dx
  ; loop dciclox
  
  
  
  ; mov cx,319
  ; dcicloxx:
   ; mov dx,100  
         ; mov colorP,7h
         ; call dibujaPunto     
  ; loop dcicloxx
  

 ; mov colorP,5h 
 
 
 ; pop bx
 ; pop dx
 ; pop cx
           
; ret
; endp
 
 
; ventesp proc
 ; push cx 
     ; mov cx,18
     ; svhac:
       ; Mens espac
     ; loop svhac   
 ; pop cx   
; ret
; endp 
; cuaresp proc
 ; push cx 
     ; mov cx,30
     ; svhacy:
       ; Mens espac
     ; loop svhacy   
 ; pop cx   
; ret
; endp

; docsal proc
 ; push cx 
     ; mov cx,11
     ; svhacx:
       ; Mens saxl
     ; loop svhacx   
 ; pop cx   
; ret
; endp
; ;Procedimientos de Arreglar la ecuacion----------------------------------------
; ChartoReal proc
   ; ;en bx offset numero 
   ; push di
   ; push bx
   
   ; mov numerox,0
   ; mov di,0
   ; mov longitud,0
   
   ; cmp byte ptr[bx],'-'
   ; jne positivoN      
      ; mov di,1
   ; jmp FinaAnaliza
   ; positivoN:
      
   ; FinaAnaliza: 
      ; add bx,di
      ; call longitudNum 
      
      ; Real bx+di,longitud       
      ; mov longitud,0
   
   ; cmp di,1
   ; jne finalProc 
      ; push ax
      ; push bx
         ; mov bx,numerox
         ; mov ax,-1
         ; imul bx
         ; mov numerox,ax
      ; pop bx
      ; pop ax
   
   ; finalProc:
    
   ; pop bx
   ; pop di 
; ret
; endp
    
 
 
 
           
; proc longitudNum
  ; push di
      ; mov di,0
      ; cuentaf:  
    
      ; cmp byte ptr[bx+di],0
      ; je salecuenta 
       ; inc longitud
       ; inc di 
       
      ; jmp cuentaf
      ; salecuenta: 
  
  ; pop di 
; ret
; endp 




; EmpaquetaEcua proc
   
   
   ; push ax
   ; push bx
   ; push cx
   ; push dx
   ; push di
   
   
   
   ; mov bx,offset ecuacionF 
   
   ; mov longitud,0
   
   ; call longitudNum
   
   ; mov cx,longitud
   ; mov di,0
    
   ; traslaE:
    ; mov bx,offset ecuacionF
    ; mov al,byte ptr[bx+di] 
    
    ; push bx
        ; mov bx,offset ecuacion
        ; mov byte ptr[bx+di+1],al
    ; pop bx
    ; inc tecuacion
    ; inc di
   ; loop traslaE 
   
   ; ;Termina de guardar ecuacion
   ; ;inicia a generar parametros
   
   ; mov di,tecuacion
   ; mov bx,offset ecuacion
   
   ; push ax
   
         ; mov ah,1
         ; int 21h
   
   ; pop ax
   
   ; mov byte ptr[bx+di],'{'
   ; inc tecuacion
   ; inc di
      
       ; mov bx,offset lsupx        
         ; call ChartoReal
       ; mov ax,numerox
       ; mov bx,offset ecuacion
       ; mov byte ptr[bx+di],al
       ; inc tecuacion
       ; inc di   
   
   ; mov byte ptr[bx+di],'{'
   ; inc tecuacion
   ; inc di
   
       ; mov bx,offset linfx        
         ; call ChartoReal
       ; mov ax,numerox
       ; mov bx,offset ecuacion
       ; mov byte ptr[bx+di],al
       ; inc tecuacion
       ; inc di
   
   ; mov byte ptr[bx+di],'{'
   ; inc tecuacion
   ; inc di
   
   
       ; mov bx,offset lsupy        
         ; call ChartoReal
       ; mov ax,numerox
       ; mov bx,offset ecuacion
       ; mov byte ptr[bx+di],al
       ; inc tecuacion
       ; inc di
   
   ; mov byte ptr[bx+di],'{'
   ; inc tecuacion
   ; inc di
       
       ; mov bx,offset linfy        
         ; call ChartoReal
       ; mov ax,numerox
       ; mov bx,offset ecuacion
       ; mov byte ptr[bx+di],al
       ; inc tecuacion
       ; inc di
   
   ; mov byte ptr[bx+di],'{'
   ; inc tecuacion
   ; inc di
   
   
       ; mov bx,offset lsupz        
         ; call ChartoReal
       ; mov ax,numerox
       ; mov bx,offset ecuacion
       ; mov byte ptr[bx+di],al
       ; inc tecuacion
       ; inc di
   
   ; mov byte ptr[bx+di],'{'
   ; inc tecuacion
   ; inc di
   
       ; mov bx,offset linfz        
         ; call ChartoReal
       ; mov ax,numerox
       ; mov bx,offset ecuacion
       ; mov byte ptr[bx+di],al
       ; inc tecuacion
       ; inc di
   ; mov byte ptr[bx+di],']'
   ; inc tecuacion
   ; inc di
   
   
    
   ; mov byte ptr[bx+di],'$'
   ; ;inc tecuacion
; ;   inc di
   
   ; pop di
   ; pop dx
   ; pop cx
   ; pop bx
   ; pop ax
       
; ret
; endp
 
;end




