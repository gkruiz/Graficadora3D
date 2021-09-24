.model tiny

.stack

.data









ecuacionF db 150 dup(0),"$"
                       ;mayor inferior, mayor inferior
   ;serial avalible
   ecuacion db '[',200 dup(0)
   
   tecuacion dw 1
   
   numerox dw 0
   longitud dw 0
   
   
             
   xyar db 350 dup(0) 
   xzar db 350 dup(0) 
   yzar db 350 dup(0)           
   
   auxar db 350 dup(0)          
   ttarr db 0          
   
   ParEx db 0
   
   ParEy db 0
   
   ParEz db 0
   
   
    linfx db 5 dup(0),"$"
    lsupx db 5 dup(0),"$"
    linfy db 5 dup(0),"$"
    lsupy db 5 dup(0),"$"
    linfz db 5 dup(0),"$"
    lsupz db 5 dup(0),"$" 
   
   
   
   
   SelecEje db 10,13,'xy(1),xz(2),yz(3),x(4)','$'
   incorrm db 10,13,'Seleccion Incorrecta','$'
   
   colorP db 5h
             
   saxl db 10,13,'$'          
             
   espac db ' ','$'
   
   paraDib dw 0,0,0,0
   

   
   
             
   
   parami db '-----------$'
   
   imprimeT db '0','$' 
   guarr db 'Guarda',10,13,'$'
   setea db 'setea',10,13,'$'









;>>>>>>>Variables de impresion 
;>>>Encabezado
menuP db "------------------> Proyecto 2 <------------------",0Ah,0Dh,"------------------> Menu Principal <------------------",0Ah,0Dh,"-----> 0.Graficar",0Ah,0Dh,"-----> 1.Cargar Ecuacion",0Ah,0Dh,"-----> 2.Salir",0Ah,0Dh,"$"
opcionInc db 0Ah,0Dh,"La opcion ingresada no es la correcta",0Ah,0Dh,"$"
tLexico db 0Ah,0Dh,"Iniciando Analisis Lexico...",0Ah,0Dh,"$"
tSintactico db 0Ah,0Dh,"Iniciando Analisis Sintactico...",0Ah,0Dh,"$"
noErrorS   db 0Ah,0Dh,"No se encontraron errores sintacticos",0Ah,0Dh,"$"
datosObtenidos db 0Ah,0Dh,"Los datos se obtuvieron con exito",0Ah,0Dh,"$"
;>>>Salto de linea
salto db 0Ah,0Dh,"$"
;>>>Solicitudes
solicitud1 db 0Ah,0Dh,"--> Ingrese opcion deseada <--",0Ah,0Dh,"$" 
solicitud2 db 0Ah,0Dh,"--> Presione la tecla enter para continuar <--",0Ah,0Dh,"$" 
solicitud3 db 0Ah,0Dh,"--> Ingrese nombre del archivo <--",0Ah,0Dh,"$" 

;>>>Lectura de datos
archivoD db 20 dup('$')
archivoLectura db 500 dup('$')
handlerAbrir dw ?
caracterL db 1,"$"
caracterS db 1,"$"
;>>>Datos almacenados

; ecuacionF db 150 dup('$'),"$"
; linfx db 4 dup('$'),"$"
; lsupx db 4 dup('$'),"$"
; linfy db 4 dup('$'),"$"
; lsupy db 4 dup('$'),"$"
; linfz db 4 dup('$'),"$"
; lsupz db 4 dup('$'),"$"

