#!/usr/bin/env bash

# Get the touchpad ID dynamically
TOUCHPAD_ID=$(xinput list --id-only "ASUP1204:00 093A:2642 Touchpad" 2>/dev/null)

# Check if we found a valid ID
if [ -z "$TOUCHPAD_ID" ]; then
    echo "Error: Touchpad not found."
    exit 1
fi

# Get the current state of the touchpad
state=$(xinput list-props "$TOUCHPAD_ID" | grep "Device Enabled" | awk '{print $4}')

# Toggle the touchpad state
if [ "$state" -eq 1 ]; then
    xinput disable "$TOUCHPAD_ID"
else
    xinput reattach "$TOUCHPAD_ID" 2  # Attach it back to the core pointer
    xinput enable "$TOUCHPAD_ID"
fi

