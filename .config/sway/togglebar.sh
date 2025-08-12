#!/usr/bin/env bash
#
# Toggles the Sway bar visibility by commenting/uncommenting the
# 'swaybar_command' line in the Sway config file and then reloading Sway.
#

# Use -e to exit immediately if a command fails.
set -e

# 1. Define the path to the Sway config file
# Using $HOME is more reliable in scripts than ~.
CONFIG_FILE="$HOME/.config/sway/config"

# 2. Check if the config file actually exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Error: Sway config file not found at $CONFIG_FILE" >&2
    exit 1
fi

# 3. Check if 'swaybar_command' exists in the file at all
if ! grep -q "swaybar_command" "$CONFIG_FILE"; then
    echo "Error: 'swaybar_command' line not found in $CONFIG_FILE" >&2
    exit 1
fi

# 4. The core logic: check if the line is already commented
# We use grep with -q (quiet) and an extended regex (-E) to check.
# The regex '^\s*#' looks for a line that starts with optional whitespace and a '#'.
if grep -qE '^\s*#\s*swaybar_command' "$CONFIG_FILE"; then
    # STATE: It's commented. We need to UNCOMMENT it.
    echo "Status: Enabling Sway bar."
    # Use sed to do an in-place edit (-i).
    # The 's' command finds and replaces.
    # It finds a line starting with optional whitespace (\s*), a '#', more optional whitespace,
    # and captures (using parentheses) the 'swaybar_command ...' part.
    # It replaces the whole thing with just the captured part (\1).
    sed -i -E 's/^\s*#\s*(swaybar_command.*)/\1/' "$CONFIG_FILE"
else
    # STATE: It's active. We need to COMMENT it.
    echo "Status: Disabling Sway bar."
    # This sed command finds a line starting with optional whitespace and captures
    # the 'swaybar_command ...' part, then replaces it with a '#' and the captured part.
    sed -i -E 's/^\s*(swaybar_command.*)/#\1/' "$CONFIG_FILE"
fi

# 5. Reload sway to apply the change
if command -v swaymsg &> /dev/null; then
    swaymsg reload
    echo "Sway reloaded successfully."
else
    echo "Warning: 'swaymsg' command not found. Could not reload Sway." >&2
fi

exit 0