;>>>>>Errores   
error1 db 0Ah,0Dh,"No se puede ingresar al archivo solicitado",0Ah,0Dh,"$"
error2 db 0Ah,0Dh,"No se puede cerrar al archivo solicitado",0Ah,0Dh,"$"   
;>>>Lexicos
errorL db 0Ah,0Dh,"%%%%% Error lexico encontrado %%%%%",0Ah,0Dh,"$"
errorC db "El simbolo encontrado no pertenece a este lenguaje: ","$"
;>>>Sintacticos
errorS db 0Ah,0Dh,"%%%%% Error sintactico encontrado %%%%%",0Ah,0Dh,"$"
errorSi db "Encontrado: " ,"$"
errorSMenor db 0Ah,0Dh,"Se esperaba: <",0Ah,0Dh,"$"
errorSMayor db 0Ah,0Dh,"Se esperaba: >",0Ah,0Dh,"$"
errorProyecto2 db 0Ah,0Dh,"Se esperaba: py2",0Ah,0Dh,"$"
errorEcuacion db 0Ah,0Dh,"Se esperaba: ecuacion",0Ah,0Dh,"$"
errorEje db 0Ah,0Dh,"Se esperaba: ejex,ejey o ejez",0Ah,0Dh,"$"
errorEjeY db 0Ah,0Dh,"Se esperaba: ejey",0Ah,0Dh,"$"
errorEjeZ db 0Ah,0Dh,"Se esperaba: ejez",0Ah,0Dh,"$"
errorLInf db 0Ah,0Dh,"Se esperaba: linf",0Ah,0Dh,"$"
errorLSup db 0Ah,0Dh,"Se esperaba: lsup",0Ah,0Dh,"$"
errorNum db 0Ah,0Dh,"Se esperaba: Numero(1...9)",0Ah,0Dh,"$"
errorSim db 0Ah,0Dh,"Se esperaba: Simbolo {+,-,*,/}",0Ah,0Dh,"$"
errorDiv db 0Ah,0Dh,"Se esperaba: Simbolo /",0Ah,0Dh,"$"
errorParC db 0Ah,0Dh,"Se esperaba: Simbolo )",0Ah,0Dh,"$"
errorParA db 0Ah,0Dh,"Se esperaba: Simbolo (",0Ah,0Dh,"$" 
errorPotencia db 0Ah,0Dh,"Se esperaba: Simbolo ^",0Ah,0Dh,"$"
errorXYZ db 0Ah,0Dh,"Se esperaba: Variable(x,y,z)",0Ah,0Dh,"$"
errorInicio db 0Ah,0Dh,"Se esperaba: Variable(x,y,z), Numero(1...9) o Simbolo (",0Ah,0Dh,"$" 
errorFinal db 0Ah,0Dh,"Se encontraron errores sintacticos, solucione los problemas y compile de nuevo",0Ah,0Dh,"$"

.code 


mov ax,@data
mov ds,ax    

include macroPro.asm
include Serial.asm

	 call BorraPantalla 
    
     call IniGrafi 
inicio:
    imprimir menuP
    imprimir solicitud1
    getOpcion 
	
	
	
	Graficarxxx:	
    cmp al,'0'
    jne cargarEcuacion 
			 
     ;25x40
     call EmpaquetaEcua
	  
     call EnviaEcuacion
     
     call RecibeDatax
     
     call MenuPaint 	
			
    jmp inicio
	cargarEcuacion:	
    cmp al,31h
    jne finalizarEjecucion
		imprimir solicitud3
		getPath archivoD
		;Lectura del archivo
		abrirArchivo archivoD,handlerAbrir
		lecturaArchivo handlerAbrir,archivoLectura,500
		cerrarArchivo handlerAbrir
		;Analisis Lexico
		analisisLexico archivoLectura
		analisisSintactico archivoLectura
		RecepcionDatos archivoLectura  
			
    jmp inicio
	
	finalizarEjecucion: 
    cmp al,32h
    jne opcionIncorrecta

		imprimir EcuacionF
		imprimir salto
		imprimir linfx
		imprimir salto
		imprimir lsupx
		imprimir salto
		imprimir linfy
		imprimir salto
		imprimir lsupy
		imprimir salto
		imprimir linfz
		imprimir salto
		imprimir lsupz
		mov ah,4ch
		int 21h
	opcionIncorrecta:    
		imprimir opcionInc
		imprimir solicitud2
		getOpcion
		cmp al,0Dh
		je inicio

	jmp opcionIncorrecta

errorArchivo1:
    imprimir error1
    jmp inicio  
         
errorArchivo2:                  
    imprimir error2
    jmp inicio


.exit
 
LChar proc
   mov ah,1
   int 21h    
ret
endp


EnviaEcuacion proc  
    
 push ax
 push dx
 push cx
 push di
 
 mov cx,tecuacion
 mov di,0 
    
 cmp cx,0
 je EsCeroEcu 
 
    envi:
        xor   dx, dx        ; Select COM1
        mov   ah, 00h       ; InitializeCommunicationsPort
        mov   al, 11100011b ; 9600, odd, 1, 8
        int   14h
        
        mov   ah, 01h       ; WriteCharacterToCommunicationsPort
        mov   al, ecuacion[di]
        int   14h
        inc di  
    loop envi 

 
 EsCeroEcu:
 
 pop di 
 pop cx      
 pop dx      
 pop ax
 
    
ret
endp   

      
      
      
      
      
      
