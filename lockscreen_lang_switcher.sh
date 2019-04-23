#!/bin/bash

export DISPLAY=:0

# If an option is not provided, make the layout to switch to "0", otherwise take the specified number
if [ -z ${1+x} ]; then
    layout="0"
else
    layout=$1
fi

function ubuntu_16_04_monitor {
    LOCK_STAT=`echo $1 | awk '{print $NF}'`
    if [[ "$LOCK_STAT" == "member=Locked" ]]; then
        /usr/bin/gsettings set org.gnome.desktop.input-sources current $layout
    fi
}

function ubuntu_18_04_monitor {
    UNLOCK=`echo $1 | grep false`
    if [[ "$UNLOCK" ]]; then
        gdbus call --session --dest org.gnome.Shell \
            --object-path /org/gnome/Shell \
            --method org.gnome.Shell.Eval \
            "imports.ui.status.keyboard.getInputSourceManager().inputSources[${layout}].activate()";
    fi
}


if [[ "$(lsb_release -rs)" == "16.04" ]]; then
    dbus_signal="type=signal,interface=com.canonical.Unity.Session,member=Locked"
    dbus-monitor --session "$dbus_signal" | 
    while read MSG; do
        ubuntu_16_04_monitor "$MSG"
    done
elif [[ "$(lsb_release -rs)" == "18.04" ]]; then
    dbus_signal="type=signal,interface=org.gnome.ScreenSaver,member=ActiveChanged"
    dbus-monitor --session "$dbus_signal" | 
    while read MSG; do
        ubuntu_18_04_monitor "$MSG"
    done
else
    echo "Not a supported Ubuntu version"
    exit 1
fi
