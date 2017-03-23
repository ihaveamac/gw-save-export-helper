#!/usr/bin/env bash
TITLEVER=1024  # how to use: https://www.3dbrew.org/wiki/Title_list#Versions
VERSION="1.0"
HOMEBREWNAME="Gateway Save Export Helper"
HOMEBREWFILENAME="gw-save-export-helper"
PUBLISHER="ihaveamac"

rm -r output/
rm -r tmp-output/
mkdir output/
mkdir tmp-output/
bannertool makesmdh -s "$HOMEBREWNAME" -l "$HOMEBREWNAME" -p "$PUBLISHER" -i resources/icon.png -f visible,nosavebackups -o tmp-output/icon.bin
bannertool makebanner -i resources/banner.png -ca resources/hbchannel.cwav -o tmp-output/banner.bin
makerom -f cia -o "output/${HOMEBREWFILENAME}${VERSION}.cia" -elf resources/lpp-3ds.elf -rsf resources/cia_workaround.rsf -icon tmp-output/icon.bin -banner tmp-output/banner.bin -exefslogo -target t -ver $TITLEVER