RecibeDatax proc
   push ax
   push dx
   push di
   push si
   push di
   push cx
   
   
   
   mov di,0
   mov si,0
    
    LeeSerial:
    
      MOV AH,00 ;inicializar el puerto 
      MOV AL,11100011b ; velocidad 9600, N,un bit de stop, 8 bit de datos....
      xor DX,dx ; puerto com1
      INT 14H
       ;11101011b
    
    Esperar:  
      mov dx,0000
      mov ah,03h
      int 14h
  
      test ah,01h; si el bit 1(dato listo) esta puesto a cero no hay dato listo  
    jz Esperar ;salta y vuelve a verificar
      mov dx,0000
      mov ah,02h
      int 14h
      
     
     ; mov imprimeT,al
     ; Mens imprimeT
        
           ;Cuando ya leyo un char pasa a analizarlo
            Cabrec:
            cmp al,'[' 
             jne Ccierra
                mov di,1  ;habilita el cargar informacion
             jmp NoGuardaSerial 
            Ccierra:
            cmp al,']' 
             jne Continua
                  
             jmp SaleSerialFin 
            Continua:
            
    ;Si ya recibio el char de inicio comienza a guardar info
    cmp di,1
    jne NoGuardaSerial
           cmp si,319 ; si ya guardo a tope el array
           je NoSigueGuar
            ;Mens guarr     
                proyx:
                cmp ttarr,0
                jne proxz
                  mov xyar[si],al   
                jmp FinGuardaArr 
                proxz:
                cmp ttarr,1
                jne proyz
                  mov xzar[si],al 
                jmp FinGuardaArr        
                proyz:
                cmp ttarr,2
                jne proxz
                  mov yzar[si],al 
                jmp FinGuardaArr
                FinGuardaArr:
                         
           jmp GuardoChar
           NoSigueGuar:
           Mens setea 
                proyxP:
                cmp ttarr,0
                jne proxzP
                  mov ParEy,al   
                jmp FinGuardaArrP 
                proxzP:
                cmp ttarr,1
                jne FinGuardaArrP
                  mov ParEz,al 
                jmp FinGuardaArrP        

                FinGuardaArrP:
           ;cuando llegue aqui , llegara con el char ;que no lo analizara
            mov si,0    ;pasa a guardar al otro arreglo
            dec si      ;porque incrementa despues abajo
            inc ttarr   ;y reinicia el contador
           GuardoChar:   
       inc si  ; si esta guardando se mueve de posicion arreglo             
    NoGuardaSerial:  
    
     
     
    jmp LeeSerial
    
    SaleSerialFin:
   
   pop cx
   pop di
   pop si
   pop di 
   pop dx 
   pop ax
   
   
ret
endp

 ;INICIA PROC DE DIBUJO------

IniGrafi proc 
 push ax
     mov ah,00 ;set mode
     mov al,13h ;mode=13(CGA High resolution)
     int 10h ;invoke the interrupt to change mode    
 pop ax
ret
endp



BorraPantalla proc 
    push ax
    push bx
    push cx
    push dx
    
    mov ax,0
    mov bx,0
    mov cx,0
    mov dx,0
    
    mov ax,0600h ;scroll the screen
    mov bh,00 ;normal attribute
    mov cx,0000 ;from row=00,column=00
    mov dx,184fh ;to row=18h, column=4fh
    int 10h ;invoke the interrupt to clear screen 
    
    
    
    pop dx
    pop cx
    pop bx
    pop ax
 
 ret
endp  
                
               
dibujaPunto proc 
    
    push ax
    push cx
    push dx
      mov ah,0ch ;ah=0ch to draw a line
      mov al,colorP ;pixels=light grey 
      ;mov cx,0  posx
      ;mov dx,0  posy
      int 10h     
    pop dx
    pop cx
    pop ax
 
ret
endp  


