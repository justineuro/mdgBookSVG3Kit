#!/bin/bash
#===================================================================================
#
#	 FILE:	knbgr2mid+svg5.sh
#
#	USAGE:	knbgr2mid+svg5.sh n1 n2 n3 n4 n5 n6 n7 n8 n9 n10 n11 n12 n13 n14 n15 n16 
#									n17 n18 n19 n20 n21 n22 n23 n24 n25 n26 n27 n28 n29 n30 n31 n32
#
#		where n1-n32 are any of the 6 possible integers from the set {1,2,3,4,5,6}; 
#		n1-n16 for the minuet, n17-n32 for the trio
#
# DESCRIPTION:	Used for generating ABC, MIDI, and SVG files of a particular 
#		Musical Dice Game (MDG) minuet based on J.P. Kirnberger's
#		"Der allezeit fertige Menuetten und Polonoisencomponist"
#
#      AUTHOR:	J.L.A. Uro (justineuro@gmail.com)
#     VERSION:	0.0.3
#     LICENSE:	Creative Commons Attribution 4.0 International License (CC-BY)
#     CREATED:	2021/03/07 10:44:34
#    REVISION:	2024/07/07 21:03:14
#==================================================================================

#----------------------------------------------------------------------------------
# declare the variables "diceS" and "measNR" as arrays
# diceS - array containing the 6 outcomes from input line
# measNR - array of all possible measure notes for a specific outcome
#----------------------------------------------------------------------------------
declare -a diceS measNR
#----------------------------------------------------------------------------------
# input 32-sequence of tosses as given in the command line
#----------------------------------------------------------------------------------
diceS=( $1 $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11} ${12} ${13} ${14} ${15} ${16} ${17} ${18} ${19} ${20} ${21} ${22} ${23} ${24} ${25} ${26} ${27} ${28} ${29} ${30} ${31} ${32} )

#----------------------------------------------------------------------------------
# input rule table to determine corresponding G/F measures for each toss outcome
#----------------------------------------------------------------------------------
# minuet
ruletab() {
	case $1 in
	1) measNR=(23 77 62 70 29 83 59 36 33 60 21 14 45 68 26 40);;
	2) measNR=(63 54  2 53 41 37 71 90 55 46 88 39 65  6 91 81);;
	3) measNR=(79 75 42  5 50 69 52  8  4 12 94  9 25 35 66 24);;
	4) measNR=(13 57 64 74 11  3 67 73 95 78 80 30  1 51 82 16);;
	5) measNR=(43  7 86 31 18 89 87 58 38 93 15 92 28 61 72 85);;
	6) measNR=(32 47 84 20 22 49 56 48 44 76 34 19 17 10 27 96);;
	esac
}

# trio
ruletabT() {
	case $1 in
	1) measNR=(81 57 67  2 90 41 24 56 94 47 62 72 25 64 48 87);;
	2) measNR=(78 45 30 65 14 33 10 73 40 55 46 17 31 85 11 76);;
	3) measNR=( 8 69 26 53 43 95 88 63 79  5  3 60 54 21 42 82);;
	4) measNR=(84  6  4 22 51 12 83 92 58 93 66 23 15 13 27 32);;
	5) measNR=(39 28 18 35 89 75 61 96  7 91 70  1 74 44 52 50);;
	6) measNR=(59 71 37 16 86 49 77 20 38 68 19 29 80 36 34  9);;
	esac
}

#----------------------------------------------------------------------------------
# input notes
# declare variables "notesG" and "notesF" as arrays
# notesG - array that contains the possible treble clef notes per measure for the minuets
# notesF - array that contains the possible bass clef notes per measure for the minuets
# notesGT - array that contains the possible treble clef notes per measure for the trios
# notesFT - array that contains the possible bass clef notes per measure for the trios
#----------------------------------------------------------------------------------
declare -a notesG notesF notesGT notesFT

