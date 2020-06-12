#! /bin/bash 

echo "TicTakToe game"

function resetting()
{

player=1
array=(@ @ @ @ @ @ @ @ @ )

game_Position=1

}

function checkGame()
{
	if [ ${array[$1]} != "@" ] && [ ${array[$1]} == ${array[$2]} ] && [ ${array[$2]} == ${array[$3]} ]
	then
		game_Position=0
	fi
}

function drawMatch()
{

	if [ ${array[0]} != "@" ] && [ ${array[1]} != "@" ] && [ ${array[2]} != "@" ] && [ ${array[3]} != "@" ] && [ ${array[4]} != "@" ] && [ ${array[5]} != "@" ] && [ ${array[6]} != "@" ] && [ ${array[7]} != "@" ] && [ ${array[8]} != "@" ]
	then
		game_Position=2
	fi
}

function checkBox()
{

	drawMatch
	checkGame 0 1 2
	checkGame 3 4 5
	checkGame 6 7 8
	checkGame 0 3 6
	checkGame 1 4 7
	checkGame 2 5 8
	checkGame 0 4 8
	checkGame 2 4 6
}

function playingBox()
{

echo "row 0   ${array[0]} ${array[1]} ${array[2]}"
echo "row 1   ${array[3]} ${array[4]} ${array[5]}"
echo "row 2   ${array[6]} ${array[7]} ${array[8]}"
}

function toss()
{

echo "Option :"
echo "1. Up"
echo "2. Down"

	read -r tossOption

	tossNum=$(( (( $RANDOM%2 ))+1 ))

	if [ $tossNum -eq $tossOption ]
	then
		echo "player won toss"
	elif [ $tossNum -ne $tossOption ] && [ $tossOption -lt 3 ]
	then
		echo "player lost toss"
		player=$(( (($player%2)) + 1 ))
	else
		echo "enter valid input"
		toss
	fi

}

function symbols()
{

        if [ $(( $RANDOM%2 )) -eq 1 ]
        then
                playerOneSymbol=X
		playerTwoSymbol=O
        else
		playerOneSymbol=O
                playerTwoSymbol=X
        fi

        echo "player one choosed "$playerOneSymbol
	echo "player two choosed "$playerTwoSymbol

        toss
}

function setBox()
{

	arrayId=$(( $(( $1-1 )) * 3 + $(( $2-1)) ))

	if [ ${array[$arrayId]}=="@" ]
	then
		array[$arrayId]=$3
	else
		echo "cannot enter"
	fi
}


function input()
{

	if [ $player -eq 1 ]
	then
		player_Symbol=$playerOneSymbol
	else
		player_Symbol=$playerTwoSymbol
	fi

		echo "Enter row and column: "
		read -r command row column

		if [ $command == "set" ]
		then
			setBox $row $column $player_Symbol
		else
			echo "enter a valid input"
			input
		fi

}

function gameBegins()
{
	resetting
        symbols

        echo "player "$player "can play now"

	while [ $game_Position -eq 1 ]
	do
        	playingBox
		input
		checkBox

		if [ $game_Position -eq 0 ]
		then 
			playingbox
			echo "player "$player "won "
		elif [ $game_Position -eq 2 ]
		then
			playing_Box
			echo "tie"
			game_Position=0
		else
			player=$(( (( $player%2 ))+1 ))

			echo "player "$player "can play now"
		fi
	done
}

gameBegins
