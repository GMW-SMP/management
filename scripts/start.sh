#!/bin/bash

PAPER_JAR=$(yq r config.yaml server-directory)/paper.jar
TMUX_SESSION=$(yq r config.yaml tmux-session-name)

tmux new-session -s $TMUX_SESSION java -Xms7680M -Xmx7680M -XX:+UseG1GC -XX:+UnlockExperimentalVMOptions -XX:MaxGCPauseMillis=100 -XX:+DisableExplicitGC -XX:TargetSurvivorRatio=90 -XX:G1NewSizePercent=50 -XX:G1MaxNewSizePercent=80 -XX:G1MixedGCLiveThresholdPercent=35 -XX:+AlwaysPreTouch -XX:+ParallelRefProcEnabled -Dusing.aikars.flags=mcflags.emc.gs -jar $PAPER_JAR --world-container worlds