#----------------------------------------------------------------------------------
# define notesG, array of 96 possible measures of treble clef notes
#----------------------------------------------------------------------------------
notesG=("G,/B,/D/G/B/d/" "g3/4b/4e3/4g/4f3/4a/4" "(3^g/a/b/ !trill!g2" "a/B/ z/ ^d/f/a/" "{a}g f/e/ f" "A,/C/!trill!B,/A,/ c" "dfa" "A3" "f3/4a/4c3/4e/4 d" "c/e/d/c/!trill!B/A/" "f/d/c/d/f/a/" "g3/4b/4^d3/4f/4 e" "(3f/g/a/ f (3c/d/e/" "f/e/{e2}f2" "g/a/ z/ c/e/g/" "D3" "(3B/A/G/ BB" "(3f/e/d/ ff" "f/D/ z/ a/(c/d/)" "G/e/E/G/ F" "z/ A/B/A/e/g/" "a/d/ {g}f{e}d" "A/d/fe" "D3" "B/G/F/G/B/d/" "d/D/ F!trill!E" "d/F/G/e/E/c/" "D/G/ {=c}B {A}G" "D/A/ (gf)" "f/d/A/F/ D" "{A}!trill!G2F" "a f/a/c/e/" "(3a/g/f/ aa" "(3g/e/d/ (3c/d/e/ (3A/a/g/" "c/e/ A,3/ c/" "A3" "E/B/ a^g" "aBa" "(3f/e/d/ (3c/d/e/ d" "D3" "D/F/!trill!E/D/ f" "a/b/g/e/f/d/" "d/f/a3/c/" "z/B/=c/B/f/a/" "G,/B,/A,/G,/ B" "g/e/B/G/ E" "d/c/!trill!B/A/ d" "A3" "B/e/ {a}^g{f}e" "D/F/A/d/f/a/" "E/A/{d}c{B}A" "a/A/ c !trill!B" "{f}!trill!e2 d" "d/f/e/g/ f" "(3a/f/e/ (3^d/e/f/ (3B/b/a/" "a/c/d/b/B/^g/" "d/b/a/c/ d" "A3" "ac!trill!B" "g/f/{f}g2" "(3c/d/e/ !trill!c2" "e/g/f/a/ g" "D/F/A/d/c/e/" "A/e/ g f3/4a/4" "G,/D/ (cB)" "d/D/{D2}!trill!E2" "a/A/ {A2}!trill!B2" "A,/E/ (dc)" "^g/b/a/g/!trill!f/e/" "{d2}!trill!c2d" "(3a/e/d/ (3c/B/A/ (3^G/A/B/" "(3d/A/B/ F!trill!E" "A3" "A/g/!trill!f/e/ f" "d/D/d2" "(3g/f/e/ (3^d/e/f/ e" " d3/4d'/4 ba" "g/e/ z/ b/^d/e/" "DFA" "gAg" "D3" "dF!trill!E" "^g/b/ E3/ g/" "e/A/!trill!B/A/f/a/" "D3" "e/c/ A3/ f/" "(3a/e/f/ c!trill!B" "(3g/f/e/ gg" "E/^G/!trill!F/E/ ^G" "A3" "(3d/A/G/ (3F/E/D/ (3C/D/E/" "f/a/g/f/!trill!e/d/" "g/b/a/g/!trill!f/e/" "z/ e/c/A/g/e/" "z/ f/^d/B/a/f/" "D3")

