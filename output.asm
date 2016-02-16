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

revertAuxiliaryArray:       # a1 is the last auxiliaryArray position, (array to revert)
    # a1 is the last auxiliaryArray position
    la   $a0, outputNumberArray  # load outputNumberArray address
    li   $t0, 0             # i = 0

revertArrayLoop:
    addi $a1, $a1, -1       # -- auxiliaryArray position
    lb   $t0, 0($a1)        # load byte from auxiliaryArray
    beqz $t0, return        # if no char was read, return to print
    sb   $t0, 0($a0)        # save loaded byte to ouput array
    addi $a0, $a0, 1        # ++ outputNumberArray position
    j    revertArrayLoop    # return to loop
