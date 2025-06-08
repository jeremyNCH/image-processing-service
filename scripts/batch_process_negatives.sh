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

START_TIME=$(date +%s)

for NEG in "$NEG_DIR"/*; do
    # Get the base filename without extension
    BASENAME=$(basename "$NEG")
    BASENAME_NOEXT="${BASENAME%.*}"
    POS="$POS_DIR/${BASENAME_NOEXT}_positive.$SUFFIX"
    echo "Processing $NEG -> $POS"
    python3 "$SCRIPT" "$NEG" "$POS" $FORMAT_FLAG
    if [ $? -ne 0 ]; then
        echo "Failed to process $NEG"
    fi

done

END_TIME=$(date +%s)
ELAPSED=$((END_TIME - START_TIME))
echo "Total time taken: ${ELAPSED} seconds"
