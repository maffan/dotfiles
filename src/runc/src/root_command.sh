#!/bin/bash -eu

TEMP_FILE="$(mktemp)"
TEMP_EXECUTABLE="$(mktemp)"

finish() {
	rm -f "$TEMP_FILE"
	rm -f "$TEMP_EXECUTABLE"
}

trap finish EXIT

CODE="$(cat)"

generate_c_program "$CODE" > "$TEMP_FILE"

gcc -xc "$TEMP_FILE" -o "$TEMP_EXECUTABLE" 2>/dev/null

"$TEMP_EXECUTABLE"

