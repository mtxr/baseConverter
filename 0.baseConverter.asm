# created by Matheus Martins Teixeira <me@mteixeira.com.br>
# USP Id 7277482

# syscall used from
# http://courses.missouristate.edu/KenVollmar/mars/Help/SyscallHelp.html
# Mars documentation

.data
    # texts
    invalidInputText:   .asciiz "Numero invalido na para a base de entrada"
    inputBaseText:      .asciiz "Instruções:\n\nUse apenas digitos e caracteres em MAIUSCULO na entrada de numeros. [0-9A-F]\n\nDigite a base do numero de entrada (b/o/d/h):   "
    outputBaseText:     .asciiz "Digite a base de conversão (b/o/d/h):   "
    inputNumberText:    .asciiz "Digite o numero a ser convertido:   "
    ivalidBaseText:     .asciiz "Base invalida fornecida."
    outputText:         .asciiz "O numero na nova base eh: "
    newline:            .asciiz "\n"

    ## input base types
    binary:             .byte   'b'
    octal:              .byte   'o'
    decimal:            .byte   'd'
    hexa:               .byte   'h'

    ## arrays for program usage
    inputNumberArray:   .space  33
    outputNumberArray:  .space  33
    auxiliaryArray:     .space  33


# program code
.text

main:
    # Print string inputBaseText
    la   $a0, inputBaseText     # load the address of inputBaseText
    jal  printString

    # Get input base from user and save
    jal  readBase
    move $t0, $v0
    jal  printNewline
    ############# END READING INPUT BASE #######################################


    # Print string inputNumberText
    la   $a0, inputNumberText   # load the address of inputNumberText
    jal  printString

    # Get input number from user and save
    jal  readNumber
    ############# END READING INPUT NUMBER #######################################



    # Print string outputBaseText
    la   $a0, outputBaseText    # load the address of outputBaseText
    jal  printString

    # Get output base from user and save
    jal  readBase
    move $t1, $v0
    jal  printNewline
    ############# END READING OUTPUT BASE #######################################

    # At this point, we have:
    # t0 = base from conversion
    # t1 = base to conversion

    j convertStart


###### CONVERSION FUNCTIONS ########
convertFinish:                          # receive $a0 as the inputNumber in the integer form and decide what to do
    move $t0, $t1                       # move output base to t0
    # so now we have
    # t0 as the input base
    # a0 has the input number as an integer
    # if inputBase = outputBase the number was already printed

    # is output Decimal?
    la   $t9, decimal
    lb   $t9, 0($t9)
    beq  $t9, $t0, outputAsDecimal

    # is output binary?
    la   $t9, binary
    lb   $t9, 0($t9)
    beq  $t9, $t0, convertToBinary

    # is output octal?
    la   $t9, octal
    lb   $t9, 0($t9)
    beq  $t9, $t0, convertToOctal


    # is output Hexa?
    la   $t9, hexa
    lb   $t9, 0($t9)
    beq  $t9, $t0, convertToHexa

    # input is hexa
    j    invalidBase

convertStart:
    # t9 will be used as an auxiliary var for comparisions
    # t8 will be our counter during conversion
    # t2 will receive inputNumberArray address
    # t7 will be current number to convert
    #

    # is input binary?
    la   $t9, binary
    lb   $t9, 0($t9)
    beq  $t9, $t0, convertFromBinary

    # is input octal?
    la   $t9, octal
    lb   $t9, 0($t9)
    beq  $t9, $t0, convertFromOctal

    # is input Decimal?
    la   $t9, decimal
    lb   $t9, 0($t9)
    beq  $t9, $t0, convertFromDecimal

    # is input Hexa?
    la   $t9, hexa
    lb   $t9, 0($t9)
    beq  $t9, $t0, convertFromHexa

    # input is hexa
    j    invalidBase


# get input number and check what to do
.include "1.baseFrom.asm"

# destiny base functions. Get an decimal interger and converto to new base
.include "3.baseTo.asm"

# output functions
.include "0.output.asm"

# helper functions
.include "0.helpers.asm"
