#!/bin/bash

# DEFAULT COUNTDOWN DURATION (Seconds)
DURATION=60
# REBOOT TITLE (<nl> for subtitle.)
REBOOT_MESSAGE="&4&lALERT<nl>&cServer rebooting in TIME seconds."
# DURATION FOR REBOOT TITLE
STAY_DURATION=60
# DEBUGGING
DEBUG=false
# TMUX SESSION NAME
SESSION_NAME=$(yq r config.yaml tmux-session-name)

TMUX_SESSION=$(yq r config.yaml tmux-session-name)
tmux has-session -t $TMUX_SESSION 2>/dev/null
if [[ $? != 0 ]]; then
  echo "No running server detected."
  exit 1
fi

# Use custom duration if provided.
if ! [ -z "$1" ]; then
  DURATION=$1
fi

runcommand() {
  if $DEBUG ; then
    echo "RUNNING CONSOLE CMD '$1' IN SESSION $SESSION_NAME"
  else
    echo "$1"
    if tmux ls | grep -q $SESSION_NAME ; then
      tmux send-keys -t $SESSION_NAME "$1"
      tmux send -t $SESSION_NAME Enter
    fi
  fi
}

#Seq counting down (-1 inc) from duration to 0.
for i in `seq $DURATION -1 0`; do
  TITLE="${REBOOT_MESSAGE/TIME/$i}"

  if (( $i % 10 == 0 )) && [ $i != 0 ] ; then
    runcommand "tbc $TITLE stay:$STAY_DURATION"
  elif (( $i <= 5 )); then
    if [ $i = 1 ]; then
      runcommand "tbc ${TITLE/seconds/second} fadein:0 stay:$STAY_DURATION"
    elif [ $i = 0 ]; then
      runcommand "stop"
      echo "Waiting 10 seconds for the server to stop..."
      sleep 10
    else
      runcommand "tbc $TITLE fadein:0 stay:$STAY_DURATION"
    fi
  fi

  sleep 1
done
