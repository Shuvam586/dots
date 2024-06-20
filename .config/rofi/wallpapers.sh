#!/bin/bash

# Source and destination directories
SRC_DIR="$HOME/wallpapers"
DEST_DIR="$HOME/.config/i3"

# Ensure the source and destination directories exist
if [[ ! -d "$SRC_DIR" ]]; then
    echo "Source directory does not exist: $SRC_DIR"
    exit 1
fi

if [[ ! -d "$DEST_DIR" ]]; then
    echo "Destination directory does not exist: $DEST_DIR"
    exit 1
fi

# Find image files in the source directory
IMAGES=$(find "$SRC_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \))

echo "Found images:"
echo "$IMAGES"

# Check if any images were found
if [[ -z "$IMAGES" ]]; then
    echo "No images found in $SRC_DIR"
    exit 1
fi

declare -A IMAGE_MAP
for IMAGE in $IMAGES; do
    BASENAME=$(basename "$IMAGE")
    IMAGE_MAP["$BASENAME"]="$IMAGE"
done

# Use rofi to display the filenames and capture the user's selection
SELECTED_BASENAME=$(printf "%s\n" "${!IMAGE_MAP[@]}" | rofi -dmenu -i -p "🖼️")

# Check if the user made a selection
if [[ -n "$SELECTED_BASENAME" ]]; then
    SELECTED_IMAGE="${IMAGE_MAP[$SELECTED_BASENAME]}"
    # Copy the selected image to the destination directory
    rm "$DEST_DIR/wallpaper.jpg"
    cp "$SELECTED_IMAGE" "$DEST_DIR/wallpaper.jpg"
    i3-msg restart
    echo "Copied $SELECTED_BASENAME to $DEST_DIR"
else
    echo "No image selected"
fi
