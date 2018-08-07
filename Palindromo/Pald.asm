ORG 1000H
	MSG0 DB "Escriba la oracion deseada:"
	MSG0_END DB ?
	MSG1 DB "Es un palindromo"
	MSG1_END DB ?
	MSG2 DB "No es un palindromo"
	MSG2_END DB ?
	TEXT0 DB 00,24 DUP(00)
	TEXT0_SIZE DB 0
	COUNT DB 0
ORG 2000H
	MOV BX, OFFSET MSG0
	MOV AL, OFFSET MSG0_END-OFFSET MSG0
	INT 7
Ask_Text:MOV BX,OFFSET TEXT0
	ADD BX, COUNT
	INT 6
	MOV CH,[BX]
	CMP CH,00Dh
	JZ End_Ask_Text
	MOV BX,OFFSET TEXT0
	MOV AL, COUNT
	ADD AL, 1
	INT 7
	INC COUNT
	CMP COUNT,24
	JNZ Ask_Text
End_Ask_Text:MOV TEXT0_SIZE,AL
	MOV BX,OFFSET TEXT0
	MOV AL, COUNT
	INT 7										;If Z flag is 0 jump to Set_Size
	CMP TEXT0_SIZE,0							;Compare both values and set Z to 1/0
	JZ Bad_End									;If Z flag is 1 jump to Bad_End
	MOV BX,OFFSET TEXT0
	MOV CX,BX									;Set pointer direction of TEXT0
	MOV BX,OFFSET TEXT0
	ADD BL,TEXT0_SIZE
	MOV DX,BX
Loop:MOV BX,CX									;Set CX as BX Value
	MOV AH,[BX]									;Set AH as BX pointed Value
	CMP AH, 32									;Compare AH with " "ASCII and set Z to 1/0
	JNZ Set_AL									;If Z is 0 jump to Set_AL
	INC CX				
	JMP Loop									;Jump to Loop
Set_AL:MOV BX,DX								;Add TEXT0_SIZE value to BX
	MOV AL,[BX]									;Set AL as BX pointed Value
	CMP AL, 00Dh								;Compare AL with enter key ASCII and set Z to 1/0
	JZ Set_AL_If								;If Z is 0 jump to Cmp_Char
	CMP AL, 32									;Compare AL with " "ASCII and set Z to 1/0
	JZ Set_AL_If								;If Z is 0 jump to Cmp_Char
	JMP Cmp_Char
Set_AL_If:DEC DX
	JMP Set_AL									;Jump to Set_AL
Cmp_Char:CMP AH, AL								;Compare both values and set Z to 1/0
	JNZ Bad_End									;If Z is 0 jump to Bad_End
	INC CX
	DEC DX				
	SUB TEXT0_SIZE,2
	CMP TEXT0_SIZE,0							;Compare pointers position to see lenght
	JZ End_Game									;If Z is 1 jump to End_Game
	JS End_Game									;If S is 1 jump to End_Game
	JMP Loop									;Jump to loop
End_Game:MOV BX, OFFSET MSG1
	MOV AL, OFFSET MSG1_END-OFFSET MSG1
	INT 7										;Print MSG0
	INT 0		
Bad_End:MOV BX, OFFSET MSG2
	MOV AL, OFFSET MSG2_END-OFFSET MSG2
	INT 7										;Print MSG1
	INT 0
HLT
END