#----------------------------------------------------------------------------------
# define notesF, array of 96 possible measures bass clef notes
#----------------------------------------------------------------------------------
notesF=("G,B,G," "E,C,D," "zE,D," "^D,B,,D," "E,A,,D," "zG,3/A,/" "F,/E,/ D,3/ D/" "A,, A,/G,/F,/E,/" "D,A,,D,," "zG,G," "zD,D," "E,B,,E,," "DA,G," "D,3/ A,/F,/D,/" "C,A,,C," "D,A,,D,," "zG,G," "zD,D," "D,E,F," "E,C,D," "C,3" "zD,D," "D,DA," "D,A,,D,," "G,G,G," "F,/G,/ A,A,," "D,G,A," "G,G,G," "zD,D," "D,3/ D,/F,/D,/" "E,A,,D," "D,D,A," "^D,3/ B,,/D,/B,,/" "C,A,,C," "A,, C,/E,/G,,/G,/" "A,, A,/G,/F,/E,/" "zD,D," "^D,3/ B,,/C,/D,/" "D,G,F," "D,A,,D,," "zD,D," "C,C,D," "D,F,/D,/A,/G,/" "^D,3" "G,G,G," "E,3/ E,/G,/E,/" "F,G,F," "A,, A,/G,/F,/E,/" "zE,E," "zF,D," "zG,G," "C,/D,/ E,E,," "A,A,,D," "F,C,D," "^D,B,,D," "C,D,E," "F,3/ G,/F," "A,, A,/G,/F,/E,/" "C,/D,/ E,E,," "E,3/ B,/G,/E,/" "A,, A,/C,/E,/G,/" "C,D,G," "D,3/F,/A," "C,2D," "G,G,G" "F,/G,/A,A,," "C,/D,/ E,E,," "zG,G," "zD,D," "A,A,,D," "C,3/4D,/4 E,E,," "F,/G,/ A,A,," "A,, A,/G,/F,/E,/" "A,C,D," "F,3/ E,/F,/D,/" "E,A,G," "F,G,F," "E,F,G," "D,F, A,/G,/" "C,3/ A,,/B,,/C,/" "D,A,,D,," "F,/G,/ A,A,," "E, ^G,/B,/D,/B,/" "C,C,D," "D,A,,D,," "C,3/ A,,/D" "C,3/4D,/4 E,E,," "C,3/ A,,/C,/A,,/" "z D,3/E,/" "A,, A,/G,/F,/E,/" "F,3/4G,/4 A,A,," "D,E,F," "E,F,G," "C,3/ A,/B,,/C,/" "^D,3/ B,,/C,/D,/" "D,A,,D,,")

