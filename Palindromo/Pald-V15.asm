ORG 1000H
	MSG0 DB "Escriba la oracion deseada:"
	MSG0END DB ?
	MSG1 DB "Es un palindromo"
	MSG1END DB ?
	MSG2 DB "No es un palindromo"
	MSG2END DB ?
	TEXT0 DB "                         "
	TEXT0END DB ?
	TEXT0SIZE DB ?
ORG 2000H
	MOV BX, OFFSET MSG0
	MOV AL, OFFSET MSG0END-OFFSET MSG0
	INT 7
	MOV BX,OFFSET TEXT0
	INT 6
	MOV AL, 25
	INT 7
	MOV TEXT0SIZE, OFFSET TEXT0-OFFSET TEXT0END
	MOV BX, OFFSET TEXT0		;Set pointer direction of TEXT0
	CMP TEXT0SIZE,0			;Compare both values and set flag Z 1/0
	JZ Bad_End			;If Z flag is 1 jump to Bad_End
Loop:	MOV AH,[BX]			;Set AH as BX pointed Value
	CALL Set_AL
	CMP AH, 32			;Compare AH with " "ASCII and set Z
	JNZ Cmp_AL			;If Z is 0 jump to Cmp_AL
	INC BX				
	JMP Loop			;Jump to Loop
Cmp_AL:CMP AL, 32			;Compare AL with " "ASCII and set Z
	JNZ Cmp_Char			;If Z is 0 jump to Cmp_Char
	DEC TEXT0SIZE
	JMP Set_AL			;Jump to Set_AL
Cmp_Char:CMP AH, AL			;Compare both values and set Z
	JNZ Bad_End			;If Z is 0 jump to Bad_End
	INC BX				
	DEC TEXT0SIZE
	CMP TEXT0SIZE,0			;Compare pointers position to see lenght
	JZ End_Game			;If Z 1 jump to End_Game
	JMP Loop			;Jump to loop
End_Game:MOV BX, OFFSET MSG1
	MOV AL, OFFSET MSG1END-OFFSET MSG0
	INT 7				;Print MSG0
	INT 0		
Bad_End:MOV BX, OFFSET MSG2
	MOV AL, OFFSET MSG2END-OFFSET MSG0
	INT 7				;Print MSG1
	INT 0
Set_AL:PUSH BX
	ADD BX,TEXT0SIZE
	MOV AL,[BX]
	POP BX
	RET
END
