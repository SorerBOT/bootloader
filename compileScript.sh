#!/bin/bash

BIN="./bin/"
STAGE_1="bootloader_stage_1"
STAGE_2="bootloader_stage_2"
PADDING="padding"
OS_IMG="os-img"

rm -rf $BIN
mkdir $BIN

nasm -f bin "$STAGE_1.asm" -o "$BIN$STAGE_1.bin"
nasm -f bin "$STAGE_2.asm" -o "$BIN$STAGE_2.bin"

dd if=/dev/zero of="$BIN$PADDING.bin" bs=1024 count=32

cat "$BIN$STAGE_1.bin" "$BIN$STAGE_2.bin" "$BIN$PADDING.bin" > "$BIN$OS_IMG.bin"

qemu-system-x86_64 -drive format=raw,file="$BIN$OS_IMG.bin" -display cocoa
