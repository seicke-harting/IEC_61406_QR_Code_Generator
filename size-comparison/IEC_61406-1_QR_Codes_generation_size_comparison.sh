#!/bin/bash

# Script for generating IEC 61406-1 compliant QR codes based on different
# URIs to compare the QR code sizes

character_array=("a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "v" "r" "v" "s" "t" "u" "v" "w" "x" "y" "z" "1" "2" "3" "4" "5" "6" "7" "8" "9" "0")

for ((character_number = 1; character_number <= 255; character_number++));
do

	# Generating identification link string
	identification_link_string=""
	for ((i = 0; i < character_number; i++));
	do
		identification_link_string+="${character_array[$i%${#character_array[@]}]}"
	done

	echo "$identification_link_string $character_number"
  ../IEC_61406-1_QR_Code_Generator.sh "$identification_link_string" "./png/$character_number.png" --verbose

done

#uris=(
#      "a"
#      "ab"
#      "abc"
#      "abcd"
#      "abcde"
#      "abcdef"
#      "abcdefg"
#      "abcdefgh"
#      "abcdefghi"
#      "abcdefghij"
#      "abcdefghijk"
#      "abcdefghijkl"
#      "abcdefghijklm"
#      "abcdefghijklmn"
#      "abcdefghijklmno"
#      "abcdefghijklmnop"
#      "abcdefghijklmnopq"
#      "abcdefghijklmnopqr"
#      "abcdefghijklmnopqrs"
#      "abcdefghijklmnopqrst"
#      "abcdefghijklmnopqrstu"
#      "abcdefghijklmnopqrstuv"
#      "abcdefghijklmnopqrstuvw"
#      "abcdefghijklmnopqrstuvwx"
#      "abcdefghijklmnopqrstuvwxy"
#      "abcdefghijklmnopqrstuvwxyz"
#      "abcdefghijklmnopqrstuvwxyz1"
#      "abcdefghijklmnopqrstuvwxyz12"
#      "abcdefghijklmnopqrstuvwxyz123"
#      "abcdefghijklmnopqrstuvwxyz1234"
#      "abcdefghijklmnopqrstuvwxyz12345"
#      "abcdefghijklmnopqrstuvwxyz123456"
#      "abcdefghijklmnopqrstuvwxyz1234567"
#      "abcdefghijklmnopqrstuvwxyz12345678"
#      "abcdefghijklmnopqrstuvwxyz123456789"
#      "abcdefghijklmnopqrstuvwxyz1234567890"
#      "abcdefghijklmnopqrstuvwxyz1234567890+"
#      "abcdefghijklmnopqrstuvwxyz1234567890+-"
#      "abcdefghijklmnopqrstuvwxyz1234567890+-*"
#      "abcdefghijklmnopqrstuvwxyz1234567890+-*/"
#      "abcdefghijklmnopqrstuvwxyz1234567890+-*/!"
#      "abcdefghijklmnopqrstuvwxyz1234567890+-*/!?"
#      "abcdefghijklmnopqrstuvwxyz1234567890+-*/!?="
#      "abcdefghijklmnopqrstuvwxyz1234567890+-*/!?=("
#      "abcdefghijklmnopqrstuvwxyz1234567890+-*/!?=()"
#      "abcdefghijklmnopqrstuvwxyz1234567890+-*/!?=(){"
#      "abcdefghijklmnopqrstuvwxyz1234567890+-*/!?=(){}"
#      "abcdefghijklmnopqrstuvwxyz1234567890+-*/!?=(){}["
#      "abcdefghijklmnopqrstuvwxyz1234567890+-*/!?=(){}[]"
#      "abcdefghijklmnopqrstuvwxyz1234567890+-*/!?=(){}[]"
#      "abcdefghijklmnopqrstuvwxyz1234567890+-*/!?=(){}[]ß"
#      "abcdefghijklmnopqrstuvwxyz1234567890+-*/!?=(){}[]ß/"
#      "abcdefghijklmnopqrstuvwxyz1234567890+-*/!?=(){}[]ß/&"
#      "abcdefghijklmnopqrstuvwxyz1234567890+-*/!?=(){}[]ß/&%"
#      "abcdefghijklmnopqrstuvwxyz1234567890+-*/!?=(){}[]ß/&%§"
#      "abcdefghijklmnopqrstuvwxyz1234567890+-*/!?=(){}[]ß/&%§'"
#      "abcdefghijklmnopqrstuvwxyz1234567890+-*/!?=(){}[]ß/&%§'#"
#      "abcdefghijklmnopqrstuvwxyz1234567890+-*/!?=(){}[]ß/&%§'#*"
#      "abcdefghijklmnopqrstuvwxyz1234567890+-*/!?=(){}[]ß/&%§'#*~"
#      "abcdefghijklmnopqrstuvwxyz1234567890+-*/!?=(){}[]ß/&%§'#*~¡"
#      "abcdefghijklmnopqrstuvwxyz1234567890+-*/!?=(){}[]ß/&%§'#*~¡“"
#      "abcdefghijklmnopqrstuvwxyz1234567890+-*/!?=(){}[]ß/&%§'#*~¡“¶"
#      "abcdefghijklmnopqrstuvwxyz1234567890+-*/!?=(){}[]ß/&%§'#*~¡“¶¢"
#      "abcdefghijklmnopqrstuvwxyz1234567890+-*/!?=(){}[]ß/&%§'#*~¡“¶¢|"
#      "abcdefghijklmnopqrstuvwxyz1234567890+-*/!?=(){}[]ß/&%§'#*~¡“¶¢|≠"
#      "abcdefghijklmnopqrstuvwxyz1234567890+-*/!?=(){}[]ß/&%§'#*~¡“¶¢|≠¿"
#      "abcdefghijklmnopqrstuvwxyz1234567890+-*/!?=(){}[]ß/&%§'#*~¡“¶¢|≠¿<"
#      "abcdefghijklmnopqrstuvwxyz1234567890+-*/!?=(){}[]ß/&%§'#*~¡“¶¢|≠¿<>"
#      "abcdefghijklmnopqrstuvwxyz1234567890+-*/!?=(){}[]ß/&%§'#*~¡“¶¢|≠¿<>≤"
#)

#for i in ${!uris[@]}; do
#  characters=${#uris[$i]}
#  ../IEC_61406-1_QR_Code_Generator.sh "${uris[$i]}" "./png/$characters" --verbose
#done