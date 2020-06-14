#!/bin/bash

echo "Welcome to TicTacToe"

#constants
NUM_OFROWS=3
NUM_OFCOLUMNS=3
LENGTH=$(( $NUM_OFROWS * $NUM_OFCOLUMNS ))

#variables
cell=1

declare -A board

function resetBoard()
{
   for ((i=0; i<NUM_OFROWS; i++))
   do
      for ((j=0; j<NUM_OFCOLUMNS; j++))
      do
         board[$i,$j]=$EMPTY
         board[$i,$j]=$cell
         ((cell++))

          done
   done
}

function assigningSymbol()
{
   if [ $(( RANDOM%2 )) -eq 1 ]
   then
      PLAYER_SYM=X
      COMP_SYM=O
   else
      COMP_SYM=X
      PLAYER_SYM=O
   fi
   echo "Player's Symbol - $PLAYER_SYM"
}

function toss()
{
   if [ $(( RANDOM%2 )) -eq 1 ]
   then
      playerTurn=1
      echo "Player's turn"
   else
      playerTurn=0
      echo "Computer's turn"
   fi
}

function displayBoard()
{
   echo "##### TicTacToe Board #####"
   local i=0
   local j=0
   for (( i=0; i<NUM_OFROWS; i++ ))
   do
      for (( j=0; j<NUM_OFCOLUMNS; j++ ))
      do
         echo -n "|   ${board[$i,$j]}   |"
      done
         printf "\n"
   done
}

function inputToBoard()
{
 for (( i=0; i<$LENGTH; i++))
   do
      echo "###########################"
      displayBoard
      if [ $playerTurn -eq 1 ]
      then
      read  -p "Choose one cell for input : " playerCell

         if [ $playerCell -gt $LENGTH ]
         then
            echo "Invalid move, Select valid cell"
            printf "\n"
         else
            rowIndex=$(( $playerCell / $NUM_OFROWS ))
               if [ $(( $playerCell % $NUM_OFROWS )) -eq 0 ]
               then
                  rowIndex=$(( $rowIndex - 1 ))
               fi

            columnIndex=$(( $playerCell %  $NUM_OFCOLUMNS ))
               if [ $columnIndex -eq 0 ]
               then
                  columnIndex=$(( $columnIndex + 2 ))
               fi

            board[$rowIndex,$columnIndex]=$PLAYER_SYM
            playerTurn=0
               if [ $(checkWinner $PLAYER_SYM) -eq 1  ]
                  then
                     echo "You Won"
                     return 0
               fi
         fi

      else
         echo "#### Computer's Turn ######"
        checkingWinningRowsForComputer
	checkingWinningColumnsForComputer
       	checkingWinningDiagonalForComputer
         if [ $(checkWinner $COMP_SYM) -eq 1  ]
         then
            echo "Computer Won"
            return 0
         fi
         computerCheckingPlayerWinningRowsForBlocking
         computerCheckingPlayerWinningColumnsForBlocking
	 computerCheckingPlayerWinningDiagonalForBlocking

         if [[ $cellBlocked == true ]]
         then
            cellBlocked=false
         else
            checkCornersCenterSidesAvailability
            if [ $isCornerAvailable == true ] || [ $isCenterAvailable == true ] || [ $isSideAvailable == true ]
               then
                  isCornerAvailable=false
                  isCenterAvailable=false
                  isSideAvailable=false
            fi
         fi
         playerTurn=1
      fi
   done
   echo "Match Tie"

}