MenuPaint proc
 push ax
 push bx      
 
 call IniGrafi   
 
 Ipaint:
 ;call IniGrafi  
 Mens SelecEje
 call LChar   
 
 
 
    opcionxh1:
    cmp al,'1' ;xy
     jne opcionxh2
         call IniGrafi  
         mov bx,offset xyar
         call ImprimerADIB 
         
         cmp ParEy,0   ;0par 1impar
         jne hnnn
             mov bx, offset xyar
             call ReflejoFun
             mov bx, offset auxar
             call ImprimerADIB 
                 push ax
                 push bx
                   mov ax,offset lsupy 
                   mov paraDib[0],ax 
                   mov ax,offset lsupx  
                   mov paraDib[2],ax 
                   mov ax,offset linfy 
                   mov paraDib[4],ax 
                   mov ax,offset linfx  
                   mov paraDib[6],ax
                 pop bx  
                 pop ax
              
         hnnn:
             call ejesdibu
     jmp fopcionxh
    opcionxh2:
    cmp al,'2' ;xz
     jne opcionxh3  
         call IniGrafi 
         mov bx,offset xzar
         call ImprimerADIB
         
         cmp ParEz,0   ;0par 1impar
         jne hnnnx
             mov bx, offset xzar
             call ReflejoFun
             mov bx, offset auxar
             call ImprimerADIB
                 push ax
                 push bx
                   mov ax,offset lsupz 
                   mov paraDib[0],ax 
                   mov ax,offset lsupx  
                   mov paraDib[2],ax 
                   mov ax,offset linfz 
                   mov paraDib[4],ax 
                   mov ax,offset linfx  
                   mov paraDib[6],ax
                 pop bx  
                 pop ax

              
         hnnnx:
             call ejesdibu
     jmp fopcionxh
    opcionxh3:
    cmp al,'3' ;yz
     jne opcionxh4
         call IniGrafi 
         mov bx,offset yzar
         call ImprimerADIB
         
         cmp ParEz,0   ;0par 1impar
         jne hnnnxx
             mov bx, offset yzar
             call ReflejoFun
             mov bx, offset auxar
             call ImprimerADIB
                 push ax
                 push bx
                   mov ax,offset lsupz 
                   mov paraDib[0],ax 
                   mov ax,offset lsupy  
                   mov paraDib[2],ax 
                   mov ax,offset linfz 
                   mov paraDib[4],ax 
                   mov ax,offset linfy  
                   mov paraDib[6],ax
                 pop bx  
                 pop ax

              
         hnnnxx:
            call ejesdibu
     jmp fopcionxh
    opcionxh4:          
    cmp al,'4' ;salir
     jne opcionxh5
     
     jmp Slirx
    opcionxh5: 
     Mens incorrm          
              
    fopcionxh:
    
 jmp Ipaint
 
   Slirx: 
 
 call LChar

 
 pop bx
 pop ax
    
ret
endp
 

ImprimerADIB proc
  ;en bx recibe offset  
 push cx
 push di
  
  
  mov cx,319
  mov di,0
  
  ccicclo:
    push cx
    push bx
        mov cx,di
        mov dh,0
        mov dl,byte ptr[bx+di] ;columna       
        call dibujaPunto
    pop bx
    pop cx
   inc di
  loop ccicclo
  
 mov bx,0 
 pop di
 pop cx
       
ret
endp


numMayort proc
 push bx
 push cx
 push di
 ;en dx guarda el numero mas grande
    
 ;en bx recibe offset arreglo      
 mov cx,319
 mov dx,0
 
 mov di,0
 bbma:
      cmp byte ptr[bx+di],dl
      jna noActuali
         mov dl,byte ptr[bx+di]
      noActuali:
    inc di
 loop bbma      
       
       
 pop di      
 pop cx      
 pop bx   
ret
endp



  
  
ReflejoFun proc
  push ax
  push bx
  push dx
  push cx
  push di
  
  ;trae en bx el offset arreglo
    
  call numMayort
  ;obtiene numero mayor en dx
  
  
  mov cx,319
  mov di,0
  mov dh,0
  
  refleha:
  push dx
   mov ax,dx;numero mayor para hacer reflejo
   sub al,byte ptr[bx+di]
   add ax,dx
   
       push bx
        mov bx, offset auxar
        cmp ax,200
         ja guarcerof; si supera los 200 salta
            
            mov byte ptr[bx+di],al
       
         jmp finalgues
         guarcerof:
            mov byte ptr[bx+di],0
       
         finalgues:
       pop bx
   
   inc di
  pop dx
  loop refleha
   
   
  pop di 
  pop cx 
  pop dx 
  pop bx 
  pop ax 
  
   
ret
endp  
  

ejesdibu proc
  push cx
  push dx
  push bx
  
  
 call ventesp  
 
 Mens2 paraDib[0];arriba
 
 call docsal
 
 Mens2 paraDib[6];izq
 
 call cuaresp
 
 Mens2 paraDib[2];der
 
 call docsal
 
 call ventesp  
 
 Mens2 paraDib[4];abajo
  
  
  
  
  
  mov cx,200
  mov dx,0 
  dciclox:
    push cx
    mov cx,160
    ;mov dx,di 
         mov colorP,7h
         call dibujaPunto
    pop cx 
   inc dx
  loop dciclox
  
  
  
  mov cx,319
  dcicloxx:
   mov dx,100  
         mov colorP,7h
         call dibujaPunto     
  loop dcicloxx
  

 mov colorP,5h 
 
 
 pop bx
 pop dx
 pop cx
           
ret
endp
 
 
ventesp proc
 push cx 
     mov cx,18
     svhac:
       Mens espac
     loop svhac   
 pop cx   
ret
endp 
cuaresp proc
 push cx 
     mov cx,30
     svhacy:
       Mens espac
     loop svhacy   
 pop cx   
ret
endp

docsal proc
 push cx 
     mov cx,11
     svhacx:
       Mens saxl
     loop svhacx   
 pop cx   
ret
endp
;Procedimientos de Arreglar la ecuacion----------------------------------------
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