#----------------------------------------------------------------------------------
# define notesGT, array of 96 possible measures treble clef notes for the trio
#----------------------------------------------------------------------------------
notesGT=("(B/A/)!trill!A/G/!trill!G/F/ & (G/F/)F/B,/B,/A,/" "(g/f/)!trill!f/e/!trill!e/d/ & (e/d/)d/G/!trill!G/F/" "z/ B/ !trill!B/4A/4B/ C/B/ & z/ G/ G/4F/4G/ C/G/" "z/ e/ !trill!e/4d/4e/ A/g/ & z/ ^c/ !trill!c/4=B/4c/ A/e/" "(3B/A/G/ !trill! G2 & GDB," "(3^c/d/e/ A2 & E^C2" "c/a/a3/c/ & A/c/c3/A/" "D/F/!trill!E/D/.d/.d/ & D2 A/F/" "D3 & D3" "(3A/G/F/ !trill!G2 & F2E" "(3F/E/D/ !trill!E2 & D2 ^C" "BB3/c/ & GG2" "(3^c/e/c/ (3A/E/^C/ (3A,/G/E/ & EE2" "a3/ f/d/A/ & f3/ d/A" "z/ A/!trill!B/A/.d/.d/ & z/ F/!trill!G/F/.F/.F/" "!trill!g/f/a/d'/ d & !trill!e/d/d z" "A/f/ F2 & F/C/(!trill!C/B,/)(!trill!B,/A,/)" "G/b/a/F/E/g/ & E/g/f/D/^C/e/" "(3B/G/F/ (3E/F/G/ C3/4B/4 & G3/ E/G/E/" "F3 & F3" "^c/e/A/G/F/E/ & EE^C" "f/d/A/F/D & d/d/A/F/d" "{B2}A3 & {G2}F3" "(3A/G/F/ !trill!G2 & F2 !trill!E " "(3D/F/A/ dd & DAF" "e3/ b/a/g/ & ^c3/ g/f/e/" "(3F/E/D/ !trill!E2 & D2^C" "{d2}^c3/ d/e & EA/=B/^c" "{B2}A3 & {G2}F3" "(3A/^c/e/ gg & A3/4^c/4 ee" "z/ f/ (!trill!f/e/)(!trill!e/d/) & z/ A/ (!trill!A/G/)(!trill!G/F/)" "D3 & D3" "c/B/A/G/g/B/ & D2C/G/" "(3F/E/D/ !trill!E2 & D2!trill!^C" "f/b/a/^c/ d & d/G/F/E/F" "(3^c/d/e/ G2 & EE2" "A/^c/!trill!=B/A/.g/.g/ & ^C3/ ^c/e/e/" "(3c/A/G/ (3^F/G/A/ D3/4c/4 & A3/ ^F/A/F/" "A/f/(!trill!f/e/)(!trill!e/d/) & F/A/(!trill!A/G/)(!trill!G/F/)" "c/_e/(e/d/)(d/c/) & A/c/c/B/B/A/" " B/geB/ & G/BGG/" "(3F/E/D/ !trill!E2 & D2 !trill!^C" "z/(f/e/)d/.a/.c/ & A2A" "(d/^c/)c/e/e/G/ & (F/E/)E/G/G/E/" "^c/A/E/^C/ A, & E/A/E/^C/A," "B/d/(d/c/)(c/B/) & G/B/(B/A/)(A/G/)" "(c/B/)d/g/G & D3/ B,/D/B,/" "(3F/E/D/ !trill! E2 &D2!trill!^C" "B3/ g/e/B/ & D3/ C/E/G/" "D3 & D3" "z/ f/ !trill!f/4e/4f/ a/f/ & z/ d/ !trill!d/4^c/4d/ A/d/" "(3F/E/D/ !trill!E2 & D2!trill!^C" "g/e/ {e2}f2 & e/^c/ {c2}d2" "z/ d/!trill!^c/4d/4d/ D/d/ & z/ F/ !trill!F/4E/4F/ D/F/" " B/g/G2 & G/D/(D/C/)(C/B,/)" "F3 & F3" "{d2}^c3 & {F2}E3" "z/ D/ _E/!trill!D/A/c/ & (A,2A,/)A/" "a3/ e/f/d/ & f3/ ^c/d/F/" "(3A/G/F/ F2 & FCA," "(3A/G/F/ !trill!G2 & F2!trill!E" "(3B/G/E/ CB & GCG" "F3 & F3" "(3^c/e/d/ (3c/=B/A/ (3G/F/E/ & EEE" "{g2}f3 & {e2}d3" "z/ C/ !trill!(D/C/)G/B/ & (G,2G,/)G/" "z/ b/(b/a/)(a/g/) & z/ g/(g/f/)(f/e/)" "{c2}B3 & {A2}G3" "(d/^c/)(c/=B/)(B/A/) & (F/E/)(E/D/)(D/^C/)" "B/g/ g3/ B/ & G/B/B3/G/" "(d/^c/)e/a/ A & E^Cz" "(B/A/)c/f/F & C3/A,/C/A,/" "F3 & F3" "z/ a (e/f/d/) & z/ f (^c/d/F/)" "B/g/ G2 & G/B/G2" "D3 & D3" "(3A/G/F/ !trill!G2 & F2!trill!E" "z/d/ !trill!d/4^c/4d/ D/d/ & z/F/ !trill!F/4E/4F/ D/F/" "z/ c/!trill!c/4B/4c/ D/c/ & z/A/ !trill!A/4G/4A/ D/A/" "(3D/f/e/ (3d/^c/d/ (3d/c/d/ & DDF" "(3D/F/A/ dd & DAF" "D3 & D3" "(3A/G/F/ !trill!G2 & F2!trill!E" "afd & F3/ G/A/B/" "^c/4d/4 e B/A/G/ & E3/ G/F/E/" "(3d/f/a/ d'/a/f/d/ & A2A" "D3 & D3" "(3A/G/F/ !trill!G2 & F2!trill!E" "z/ .A/(A/f/).f/.d/ & z/ .F/(F/A/).A/.F/" "d/D/ d3/d/ & FAA" "(c/B/)(B/A/)(A/G/) & (A/G/)(G/C/)(C/B/)" "F3 & F3" "{c2}B3 & {A2}G3" "(3c/A/^F/ Dc & ADA" "B/g/ g3/B/ & G/B/ B3/ G/" "F3 & F3")

