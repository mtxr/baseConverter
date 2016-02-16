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
    li   $v0, 1             # print_string syscall code = 4
    syscall
    j    exit

outputAsString:
    la   $a0, outputText    # get outputText address
    jal  printString        # call method to printString

    la  $a0, outputNumberArray
    jal  printString        # call method to printString
    j    exit
