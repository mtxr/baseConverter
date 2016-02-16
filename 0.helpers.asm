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

return:
    jr  $ra                 # return to last saved address

revertToOutputArray:
    la   $a0, outputNumberArray  # load outputNumberArray address
    j    revertFromA1

revertToAuxiliaryArray:
    la   $a0, auxiliaryArray # load outputNumberArray address
    j    revertFromA1

revertToInputArray:
    addi $a1, $a1, -1       # -- auxiliaryArray position
    la   $a0, inputNumberArray # load outputNumberArray address
    j    revertFromA1

revertFromA1:               # a1 is the last position, (array to revert)
    li   $t0, 0             # i = 0

revertArrayLoop:
    addi $a1, $a1, -1       # -- auxiliaryArray position
    lb   $t0, 0($a1)        # load byte from auxiliaryArray
    beqz $t0, return        # if no char was read, return to print
    sb   $t0, 0($a0)        # save loaded byte to ouput array
    addi $a0, $a0, 1        # ++ outputNumberArray position
    j    revertArrayLoop    # return to loop


copyToAuxiliaryArray:
    la   $a1, auxiliaryArray
    j    copyLoop

copyLoop:
    lb   $t9, 0($a0)
    beq  $t9, $zero, return
    sb   $t9, 0($a1)
    addi $a0, $a0, 1
    addi $a1, $a1, 1
    j    copyLoop
