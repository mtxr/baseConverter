######### ORIGIN BASE FUNCTIONS ####################

convertFromBinary:
    # output base is binary too, so just print it
    la   $t9, binary
    lb   $t9, 0($t9)
    beq  $t9, $t1, sameBase
    la   $a0, inputNumberArray
    jal  copyToAuxiliaryArray          # get last array address to a1
    jal  revertToInputArray            # revert input array for conversion to decimal

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
