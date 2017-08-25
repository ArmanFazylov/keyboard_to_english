#!/bin/bash

export DISPLAY=:0
dbus-monitor --session "type=signal,interface=com.canonical.Unity.Session,member=Locked" | 
  while read MSG; do
    LOCK_STAT=`echo $MSG | awk '{print $NF}'`
    if [[ "$LOCK_STAT" == "member=Locked" ]]; then
        echo "was unlocked"
	setxkbmap us
    fi
  done

