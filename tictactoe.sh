#! /bin/bash
echo "Welcome to TicTakToe game"

function resetting()
{

        player=1
        array=(@ @ @ @ @ @ @ @ @ )
        gamePosition=1
}

function gamePlace()
{

         if [ $gamePosition -eq 0 ]
         then
                        playingBox
                        if [ $mode -eq 1 ] && [ $player -eq 2 ]
                         then
                                echo "computer won "
                        else
                                echo "player "$player "won "
                        fi
                elif [ $gamePosition -eq 2 ]
                then
                        playingBox
                        echo "tie"
                        gamePosition=0
                else
                        player=$(( (( $player%2 ))+1 ))

                        if [ $mode -eq 1 ] && [ $player -eq 2 ]
                        then
                                echo "computer play"
                        else
                                echo "player "$player "play"
                        fi
        fi
}

function columnChecking()
{

                for (( i=0; i<3; i++ ))
                do
                        j=0
                        if [ ${array[$(( $j *3 + $i ))]} != "@" ] && [ ${array[$(( $j *3 + $i ))]} == ${array[$(( $j+1 *3 + $i ))]} ] && [ ${array[$(( $j+1 *3 + $i ))]} == ${array[$(( $j+2 *3 + $i ))]} ]
                        then
                                gamePosition=0
                        fi
                done
}

function rowChecking()
{

                for (( i=0; i<3; i++ ))
                do
                        j=0
                        if [ ${array[$(( $i *3 + $j ))]} != "@" ] && [ ${array[$(( $i *3 + $j ))]} == ${array[$(( $i *3 + $j+1 ))]} ] && [ ${array[$(( $i *3 + $j+1 ))]} == array[$(( $i *3 + $j+2 ))]} ]
                        then
                                gamePosition=0
                        fi
                done
}

function diagonalChecking()
{
        if [ ${array[0]} != "@" ] && [ ${array[0]} == ${array[4]} ] && [ ${array[4]} == ${array[8]} ]
        then
                gamePosition=0
        elif [ ${array[2]} != "@" ] && [ ${array[2]} == ${array[4]} ] && [ ${array[4]} == ${array[6]} ]
        then
                gamePosition=0

        fi
}

function computerToWinRow()
{

        for (( i=0; i<3; i++ ))
        do
                j=0
                if [ $valueSet -eq 0 ]
                then
                        if [ ${array[$(( $i *3 + $j ))]} == $computerSymbol ] && [ ${array[$(( $i *3 + $j+1 ))]} == $computerSymbol ] && [ ${array[$(( $i *3 + $j+2 ))]} == "@" ]
                        then
                                array[$(( $i *3 + $j+2 ))]=$computerSymbol
                                valueSet=1
                        elif [ ${array[$(( $i *3 + $j ))]} == $computerSymbol ] && [ ${array[$(( $i *3 + $j+1 ))]} == "@" ] && [ ${array[$(( $i *3 + $j+2 ))]} == $computerSymbol ]
                        then
                                array[$(( $i *3 + $j+1 ))]=$computerSymbol
                                valueSet=1
                        elif [ ${array[$(( $i *3 + $j ))]} == "@" ] && [ ${array[$(( $i *3 + $j+1 ))]} == $computerSymbol ] && [ ${array[$(( $i *3 + $j+2 ))]} == $computerSymbol ]
                        then
                                array[$(( $i *3 + $j ))]=$computerSymbol
                                valueSet=1
                        fi
                fi
        done
}

function computerToWinColumn()
{

        for (( i=0; i<3; i++ ))
        do
                j=0
                if [ $valueSet -eq 0 ]
                then
                        if [ ${array[$(( $j *3 + $i ))]} == $computerSymbol ] && [ ${array[$(( $j+1 *3 + $i ))]} == $computerSymbol ] && [ ${array[$(( $j+2 *3 + $i ))]} == "@" ]
                        then
                                array[$(( $j+2 *3 + $i ))]=$computerSymbol
                                valueSet=1
                        elif [ ${array[$(( $j *3 + $i ))]} == $computerSymbol ] && [ ${array[$(( $j+1 *3 + $i ))]} == "@" ] && [ ${array[$(( $j+2 *3 + $i ))]} == $computerSymbol ]
                        then
                                array[$(( $j+1 *3 + $i ))]=$computerSymbol
                                valueSet=1
                        elif [ ${array[$(( $j *3 + $i ))]} == "@" ] && [ ${array[$(( $j+1 *3 + $i ))]} == $computerSymbol ] && [ ${array[$(( $j+2 *3 + $i ))]} == $computerSymbol ]
                        then
                                array[$(( $j *3 + $i ))]=$computerSymbol
                                valueSet=1
                        fi
                fi
        done
}