function checkWinner()
{
   local symbol=$1

   if [ ${board[0,0]} == $symbol ] && [ ${board[0,1]} == $symbol ] && [ ${board[0,2]} == $symbol ]
   then
      echo 1
   elif [ ${board[1,0]} == $symbol ] && [ ${board[1,1]} == $symbol ] && [ ${board[1,2]} == $symbol ]
   then
      echo 1
   elif [ ${board[2,0]} == $symbol ] && [ ${board[2,1]} == $symbol ] && [ ${board[2,2]} == $symbol ]
   then
      echo 1
   elif [ ${board[0,0]} == $symbol ] && [ ${board[1,0]} == $symbol ] && [ ${board[2,0]} == $symbol ]
   then
      echo 1
   elif [ ${board[0,1]} == $symbol ] && [ ${board[1,1]} == $symbol ] && [ ${board[2,1]} == $symbol ]
   then
      echo 1
   elif [ ${board[0,2]} == $symbol ] && [ ${board[1,2]} == $symbol ] && [ ${board[2,2]} == $symbol ]
   then
      echo 1
   elif [ ${board[0,0]} == $symbol ] && [ ${board[1,1]} == $symbol ] && [ ${board[2,2]} == $symbol ]
   then
      echo 1
   elif [ ${board[2,0]} == $symbol ] && [ ${board[1,1]} == $symbol ] && [ ${board[0,2]} == $symbol ]
   then
      echo 1
   else
      echo 0
   fi
}


function  computerCheckingPlayerWinningRowsForBlocking()
{
#Rows
   if [[ $cellBlocked == false ]]
   then
      for ((row=0; row<NUM_OFROWS; row++))
      do
         if [ ${board[$row,$col]} == $PLAYER_SYM ] && [ ${board[$(($row)),$(($col+1))]} == $PLAYER_SYM ]
         then
           if [ ${board[$row,$(($col+2))]} != $COMP_SYM ]
           then
              board[$row,$(($col+2))]=$COMP_SYM
              cellBlocked=true
              break
           fi
         elif [ ${board[$row,$(($col+1))]} == $PLAYER_SYM ] && [ ${board[$row,$(($col+2))]} == $PLAYER_SYM ]
         then
            if [ ${board[$row,$col]} != $COMP_SYM ]
            then
               board[$row,$col]=$COMP_SYM
               cellBlocked=true
               break
            fi
         elif [ ${board[$row,$col]} == $PLAYER_SYM ] && [ ${board[$row,$(($col+2))]} == $PLAYER_SYM ]
         then
            if [ ${board[$row,$(($col+1))]} != $COMP_SYM ]
            then
               board[$row,$(($col+1))]=$COMP_SYM
               cellBlocked=true
               break
            fi
         fi
      done
   fi

}
function  computerCheckingPlayerWinningColumnsForBlocking()
{
#Columns
   if [[ $cellBlocked == false ]]
   then
      for ((col=0; col<NUM_OFCOLUMNS; col++))
      do
         if [ ${board[$row,$col]} == $PLAYER_SYM ] &&  [ ${board[$(($row+1)),$col]} == $PLAYER_SYM ]
         then
            if [ ${board[$(($row+2)),$col]} != $COMP_SYM ]
            then
               board[$(($row+2)),$col]=$COMP_SYM
               cellBlocked=true
               break
            fi
         elif [ ${board[$(($row+1)),$col]} == $PLAYER_SYM ] && [ ${board[$(($row+2)),$col]} == $PLAYER_SYM ]
         then
            if [ ${board[$row,$col]} != $COMP_SYM ]
            then
               board[$row,$col]=$COMP_SYM
               cellBlocked=true
               break
            fi
         elif [ ${board[$row,$col]} == $PLAYER_SYM ] && [ ${board[$(($row+2)),$col]} == $PLAYER_SYM ]
         then
            if [ ${board[$(($row+1)),$col]} != $COMP_SYM ]
            then
               board[$(($row+1)),$col]=$COMP_SYM
               cellBlocked=true
               break
            fi
         fi
      done
   fi
}
function  computerCheckingPlayerWinningDiagonalForBlocking()
{
#Diagonal
   if [[ $cellBlocked == false ]]
   then
      if [ ${board[$row,$col]} == $PLAYER_SYM ] &&  [ ${board[$(($row+1)),$(($col+1))]} == $PLAYER_SYM ]
      then
         if [ ${board[$(($row+2)),$(($col+2))]} != $COMP_SYM ]
         then
            board[$(($row+2)),$(($col+2))]=$COMP_SYM
            cellBlocked=true
            return
         fi
      elif [ ${board[$(($row+1)),$(($col+1))]} == $PLAYER_SYM ] && [ ${board[$(($row+2)),$(($col+2))]} == $PLAYER_SYM ]
      then
         if [ ${board[$row,$col]} != $COMP_SYM ]
         then
            board[$row,$col]=$COMP_SYM
            cellBlocked=true
            return
          fi
      elif [ ${board[$row,$col]} == $PLAYER_SYM ] && [ ${board[$(($row+2)),$(($col+2))]} == $PLAYER_SYM ]
      then
         if [ ${board[$(($row+1)),$(($col+1))]} != $COMP_SYM ]
         then
            board[$(($row+1)),$(($col+1))]=$COMP_SYM
            cellBlocked=true
            return
          fi
      elif [ ${board[$(($row+2)),$col]} == $PLAYER_SYM ] &&  [ ${board[$(($row+1)),$(($col+1))]} == $PLAYER_SYM ]
      then
         if [ ${board[$row,$(($col+2))]} != $COMP_SYM ]
         then
            board[$row,$(($col+2))]=$COMP_SYM
            cellBlocked=true
            return
          fi
      elif [ ${board[$(($row+1)),$(($col+1))]} == $PLAYER_SYM ] && [ ${board[$row,$(($col+2))]} == $PLAYER_SYM ]
      then
         if [ ${board[$(($row+2)),$col]} != $COMP_SYM ]
         then
            board[$(($row+2)),$col]=$COMP_SYM
            cellBlocked=true
            return
          fi
      elif [ ${board[$(($row+2)),$col]} == $PLAYER_SYM ] && [ ${board[$row,$(($col+2))]} == $PLAYER_SYM ]
      then
         if [ ${board[$(($row+1)),$(($col+1))]} != $COMP_SYM ]
         then
            board[$(($row+1)),$(($col+1))]=$COMP_SYM
            cellBlocked=true
            return
         fi
      fi
   fi
}


