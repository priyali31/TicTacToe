#! /bin/bash 

echo "TicTakToe game"

function resetting()
{

  	player=1
	array=(@ @ @ @ @ @ @ @ @ )
	game_Position=1
}

function GamePlace()
{

         if [ $game_Position -eq 0 ]
                then
                        playingBox
			if [ $mode -eq 1 ] && [ $player -eq 2 ]
                        then
                                echo "computer won "
                        else
                                echo "player "$player "won"
			fi
                elif [ $game_Position -eq 2 ]
                then
                        playingBox
                        echo "tie"
                        game_Position=0
                else
                        player=$(( (( $player%2 ))+1 ))

			if [ $mode -eq 1 ] && [ $player -eq 2 ]
			then
				echo "computer can play now"
			else
                        	echo "player "$player "can play now"
                	fi
	fi
}

function checkGame()
{
	if [ ${array[$1]} != "@" ] && [ ${array[$1]} == ${array[$2]} ] && [ ${array[$2]} == ${array[$3]} ]
        then
                game_Position=0
        fi

}

function checkWinning()
{


	if [ $valueSet -eq 0 ]
	then
		if [ ${array[$1]} == $computerSymbol ] && [ ${array[$2]} == $computerSymbol ] && [ ${array[$3]} == "@" ]
		then 
			array[$3]=$computerSymbol
			valueSet=1
		elif [ ${array[$1]} == $computerSymbol ] && [ ${array[$2]} == "@" ] && [ ${array[$3]} == $computerSymbol ]
		then 
			array[$2]=$computerSymbol
			valueSet=1
		elif [ ${array[$1]} == "@" ] && [ ${array[$2]} == $computerSymbol ] && [ ${array[$3]} == $computerSymbol ]
		then
			array[$1]=$computerSymbol
			valueSet=1
		fi 
	fi

}

function blockGame()
{

	if [ $valueSet -eq 0 ]
        then

		if [ ${array[$1]} == $playerOneSymbol ] && [ ${array[$2]} == $playerOneSymbol ] && [ ${array[$3]} == "@" ]
        	then
        		array[$3]=$computerSymbol
			valueSet=1
        	elif [ ${array[$1]} == $playerOneSymbol ] && [ ${array[$2]} == "@" ] && [ ${array[$3]} == $playerOneSymbol ]
        	then
                	array[$2]=$computerSymbol
			valueSet=1
        	elif [ ${array[$1]} == "@" ] && [ ${array[$2]} == $playerOneSymbol ] && [ ${array[$3]} == $playerOneSymbol ]
        	then
                	array[$1]=$computerSymbol
			valueSet=1
        	fi
	fi
}

function checkCorners()
{

	if [ $valueSet -eq 0 ]
        then
        	if [ ${array[$1]} == "@" ]
        	then
        		array[$1]=$computerSymbol
			valueSet=1
        	elif [ ${array[$2]} == "@" ]
        	then
                	array[$2]=$computerSymbol
			valueSet=1
		elif [ ${array[$3]} == "@" ]
        	then
                	array[$3]=$computerSymbol
			valueSet=1
		elif [ ${array[$4]} == "@" ]
        	then
                	array[$4]=$computerSymbol
			valueSet=1
		fi
	fi
}

function checkSide()
{

        if [ $valueSet -eq 0 ]
        then
                if [ ${array[$1]} == "@" ]
                then
                        array[$1]=$computerSymbol
                        valueSet=1
                elif [ ${array[$2]} == "@" ]
                then
                        array[$2]=$computerSymbol
                        valueSet=1
                elif [ ${array[$3]} == "@" ]
                then
                        array[$3]=$computerSymbol
                        valueSet=1
                elif [ ${array[$4]} == "@" ]
                then
                        array[$4]=$computerSymbol
                        valueSet=1
                fi
        fi
}

function checkCentre()
{

	if [ $valueSet -eq 0 ]
        then
		if [ ${array[$1]} == "@" ]
		then
			array[$1]=$computerSymbol
			valueSet=1
		fi
	fi
}

function drawMatch()
{

	if [ ${array[0]} != "@" ] && [ ${array[1]} != "@" ] && [ ${array[2]} != "@" ] && [ ${array[3]} != "@" ] && [ ${array[4]} != "@" ] && 
		[ ${array[5]} != "@" ] && [ ${array[6]} != "@" ] && [ ${array[7]} != "@" ] && [ ${array[8]} != "@" ]
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

	echo "0   ${array[0]} ${array[1]} ${array[2]}"
	echo "1   ${array[3]} ${array[4]} ${array[5]}"
	echo "2   ${array[6]} ${array[7]} ${array[8]}"
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

	case $mode in
		1) if [ $(( $RANDOM%2 )) -eq 1 ]
	           then
			playerOneSymbol=X
                	computerSymbol=O
        	   else
                	playerOneSymbol=O
                	computerSymbol=X
        	   fi
        	   echo "player choosed  "$playerOneSymbol
       		   echo "computer choosed  "$computerSymbol 
		   ;;

        	2) if [ $(( $RANDOM%2 )) -eq 1 ]
        	   then
                	playerOneSymbol=X
			playerTwoSymbol=O
        	   else
			playerOneSymbol=O
                	playerTwoSymbol=X
        	   fi
        	   echo "player one choosed "$playerOneSymbol
		   echo "player two choosed "$playerTwoSymbol 
		   ;;
	esac
}

function setBox()
{

	arrayId=$(( $(( $1-1 )) * 3 + $(( $2-1)) ))

	if [ ${array[$arrayId]} == "@" ]
	then
		array[$arrayId]=$3
	else
		echo "cannot place there"
	fi
}

function computerEnters()
{

	valueSet=0
	valueSet=0

	checkWinning 0 1 2
        checkWinning 3 4 5
        checkWinning 6 7 8
        checkWinning 0 3 6
        checkWinning 1 4 7
        checkWinning 2 5 8
        checkWinning 0 4 8
        checkWinning 2 4 6

	blockGame 0 1 2
        blockGame 3 4 5
        blockGame 6 7 8
        blockGame 0 3 6
        blockGame 1 4 7
        blockGame 2 5 8
        blockGame 0 4 8
        blockGame 2 4 6

	checkCorners 0 2 6 8

	checkCentre 4

	checkSide 1 3 5 7
}

function playerEnters()
{
	if [ $player -eq 1 ]
	then
		player_Symbol=$playerOneSymbol
	else
		player_Symbol=$playerTwoSymbol
	fi
		echo "enter row and column"
		read -r command row column

		if [ $command == "set" ]
		then
			setBox $row $column $player_Symbol
		else
			echo "enter a valid input"
			playerEnters
		fi

}

function playerOption()
{
	case $mode in
		1) if [ $player -eq 1 ]
		   then
			playerEnters
		   else
			computerEnters
		   fi ;;
		2) playerEnters
	esac
}

function Options()
{
	echo "options: "
	echo "1. computer"
	echo "2. between players"
	read -r mode
}

function ComputerGame()
{

 	if [ $player -eq 2 ]
        then
               	echo "computer can play now"
        else
                echo "player can play now"
        fi

        while [ $game_Position -eq 1 ]
        do
                playingBox
                playerOption
                checkBox
                GamePlace
        done
}

function gameBegins()
{

	computerChoice=nothing
	resetting
	Options
        symbols
	toss

	if [ $mode -eq 1 ]
	then
		ComputerGame
	else
	        echo "player "$player "can play now"

		while [ $game_Position -eq 1 ]
		do
        		playingBox
			playerEnters
			checkBox
			GamePlace
		done
	fi
}

gameBegins
