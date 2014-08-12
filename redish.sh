#!/bin/bash

# date: 2014-08-11 ~ 2014-08-12

RESET=$(tput sgr0)
RED=$(tput setaf 1)
BLUE=$(tput setaf 4)
ORANGE=$(tput setaf 3)
GREEN=$(tput setaf 2)
PINK=$(tput setaf 5)
CYAN=$(tput setaf 6)

NOT_RUNNING="$RED redis server is currently not running. $RESET"
MAIN_PROMPT="$PINK [read | write | quit | help] >> $GREEN "
READER_PROMPT="$ORANGE key reader >> $GREEN "
WRITER_PROMPT="$BLUE key writer >> $GREEN "
QUIT_INFO="$RED type 'q' or 'quit' to exit $RESET"

function reader() {
  local redis=`redis-cli ping`

  if [[ $redis = 'PONG' ]]; then
    echo "$QUIT_INFO"
    local key;
    while [[ 1 -eq 1 ]]; do

      printf "$READER_PROMPT"
      read -r key

      case $key in
        quit ) return ;;
        q ) return ;;
        * )
          if [[ -n $key ]]; then

            local result=`redis-cli GET $key`
            if [[ -z $result ]]; then
              echo "$RED key '$key' does not exist $REST"
            else
              echo "$CYAN $key = $result $RESET"
            fi

          else
            echo "$RED inform a key."
          fi
          ;;
      esac

    done

  else
    echo "$NOT_RUNNING"
  fi
}

function writer() {
  echo "implement writer..."
}

function help() {
  echo "implement help..."
}

function main() {
  local cmd;

  while [[ 1 -eq 1 ]]; do

    printf "$MAIN_PROMPT"
    read -r cmd

    case $cmd in
      read ) reader ;;
      reader ) reader ;;
      r ) reader ;;
      write ) writer ;;
      writer ) writer ;;
      w ) writer ;;
      quit ) exit 0 ;;
      q ) exit 0 ;;
      * ) help ;;
    esac

  done
}

# let it run
main
