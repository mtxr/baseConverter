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
