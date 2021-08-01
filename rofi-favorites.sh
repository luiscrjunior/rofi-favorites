#! /bin/bash

GET_FAVORITES_CMD="gsettings get org.gnome.shell favorite-apps"
DESKTOP_FILES_PATH="/usr/share/applications/"
SNAP_FILES_PATH="/var/lib/snapd/desktop/applications/"

$GET_FAVORITES_CMD | grep -Po "\'(.+?)\'" | sed -r "s/'$|^'//g" | while read -r favorite ; do
    desktop_file="${DESKTOP_FILES_PATH}${favorite}"
    snap_desktop_file="${SNAP_FILES_PATH}${favorite}"

    if [ -f "$desktop_file" ]; then
        name=$(cat $desktop_file | awk -F "=" '/Name=/ {print $2}' | head -1)
        command=$(cat $desktop_file | awk -F "=" '/Exec=/ {print $2}' | head -1)
        icon=$(cat $desktop_file | awk -F "=" '/Icon=/ {print $2}' | head -1)
    elif [ -f "$snap_desktop_file" ]; then
        name=$(cat $snap_desktop_file | awk -F "=" '/Name=/ {print $2}' | head -1)
        command=$(cat $snap_desktop_file | awk -F "=" '/Exec=/ {print $2}' | head -1)
        icon=$(cat $snap_desktop_file | awk -F "=" '/Icon=/ {print $2}' | head -1)
    else
        continue
    fi

    if [ $# -eq 0 ]; then
      echo -en "${name}\0icon\x1f${icon}\n"
    fi

    if [ $# -eq 1 ]; then
        chosen="$1"
        if [ "$chosen" == "$name" ]; then
            coproc gtk-launch ${favorite}
            exit
        fi
    fi

done
