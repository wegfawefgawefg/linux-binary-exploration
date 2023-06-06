#!/bin/bash

# File path argument
file_path="../build/basic"

# List of commands to execute
commands=(
    "strings $file_path"
    "file $file_path"
    "xxd $file_path"
    # readelf for -h -S s r x
    "readelf -d $file_path"
    "readelf -h $file_path"
    "readelf -S $file_path"
    "readelf -s $file_path"
    "readelf -r $file_path"
    "readelf -x .rodata $file_path"
    # objdump for -d t x
    "objdump -d $file_path"
    "objdump -t $file_path"
    "objdump -x $file_path"
)

# Loop through the commands
# make a folder to put the outputs in
mkdir -p outputs
for cmd in "${commands[@]}"; do
    sanitized_cmd=$(echo "$cmd" | tr -dc '[:alnum:]._-' | tr ' ' '_')

    output_file="$sanitized_cmd.txt"
    output_file="outputs/$output_file"

    echo "Running command: $cmd"
    echo "Output file: $output_file"
    touch "$output_file"

    echo "output of command: $cmd" >> "$output_file"
    echo "---------------------------------------" >> "$output_file"
    echo "" >> "$output_file"
    eval "$cmd" >> "$output_file"
    

    echo "---------------------------------------"
done
