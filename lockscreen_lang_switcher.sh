#!/bin/bash

export DISPLAY=:0

# If an option is not provided, make the layout to switch to "0", otherwise take the specified number
layout="${1:-0}"

if ! [ "$layout" -ge 0 ]; then
  echo "Layout specified must be a number"
  exit 1
fi

release_version=$(lsb_release -rs)

function ubuntu_16_04_monitor {
    if awk '($(NF) == "member=Locked") { exit 0 } { exit 1 }' <<< $1; then
        /usr/bin/gsettings set org.gnome.desktop.input-sources current "$layout"
    fi
}

function ubuntu_18_04_monitor {    
    if grep -v -q false <<< $1; then
        gdbus call --session --dest org.gnome.Shell \
            --object-path /org/gnome/Shell \
            --method org.gnome.Shell.Eval \
            "imports.ui.status.keyboard.getInputSourceManager().inputSources[${layout}].activate()"
    fi
}

if [[ "$release_version" == "16.04" ]]; then
    dbus_signal="type=signal,interface=com.canonical.Unity.Session,member=Locked"
    dbus-monitor --session "$dbus_signal" | 
    while read MSG; do
        ubuntu_16_04_monitor "$MSG"
    done
elif [[ "$release_version" == "18.04" ]]; then
    dbus_signal="type=signal,interface=org.gnome.ScreenSaver,member=ActiveChanged"
    dbus-monitor --session "$dbus_signal" | 
    while read MSG; do
        ubuntu_18_04_monitor "$MSG"
    done
else
    echo "Not a supported Ubuntu version"
    exit 1
fi