#----------------------------------------------------------------------------------
# define notesFT, array of 96 possible measures bass clef notes for the trio
#----------------------------------------------------------------------------------
notesFT=("F,F,,z" "DD,z" "E,3" "A,2^C" "G,/G,,/B,,/D,/G,/G,,/" "A,3/ E,/^C,/A,,/" "^F,/D,/F,/A,/D/F,/" "D,3/D,/F,/D,/" "D,A,,D,," "F,C,C,," "D,A,A,," "G,,/E,/ !trill!E,/4D,/4E,/ G,/E,/" "A,^C,2" "(3D,/F,/A,/ DF," "D,2D," "DD,z" "F,/A,/A,/G,/G,/F,/" "zA,A," "E,3/ C,/E,/C,/" "F,, A,/G,/F,/E,/" "A,^CA," "D/D/A,/F,/D," "F,,/F,/ !trill!F,/4E,/4F,/ F,,/F,/" "F,C,C,," "D,F,D," "(3A,/E,/^C,/ A,,A," "D,A,A,," "A,A,,z" "(3F,,/A,,/C,/ F,/E,/D,/^C,/" "z/ A,/ !trill!A,/4^G,/4A,/ A,,/A,/" "D,DG," "D,A,,D,," "G,,G,E," "D,A,A,," "D,3/ A,/F,/A,/" "A,,/A,/ A,/4!trill!^G,/4A,/ A,,/A,/" "A,3/ A,/^C/A,/" "^F,3/ D,/^F,/D,/" "D,DG," "^F,2F," "G,C,E," "D,A,A,," "D,2F," "A,A,,3/ ^C,/" "A,,/A,/E,/C,/ A,," "E,2E," "G,3/G,/B,/G,/" "D,A,A,," "(3G,,/B,,/D,/ G,/E,/C,/E,/" "D,A,,D,," "D,D,F," "D,A,A,," "D,3/ F,/A,/D/" "D,2D," "G,/B,/(B,/A,/)(A,/G,/)" "F,,/F,/ !trill!F,/4E,/4F,/ F,," "A,,/A,/ !trill!A,/4^G,/4A,/ A,," "^F,2F," "(3D,/F,/A,/ DD" "F,/F,,/A,,/C,/F,/F,,/" "F,C,C,," "E,3" "F,,C,F," "A,A,,^C," "D,/D/A,/F,/ D," "E,2E," "^C3" "(3G,,/B,,/D,/ G,/F,/E,/D,/" "A,A,,z" "E,/C,/E,/G,/C/E,/" "A,,A,z" "F,3/ F,/A,/F,/" "F,,/F,/C,/A,,/F,," "(3D,/F,/A,/ DD" "z/ G,,/G,,/E,/E,/C,/" "D,A,,D,," "F,C,C,," "D,2D," "^F,3" "D,B,^G," "D,F,D," "D,A,,D,," "F,C,C,," "D,3/ E,/F,/G,/" "A,^C,C," "F,2D," "D,A,,D,," "F,C,C,," "D,2D," "D,F,^F," "G,G,,z" "F,,/F,,/A,,/C,/ F," "G,,/G,/ !trill!G,/4^F,/4G,/ F,,/=F,/" "^F,3" "G,3/ C,/D,/E,/" "F,,3/ A,/4G,/4F,/E,/")



#----------------------------------------------------------------------------------
# create cat-to-output-file function
#----------------------------------------------------------------------------------
catToFile(){
	cat >> $filen << EOT
$1
EOT
}

#----------------------------------------------------------------------------------
# create empty ABC file
# set header info: generic index number, filename
# Total MDGs: 7,958,661,109,946,400,884,391,936	= (6^16)*(6^16) =  6**32
# Unique MDGs:    1,023,490,369,077,469,249,536	= (6^14)*(1^2)*(6^13)*(1^3) = 6**27
# all same for measures VIII; XVI; XXIII; XXXII 
#----------------------------------------------------------------------------------
fileInd=$1-$2-$3-$4-$5-$6-$7-$8-$9-${10}-${11}-${12}-${13}-${14}-${15}-${16}
fileInd2=${17}-${18}-${19}-${20}-${21}-${22}-${23}-${24}-${25}-${26}-${27}-${28}-${29}-${30}-${31}-${32}
filen="knbgr-$fileInd-$fileInd2.abc"

