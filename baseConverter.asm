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
    newline:            .asciiz "\n"
    binary:             .byte   'b'
    octal:              .byte   'o'
    decimal:            .byte   'd'
    hexa:               .byte   'h'
    inputNumberArray:   .space  32
    outputNumberArray:  .space  32
    auxiliaryArray:     .space  32


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


######### ORIGIN BASE FUNCTIONS ####################

convertFromBinary:
    # output base is binary too, so just print it
    la   $t9, binary
    lb   $t9, 0($t9)
    beq  $t9, $t1, sameBase

    j    fromBinaryStringToDecimal

convertFromOctal:
    # output base is octal too, so just print it
    la   $t9, octal
    lb   $t9, 0($t9)
    beq  $t9, $t1, sameBase

    j    fromOctalStringToDecimal

convertFromDecimal:
    # output base is decimal too, so just print it
    la   $t9, decimal
    lb   $t9, 0($t9)
    beq  $t9, $t1, sameBase

    j    fromDecimalStringToDecimal

convertFromHexa:
    # output base is hexa too, so just print it
    la   $t9, hexa
    lb   $t9, 0($t9)
    beq  $t9, $t1, sameBase

    # @TODO: FINISH IMPLEMENTATION


######### STRING TO DECIMAL FUNCIONS ###############
### BINARY -> DECIMAL
fromBinaryStringToDecimal:
    # start counter
    la   $t2, inputNumberArray       # load inputNumber address to t2
    li   $t8, 1                      # start our counter
    li   $a0, 0                      # output number
    j    binaryToDecimalLoop

binaryToDecimalLoop:
    lb   $t7, 0($t2)
    addi $t7, $t7, -48              # convert from string to int
    blt  $t7, $zero, convertFinish  # print int if t7 < 0
    mul  $t7, $t7, $t8              # mult t7 * t8
    add  $a0, $a0, $t7              # add t7 to a0
    li   $t6, 2                     # load 2 to t6
    mul  $t8, $t8, $t6              # t8 = t8 * t6
    addi $t2, $t2, 1                # increment array position
    j    binaryToDecimalLoop


### DECIMAL STRING -> DECIMAL
fromDecimalStringToDecimal:
    # start counter
    la   $t2, inputNumberArray       # load inputNumber address to t2
    li   $t8, 1                      # start our counter
    li   $a0, 0                      # output number
    j    decStringToDecimalLoop

decStringToDecimalLoop:
    lb   $t7, 0($t2)
    addi $t7, $t7, -48              # convert from string to int
    blt  $t7, $zero, convertFinish  # print int if t7 < 0
    mul  $t7, $t7, $t8              # mult t7 * t8
    li   $t6, 10                    # load 10 to t6
    mul  $a0, $a0, $t6              # t8 = t8 * t6
    add  $a0, $a0, $t7              # add t7 to a0
    addi $t2, $t2, 1                # increment array position
    j    decStringToDecimalLoop


### OCTAL -> DECIMAL
fromOctalStringToDecimal:
    # start counter
    la   $t2, inputNumberArray       # load inputNumber address to t2
    li   $t8, 1                      # start our counter
    li   $a0, 0                      # output number
    j    octalStringToDecimalLoop

octalStringToDecimalLoop:
    lb   $t7, 0($t2)
    addi $t7, $t7, -48              # convert from string to int
    blt  $t7, $zero, convertFinish  # print int if t7 < 0
    li   $t6, 8                     # load 2 to t6
    mul  $a0, $a0, $t6              # t8 = t8 * t6
    add  $a0, $a0, $t7              # add t7 to a0
    addi $t2, $t2, 1                # increment array position
    j    octalStringToDecimalLoop

### HEXA -> DECIMAL
# @TODO: FINISH IMPLEMENTATION

######### BASE TO FUNCTIONS #############

# DECIMAL -> BINARY STRING ARRAY
convertToBinary:
    li   $t0, 2             # load t0 with 2 to divide
    la   $a1, auxiliaryArray # load outputArrayAddress
    j    decimalToBinaryLoop

decimalToBinaryLoop:
    divu $a0, $t0            # lo = a0/2, hi = a0 % 2
    mfhi $t1                 # t1 = hi (remainder)
    mflo $a0                 # a0 = lo or a0 = (a0/2)
    addi $t1, $t1, 48        # convert to char
    sb   $t1, 0($a1)         # save to outputArray
    addi $a1, $a1, 1         # ++ auxiliaryArray position
    bgtz $a0, decimalToBinaryLoop
    jal  revertAuxiliaryArray
    j    outputAsString

# @TODO: FINISH IMPLEMENTATION

# DECIMAL -> OCTAL STRING ARRAY
convertToOctal:
# @TODO: FINISH IMPLEMENTATION

# DECIMAL -> HEXA STRING ARRAY
convertToHexa:
# @TODO: FINISH IMPLEMENTATION

######### OUTPUT FUNCTIONS ##############
invalidBase:
    la   $a0, invalidBase
    jal  printString

sameBase:
    # Print string outputText
    la   $a0, outputText
    jal  printString

    # Print converted number
    la   $a0, inputNumberArray
    jal  printString

    j    exit

outputAsDecimal:            # receive a0 as the number to output
    move $a1, $a0           # store a0 value into a1 to use a0 later
    la   $a0, outputText    # get outputText address
    jal  printString        # call method to printString

    move $a0, $a1           # restores input number to a0
    li   $v0, 1              # print_string syscall code = 4
    syscall
    j    exit

outputAsString:
    la   $a0, outputText    # get outputText address
    jal  printString        # call method to printString

    la  $a0, outputNumberArray
    jal  printString        # call method to printString
    j    exit

revertAuxiliaryArray:
    # a1 is the last auxiliaryArray position
    la   $a0, outputNumberArray
    li   $t0, 0             # i = 0


revertArrayLoop:
    addi $a1, $a1, -1
    lb   $t0, 0($a1)
    beqz $t0, return
    sb   $t0, 0($a0)
    addi $a0, $a0, 1
    j    revertArrayLoop

return:
    jr  $ra

######### HELPER FUNCTIONS ##############
printNewline:               # Print string newline
    la   $a0, newline       # load the address of newline
    li   $v0, 4             # print_string syscall code = 4
    syscall
    jr   $ra                # return

printString:
    li   $v0, 4             # print_string syscall code = 4
    syscall
    jr   $ra                # return

readBase:
    li   $v0, 12            # read_string syscall code = 8
    syscall
    jr   $ra                # return

readNumber:
    la   $a0, inputNumberArray  # load inputBase address to argument0
    li   $v0, 8             # read_string syscall code = 8
    li   $a1, 32            # space allocated for inputBase
    syscall
    jr   $ra                # return

exit:
    jal printNewline
    li   $v0, 10         # exit
    syscall