function checkingWinningRowsForComputer()
{
#Rows
   for ((row=0; row<NUM_OFROWS; row++))
   do
      if [ ${board[$row,$col]} == $COMP_SYM ] && [ ${board[$(($row)),$(($col+1))]} == $COMP_SYM ]
      then
         if [ ${board[$row,$(($col+2))]} != $PLAYER_SYM ]
          then
             board[$row,$(($col+2))]=$COMP_SYM
             break
          fi
      elif [ ${board[$row,$(($col+1))]} == $COMP_SYM ] && [ ${board[$row,$(($col+2))]} == $COMP_SYM ]
      then
          if [ ${board[$row,$col]} != $PLAYER_SYM ]
          then
             board[$row,$col]=$COMP_SYM
             break
          fi
      elif [ ${board[$row,$col]} == $COMP_SYM ] && [ ${board[$row,$(($col+2))]} == $COMP_SYM ]
      then
          if [ ${board[$row,$(($col+1))]} != $PLAYER_SYM ]
          then
             board[$row,$(($col+1))]=$COMP_SYM
             break
          fi
      fi
   done
}
function checkingWinningColumnsForComputer()
{
#Columns
   for ((col=0; col<NUM_OFCOLUMNS; col++))
   do
      if [ ${board[$row,$col]} == $COMP_SYM ] &&  [ ${board[$(($row+1)),$col]} == $COMP_SYM ]
      then
         if [ ${board[$(($row+2)),$col]} != $PLAYER_SYM ]
         then
            board[$(($row+2)),$col]=$COMP_SYM
            break
         fi
      elif [ ${board[$(($row+1)),$col]} == $COMP_SYM ] && [ ${board[$(($row+2)),$col]} == $COMP_SYM ]
      then
         if [ ${board[$row,$col]} != $PLAYER_SYM ]
         then
            board[$row,$col]=$COMP_SYM
            break
          fi
      elif [ ${board[$row,$col]} == $COMP_SYM ] && [ ${board[$(($row+2)),$col]} == $COMP_SYM ]
      then
         if [ ${board[$(($row+1)),$col]} != $PLAYER_SYM ]
         then
            board[$(($row+1)),$col]=$COMP_SYM
            break
         fi
      fi
   done
}
function checkingWinningDiagonalForComputer()
{
#Diagonal
      if [ ${board[$row,$col]} == $COMP_SYM ] &&  [ ${board[$(($row+1)),$(($col+1))]} == $COMP_SYM ]
      then
         if [ ${board[$(($row+2)),$(($col+2))]} != $PLAYER_SYM ]
         then
            board[$(($row+2)),$(($col+2))]=$COMP_SYM
            return
         fi
      elif [ ${board[$(($row+1)),$(($col+1))]} == $COMP_SYM ] && [ ${board[$(($row+2)),$(($col+2))]} == $COMP_SYM ]
      then
         if [ ${board[$row,$col]} != $PLAYER_SYM ]
         then
            board[$row,$col]=$COMP_SYM
            return
          fi
      elif [ ${board[$row,$col]} == $COMP_SYM ] && [ ${board[$(($row+2)),$(($col+2))]} == $COMP_SYM ]
      then
         if [ ${board[$(($row+1)),$(($col+1))]} != $PLAYER_SYM ]
         then
            board[$(($row+1)),$(($col+1))]=$COMP_SYM
            return
          fi
      elif [ ${board[$(($row+2)),$col]} == $COMP_SYM ] &&  [ ${board[$(($row+1)),$(($col+1))]} == $COMP_SYM ]
      then
         if [ ${board[$row,$(($col+2))]} != $PLAYER_SYM ]
         then
            board[$row,$(($col+2))]=$COMP_SYM
            return
          fi
      elif [ ${board[$(($row+1)),$(($col+1))]} == $COMP_SYM ] && [ ${board[$row,$(($col+2))]} == $COMP_SYM ]
      then
         if [ ${board[$(($row+2)),$col]} != $PLAYER_SYM ]
         then
            board[$(($row+2)),$col]=$COMP_SYM
            return
          fi
      elif [ ${board[$(($row+2)),$col]} == $COMP_SYM ] && [ ${board[$row,$(($col+2))]} == $COMP_SYM ]
      then
         if [ ${board[$(($row+1)),$(($col+1))]} != $PLAYER_SYM ]
         then
            board[$(($row+1)),$(($col+1))]=$COMP_SYM
            return
          fi
      else
         return
      fi
}

