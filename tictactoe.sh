#! /bin/bash/ 

echo "TicTakToe game"

array=(@ @ @ @ @ @ @ @ @ ) 

function playingBox()
{

	echo "0  ${array[0]} ${array[1]} ${array[2]}"
	echo "1  ${array[3]} ${array[4]} ${array[5]}"
	echo "2  ${array[6]} ${array[7]} ${array[8]}"
}

playingBox
