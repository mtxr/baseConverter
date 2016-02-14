jmp main

inputBase1:  string "Digite a base de entrada (b/o/d/h):"
inputNumber: string "Qual numero da base?"
inputBase2:  string "Digite a base de entrada (b/o/d/h):"
outputNumber: string "Numerto convertido:"

numberEntered: var #8

main:
    loadn r0, #0            ; Posicao na tela onde a mensagem sera' escrita
    loadn r1, #inputBase1    ; Carrega r1 com o endereco do vetor que contem a mensagem

    call imprimeStr

    loadn r7, #40
    call readBase

    loadn r0, #80            ; Posicao na tela onde a mensagem sera' escrita
    loadn r1, #inputNumber    ; Carrega r1 com o endereco do vetor que contem a mensagem
    call imprimeStr

    loadn r5, #48 ; para converter caracter de numero para numero
    loadn r7, #120
    loadn r6, #numberEntered ; salva o array de numeros digitados
    call readNumber

    loadn r0, #160            ; Posicao na tela onde a mensagem sera' escrita
    loadn r1, #inputBase2    ; Carrega r1 com o endereco do vetor que contem a mensagem
    call imprimeStr

    loadn r7, #200
    call readBase

    loadn r0, #240            ; Posicao na tela onde a mensagem sera' escrita
    loadn r1, #outputNumber    ; Carrega r1 com o endereco do vetor que contem a mensagem
    call imprimeStr



    ; imprimir numero aqui apos convertido
    call converterNumero
    loadn r0, #280            ; Posicao na tela onde a mensagem sera' escrita
    loadn r1, #numberEntered    ; Carrega r1 com o endereco do vetor que contem a mensagem
    loadn r5, #48 ; para converter caracter de numero para numero
    call imprimeNumber

    halt    ; Fim do programa - Para o Processador



imprimeNumber:

;---- Empilhamento: protege os registradores utilizados na subrotina na pilha para preservar seu valor
    push r0
    push r1
    push r2
    push r3
    push r4
    push r5
    push r6
    push r7

    loadn r2, #'\0' ; Criterio de parada
    jmp imprimeNumberLoop

imprimeStr:

;---- Empilhamento: protege os registradores utilizados na subrotina na pilha para preservar seu valor
    push r0
    push r1
    push r2
    push r3
    push r4
    push r5
    push r6
    push r7

    loadn r2, #'\0' ; Criterio de parada

imprimeStrLoop:
    loadi r3, r1        ; aponta para a memoria no endereco r1 e busca seu conteudo em r3
    cmp r3, r2          ; compara o codigo do caractere buscado com o criterio de parada
    jeq saiImprime      ; goto Final da rotina
    outchar r3, r0      ; imprime o caractere cujo codigo está em r3 na posicao r0 da tela
    inc r0              ; incrementa a posicao que o proximo caractere sera' escrito na tela
    inc r1              ; incrementa o ponteiro para a mensagem na memoria
    jmp imprimeStrLoop  ; goto Loop

imprimeNumberLoop:
    loadi r3, r1        ; aponta para a memoria no endereco r1 e busca seu conteudo em r3
    cmp r3, r2          ; compara o codigo do caractere buscado com o criterio de parada
    jeq saiImprime      ; goto Final da rotina
    add r3, r3, r5
    outchar r3, r0      ; imprime o caractere cujo codigo está em r3 na posicao r0 da tela
    inc r0              ; incrementa a posicao que o proximo caractere sera' escrito na tela
    inc r1              ; incrementa o ponteiro para a mensagem na memoria
    jmp imprimeNumberLoop  ; goto Loop

saiImprime:
;---- Desempilhamento: resgata os valores dos registradores utilizados na Subrotina da Pilha
    pop r7
    pop r6
    pop r5
    pop r4
    pop r3
    pop r2
    pop r1
    pop r0
    rts     ; retorno da subrotina

readBase:
    inchar r0 ;Ler entrada do teclado
    loadn r1, #'b'
    cmp r0, r1 ;Compara a entrada com 'b'
    jeq printAndReturn ;Se o valor continuar sendo 'b' volta ao inicio do loop

    loadn r1, #'d'
    cmp r0, r1 ;Compara a entrada com 'd'
    jeq printAndReturn ;Se o valor continuar sendo 'd' volta ao inicio do loop

    loadn r1, #'o'
    cmp r0, r1 ;Compara a entrada com 'o'
    jeq printAndReturn ;Se o valor continuar sendo 'o' volta ao inicio do loop

    loadn r1, #'h'
    cmp r0, r1 ;Compara a entrada com 'h'
    jeq printAndReturn ;Se o valor continuar sendo 'h' volta ao inicio do loop

    jmp readBase

readNumber:
    inchar r0 ;Ler entrada do teclado
    loadn r1, #255
    cmp r0, r1 ;Compara a entrada com 255
    jeq readNumber ;Se o valor continuar sendo 255 volta ao inicio do loop
    outchar r0, r7 ;Se o valor da entrada for diferente de 255 imprime na tela
    inc r7
    sub r4, r0, r5 ; subtrai 48 para armazear o numero correto
    storei r6, r4  ; armazena o numero digitado na memoria
    inc r6
    loadn r1, #13  ; aguarda presionar ENTER para finalizar
    cmp r0, r1 ;Compara a entrada com ENTER
    jeq return
    jmp readNumber

printAndReturn:
    outchar r0, r7
    rts

return:
    inc r6
    loadn r4, #'\0'
    storei r6, r4  ; armazena o numero digitado na memoria
    rts

converterNumero:
    rts