function checkCornersCenterSidesAvailability()
{
      if [ ${board[0,0]} != $PLAYER_SYM ] && [ ${board[0,0]} != $COMP_SYM ]
      then
         board[0,0]=$COMP_SYM
         isCornerAvailable=true
      elif [ ${board[0,2]} != $PLAYER_SYM ] && [ ${board[0,2]} != $COMP_SYM ]
      then
         board[0,2]=$COMP_SYM
         isCornerAvailable=true
      elif [ ${board[2,0]} != $PLAYER_SYM ] && [ ${board[2,0]} != $COMP_SYM ]
      then
         board[2,0]=$COMP_SYM
         isCornerAvailable=true
      elif [ ${board[2,2]} != $PLAYER_SYM ] && [ ${board[2,2]} != $COMP_SYM ]
      then
         board[2,2]=$COMP_SYM
         isCornerAvailable=true
      elif [ ${board[1,1]} != $PLAYER_SYM ] && [ ${board[1,1]} != $COMP_SYM ]
      then
         board[1,1]=$COMP_SYM
         isCenterAvailable=true
      elif [ ${board[0,1]} != $PLAYER_SYM ] && [ ${board[0,1]} != $COMP_SYM ]
      then
         board[0,1]=$COMP_SYM
         isSideAvailable=true
      elif [ ${board[1,2]} != $PLAYER_SYM ] && [ ${board[1,2]} != $COMP_SYM ]
      then
         board[1,2]=$COMP_SYM
         isSideAvailable=true
      elif [ ${board[2,1]} != $PLAYER_SYM ] && [ ${board[2,1]} != $COMP_SYM ]
      then
         board[2,1]=$COMP_SYM
         isSideAvailable=true
      elif [ ${board[1,0]} != $PLAYER_SYM ] && [ ${board[1,0]} != $COMP_SYM ]
      then
         board[1,0]=$COMP_SYM
         isSideAvailable=true
      fi
}
resetBoard
assigningSymbol
toss
inputToBoard
displayBoard
