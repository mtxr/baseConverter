# Start .data segment (data!)
.data
    inputBaseText:      .asciiz "Digite a base do numero de entrada (b/o/d/h):   "
    outputBaseText:     .asciiz "Digite a base de conversão (b/o/d/h):   "
    inputNumberText:    .asciiz "Digite o numero a ser convertido:   "
    outputText:         .asciiz "O numero na nova base eh: "
    inputBase:          .space 2
    outputBase:         .space 2
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
    la   $a0, inputBase         # load inputBase address to argument0
    jal  readBase
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
    la   $a0, outputBase        # load inputBase address to argument0
    jal  readBase
    jal  printNewline
    ############# END READING OUTPUT BASE #######################################

    # At this point, we have:
    # t0 = input numner for conversion
    # data .inputBase  = base from conversion
    # data .outputBase = base from conversion

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

    j printOutput


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
    li  $v0, 8          # read_string syscall code = 8
    li  $a1, 2          # space allocated for inputBase
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
