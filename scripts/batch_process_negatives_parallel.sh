#!/bin/bash
# Batch process all images in assets/negatives/ using image_processing_experimental.py
# Outputs are saved in assets/positives/ with _positive.jpg suffix

NEG_DIR="assets/negatives"
POS_DIR="assets/positives"
SCRIPT="processor/image_processing_experimental.py"

mkdir -p "$POS_DIR"

# Usage: batch_process_negatives.sh [--jpeg|--tif]
FORMAT_FLAG=""
SUFFIX="tif"

if [ "$1" == "--jpeg" ]; then
    FORMAT_FLAG="--jpeg"
    SUFFIX="jpg"
fi

# Get half the number of available CPU cores (rounded up)
CORES=$(python3 -c "import os, math; print(max(1, math.ceil(os.cpu_count() / 2)))")

# Export the processing command as a function for xargs
process_negative() {
    NEG="$1"
    BASENAME=$(basename "$NEG")
    BASENAME_NOEXT="${BASENAME%.*}"
    POS="$POS_DIR/${BASENAME_NOEXT}_positive.$SUFFIX"
    echo "Processing $NEG -> $POS"
    python3 "$SCRIPT" "$NEG" "$POS" $FORMAT_FLAG
    if [ $? -ne 0 ]; then
        echo "Failed to process $NEG"
    fi
}
export -f process_negative
export POS_DIR SCRIPT FORMAT_FLAG SUFFIX

START_TIME=$(date +%s)

find "$NEG_DIR" -type f | xargs -P "$CORES" -I {} bash -c 'process_negative "$@"' _ {}

END_TIME=$(date +%s)
ELAPSED=$((END_TIME - START_TIME))
echo "Total time taken: ${ELAPSED} seconds"
