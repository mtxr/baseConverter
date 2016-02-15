# Start .data segment (data!)

# syscall used from
# http://courses.missouristate.edu/KenVollmar/mars/Help/SyscallHelp.html
# Mars documentation

.data
    inputBaseText:      .asciiz "Digite a base do numero de entrada (b/o/d/h):   "
    outputBaseText:     .asciiz "Digite a base de conversão (b/o/d/h):   "
    inputNumberText:    .asciiz "Digite o numero a ser convertido:   "
    ivalidBaseText:     .asciiz "Base invalida fornecida."
    outputText:         .asciiz "O numero na nova base eh: "
    inputNumberArray:   .space 32
    outputNumberArray:  .space 32
    newline:            .asciiz "\n"
    binary:             .byte 'b'
    octal:              .byte 'o'
    decimal:            .byte 'd'
    hexa:               .byte 'h'


# program code
.text

    .globl  main
main:
    # Print string inputBaseText
    la   $a0, inputBaseText     # load the address of inputBaseText
    jal  printString

    # Get input base from user and save
    jal  readBase
    move $t1, $v0
    jal  printNewline
    ############# END READING INPUT BASE #######################################




    # Print string inputNumberText
    la   $a0, inputNumberText   # load the address of inputNumberText
    jal  printString

    # Get input number from user and save
    la   $a0, inputNumberArray  # load inputBase address to argument0
    jal  readNumber
    jal  printNewline
    ############# END READING INPUT NUMBER #######################################




    # Print string outputBaseText
    la   $a0, outputBaseText    # load the address of outputBaseText
    jal  printString

    # Get output base from user and save
    jal  readBase
    move $t2, $v0
    jal  printNewline
    ############# END READING OUTPUT BASE #######################################

    # At this point, we have:
    # t1 = base from conversion
    # t2 = base to conversion

    j convert



printOutput:
    # Print string outputText
    la   $a0, outputText
    jal  printString

    # Print converted number
    la   $a0, inputNumberArray
    jal  printString

    j exit

convert:
    # is input binary?
    la $t9, binary
    lb $t9, 0($t9)
    beq $t9, $t1, convertFromBinary

    # is input octal?
    la $t9, octal
    lb $t9, 0($t9)
    beq $t9, $t1, convertFromOctal

    # is input Decimal?
    la $t9, decimal
    lb $t9, 0($t9)
    beq $t9, $t1, convertFromDecimal

    # is input Hexa?
    la $t9, hexa
    lb $t9, 0($t9)
    beq $t9, $t1, convertFromHexa

    # input is hexa
    j invalidBase


convertFromBinary:
    # output base is binary too, so just print it
    la $t9, binary
    lb $t9, 0($t9)
    beq $t9, $t2, printOutput


convertFromOctal:
    # output base is octal too, so just print it
    la $t9, octal
    lb $t9, 0($t9)
    beq $t9, $t2, printOutput

convertFromDecimal:
    # output base is decimal too, so just print it
    la $t9, decimal
    lb $t9, 0($t9)
    beq $t9, $t2, printOutput

convertFromHexa:
    # output base is hexa too, so just print it
    la $t9, hexa
    lb $t9, 0($t9)
    beq $t9, $t2, printOutput

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
    li  $v0, 12          # read_string syscall code = 8
    syscall
    jr  $ra

readNumber:
    li  $v0, 8          # read_string syscall code = 8
    li  $a1, 32         # space allocated for inputBase
    syscall
    jr  $ra

exit:
    jal printNewline
    li  $v0, 10         # exit
    syscall