function computerToWinDiagonal()
{

        if [ $valueSet -eq 0 ]
        then
                if [ ${array[0]} == $computerSymbol ] && [ ${array[4]} == $computerSymbol ] && [ ${array[8]} == "@" ]
                then
                        array[8]=$computerSymbol
                        valueSet=1
                elif [ ${array[0]} == $computerSymbol ] && [ ${array[4]} == "@" ] && [ ${array[8]} == $computerSymbol ]
                then
                        array[4]=$computerSymbol
                        valueSet=1
                elif [ ${array[0]} == "@" ] && [ ${array[4]} == $computerSymbol ] && [ ${array[8]} == $computerSymbol ]
                then
                        array[0]=$computerSymbol
                        valueSet=1
                elif [ ${array[2]} == $computerSymbol ] && [ ${array[4]} == $computerSymbol ] && [ ${array[6]} == '@' ]
                then
                        array[6]=$computerSymbol
                        valueSet=1
                elif [ ${array[2]} == $computerSymbol ] && [ ${array[4]} == "@" ] && [ ${array[6]} == $computerSymbol ]
                then
                        array[4]=$computerSymbol
                        valueSet=1
                elif [ ${array[2]} == "@" ] && [ ${array[4]} == $computerSymbol ] && [ ${array[6]} == $computerSymbol ]
                then
                        array[2]=$computerSymbol
                        valueSet=1
                fi
        fi
}

function computerToBlockRow()
{
        for (( i=0; i<3; i++ ))
        do
                j=0
         if [ $valueSet -eq 0 ]
                then
                        if [ ${array[$(( $i *3 + $j ))]} == $playerOneSymbol ] && [ ${array[$(( $i *3 + $j+1 ))]} == $playerOneSymbol ] && [ ${array[$(( $i *3 + $j+2 ))]} == "@" ]
                        then
                                array[$(( $i *3 + $j+2 ))]=$computerSymbol
                                valueSet=1

                        elif [ ${array[$(( $i *3 + $j ))]} == $playerOneSymbol ] && [ ${array[$(( $i *3 + $j+1 ))]} == "@" ] && [ ${array[$((  $i *3 + $j+2 ))]} == $playerOneSymbol ]
                        then
                                array[$(( $i *3 + $j+1 ))]=$computerSymbol
                                valueSet=1

                        elif [ ${array[$(( $i *3 + $j ))]} == "@" ] && [ ${array[$(( $i *3 + $j+1 ))]} == $playerOneSymbol ] && [ ${array[$((  $i *3 + $j+2 ))]} == $playerOneSymbol ]
                        then
                                array[$(( $i *3 + $j ))]=$computerSymbol
                                valueSet=1

                        fi
                fi
        done
}

function computerToBlockColumn()
{

        for (( i=0; i<3; i++ ))
        do
                j=0
                if [ $valueSet -eq 0 ]
                then
                        if [ ${array[$(( $j *3 + $i ))]} == $playerOneSymbol ] && [ ${array[$(( $j+1 *3 + $i ))]} == $playerOneSymbol ] && [ ${array[$(( $j+2 *3 + $i ))]} == "@" ]
                        then
                                array[$(( $j+2 *3 + $i ))]=$computerSymbol
                                valueSet=1
                        elif [ ${array[$(( $j *3 + $i ))]} == $playerOneSymbol ] && [ ${array[$(( $j+1 *3 + $i ))]} == "@" ] && [ ${array[$(( $j+2 *3 + $i ))]} == $playerOneSymbol ]
                        then
                                array[$(( $j+1 *3 + $i ))]=$computerSymbol
                                valueSet=1
                        elif [ ${array[$(( $j *3 + $i ))]} == "@" ] && [ ${array[$(( $j+1 *3 + $i ))]} == $playerOneSymbol ] && [ ${array[$(( $j+2  *3 + $i ))]} == $playerOneSymbol ]
                        then
                                array[$(( $j *3 + $i ))]=$computerSymbol
                                valueSet=1

                        fi
                fi
        done
}

function computerToBlockDiagonal()
{

        if [ $valueSet -eq 0 ]
        then
                if [ ${array[0]} == $playerOneSymbol ] && [ ${array[4]} == $playerOneSymbol ] && [ ${array[8]} == "@" ]
                then
                        array[8]=$computerSymbol
                        valueSet=1
                elif [ ${array[0]} == $playerOneSymbol ] && [ ${array[4]} == "@" ] && [ ${array[8]} == $playerOneSymbol ]
                then
                        array[4]=$computerSymbol
                        valueSet=1
                elif [ ${array[0]} == "@" ] && [ ${array[4]} == $playerOneSymbol ] && [ ${array[8]} == $playerOneSymbol ]
                then
                        array[0]=$computerSymbol
                        valueSet=1
                elif [ ${array[2]} == $playerOneSymbol ] && [ ${array[4]} == $playerOneSymbol ] && [ ${array[6]} == "@" ]
                then
                        array[6]=$computerSymbol
                        valueSet=1
                elif [ ${array[2]} == $playerOneSymbol ] && [ ${array[4]} == "@" ] && [ ${array[6]} == $playerOneSymbol ]
                then
                        array[4]=$computerSymbol
                        valueSet=1
                elif [ ${array[2]} == "@" ] && [ ${array[4]} == $playerOneSymbol ] && [ ${array[6]} == $playerOneSymbol ]
                then
                        array[2]=$computerSymbol
                        valueSet=1
                fi
        fi
}

