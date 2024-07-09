#!/bin/bash
#===================================================================================
#
#	 FILE:	mdg32midRndN-svg.sh
#
#	USAGE:	mdg32midRndN-svg.sh <num>
#
#		where <num> is the number of random MDG minuets to be generated, e.g., 50.
#		*** NOTE:  This script has to be in the same directory as mdg32mid+svg.sh. ***
#
# DESCRIPTION:	Used for generating <num> ABC files, each a Musical Dice Game (MDG)
#		minuet based on the rules given in Joseph Haydn's "Der alleizet fertige" 
#
#      AUTHOR:	J.L.A. Uro (justineuro@gmail.com)
#     VERSION:	1.0.3
#     LICENSE:	Creative Commons Attribution 4.0 International License (CC-BY)
#     CREATED:	2024/06/24 19:48:24
#    REVISION:	2024/07/09 14:02:15
#==================================================================================

#----------------------------------------------------------------------------------
# define the function genS() that randomly chooses an integer from 1 to 6, inclusive
#----------------------------------------------------------------------------------
genS() { # RANDOM randomly generates an integer from 0 to 32767
	rnd=32764
	until [ $rnd -lt 32764 ]
	do
		rnd=$[RANDOM]
		if [ $rnd -lt 32764 ]; then echo $[rnd%6+1]; fi
	done
}

#----------------------------------------------------------------------------------
# declare the variables "diceS" as an array
# diceS - array containing the 16 outcomes from input line
#----------------------------------------------------------------------------------
declare -a diceS

#----------------------------------------------------------------------------------
# generate the <num> random minuets
#----------------------------------------------------------------------------------
i=1
while [ $i -le $1 ]; do
#----------------------------------------------------------------------------------
# generate the random 32-sequence of outcomes of the 32 throws of a dice for 
# the minuet and trio
#----------------------------------------------------------------------------------
	for j in {0..31}; do
		diceS[$j]=`genS`
	done

#----------------------------------------------------------------------------------
# generate a waltz in ABC notation and corresponding MIDI and svg for the current 
# diceS using mdg42mid+svg.sh
#----------------------------------------------------------------------------------
	./mdg32mid+svg.sh ${diceS[*]}
	i=`expr $i + 1`
done
#
##
####
