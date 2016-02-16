######### BASE TO FUNCTIONS #############

# DECIMAL -> BINARY STRING ARRAY
convertToBinary:
    li   $t0, 2             # load t0 with 2 to divide
    la   $a1, auxiliaryArray # load outputArrayAddress
    j    decimalToT0ValueBase

# DECIMAL -> OCTAL STRING ARRAY
convertToOctal:
    li   $t0, 8              # load t0 with 8 to divide
    la   $a1, auxiliaryArray # load outputArrayAddress
    j    decimalToT0ValueBase


# DECIMAL -> HEXA STRING ARRAY
convertToHexa:
# @TODO: FINISH IMPLEMENTATION


decimalToT0ValueBase:        # receive t0 with the divisor value
    divu $a0, $t0            # lo = a0/t0, hi = a0 % t0
    mfhi $t1                 # t1 = hi (remainder)
    mflo $a0                 # a0 = lo or a0 = (a0/t0)
    addi $t1, $t1, 48        # convert to char
    sb   $t1, 0($a1)         # save to outputArray
    addi $a1, $a1, 1         # ++ auxiliaryArray position
    bgtz $a0, decimalToT0ValueBase
    jal  revertToOutputArray
    j    outputAsString
