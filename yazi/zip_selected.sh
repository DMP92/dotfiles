#!/bin/bash
archive="selected_$(date +%H%M%S).zip"
cd "$(dirname "$1")"

# Create file list with basenames
for file in "$@"; do
    basename "$file"
done > /tmp/zip_files

# Zip using file list
zip "$archive" -@ < /tmp/zip_files
rm /tmp/zip_files

# Copy to clipboard
osascript -e "set the clipboard to (read (POSIX file \"$(pwd)/$archive\") as «class furl»)"
echo "Done: $archive"
