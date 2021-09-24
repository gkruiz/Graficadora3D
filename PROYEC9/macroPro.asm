                        
imprimir macro texto
    mov ah,09h
    mov dx,offset texto
    int 21h
endm 

getOpcion macro
    mov ah,01h
    int 21h
endm

getTexto macro buff
    LOCAL getCaracter,salir    
    xor si,si
    getCaracter: 
        getOpcion
        cmp al, 0Dh
        je salir 
        mov buff[si],al
        inc si
    jmp getCaracter

    salir:
    mov al,24h
    mov buff[si],al
endm

getPath macro buff
    LOCAL getCaracter,salir    
    xor si,si
    getCaracter: 
        getOpcion
        cmp al, 0Dh
        je salir 
        mov buff[si],al
        inc si
    jmp getcaracter

    salir:
    mov al,00h
    mov buff[si],al
endm   

abrirArchivo macro buff,handlerA
   mov ah,3Dh
   mov al,02h
   lea dx,buff
   int 21h
   jc errorArchivo1
   mov handlerA,ax 
endm

cerrarArchivo macro handlerA
    mov ah,3Eh
    mov bx,handlerA
    int 21h
    jc errorArchivo1
endm   

lecturaArchivo macro handlerA,buffLectura,numBytes
    mov ah,3Fh
    mov bx,handlerA
    mov cx,numBytes
    lea dx,buffLectura
    int 21h
    jc errorArchivo2    
    
endm  

analisisLexico macro entrada
LOCAL analisis,finLexico,aumento,lexico,numerosLetras
LOCAL letrasMa,letrasMi,errorLexico,salidaL,fin
analisis:  
    imprimir tLexico
    xor si,si
    xor di,di
    jmp finLexico

finLexico:
    cmp entrada[si],24h
    je salidaL
    jmp lexico
    
aumento:
    inc si
    jmp finLexico
    
