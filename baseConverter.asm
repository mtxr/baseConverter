# created by Matheus Martins Teixeira <me@mteixeira.com.br>
# USP Id 7277482

# syscall used from
# http://courses.missouristate.edu/KenVollmar/mars/Help/SyscallHelp.html
# Mars documentation

.data
    inputBaseText:      .asciiz "Digite a base do numero de entrada (b/o/d/h):   "
    outputBaseText:     .asciiz "Digite a base de conversão (b/o/d/h):   "
    inputNumberText:    .asciiz "Digite o numero a ser convertido:   "
    ivalidBaseText:     .asciiz "Base invalida fornecida."
    outputText:         .asciiz "O numero na nova base eh: "
    inputNumberArray:   .space  32
    outputNumberArray:  .space  32
    newline:            .asciiz "\n"
    binary:             .byte   'b'
    octal:              .byte   'o'
    decimal:            .byte   'd'
    hexa:               .byte   'h'


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
    jal  printNewline
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

convertFinish:
    # receive $a0 as the inputNumber in the integer form and decide what to do

    # is output Decimal?
    la   $t9, decimal
    lb   $t9, 0($t9)
    beq  $t9, $t1, outputAsDecimal

    # is output binary?
    la   $t9, binary
    lb   $t9, 0($t9)
    beq  $t9, $t1, convertToBinary

    # is output octal?
    la   $t9, octal
    lb   $t9, 0($t9)
    beq  $t9, $t1, convertToOctal


    # is output Hexa?
    la   $t9, hexa
    lb   $t9, 0($t9)
    beq  $t9, $t1, convertToHexa

    # input is hexa
    j invalidBase

sameBase:
    # Print string outputText
    la   $a0, outputText
    jal  printString

    # Print converted number
    la   $a0, inputNumberArray
    jal  printString

    j exit

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
    j invalidBase


convertFromBinary:
    # output base is binary too, so just print it
    la   $t9, binary
    lb   $t9, 0($t9)
    beq  $t9, $t1, sameBase

    j  convertFromBinaryToDecimal

convertFromBinaryToDecimal:
    # start counter
    la   $t2, inputNumberArray       # load inputNumber address to t2
    li   $t8, 1                      # start our counter
    li   $a0, 0                      # output number
    j binaryToDecimalLoop

binaryToDecimalLoop:
    lb   $t7, 0($t2)
    addi $t7, $t7, -48              # convert from string to int
    blt  $t7, $zero, convertFinish  # print int if t7 < 0
    mul  $t7, $t7, $t8              # mult t7 * t8
    add  $a0, $a0, $t7              # add t7 to a0
    li   $t6, 2                     # load 2 to t6
    mul  $t8, $t8, $t6              # t8 = t8 * t6
    addi $t2, $t2, 1                # increment array position
    li   $t7, 32                    # t7 = 32
    bgt  $t8, $t7, convertFinish    # print int if t8 > t7 (or 32)
    j binaryToDecimalLoop

outputAsDecimal:
    move $a1, $a0
    la   $a0, outputText
    jal  printString

    move $a0, $a1
    li  $v0, 1          # print_string syscall code = 4
    syscall
    j exit


convertFromOctal:
    # output base is octal too, so just print it
    la   $t9, octal
    lb   $t9, 0($t9)
    beq  $t9, $t1, sameBase

convertFromDecimal:
    # output base is decimal too, so just print it
    la   $t9, decimal
    lb   $t9, 0($t9)
    beq  $t9, $t1, sameBase

convertFromHexa:
    # output base is hexa too, so just print it
    la   $t9, hexa
    lb   $t9, 0($t9)
    beq  $t9, $t1, sameBase


convertToBinary:

convertToOctal:

convertToHexa:

invalidBase:
    la   $a0, invalidBase
    jal  printString

# Print string newline
printNewline:
    la  $a0, newline    # load the address of newline
    li  $v0, 4          # print_string syscall code = 4
    syscall
    jr  $ra

printString:
    li  $v0, 4          # print_string syscall code = 4
    syscall
    jr  $ra

readBase:
    li  $v0, 12         # read_string syscall code = 8
    syscall
    jr  $ra

readNumber:
    la   $a0, inputNumberArray  # load inputBase address to argument0
    li   $v0, 8          # read_string syscall code = 8
    li   $a1, 32         # space allocated for inputBase
    syscall
    jr   $ra

exit:
    jal printNewline
    li   $v0, 10         # exit
    syscall
