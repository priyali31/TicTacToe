#! /bin/bash/


echo "Welcome to TicTakToe game"

player=1

array=(@ @ @ @ @ @ @ @ @)

function playingBox()
{

	echo "row 0  ${array[0]} ${array[1]} ${array[2]}"
	echo "row 1  ${array[3]} ${array[4]} ${array[5]}"
	echo "row 2  ${array[6]} ${array[7]} ${array[8]}"
}

function toss()
{

echo "Options:"
echo "1. Up"
echo "2. Down"

	read -r tossOption

	tossNum=$(( (( $RANDOM%2 ))+1 ))

	if [ $tossNum -eq $tossOption ]
	then
		echo "player won toss"
	else
		echo "player lost toss"
		player=$(( (( $player%2 ))+1 ))
	fi

	playingBox
}

function symbols()
{

        if [ $(( $RANDOM%2 )) -eq 1 ]
        then
                player_Symbol=X
        else
                player_Symbol=O
        fi

        echo "player symbol is : "$player_Symbol

        toss
}

symbols