lexico:
    cmp entrada[si],0Ah;Salto de linea
    je aumento
    cmp entrada[si],0Dh;Retorno de carro 
    je aumento
    cmp entrada[si],09h;Tab horizontal
    je aumento
    cmp entrada[si],20h;Espacio 
    je aumento
    cmp entrada[si],2Fh;Numeros 47
    jg numerosLetras        
    cmp entrada[si],2Fh;Simbolo /
    je aumento
    cmp entrada[si],2Dh;Simbolo -
    je aumento
    cmp entrada[si],2Bh;Simbolo +
    je aumento
    cmp entrada[si],2Ah;Simbolo *
    je aumento
    cmp entrada[si],29h;Simbolo )
    je aumento
    cmp entrada[si],28h;Simbolo (
    je aumento
    cmp entrada[si],25h;Simbolo %
    je aumento
    
    mov al,entrada[si]
    mov caracterL,al
       
    jmp errorLexico
    
numerosLetras:
    cmp entrada[si],3Ah;Numeros inferiores, 58
    jl aumento
    cmp entrada[si],3Ch;Simbolo <
    je aumento
    cmp entrada[si],3Eh;Simbolo >
    je aumento   
    cmp entrada[si],3Dh;Simbolo =
    je aumento                  
    cmp entrada[si],40h;Letras Mayusculas, 64
    jg letrasMa
    
    mov al,entrada[si]
    mov caracterL,al
       
    jmp errorLexico
    
letrasMa:
    cmp entrada[si],5Bh;Letras Mayusculas,91
    jl aumento
    cmp entrada[si],5Eh;Simbolo ^
    je aumento
    cmp entrada[si],60h;Letras Minusculas,96
    jg letrasMi                  
                      
    mov al,entrada[si]
    mov caracterL,al
       
    jmp errorLexico
    
letrasMi:
    cmp entrada[si],7Bh;Letras Minusculas, 123
    jl aumento     
    
    mov al,entrada[si]
    mov caracterL,al
       
    jmp errorLexico

errorLexico:
    inc di    
    imprimir errorL
    imprimir errorC
    imprimir caracterL
    imprimir salto
    jmp aumento 
    
salidaL:
    imprimir solicitud2
    getOpcion
    cmp al,0Dh
    je fin
jmp opcionIncorrecta

fin:
    
endm

analisisSintactico macro entrada
LOCAL inicio,fin,aumento1,fin1,sintactico,proyecto2_1,proyecto2_2,proyecto2_3,proyecto2_4,ecuacion_0,ecuacion_1,ecuacion_2,ecuacion_3,ecuacion_4,ecuacion_5,ecuacion_6,ecuacion_7,ecuacion_8,ecuacion_9,ecuacionNum
LOCAL parentesisA,variableS,datosNum2,parentesisC,errorParentesisC,datosNum,variablesS2,finEcuacion,errorParentesisA,finEcuacion_1,finEcuacion_2,finEcuacion_3,finEcuacion_4,finEcuacion_5,finEcuacion_6,finEcuacion_7
LOCAL finEcuacion_8,finEcuacion_9,ejeX,ejeX1,eje2,ejeX3,ejeX4,ejeX5,linf_0,linf_1,linf_2,linf_3,linf_4,linf_5,limiteNumerico,limiteNumerico2,limiteNumerico3,Flinf_0,Flinf_1,Flinf_2,Flinf_3,Flinf_4,Flinf_5,lsup_0
LOCAL lsup_1,lsup_2,lsup_3,lsup_4,lsup_5,limiteSNumerico,limiteSNumerico2,limiteSNumerico3,Flsup_0,Flsup_1,Flsup_2,Flsup_3,Flsup_4,Flsup_5,FinejeX,FinejeX1,FinejeX2,FinejeX3,FinejeX4,FinejeX5,finProyecto2
LOCAL finProyecto2_0,finProyecto2_1,finProyecto2_2,finProyecto2_3,finProyecto2_4,finB

inicio:
    imprimir tSintactico
    xor si,si
    mov di,30h
    mov bl,30h
fin1:  
    cmp entrada[si],24h
    je fin
    jmp sintactico
aumento1:
    inc si
    jmp fin1
       
sintactico:
    
    cmp entrada[si],0Ah;Nueva linea
    je aumento1
    cmp entrada[si],0Dh;Retorno de carro
    je aumento1
    cmp entrada[si],09h;Tab horizontal
    je aumento1
    cmp entrada[si],3Ch;<
    je proyecto2_1
    cmp entrada[si],20h;Espacio
    je aumento1
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorSMenor
    jmp fin
    
proyecto2_1:
    inc si
    
    
    cmp entrada[si],0Ah;Nueva linea
    je proyecto2_1
    cmp entrada[si],0Dh;Retorno de carro
    je proyecto2_1
    cmp entrada[si],09h;Tab horizontal
    je proyecto2_1 
    cmp entrada[si],20h;Espacio
    je proyecto2_1
    
    cmp entrada[si],70h;P
    je proyecto2_2
    cmp entrada[si],50h;p
    je proyecto2_2
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorProyecto2
    jmp fin                                 

proyecto2_2:
    inc si
    
    
    cmp entrada[si],0Ah;Nueva linea
    je proyecto2_2
    cmp entrada[si],0Dh;Retorno de carro
    je proyecto2_2
    cmp entrada[si],09h;Tab horizontal
    je proyecto2_2 
    cmp entrada[si],20h;Espacio
    je proyecto2_2
    
    cmp entrada[si],79h;Y
    je proyecto2_3
    cmp entrada[si],59h;y
    je proyecto2_3
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorProyecto2
    jmp fin                                 

proyecto2_3:
    inc si
    
    cmp entrada[si],20h;Espacio
    je proyecto2_3
    cmp entrada[si],0Ah;Nueva linea
    je proyecto2_3
    cmp entrada[si],0Dh;Retorno de carro
    je proyecto2_3
    cmp entrada[si],09h;Tab horizontal
    je proyecto2_3 
    
    cmp entrada[si],32h;2
    je proyecto2_4
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorProyecto2
    jmp fin                                 
    
proyecto2_4:
    inc si
    
    cmp entrada[si],20h;Espacio
    je proyecto2_4
    cmp entrada[si],0Ah;Nueva linea
    je proyecto2_4
    cmp entrada[si],0Dh;Retorno de carro
    je proyecto2_4
    cmp entrada[si],09h;Tab horizontal
    je proyecto2_4 
    
    cmp entrada[si],3Eh;>
    je ecuacion_0
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorSMayor
    jmp fin
    
ecuacion_0:
    inc si
    
    cmp entrada[si],20h;Espacio
    je ecuacion_0
    cmp entrada[si],0Ah;Nueva linea
    je ecuacion_0
    cmp entrada[si],0Dh;Retorno de carro
    je ecuacion_0
    cmp entrada[si],09h;Tab horizontal
    je ecuacion_0 
    
    cmp entrada[si],3Ch;<
    je ecuacion_1
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorSMenor
    jmp fin
    
ecuacion_1:
    inc si
    
    cmp entrada[si],20h;Espacio
    je ecuacion_1
    cmp entrada[si],0Ah;Nueva linea
    je ecuacion_1
    cmp entrada[si],0Dh;Retorno de carro
    je ecuacion_1
    cmp entrada[si],09h;Tab horizontal
    je ecuacion_1 
    
    cmp entrada[si],45h;E
    je ecuacion_2
    cmp entrada[si],65h;e
    je ecuacion_2
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorEcuacion
    jmp fin

ecuacion_2:
    inc si
    
    cmp entrada[si],20h;Espacio
    je ecuacion_2
    cmp entrada[si],0Ah;Nueva linea
    je ecuacion_2
    cmp entrada[si],0Dh;Retorno de carro
    je ecuacion_2
    cmp entrada[si],09h;Tab horizontal
    je ecuacion_2 
    
    cmp entrada[si],43h;C
    je ecuacion_3
    cmp entrada[si],63h;c
    je ecuacion_3
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorEcuacion
    jmp fin
    
ecuacion_3:
    inc si
    
    cmp entrada[si],20h;Espacio
    je ecuacion_3
    cmp entrada[si],0Ah;Nueva linea
    je ecuacion_3
    cmp entrada[si],0Dh;Retorno de carro
    je ecuacion_3
    cmp entrada[si],09h;Tab horizontal
    je ecuacion_3 
    
    cmp entrada[si],55h;U
    je ecuacion_4
    cmp entrada[si],75h;u
    je ecuacion_4
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorEcuacion
    jmp fin

ecuacion_4:
    inc si
    
    cmp entrada[si],20h;Espacio
    je ecuacion_4
    cmp entrada[si],0Ah;Nueva linea
    je ecuacion_4
    cmp entrada[si],0Dh;Retorno de carro
    je ecuacion_4
    cmp entrada[si],09h;Tab horizontal
    je ecuacion_4 
    
    cmp entrada[si],41h;A
    je ecuacion_5
    cmp entrada[si],61h;a
    je ecuacion_5
                
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorEcuacion
    jmp fin
    
ecuacion_5:
    inc si
    
    cmp entrada[si],20h;Espacio
    je ecuacion_5
    cmp entrada[si],0Ah;Nueva linea
    je ecuacion_5
    cmp entrada[si],0Dh;Retorno de carro
    je ecuacion_5
    cmp entrada[si],09h;Tab horizontal
    je ecuacion_5 
    
    cmp entrada[si],43h;C
    je ecuacion_6
    cmp entrada[si],63h;c
    je ecuacion_6
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorEcuacion
    jmp fin
    
ecuacion_6:
    inc si
    
    cmp entrada[si],20h;Espacio
    je ecuacion_6
    cmp entrada[si],0Ah;Nueva linea
    je ecuacion_6
    cmp entrada[si],0Dh;Retorno de carro
    je ecuacion_6
    cmp entrada[si],09h;Tab horizontal
    je ecuacion_6 
    
    cmp entrada[si],49h;I
    je ecuacion_7
    cmp entrada[si],69h;i
    je ecuacion_7
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorEcuacion
    jmp fin
    
ecuacion_7:
    inc si
    
    cmp entrada[si],20h;Espacio
    je ecuacion_7
    cmp entrada[si],0Ah;Nueva linea
    je ecuacion_7
    cmp entrada[si],0Dh;Retorno de carro
    je ecuacion_7
    cmp entrada[si],09h;Tab horizontal
    je ecuacion_7 
    
    cmp entrada[si],4Fh;O
    je ecuacion_8
    cmp entrada[si],6Fh;o
    je ecuacion_8
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorEcuacion
    jmp fin
    
ecuacion_8:
    inc si
    
    cmp entrada[si],20h;Espacio
    je ecuacion_8
    cmp entrada[si],0Ah;Nueva linea
    je ecuacion_8
    cmp entrada[si],0Dh;Retorno de carro
    je ecuacion_8
    cmp entrada[si],09h;Tab horizontal
    je ecuacion_8 
    
    cmp entrada[si],4Eh;N
    je ecuacion_9
    cmp entrada[si],6Eh;n
    je ecuacion_9
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorEcuacion
    jmp fin 

ecuacion_9:
    inc si
    
    cmp entrada[si],20h;Espacio
    je ecuacion_9
    cmp entrada[si],0Ah;Nueva linea
    je ecuacion_9
    cmp entrada[si],0Dh;Retorno de carro
    je ecuacion_9
    cmp entrada[si],09h;Tab horizontal
    je ecuacion_9 
    
    cmp entrada[si],3Eh;>
    je ecuacionNum
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorSMayor
    jmp fin 
ecuacionNumA:
    dec si
    jmp ecuacionNum
ecuacionNum: 
    inc si
    cmp entrada[si],20h;Espacio
    je ecuacionNum
    cmp entrada[si],0Ah;Nueva linea
    je ecuacionNum
    cmp entrada[si],0Dh;Retorno de carro
    je ecuacionNum
    cmp entrada[si],09h;Tab horizontal
    je ecuacionNum  
    
    cmp entrada[si],3Ch;<
    je finEcuacion
    cmp entrada[si],2Bh;+
    je ecuacionNum 
    cmp entrada[si],2Dh;-
    je ecuacionNum 
    cmp entrada[si],28h;(
    je parentesisA 
    cmp entrada[si],29h;)
    je parentesisC 
    cmp entrada[si],58h;X
    je variableS
    cmp entrada[si],78h;x
    je variableS
    cmp entrada[si],59h;Y
    je variableS
    cmp entrada[si],79h;y
    je variableS
    cmp entrada[si],5Ah;Z
    je variableS
    cmp entrada[si],7Ah;z
    je variableS
    cmp entrada[si],2Fh;Numeros
    jg datosNum
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorInicio
    jmp fin
    
parentesisA:
    inc bl
    jmp ecuacionNum
parentesisC:
    cmp bl,30h
    je errorParentesisC
    dec bl
    jmp datosNum2
    
errorParentesisC:
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorParA
    jmp fin    
datosNum:
    cmp entrada[si],3Ah;Final numeros
    jl datosNum2  
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorNum
    jmp fin
    
datosNum2:     
    inc si 
    cmp entrada[si],20h;Espacio
    je datosNum2
    cmp entrada[si],0Ah;Nueva linea
    je datosNum2
    cmp entrada[si],0Dh;Retorno de carro
    je datosNum2
    cmp entrada[si],09h;Tab horizontal
    je datosNum2
    
    cmp entrada[si],3Ch;<
    je finEcuacion
    cmp entrada[si],25h;%
    je ecuacionNum
    cmp entrada[si],2Ah;*
    je ecuacionNum
    cmp entrada[si],2Bh;+
    je ecuacionNum
    cmp entrada[si],2Dh;-
    je ecuacionNum       
    cmp entrada[si],2Fh;/
    je ecuacionNum   
    cmp entrada[si],29h;)
    je parentesisC
    cmp entrada[si],28h;(
    je parentesisA 
    cmp entrada[si],3Dh;=
    je ecuacionNum  
    cmp entrada[si],5Eh;^
    je ecuacionNum
    cmp entrada[si],2Fh;Numeros
    jg ecuacionNumA 
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorSim
    jmp fin
    
variableS: 
    inc si
    cmp entrada[si],20h;Espacio
    je variableS
    cmp entrada[si],0Ah;Nueva linea
    je variableS
    cmp entrada[si],0Dh;Retorno de carro
    je variableS
    cmp entrada[si],09h;Tab horizontal
    je variableS
    
    cmp entrada[si],5Eh;^
    je variablesS2
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorPotencia
    jmp fin

variablesS2:
    inc si
    
    cmp entrada[si],20h;Espacio
    je variablesS2
    cmp entrada[si],0Ah;Nueva linea
    je variablesS2
    cmp entrada[si],0Dh;Retorno de carro
    je variablesS2
    cmp entrada[si],09h;Tab horizontal
    je variablesS2
    
    cmp entrada[si],28h;(
    je parentesisA 
    cmp entrada[si],2Fh;Numeros
    jg datosNum  
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorNum
    jmp fin    
    
finEcuacion:
    inc si
    
    cmp entrada[si],20h;Espacio
    je finEcuacion
    cmp entrada[si],0Ah;Nueva linea
    je finEcuacion
    cmp entrada[si],0Dh;Retorno de carro
    je finEcuacion
    cmp entrada[si],09h;Tab horizontal
    je finEcuacion
    
    cmp bl,30h
    jne errorParentesisA
    
    mov bl,30h
    
    cmp entrada[si],2Fh;/
    je finEcuacion_1
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorDiv
    jmp fin

errorParentesisA:
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorParC
    jmp fin
        
finEcuacion_1:
    inc si
    
    cmp entrada[si],20h;Espacio
    je finEcuacion_1
    cmp entrada[si],0Ah;Nueva linea
    je finEcuacion_1
    cmp entrada[si],0Dh;Retorno de carro
    je finEcuacion_1
    cmp entrada[si],09h;Tab horizontal
    je finEcuacion_1 
    
    cmp entrada[si],45h;E
    je finEcuacion_2
    cmp entrada[si],65h;e
    je finEcuacion_2
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorEcuacion
    jmp fin

finEcuacion_2:
    inc si
    
    cmp entrada[si],20h;Espacio
    je finEcuacion_2
    cmp entrada[si],0Ah;Nueva linea
    je finEcuacion_2
    cmp entrada[si],0Dh;Retorno de carro
    je finEcuacion_2
    cmp entrada[si],09h;Tab horizontal
    je finEcuacion_2 
    
    cmp entrada[si],43h;C
    je finEcuacion_3
    cmp entrada[si],63h;c
    je finEcuacion_3
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorEcuacion
    jmp fin
    
finEcuacion_3:
    inc si
    
    cmp entrada[si],20h;Espacio
    je finEcuacion_3
    cmp entrada[si],0Ah;Nueva linea
    je finEcuacion_3
    cmp entrada[si],0Dh;Retorno de carro
    je finEcuacion_3
    cmp entrada[si],09h;Tab horizontal
    je finEcuacion_3 
    
    cmp entrada[si],55h;U
    je finEcuacion_4
    cmp entrada[si],75h;u
    je finEcuacion_4
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorEcuacion
    jmp fin

finEcuacion_4:
    inc si
    
    cmp entrada[si],20h;Espacio
    je finEcuacion_4
    cmp entrada[si],0Ah;Nueva linea
    je finEcuacion_4
    cmp entrada[si],0Dh;Retorno de carro
    je finEcuacion_4
    cmp entrada[si],09h;Tab horizontal
    je finEcuacion_4 
    
    cmp entrada[si],41h;A
    je finEcuacion_5
    cmp entrada[si],61h;a
    je finEcuacion_5
                
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorEcuacion
    jmp fin
    
finEcuacion_5:
    inc si
    
    cmp entrada[si],20h;Espacio
    je finEcuacion_5
    cmp entrada[si],0Ah;Nueva linea
    je finEcuacion_5
    cmp entrada[si],0Dh;Retorno de carro
    je finEcuacion_5
    cmp entrada[si],09h;Tab horizontal
    je finEcuacion_5 
    
    cmp entrada[si],43h;C
    je finEcuacion_6
    cmp entrada[si],63h;c
    je finEcuacion_6
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorEcuacion
    jmp fin
    
finEcuacion_6:
    inc si
    
    cmp entrada[si],20h;Espacio
    je finEcuacion_6
    cmp entrada[si],0Ah;Nueva linea
    je finEcuacion_6
    cmp entrada[si],0Dh;Retorno de carro
    je finEcuacion_6
    cmp entrada[si],09h;Tab horizontal
    je finEcuacion_6 
    
    cmp entrada[si],49h;I
    je finEcuacion_7
    cmp entrada[si],69h;i
    je finEcuacion_7
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorEcuacion
    jmp fin
    
finEcuacion_7:
    inc si
    
    cmp entrada[si],20h;Espacio
    je finEcuacion_7
    cmp entrada[si],0Ah;Nueva linea
    je finEcuacion_7
    cmp entrada[si],0Dh;Retorno de carro
    je finEcuacion_7
    cmp entrada[si],09h;Tab horizontal
    je finEcuacion_7 
    
    cmp entrada[si],4Fh;O
    je finEcuacion_8
    cmp entrada[si],6Fh;o
    je finEcuacion_8
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorEcuacion
    jmp fin
    
finEcuacion_8:            
    inc si
    
    cmp entrada[si],20h;Espacio
    je finEcuacion_8
    cmp entrada[si],0Ah;Nueva linea
    je finEcuacion_8
    cmp entrada[si],0Dh;Retorno de carro
    je finEcuacion_8
    cmp entrada[si],09h;Tab horizontal
    je finEcuacion_8 
    
    cmp entrada[si],4Eh;N
    je finEcuacion_9
    cmp entrada[si],6Eh;n
    je finEcuacion_9
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorEcuacion
    jmp fin 

finEcuacion_9:
    inc si
    
    cmp entrada[si],20h;Espacio
    je finEcuacion_9
    cmp entrada[si],0Ah;Nueva linea
    je finEcuacion_9
    cmp entrada[si],0Dh;Retorno de carro
    je finEcuacion_9
    cmp entrada[si],09h;Tab horizontal
    je finEcuacion_9 
    
    cmp entrada[si],3Eh;>
    je ejeX
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorSMayor
    jmp fin 

ejeX:             
    inc si
    cmp entrada[si],20h;Espacio
    je ejeX
    cmp entrada[si],0Ah;Nueva linea
    je ejeX
    cmp entrada[si],0Dh;Retorno de carro
    je ejeX
    cmp entrada[si],09h;Tab horizontal
    je ejeX
    
    cmp entrada[si],3Ch;<
    je ejeX1
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorSMenor
    jmp fin 
    
ejeX1:             
    inc si
    cmp entrada[si],20h;Espacio
    je ejeX1
    cmp entrada[si],0Ah;Nueva linea
    je ejeX1
    cmp entrada[si],0Dh;Retorno de carro
    je ejeX1
    cmp entrada[si],09h;Tab horizontal
    je ejeX1
    
    cmp entrada[si],45h;E
    je ejeX2
    cmp entrada[si],65h;e
    je ejeX2
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorEje
    jmp fin 
    
ejeX2:             
    inc si
    cmp entrada[si],20h;Espacio
    je ejeX2
    cmp entrada[si],0Ah;Nueva linea
    je ejeX2
    cmp entrada[si],0Dh;Retorno de carro
    je ejeX2
    cmp entrada[si],09h;Tab horizontal
    je ejeX2
    
    cmp entrada[si],4Ah;J
    je ejeX3
    cmp entrada[si],6Ah;j
    je ejeX3
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorEje
    jmp fin
    
ejeX3:             
    inc si
    cmp entrada[si],20h;Espacio
    je ejeX3
    cmp entrada[si],0Ah;Nueva linea
    je ejeX3
    cmp entrada[si],0Dh;Retorno de carro
    je ejeX3
    cmp entrada[si],09h;Tab horizontal
    je ejeX3
    
    cmp entrada[si],45h;E
    je ejeX4
    cmp entrada[si],65h;e
    je ejeX4
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorEje
    jmp fin

ejeX4:             
    inc si 
    inc di
    cmp entrada[si],20h;Espacio
    je ejeX4
    cmp entrada[si],0Ah;Nueva linea
    je ejeX4
    cmp entrada[si],0Dh;Retorno de carro
    je ejeX4
    cmp entrada[si],09h;Tab horizontal
    je ejeX4
    
    cmp entrada[si],58h;X
    je ejeX5
    cmp entrada[si],78h;x
    je ejeX5
    
     cmp entrada[si],59h;Y
    je ejeX5
    cmp entrada[si],79h;y
    je ejeX5
    
     cmp entrada[si],5Ah;Z
    je ejeX5
    cmp entrada[si],7Ah;z
    je ejeX5
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorEje
    jmp fin

ejeX5:             
    inc si 
    cmp entrada[si],20h;Espacio
    je ejeX5
    cmp entrada[si],0Ah;Nueva linea
    je ejeX5
    cmp entrada[si],0Dh;Retorno de carro
    je ejeX5
    cmp entrada[si],09h;Tab horizontal
    je ejeX5
    
    cmp entrada[si],36h;6
    je finProyecto2
    cmp entrada[si],3Eh;>
    je linf_0
   
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorSMayor
    jmp fin

linf_0:
    inc si
    cmp entrada[si],20h;Espacio
    je linf_0
    cmp entrada[si],0Ah;Nueva linea
    je linf_0
    cmp entrada[si],0Dh;Retorno de carro
    je linf_0
    cmp entrada[si],09h;Tab horizontal
    je linf_0
    
    cmp entrada[si],3Ch;<
    je linf_1
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorSMenor
    jmp fin

linf_1:
    inc si
    cmp entrada[si],20h;Espacio
    je linf_1
    cmp entrada[si],0Ah;Nueva linea
    je linf_1
    cmp entrada[si],0Dh;Retorno de carro
    je linf_1
    cmp entrada[si],09h;Tab horizontal
    je linf_1
    
    cmp entrada[si],4Ch;L
    je linf_2
    cmp entrada[si],6Ch;l
    je linf_2
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorLInf
    jmp fin    

linf_2:
    inc si
    cmp entrada[si],20h;Espacio
    je linf_2
    cmp entrada[si],0Ah;Nueva linea
    je linf_2
    cmp entrada[si],0Dh;Retorno de carro
    je linf_2
    cmp entrada[si],09h;Tab horizontal
    je linf_2
    
    cmp entrada[si],49h;I
    je linf_3
    cmp entrada[si],69h;i
    je linf_3
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorLInf
    jmp fin 

linf_3:
    inc si
    cmp entrada[si],20h;Espacio
    je linf_3
    cmp entrada[si],0Ah;Nueva linea
    je linf_3
    cmp entrada[si],0Dh;Retorno de carro
    je linf_3
    cmp entrada[si],09h;Tab horizontal
    je linf_3
    
    cmp entrada[si],4Eh;N
    je linf_4
    cmp entrada[si],6Eh;n
    je linf_4
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorLInf
    jmp fin 

linf_4:
    inc si
    cmp entrada[si],20h;Espacio
    je linf_4
    cmp entrada[si],0Ah;Nueva linea
    je linf_4
    cmp entrada[si],0Dh;Retorno de carro
    je linf_4
    cmp entrada[si],09h;Tab horizontal
    je linf_4
    
    cmp entrada[si],46h;F
    je linf_5
    cmp entrada[si],66h;f
    je linf_5
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorLInf
    jmp fin 
    
linf_5:
    inc si
    cmp entrada[si],20h;Espacio
    je linf_5
    cmp entrada[si],0Ah;Nueva linea
    je linf_5
    cmp entrada[si],0Dh;Retorno de carro
    je linf_5
    cmp entrada[si],09h;Tab horizontal
    je linf_5
    
    cmp entrada[si],3Eh;>
    je limiteNumerico
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorSMayor
    jmp fin

limiteNumerico:
    inc si
    cmp entrada[si],20h;Espacio
    je limiteNumerico
    cmp entrada[si],0Ah;Nueva linea
    je limiteNumerico
    cmp entrada[si],0Dh;Retorno de carro
    je limiteNumerico
    cmp entrada[si],09h;Tab horizontal
    je limiteNumerico
    
    cmp entrada[si],2Fh;Numeros
    jg limiteNumerico2
    
    cmp entrada[si],2Dh;-
    je limiteNumerico
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorNum
    jmp fin
    
limiteNumerico2:
    cmp entrada[si],3Ah
    jl limiteNumerico3
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorNum
    jmp fin 
    
limiteNumerico3:
    inc si
    cmp entrada[si],20h;Espacio
    je Flinf_0
    cmp entrada[si],0Ah;Nueva linea
    je Flinf_0
    cmp entrada[si],0Dh;Retorno de carro
    je Flinf_0
    cmp entrada[si],09h;Tab horizontal
    je Flinf_0
    
    cmp entrada[si],3Ch;<
    je Flinf_01
    
    cmp entrada[si],2Fh;Numeros
    jg limiteNumerico2
    
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorNum
    jmp fin

Flinf_0:
    inc si
    cmp entrada[si],20h;Espacio
    je Flinf_0
    cmp entrada[si],0Ah;Nueva linea
    je Flinf_0
    cmp entrada[si],0Dh;Retorno de carro
    je Flinf_0
    cmp entrada[si],09h;Tab horizontal
    je Flinf_0
    
    cmp entrada[si],3Ch;<
    je Flinf_01
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorSMenor
    jmp fin

Flinf_01:
    inc si
    cmp entrada[si],20h;Espacio
    je Flinf_01
    cmp entrada[si],0Ah;Nueva linea
    je Flinf_01
    cmp entrada[si],0Dh;Retorno de carro
    je Flinf_01
    cmp entrada[si],09h;Tab horizontal
    je Flinf_01
    
    cmp entrada[si],2Fh;/
    je Flinf_1
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorDiv
    jmp fin                

Flinf_1:
    inc si
    cmp entrada[si],20h;Espacio
    je Flinf_1
    cmp entrada[si],0Ah;Nueva linea
    je Flinf_1
    cmp entrada[si],0Dh;Retorno de carro
    je Flinf_1
    cmp entrada[si],09h;Tab horizontal
    je Flinf_1
    
    cmp entrada[si],4Ch;L
    je Flinf_2
    cmp entrada[si],6Ch;l
    je Flinf_2
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorLInf
    jmp fin    

Flinf_2:
    inc si
    cmp entrada[si],20h;Espacio
    je Flinf_2
    cmp entrada[si],0Ah;Nueva linea
    je Flinf_2
    cmp entrada[si],0Dh;Retorno de carro
    je Flinf_2
    cmp entrada[si],09h;Tab horizontal
    je Flinf_2
    
    cmp entrada[si],49h;I
    je Flinf_3
    cmp entrada[si],69h;i
    je Flinf_3
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorLInf
    jmp fin 

Flinf_3:
    inc si
    cmp entrada[si],20h;Espacio
    je Flinf_3
    cmp entrada[si],0Ah;Nueva linea
    je Flinf_3
    cmp entrada[si],0Dh;Retorno de carro
    je Flinf_3
    cmp entrada[si],09h;Tab horizontal
    je Flinf_3
    
    cmp entrada[si],4Eh;N
    je Flinf_4
    cmp entrada[si],6Eh;n
    je Flinf_4
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorLInf
    jmp fin 

Flinf_4:
    inc si
    cmp entrada[si],20h;Espacio
    je Flinf_4
    cmp entrada[si],0Ah;Nueva linea
    je Flinf_4
    cmp entrada[si],0Dh;Retorno de carro
    je Flinf_4
    cmp entrada[si],09h;Tab horizontal
    je Flinf_4
    
    cmp entrada[si],46h;F
    je Flinf_5
    cmp entrada[si],66h;f
    je Flinf_5
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorLInf
    jmp fin 
    
Flinf_5:
    inc si
    cmp entrada[si],20h;Espacio
    je Flinf_5
    cmp entrada[si],0Ah;Nueva linea
    je Flinf_5
    cmp entrada[si],0Dh;Retorno de carro
    je Flinf_5
    cmp entrada[si],09h;Tab horizontal
    je Flinf_5
    
    cmp entrada[si],3Eh;>
    je lsup_0
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorSMayor
    jmp fin

lsup_0:
    inc si
    cmp entrada[si],20h;Espacio
    je lsup_0
    cmp entrada[si],0Ah;Nueva linea
    je lsup_0
    cmp entrada[si],0Dh;Retorno de carro
    je lsup_0
    cmp entrada[si],09h;Tab horizontal
    je lsup_0
    
    cmp entrada[si],3Ch;<
    je lsup_1
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorSMenor
    jmp fin

lsup_1:
    inc si
    cmp entrada[si],20h;Espacio
    je lsup_1
    cmp entrada[si],0Ah;Nueva linea
    je lsup_1
    cmp entrada[si],0Dh;Retorno de carro
    je lsup_1
    cmp entrada[si],09h;Tab horizontal
    je lsup_1
    
    cmp entrada[si],4Ch;L
    je lsup_2
    cmp entrada[si],6Ch;l
    je lsup_2
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorLSup
    jmp fin    

lsup_2:
    inc si
    cmp entrada[si],20h;Espacio
    je lsup_2
    cmp entrada[si],0Ah;Nueva linea
    je lsup_2
    cmp entrada[si],0Dh;Retorno de carro
    je lsup_2
    cmp entrada[si],09h;Tab horizontal
    je lsup_2
    
    cmp entrada[si],53h;S
    je lsup_3
    cmp entrada[si],73h;s
    je lsup_3
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorLSup
    jmp fin 

lsup_3:
    inc si
    cmp entrada[si],20h;Espacio
    je lsup_3
    cmp entrada[si],0Ah;Nueva linea
    je lsup_3
    cmp entrada[si],0Dh;Retorno de carro
    je lsup_3
    cmp entrada[si],09h;Tab horizontal
    je lsup_3
    
    cmp entrada[si],55h;U
    je lsup_4
    cmp entrada[si],75h;u
    je lsup_4
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorLSup
    jmp fin 

lsup_4:
    inc si
    cmp entrada[si],20h;Espacio
    je lsup_4
    cmp entrada[si],0Ah;Nueva linea
    je lsup_4
    cmp entrada[si],0Dh;Retorno de carro
    je lsup_4
    cmp entrada[si],09h;Tab horizontal
    je lsup_4
    
    cmp entrada[si],50h;P
    je lsup_5
    cmp entrada[si],70h;p
    je lsup_5
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorLSup
    jmp fin 
    
lsup_5:
    inc si
    cmp entrada[si],20h;Espacio
    je lsup_5
    cmp entrada[si],0Ah;Nueva linea
    je lsup_5
    cmp entrada[si],0Dh;Retorno de carro
    je lsup_5
    cmp entrada[si],09h;Tab horizontal
    je lsup_5
    
    cmp entrada[si],3Eh;>
    je limiteSNumerico
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorSMayor
    jmp fin

limiteSNumerico:
    inc si
    cmp entrada[si],20h;Espacio
    je limiteSNumerico
    cmp entrada[si],0Ah;Nueva linea
    je limiteSNumerico
    cmp entrada[si],0Dh;Retorno de carro
    je limiteSNumerico
    cmp entrada[si],09h;Tab horizontal
    je limiteSNumerico
    
    cmp entrada[si],2Fh
    jg limiteSNumerico2
    
    cmp entrada[si],2Dh;-
    je limiteSNumerico
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorNum
    jmp fin
    
limiteSNumerico2:
    cmp entrada[si],3Ah
    jl limiteSNumerico3
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorNum
    jmp fin 
    
limiteSNumerico3:
    inc si
    cmp entrada[si],20h;Espacio
    je Flsup_0
    cmp entrada[si],0Ah;Nueva linea
    je Flsup_0
    cmp entrada[si],0Dh;Retorno de carro
    je Flsup_0
    cmp entrada[si],09h;Tab horizontal
    je Flsup_0
    
    cmp entrada[si],3Ch;<
    je Flsup_01
    
    cmp entrada[si],2Fh;Numeros
    jg limiteSNumerico2
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorNum
    jmp fin

Flsup_0:
    inc si
    cmp entrada[si],20h;Espacio
    je Flsup_0
    cmp entrada[si],0Ah;Nueva linea
    je Flsup_0
    cmp entrada[si],0Dh;Retorno de carro
    je Flsup_0
    cmp entrada[si],09h;Tab horizontal
    je Flsup_0
    
    cmp entrada[si],3Ch;<
    je Flsup_01
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorSMenor
    jmp fin

Flsup_01:
    inc si
    cmp entrada[si],20h;Espacio
    je Flsup_01
    cmp entrada[si],0Ah;Nueva linea
    je Flsup_01
    cmp entrada[si],0Dh;Retorno de carro
    je Flsup_01
    cmp entrada[si],09h;Tab horizontal
    je Flsup_01
    
    cmp entrada[si],2Fh;/
    je Flsup_1
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorDiv
    jmp fin                

Flsup_1:
    inc si
    cmp entrada[si],20h;Espacio
    je Flsup_1
    cmp entrada[si],0Ah;Nueva linea
    je Flsup_1
    cmp entrada[si],0Dh;Retorno de carro
    je Flsup_1
    cmp entrada[si],09h;Tab horizontal
    je Flsup_1
    
    cmp entrada[si],4Ch;L
    je Flsup_2
    cmp entrada[si],6Ch;l
    je Flsup_2
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorLSup
    jmp fin    

Flsup_2:
    inc si
    cmp entrada[si],20h;Espacio
    je Flsup_2
    cmp entrada[si],0Ah;Nueva linea
    je Flsup_2
    cmp entrada[si],0Dh;Retorno de carro
    je Flsup_2
    cmp entrada[si],09h;Tab horizontal
    je Flsup_2
    
    cmp entrada[si],53h;S
    je Flsup_3
    cmp entrada[si],73h;s
    je Flsup_3
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorLSup
    jmp fin 

Flsup_3:
    inc si
    cmp entrada[si],20h;Espacio
    je Flsup_3
    cmp entrada[si],0Ah;Nueva linea
    je Flsup_3
    cmp entrada[si],0Dh;Retorno de carro
    je Flsup_3
    cmp entrada[si],09h;Tab horizontal
    je Flsup_3
    
    cmp entrada[si],55h;U
    je Flsup_4
    cmp entrada[si],75h;u
    je Flsup_4
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorLSup
    jmp fin 

Flsup_4:
    inc si
    cmp entrada[si],20h;Espacio
    je Flsup_4
    cmp entrada[si],0Ah;Nueva linea
    je Flsup_4
    cmp entrada[si],0Dh;Retorno de carro
    je Flsup_4
    cmp entrada[si],09h;Tab horizontal
    je Flsup_4
    
    cmp entrada[si],50h;P
    je Flsup_5
    cmp entrada[si],70h;p
    je Flsup_5
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorLSup
    jmp fin 
    
Flsup_5:
    inc si
    cmp entrada[si],20h;Espacio
    je Flsup_5
    cmp entrada[si],0Ah;Nueva linea
    je Flsup_5
    cmp entrada[si],0Dh;Retorno de carro
    je Flsup_5
    cmp entrada[si],09h;Tab horizontal
    je Flsup_5
    
    cmp entrada[si],3Eh;>
    je FinejeX
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorSMayor
    jmp fin  

FinejeX:             
    inc si
    cmp entrada[si],20h;Espacio
    je FinejeX
    cmp entrada[si],0Ah;Nueva linea
    je FinejeX
    cmp entrada[si],0Dh;Retorno de carro
    je FinejeX
    cmp entrada[si],09h;Tab horizontal
    je FinejeX
    
    cmp entrada[si],3Ch;<
    je FinejeX0
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorSMenor
    jmp fin 
    
FinejeX0:             
    inc si
    cmp entrada[si],20h;Espacio
    je FinejeX0
    cmp entrada[si],0Ah;Nueva linea
    je FinejeX0
    cmp entrada[si],0Dh;Retorno de carro
    je FinejeX0
    cmp entrada[si],09h;Tab horizontal
    je FinejeX0
    
    cmp entrada[si],2Fh;/
    je FinejeX1
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorDiv
    jmp fin 
        
FinejeX1:             
    inc si
    cmp entrada[si],20h;Espacio
    je FinejeX1
    cmp entrada[si],0Ah;Nueva linea
    je FinejeX1
    cmp entrada[si],0Dh;Retorno de carro
    je FinejeX1
    cmp entrada[si],09h;Tab horizontal
    je FinejeX1
    
    cmp entrada[si],45h;E
    je FinejeX2
    cmp entrada[si],65h;e
    je FinejeX2
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorEje
    jmp fin 
    
FinejeX2:             
    inc si
    cmp entrada[si],20h;Espacio
    je FinejeX2
    cmp entrada[si],0Ah;Nueva linea
    je FinejeX2
    cmp entrada[si],0Dh;Retorno de carro
    je FinejeX2
    cmp entrada[si],09h;Tab horizontal
    je FinejeX2
    
    cmp entrada[si],4Ah;J
    je FinejeX3
    cmp entrada[si],6Ah;j
    je FinejeX3
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorEje
    jmp fin
    
FinejeX3:             
    inc si
    cmp entrada[si],20h;Espacio
    je FinejeX3
    cmp entrada[si],0Ah;Nueva linea
    je FinejeX3
    cmp entrada[si],0Dh;Retorno de carro
    je FinejeX3
    cmp entrada[si],09h;Tab horizontal
    je FinejeX3
    
    cmp entrada[si],45h;E
    je FinejeX4
    cmp entrada[si],65h;e
    je FinejeX4
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorEje
    jmp fin

FinejeX4:             
    inc si 
    inc di
    cmp entrada[si],20h;Espacio
    je FinejeX4
    cmp entrada[si],0Ah;Nueva linea
    je FinejeX4
    cmp entrada[si],0Dh;Retorno de carro
    je FinejeX4
    cmp entrada[si],09h;Tab horizontal
    je FinejeX4
    
    cmp entrada[si],58h;X
    je FinejeX5
    cmp entrada[si],78h;x
    je FinejeX5
    
     cmp entrada[si],59h;Y
    je FinejeX5
    cmp entrada[si],79h;y
    je FinejeX5
    
     cmp entrada[si],5Ah;Z
    je FinejeX5
    cmp entrada[si],7Ah;z
    je FinejeX5
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorEje
    jmp fin

FinejeX5:             
    inc si 
    cmp entrada[si],20h;Espacio
    je FinejeX5
    cmp entrada[si],0Ah;Nueva linea
    je FinejeX5
    cmp entrada[si],0Dh;Retorno de carro
    je FinejeX5
    cmp entrada[si],09h;Tab horizontal
    je FinejeX5
    
    cmp di,36h;6
    je finProyecto2
    cmp entrada[si],3Eh;>
    je ejeX
   
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorSMayor
    jmp fin
    
finProyecto2:
    inc si
    
    cmp entrada[si],20h;Espacio
    je finProyecto2
    cmp entrada[si],0Ah;Nueva linea
    je finProyecto2
    cmp entrada[si],0Dh;Retorno de carro
    je finProyecto2
    cmp entrada[si],09h;Tab horizontal
    je finProyecto2 
    
    cmp entrada[si],3Ch;<
    je finProyecto2_0
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorSMenor
    jmp fin 
    
finProyecto2_0:
    inc si
    
    cmp entrada[si],20h;Espacio
    je finProyecto2_0
    cmp entrada[si],0Ah;Nueva linea
    je finProyecto2_0
    cmp entrada[si],0Dh;Retorno de carro
    je finProyecto2_0
    cmp entrada[si],09h;Tab horizontal
    je finProyecto2_0 
    
    cmp entrada[si],2Fh;<
    je finProyecto2_1
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorDiv
    jmp fin 
    
finProyecto2_1:
    inc si
    
    cmp entrada[si],20h;Espacio
    je finProyecto2_1
    cmp entrada[si],0Ah;Nueva linea
    je finProyecto2_1
    cmp entrada[si],0Dh;Retorno de carro
    je finProyecto2_1
    cmp entrada[si],09h;Tab horizontal
    je finProyecto2_1 
    
    cmp entrada[si],70h;P
    je finProyecto2_2
    cmp entrada[si],50h;p
    je finProyecto2_2
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorProyecto2
    jmp fin                                 

finProyecto2_2:
    inc si
    
    cmp entrada[si],20h;Espacio
    je finProyecto2_2
    cmp entrada[si],0Ah;Nueva linea
    je finProyecto2_2
    cmp entrada[si],0Dh;Retorno de carro
    je finProyecto2_2
    cmp entrada[si],09h;Tab horizontal
    je finProyecto2_2 
    
    cmp entrada[si],79h;Y
    je finProyecto2_3
    cmp entrada[si],59h;y
    je finProyecto2_3
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorProyecto2
    jmp fin                                 

finProyecto2_3:
    inc si
    
    cmp entrada[si],20h;Espacio
    je finProyecto2_3
    cmp entrada[si],0Ah;Nueva linea
    je finProyecto2_3
    cmp entrada[si],0Dh;Retorno de carro
    je finProyecto2_3
    cmp entrada[si],09h;Tab horizontal
    je finProyecto2_3 
    
    cmp entrada[si],32h;2
    je finProyecto2_4
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorProyecto2
    jmp fin                                 
    
finProyecto2_4:
    inc si
    
    cmp entrada[si],20h;Espacio
    je finProyecto2_4
    cmp entrada[si],0Ah;Nueva linea
    je finProyecto2_4
    cmp entrada[si],0Dh;Retorno de carro
    je finProyecto2_4
    cmp entrada[si],09h;Tab horizontal
    je finProyecto2_4 
    
    cmp entrada[si],3Eh;>
    je finB
    
    mov al,entrada[si]
    mov caracterS,al 
    errorSintactico caracterS,errorSMayor
    jmp fin
finB: 
imprimir noErrorS
getOpcion   

jmp finB2    
fin:
imprimir errorFinal
jmp opcionIncorrecta
finB2:

endm


errorSintactico macro caracter,tipo
    imprimir errorS
    imprimir errorSi
    imprimir caracter
    imprimir salto
    imprimir tipo
endm

RecepcionDatos macro entrada
LOCAL principio,inicio,fin,ecuacion,aumento,linf0,linf02,linfx0,linfy0,linfz0,linfx02,linfx1,linfx0,linfx12,linfx3,lsupx0,lsupx02,lsupx2,linfg    
LOCAL linfy02,linfy1,linfy0,linfy12,linfy3,lsupy0,lsupy02,lsupy2,linfz02,linfz1,linfz0,linfz12,linfz3,lsupz0,lsupz02,lsupz2   

    inicio:
    xor si,si
    xor di,di
    jmp principio
    
    aumento:
    add si,3
    jmp principio
    
    principio2:
    inc si
    jmp principio
    principio:
    cmp entrada[si],20h;Espacio
    je principio2
    cmp entrada[si],0Ah;Nueva linea
    je principio2
    cmp entrada[si],0Dh;Retorno de carro
    je principio2
    cmp entrada[si],09h;Tab horizontal
    je principio2
    
    cmp entrada[si],50h;P
    je aumento
    cmp entrada[si],70h;p
    je aumento 
    
    cmp entrada[si],28h;(
    je ecuacion 
    cmp entrada[si],29h;)
    je ecuacion 
    cmp entrada[si],58h;X
    je ecuacion
    cmp entrada[si],78h;x
    je ecuacion
    cmp entrada[si],59h;Y
    je ecuacion
    cmp entrada[si],79h;y
    je ecuacion
    cmp entrada[si],5Ah;Z
    je ecuacion
    cmp entrada[si],7Ah;z
    je ecuacion
    cmp entrada[si],2Bh;+
    je ecuacion
    cmp entrada[si],2Dh;-
    je ecuacion
    cmp entrada[si],30h;Numeros
    je ecuacion
    cmp entrada[si],31h;Numeros
    je ecuacion
    cmp entrada[si],32h;Numeros
    je ecuacion
    cmp entrada[si],33h;Numeros
    je ecuacion
    cmp entrada[si],34h;Numeros
    je ecuacion
    cmp entrada[si],35h;Numeros
    je ecuacion
    cmp entrada[si],36h;Numeros
    je ecuacion
    cmp entrada[si],37h;Numeros
    je ecuacion
    cmp entrada[si],38h;Numeros
    je ecuacion
    cmp entrada[si],39h;Numeros
    je ecuacion 
   
    jmp principio2
    
    ecuacion2:
    inc si 
    
    jmp ecuacion
    ecuacion:
    cmp entrada[si],20h;Espacio
    je ecuacion2
    cmp entrada[si],0Ah;Nueva linea
    je ecuacion2
    cmp entrada[si],0Dh;Retorno de carro
    je ecuacion2
    cmp entrada[si],09h;Tab horizontal
    je ecuacion2
    
    cmp entrada[si],3Ch;<
    je linf0   
    
    mov al,entrada[si]
    mov ecuacionF[di],al 
    inc di
    jmp ecuacion2
    
    linf02:
    inc si
    jmp linf0
    
    linf0:
    cmp entrada[si],20h;Espacio
    je linf02
    cmp entrada[si],0Ah;Nueva linea
    je linf02
    cmp entrada[si],0Dh;Retorno de carro
    je linf02
    cmp entrada[si],09h;Tab horizontal
    je linf02
    xor di,di
    mov al,entrada[si]
    cmp entrada[si],70h;P
    je fin
    cmp entrada[si],90h;p
    je fin
    cmp entrada[si],58h;X
    je linfx0
    cmp entrada[si],78h;x
    je linfx0
    cmp entrada[si],59h;Y
    je linfy0
    cmp entrada[si],79h;y
    je linfy0
    cmp entrada[si],5Ah;Z
    je linfz0
    cmp entrada[si],7Ah;z
    je linfz0 
    
    jmp linf02
    
    linfx02:
    inc si
    jmp linfx0
    
    linfx0:
    cmp entrada[si],20h;Espacio
    je linfx02
    cmp entrada[si],0Ah;Nueva linea
    je linfx02
    cmp entrada[si],0Dh;Retorno de carro
    je linfx02
    cmp entrada[si],09h;Tab horizontal
    je linfx02
    xor di,di
    cmp entrada[si],49h;I
    je linfx1
    cmp entrada[si],69h;i
    je linfx1
    
    cmp entrada[si],53h;S
    je lsupx0
    cmp entrada[si],73h;s
    je lsupx0 
    
    jmp linfx02
    
    linfx12:
    inc si
    jmp linfx1
    
    linfx1:
    cmp entrada[si],20h;Espacio
    je linfx12
    cmp entrada[si],0Ah;Nueva linea
    je linfx12
    cmp entrada[si],0Dh;Retorno de carro
    je linfx12
    cmp entrada[si],09h;Tab horizontal
    je linfx12 
    
    cmp entrada[si],3Ch;<
    je linfx0
    cmp entrada[si],30h;Numeros
    je linfx3
    cmp entrada[si],31h;Numeros
    je linfx3
    cmp entrada[si],32h;Numeros
    je linfx3
    cmp entrada[si],33h;Numeros
    je linfx3
    cmp entrada[si],34h;Numeros
    je linfx3
    cmp entrada[si],35h;Numeros
    je linfx3
    cmp entrada[si],36h;Numeros
    je linfx3
    cmp entrada[si],37h;Numeros
    je linfx3
    cmp entrada[si],38h;Numeros
    je linfx3
    cmp entrada[si],39h;Numeros
    je linfx3 
    cmp entrada[si],2Dh;-
    je linfx3        
            
    jmp linfx12
    
    linfx3:
    mov al,entrada[si]
    mov linfx[di],al
    
    inc si
    inc di
    jmp linfx1
     
    linfg:        
    mov cl,entrada[si]
    mov caracterS,cl  
    cmp entrada[si],3Eh;>
    je linf0
    inc si
    jmp linfg
    
    lsupx02:
    inc si
    jmp lsupx0
    lsupx0:
    cmp entrada[si],20h;Espacio
    je lsupx02
    cmp entrada[si],0Ah;Nueva linea
    je lsupx02
    cmp entrada[si],0Dh;Retorno de carro
    je lsupx02
    cmp entrada[si],09h;Tab horizontal
    je lsupx02 
    
    cmp entrada[si],58h;X
    je linfg
    cmp entrada[si],78h;x
    je linfg
    cmp entrada[si],30h;Numeros
    je lsupx2
    cmp entrada[si],31h;Numeros
    je lsupx2
    cmp entrada[si],32h;Numeros          
    je lsupx2
    cmp entrada[si],33h;Numeros
    je lsupx2
    cmp entrada[si],34h;Numeros
    je lsupx2
    cmp entrada[si],35h;Numeros
    je lsupx2
    cmp entrada[si],36h;Numeros
    je lsupx2
    cmp entrada[si],37h;Numeros
    je lsupx2
    cmp entrada[si],38h;Numeros
    je lsupx2
    cmp entrada[si],39h;Numeros
    je lsupx2 
    cmp entrada[si],2Dh;-
    je lsupx2        
            
    jmp lsupx02
    
    lsupx2:
    mov al,entrada[si]
    mov lsupx[di],al
    
    inc si
    inc di
    jmp lsupx0
    
    linfy02:
    inc si
    jmp linfy0
    
    linfy0:
    cmp entrada[si],20h;Espacio
    je linfy02
    cmp entrada[si],0Ah;Nueva linea
    je linfy02
    cmp entrada[si],0Dh;Retorno de carro
    je linfy02
    cmp entrada[si],09h;Tab horizontal
    je linfy02
    xor di,di
    cmp entrada[si],49h;I
    je linfy1
    cmp entrada[si],69h;i
    je linfy1
    
    cmp entrada[si],53h;S
    je lsupy0
    cmp entrada[si],73h;s
    je lsupy0 
    
    jmp linfy02
    
    linfy12:
    inc si
    jmp linfy1
    
    linfy1:
    cmp entrada[si],20h;Espacio
    je linfy12
    cmp entrada[si],0Ah;Nueva linea
    je linfy12
    cmp entrada[si],0Dh;Retorno de carro
    je linfy12
    cmp entrada[si],09h;Tab horizontal
    je linfy12 
    
    cmp entrada[si],3Ch;<
    je linfy0
    cmp entrada[si],30h;Numeros
    je linfy3
    cmp entrada[si],31h;Numeros
    je linfy3
    cmp entrada[si],32h;Numeros
    je linfy3
    cmp entrada[si],33h;Numeros
    je linfy3
    cmp entrada[si],34h;Numeros
    je linfy3
    cmp entrada[si],35h;Numeros
    je linfy3
    cmp entrada[si],36h;Numeros
    je linfy3
    cmp entrada[si],37h;Numeros
    je linfy3
    cmp entrada[si],38h;Numeros
    je linfy3
    cmp entrada[si],39h;Numeros
    je linfy3 
    cmp entrada[si],2Dh;-
    je linfy3        
            
    jmp linfy12
    
    linfy3:
    mov al,entrada[si]
    mov linfy[di],al
    
    inc si
    inc di
    jmp linfy1
    
    lsupy02:
    inc si
    jmp lsupy0
    lsupy0:
    cmp entrada[si],20h;Espacio
    je lsupy02
    cmp entrada[si],0Ah;Nueva linea
    je lsupy02
    cmp entrada[si],0Dh;Retorno de carro
    je lsupy02
    cmp entrada[si],09h;Tab horizontal
    je lsupy02 
    
    cmp entrada[si],59h;Y
    je linfg
    cmp entrada[si],79h;y
    je linfg
    cmp entrada[si],30h;Numeros
    je lsupy2
    cmp entrada[si],31h;Numeros
    je lsupy2
    cmp entrada[si],32h;Numeros
    je lsupy2
    cmp entrada[si],33h;Numeros
    je lsupy2
    cmp entrada[si],34h;Numeros
    je lsupy2
    cmp entrada[si],35h;Numeros
    je lsupy2
    cmp entrada[si],36h;Numeros
    je lsupy2
    cmp entrada[si],37h;Numeros
    je lsupy2
    cmp entrada[si],38h;Numeros
    je lsupy2
    cmp entrada[si],39h;Numeros
    je lsupy2 
    cmp entrada[si],2Dh;-
    je lsupy2        
            
    jmp lsupy02
    
    lsupy2:
    mov al,entrada[si]
    mov lsupy[di],al
    
    inc si
    inc di
    jmp lsupy0
    
    linfz02:
    inc si
    jmp linfz0
    
    linfz0:
    cmp entrada[si],20h;Espacio
    je linfz02
    cmp entrada[si],0Ah;Nueva linea
    je linfz02
    cmp entrada[si],0Dh;Retorno de carro
    je linfz02
    cmp entrada[si],09h;Tab horizontal
    je linfz02
    xor di,di
    cmp entrada[si],49h;I
    je linfz1
    cmp entrada[si],69h;i
    je linfz1
    
    cmp entrada[si],53h;S
    je lsupz0
    cmp entrada[si],73h;s
    je lsupz0 
    
    jmp linfz02
    
    linfz12:
    inc si
    jmp linfz1
    
    linfz1:
    cmp entrada[si],20h;Espacio
    je linfz12
    cmp entrada[si],0Ah;Nueva linea
    je linfz12
    cmp entrada[si],0Dh;Retorno de carro
    je linfz12
    cmp entrada[si],09h;Tab horizontal
    je linfz12 
    
    cmp entrada[si],3Ch;<
    je linfz0
    cmp entrada[si],30h;Numeros
    je linfz3
    cmp entrada[si],31h;Numeros
    je linfz3
    cmp entrada[si],32h;Numeros
    je linfz3
    cmp entrada[si],33h;Numeros
    je linfz3
    cmp entrada[si],34h;Numeros
    je linfz3
    cmp entrada[si],35h;Numeros
    je linfz3
    cmp entrada[si],36h;Numeros
    je linfz3
    cmp entrada[si],37h;Numeros
    je linfz3
    cmp entrada[si],38h;Numeros
    je linfz3
    cmp entrada[si],39h;Numeros
    je linfz3 
    cmp entrada[si],2Dh;-
    je linfz3        
            
    jmp linfz12
    
    linfz3:
    mov al,entrada[si]
    mov linfz[di],al
    
    inc si
    inc di
    jmp linfz1
    
    lsupz02:
    inc si
    jmp lsupz0
    lsupz0:
    cmp entrada[si],20h;Espacio
    je lsupz02
    cmp entrada[si],0Ah;Nueva linea
    je lsupz02
    cmp entrada[si],0Dh;Retorno de carro
    je lsupz02
    cmp entrada[si],09h;Tab horizontal
    je lsupz02 
    
    cmp entrada[si],5Ah;Z
    je linfg
    cmp entrada[si],7Ah;z
    je linfg
    cmp entrada[si],30h;Numeros
    je lsupz2
    cmp entrada[si],31h;Numeros
    je lsupz2
    cmp entrada[si],32h;Numeros
    je lsupz2
    cmp entrada[si],33h;Numeros
    je lsupz2
    cmp entrada[si],34h;Numeros
    je lsupz2
    cmp entrada[si],35h;Numeros
    je lsupz2
    cmp entrada[si],36h;Numeros
    je lsupz2
    cmp entrada[si],37h;Numeros
    je lsupz2
    cmp entrada[si],38h;Numeros
    je lsupz2
    cmp entrada[si],39h;Numeros
    je lsupz2 
    cmp entrada[si],2Dh;-
    je lsupz2        
            
    jmp lsupz02
    
    lsupz2:
    mov al,entrada[si]
    mov lsupz[di],al
    
    inc si
    inc di
    jmp lsupz0
    
    fin:
    imprimir datosObtenidos
    getOpcion 
    
endm