#Same measures for all 6(?) tosses in five (5) measures: VIII, XVI, VII, XV, XVI 
#######
#TOTAL:		6**32 =	7,958,661,109,946,400,884,391,936
#UNIQUE:	6**27 =			1,023,490,369,077,469,249,356
#######
# dbNum cannnot be computed in bash
##dbNum=(( ${diceS[0]} + (${diceS[1]}-1)*6 + (${diceS[2]}-1)*6**2 + (${diceS[3]}-1)*6**3 + (${diceS[4]}-1)*6**4 + (${diceS[5]}-1)*6**5 + (${diceS[6]}-1)*6**6 + 0 + (${diceS[8]}-1)*6**7 + (${diceS[9]}-1)*6**8 + (${diceS[10]}-1)*6**9 + (${diceS[11]}-1)*6**10 + (${diceS[12]}-1)*6**11 + (${diceS[13]}-1)*6**12 + (${diceS[14]}-1)*6**13 + 0 + (${diceS[16]}-1)*6**14 + (${diceS[17]}-1)*6**15 + (${diceS[18]}-1)*6**16 + (${diceS[19]}-1)*6**17 + (${diceS[20]}-1)*6**18 + (${diceS[21]}-1)*6**19 + 0 + (${diceS[23]}-1)*6**20 + (${diceS[24]}-1)*6**21 + (${diceS[25]}-1)*6**22 + (${diceS[26]}-1)*6**23 +(${diceS[27]}-1)*6**24 + (${diceS[28]}-1)*6**25 + (${diceS[29]}-1)*6**26 + 0 + 0 )) 

#echo "${diceS[0]} + (${diceS[1]}-1)*6 + (${diceS[2]}-1)*6**2 + (${diceS[3]}-1)*6**3 + (${diceS[4]}-1)*6**4 + (${diceS[5]}-1)*6**5 + (${diceS[6]}-1)*6**6 + 0 + (${diceS[8]}-1)*6**7 + (${diceS[9]}-1)*6**8 + (${diceS[10]}-1)*6**9 + (${diceS[11]}-1)*6**10 + (${diceS[12]}-1)*6**11 + (${diceS[13]}-1)*6**12 + (${diceS[14]}-1)*6**13 + 0 + (${diceS[16]}-1)*6**14 + (${diceS[17]}-1)*6**15 + (${diceS[18]}-1)*6**16 + (${diceS[19]}-1)*6**17 + (${diceS[20]}-1)*6**18 + (${diceS[21]}-1)*6**19 + 0 + (${diceS[23]}-1)*6**20 + (${diceS[24]}-1)*6**21 + (${diceS[25]}-1)*6**22 + (${diceS[26]}-1)*6**23 + (${diceS[27]}-1)*6**24 + (${diceS[28]}-1)*6**25 + (${diceS[29]}-1)*6**26 + 0 + 0"

# export to maxima to compute dbNum
cat > /tmp/001.mac << EOF
with_stdout("/tmp/001.txt",print(${diceS[0]} + (${diceS[1]}-1)*6 + (${diceS[2]}-1)*6**2 + (${diceS[3]}-1)*6**3 + (${diceS[4]}-1)*6**4 + (${diceS[5]}-1)*6**5 + (${diceS[6]}-1)*6**6 + 0 + (${diceS[8]}-1)*6**7 + (${diceS[9]}-1)*6**8 + (${diceS[10]}-1)*6**9 + (${diceS[11]}-1)*6**10 + (${diceS[12]}-1)*6**11 + (${diceS[13]}-1)*6**12 + (${diceS[14]}-1)*6**13 + 0 + (${diceS[16]}-1)*6**14 + (${diceS[17]}-1)*6**15 + (${diceS[18]}-1)*6**16 + (${diceS[19]}-1)*6**17 + (${diceS[20]}-1)*6**18 + (${diceS[21]}-1)*6**19 + 0 + (${diceS[23]}-1)*6**20 + (${diceS[24]}-1)*6**21 + (${diceS[25]}-1)*6**22 + (${diceS[26]}-1)*6**23 +(${diceS[27]}-1)*6**24 + (${diceS[28]}-1)*6**25 +(${diceS[29]}-1)*6**26 + 0 + 0))$
printfile("/tmp/001.txt")$
quit();
EOF
/usr/local/bin/maxima < /tmp/001.mac > /dev/null
dbNum=`cat /tmp/001.txt`
#echo $dbNum

