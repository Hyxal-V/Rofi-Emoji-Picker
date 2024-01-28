#!/bin/bash
json_file="Emoji.json"

case "$1" in
    "--x11")
        clipboard_command="xclip -selection clipboard"
        ;;
    "--wayland")
        clipboard_command="wl-copy"
        ;;
    *)
        echo "Error: Invalid option. Please specify '--wayland' or '--x11' as a parameter based on your display server."
        exit 1
        ;;
esac

# To extract "char" and "name" attributes from Emoji objects within the array.
emoji_chars=$(jq -r '.[] | "\(.char) \(.name)"' "$json_file")

selected_char_and_name=$(echo "$emoji_chars" | rofi -dmenu -i -p "Search")

if [ -n "$selected_char_and_name" ]; then
    selected_char=$(echo "$selected_char_and_name" | awk '{print $1}')

    # Copy to clipboard using the selected clipboard manager
    echo -n "$selected_char" | $clipboard_command
    echo "Emoji copied to clipboard: $selected_char"
fi

