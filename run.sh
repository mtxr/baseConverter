#!/bin/bash
MIF_FILE=$(basename $1 .asm).mif
CHARMAP_FILE=charmap.mif

./montador $1 $MIF_FILE > montador.log ; cat montador.log
./sim $MIF_FILE $CHARMAP_FILE > sim.log 2> /dev/null ; cat sim.log
