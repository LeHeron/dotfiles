#!/bin/bash
COLOR=#FF5555
TEXT_COLOR=#FFFFFF
TEXT_COLOR_CHARGING=#00FF00
TEXT_ICON=

ACPI_RES=$(acpi -bi)
if [ "$?" -ne 0 ]
then
    exit 0
fi

# Get real battery level based on hardware

BAT_INFO=$(echo "$ACPI_RES" | grep -E -o "((100)|([0-9]{2}))%")

echo "$BAT_INFO" > tmp1

BAT_LEVEL=$(echo "$BAT_INFO" | head -n1)
BAT_LEVEL=${BAT_LEVEL::${#BAT_LEVEL}-1}

BAT_MAX=$(echo "$BAT_INFO" | tail -n1)
BAT_MAX=${BAT_MAX::${#BAT_MAX}-1}

BAT_REAL=$((BAT_MAX * BAT_LEVEL / 100))


# Display different color upon charging, discharging and low battery

if [ "$BAT_REAL" -le 20 ]
then
    TEXT_COLOR=$COLOR # Red alert
    TEXT_ICON=
fi


if [ "$(echo "$ACPI_RES" | grep -E -o "Charging")" ]
then
    TEXT_COLOR=$TEXT_COLOR_CHARGING
    TEXT_ICON=
fi

BAT_REAL="<span foreground=\"${TEXT_COLOR}\">${BAT_REAL}</span>"
echo -e "<span foreground=\"${COLOR}\">${TEXT_ICON} ${BAT_REAL}% </span>"
