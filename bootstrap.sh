#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 5 ]; then
    echo "Usage: $0 <target_folder> <year> <company> <project_name> <language>"
    echo "Language can be one of: cpp, c, or rust"
    exit 1
fi

# Assign arguments to variables
TARGET_FOLDER="$1"
YEAR="$2"
COMPANY="$3"
PROJECT_NAME="$4"
LANGUAGE="$5"

# Validate language argument
if [[ ! "$LANGUAGE" =~ ^(cpp|c|rust)$ ]]; then
    echo "Error: Invalid language. Please choose cpp, c, or rust."
    exit 1
fi

# Create the target folder
mkdir -p "$TARGET_FOLDER"/build
mkdir -p "$TARGET_FOLDER"/src

# Copy the specified files to the target folder
cp ./template_files/LICENSE.md ./template_files/README.md ./template_files/CODE_OF_CONDUCT.md "$TARGET_FOLDER/"
cp ./template_files/extension.wit "$TARGET_FOLDER/build/"

# Function to perform sed replacement
sed_replace() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS (BSD sed)
        sed -i '' "$1" "$2"
    else
        # Linux (GNU sed)
        sed -i "$1" "$2"
    fi
}

# Copy the appropriate Makefile based on the language
case "$LANGUAGE" in
    cpp)
        cp ./template_files/Makefile-cpp "$TARGET_FOLDER/Makefile"
        cp ./template_files/src/extension_impl.cpp "$TARGET_FOLDER/src/"
        ;;
    c)
        cp ./template_files/Makefile-c "$TARGET_FOLDER/Makefile"
        cp ./template_files/src/extension_impl.c "$TARGET_FOLDER/src/"
        ;;
    rust)
        cp ./template_files/Makefile-rust "$TARGET_FOLDER/Makefile"
        cp ./template_files/Cargo.toml "$TARGET_FOLDER/Cargo.toml"
        cp ./template_files/src/lib.rs "$TARGET_FOLDER/src/"
        ;;
esac

# Update the LICENSE.md file
sed_replace "s/\$YEAR/$YEAR/g" "$TARGET_FOLDER/LICENSE.md"
sed_replace "s/\$COMPANY/$COMPANY/g" "$TARGET_FOLDER/LICENSE.md"

# Update the README.md file with the project name
sed_replace "s/# Project Name/# $PROJECT_NAME/g" "$TARGET_FOLDER/README_template.md"

echo "Files copied and updated successfully in $TARGET_FOLDER"
echo "Language selected: $LANGUAGE"