# CONVERT ANY INPUT TO DECIMAL INTEGER

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
