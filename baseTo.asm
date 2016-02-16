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
    jal  revertToOutputArray
    j    outputAsString

# @TODO: FINISH IMPLEMENTATION

# DECIMAL -> OCTAL STRING ARRAY
convertToOctal:
# @TODO: FINISH IMPLEMENTATION

# DECIMAL -> HEXA STRING ARRAY
convertToHexa:
# @TODO: FINISH IMPLEMENTATION