#----------------------------------------------------------------------------------
# calculate the measure numbers for the current dice toss (from (6**14)(16**6) possibilities)
#----------------------------------------------------------------------------------
currMeas=0
for measj in ${diceS[*]} ; do
	currMeas=`expr $currMeas + 1`
	if [ "$currMeas" -lt "17" ]; then
		ruletab $measj
		measPerm="$measPerm${measNR[$currMeas-1]}:"
	else
		ruletabT $measj
		measPerm="$measPerm${measNR[$currMeas-17]}:"
	fi
done
measPerm="$measPerm:"

#----------------------------------------------------------------------------------
# if output abc file already exists, then make a back-up copy
#----------------------------------------------------------------------------------
if [ -f $filen ]; then 
	mv $filen $filen."bak"
fi


#----------------------------------------------------------------------------------
# generate the header of the ABC file
#----------------------------------------------------------------------------------
catToFile "%%scale 0.65
%%pagewidth 21.082cm
%%bgcolor white
%%topspace 0
%%composerspace 0
%%leftmargin 0.254cm
%%rightmargin 0.254cm
X:$dbNum
T:${fileInd}-${fileInd2}
%%setfont-1 Courier-Bold 12
T:\$1knbgr::$measPerm\$0
T:\$1Perm. No.: $dbNum\$0
M:3/4
L:1/4
Q:1/4=90
%%staves [1 2]
V:1 clef=treble
V:2 clef=bass
K:D"

#----------------------------------------------------------------------------------
# write the notes of the ABC file
#----------------------------------------------------------------------------------
currMeas=0
for measj in ${diceS[*]} ; do
	currMeas=`expr $currMeas + 1`
	if [ "$currMeas" -lt "17" ]; then 
		ruletab $measj
		measN=${measNR[$currMeas-1]}
		phrG=${notesG[$measN-1]}
		phrF=${notesF[$measN-1]}
	else
		ruletabT $measj
		measN=${measNR[$currMeas-17]}
		phrG=${notesGT[$measN-1]}
		phrF=${notesFT[$measN-1]}
	fi
	if [ "${currMeas}" == "1" ]; then
		catToFile "%1
[V:1]|: $phrG |\\
[V:2]|: $phrF |\\"
		continue
	elif [ "$currMeas" == "8" ] || [ "$currMeas" == "16" ] || [ "$currMeas" == "24" ]; then
		catToFile "%8,16,24 returns
[V:1] $phrG ::
[V:2] $phrF ::"
		continue
	elif [ "$currMeas" == "17" ]; then
		catToFile "%17 key change
[V:1] [K:F][Q:1/4=80] $phrG |\\
[V:2] [K:F][Q:1/4=80] $phrF |\\"
		continue
	elif [ "$currMeas" == "32" ]; then
		catToFile "%32
[V:1] $phrG :|]
[V:2] $phrF :|]"
		continue
	else
		catToFile "%$currMeas 2-7,9-15,18-23,25-31
[V:1] $phrG |\\
[V:2] $phrF |\\"
	fi
done

# create SVG
abcm2ps ./$filen -O ./"knbgr-$fileInd-$fileInd2.svg" -g 

# create MIDI
/usr/bin/abc2midi ./$filen -quiet -silent -o ./"knbgr-$fileInd-$fileInd2.mid"
#
##
###
