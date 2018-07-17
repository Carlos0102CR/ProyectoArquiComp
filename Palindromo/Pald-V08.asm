ORG 1000H
	TEXT0 DB "AMO LA PALOMA"
	TEXTEND0 DB ?
	CHAR0 DB ?
	CHAR1 DB ?
	MSG0 DB "Es un palindromo"
	MSG1 DB "No es un palindromo"
ORG 2000H
	MOV AX, OFFSET TEXT0		;Set pointer direction of TEXT0
	MOV CX, TEXTEND0		;Set pointer direction of TEXT0 end +1
	DEC CX
	CMP CX, AX			;Compare both values and set flag Z 1/0
	JZ Bad_End			;If Z is 1 jump to Bad_End
Loop:	MOV CHAR0, [AX]			;Set CHAR0 as AX Pointed value
Set_CHAR1:MOV CHAR1, [CX]
	CMP CHAR0, 32			;Compare CHAR0 with " "ASCII and set flag Z
	JNZ Cmp_BX			;If Z flag is 0 jump to 
	INC AX				
	JMP Loop			;Jump to Loop
Cmp_CHAR1:CMP CHAR1, 32			;Compare CHAR1 with " "ASCII and set flag Z
	JNZ Cmp_Char			;If Z flag is 0 jump to Cmp_Char
	DEC CX
	JMP Set_CHAR1			;Jump to Set_CHAR1
Cmp_Char:CMP CHAR0, CHAR1		;Compare both values and set flag Z
	JNZ Bad_End			;If Z flag is 0 jump to Bad_End
	INC AX				
	DEC CX
	CMP CX, AX			;Compare pointers position to see lenght
	JZ End_Game			;If Z flag 1 jump to End_Game
	JMP Loop			;Jump to loop
End_Game:JMP Bad_End			;Print MSG0
Bad_End: HLT				;Print MSG1
END