function checkForCorner()
{
        for (( i=0; i<3; i=$(( $i+2 )) ))
        do
                if [ $valueSet -eq 0 ]
                then
                        j=0
                        if [ ${array[$(( $i *3 + $j ))]} == "@" ]
                        then
                                array[$(( $i *3 + $j ))]=$computerSymbol
                                valueSet=1
                        elif [ ${array[$(( $i *3 + $j+2 ))]} == "@" ]
                       then
                                array[$(( $i *3 + $j+2 ))]=$computerSymbol
                                valueSet=1

                        fi
                fi
        done

}

function checkForSide()
{

        for (( i=0; i<3; i++ ))
        do
                if [ $valueSet -eq 0 ]
                then
                        j=1
                        if [ ${array[$(( $i *3 + $j ))]} == "@" ]
                        then
                                array[$(( $i *3 + $j ))]=$computerSymbol
                                valueSet=1
                        elif [ ${array[$(( $i+1 *3 + $j-1 ))]} == "@" ]
                        then
                                array[$(( $i+1 *3 + $j-1 ))]=$computerSymbol
                                valueSet=1
                        fi
                        j=$(( $j+2 ))
                fi
        done
}
function checkForCentre()
{

        if [ $valueSet -eq 0 ]
        then
                if [ ${array[4]} == "@" ]
                then
                        array[4]=$computerSymbol
                        valueSet=1
                fi
        fi
}

function checkingTie()
{

        if [ ${array[0]} != "@" ] && [ ${array[1]} != "@" ] && [ ${array[2]} != "@" ] && [ ${array[3]} != "@" ] && [ ${array[4]} != "@" ] &&
                [ ${array[5]} != "@" ] && [ ${array[6]} != "@" ] && [ ${array[7]} != "@" ] && [ ${array[8]} != "@" ]
        then
                gamePosition=2
        fi
}

function checkBox()
{

        checkingTie
        rowChecking
        columnChecking
        diagonalChecking
}

function playingBox()
{
        echo "1 - | ${array[0]} ${array[1]} ${array[2]} |"
        echo "2 - | ${array[3]} ${array[4]} ${array[5]} |"
        echo "3 - | ${array[6]} ${array[7]} ${array[8]} |"
}

function toss()
{

        echo "Options :"

        echo "1. Head"

        echo "2. Tails"

        read -r tossOption

        tossNum=$(( (( $RANDOM%2 ))+1 ))

        if [ $tossNum -eq $tossOption ]
        then
                echo "player won the toss"
        elif [ $tossNum -ne $tossOption ] && [ $tossOption -lt 3 ]
        then
                echo "player lost toss"
                player=$(( (( $player%2 ))+1 ))
        else
                echo "enter valid input"
                toss
        fi

}

function symbol()
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
                   echo "player one symbol : "$playerOneSymbol
                   echo "computer symbol : "$computerSymbol
                   ;;

                2) if [ $(( $RANDOM%2 )) -eq 1 ]
                   then
                        playerOneSymbol=X
                        playerTwoSymbol=O
                   else
                        playerOneSymbol=O
                        playerTwoSymbol=X
                   fi
                   echo "player one symbol  : "$playerOneSymbol
                   echo "player two symbol  : "$playerTwoSymbol
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
                echo "invalid placing"
                player=$(( (( $player%2 ))+1 ))
        fi
}

function computerEnters()
{

        valueSet=0

        computerToWinRow
        computerToWinColumn
        computerToWinDiagonal
        computerToBlockRow
        computerToBlockColumn
        computerToBlockDiagonal
        checkForCorner
        checkForCentre
        checkForSide
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

        echo "Option: "
        echo "1. Play with computer"
        echo "2. Between 2 players"

        read -r mode
}

function computerGame()
{

        if [ $player -eq 2 ]
        then
                echo "computer turn"
        else
                echo "player turn"
        fi

        while [ $gamePosition -eq 1 ]
        do
                playingBox
                playerOption
                checkBox
                gamePlace
        done
}

function gameBegins()
{
        resetting
        Options
        symbol
        toss

        if [ $mode -eq 1 ]
        then
                computerGame
        else
                echo "player "$player "turn"

                while [ $gamePosition -eq 1 ]
                do
                        playingBox
                        playerEnters
                        checkBox
                        gamePlace
                done
        fi
}
gameBegins

