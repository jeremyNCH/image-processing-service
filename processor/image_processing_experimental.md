# image_processing_experimental.py — Detailed Explanation

## Purpose

This script is an advanced film negative inversion tool. It converts scanned film negatives (color or black and white) into positive images, with sophisticated color correction, border detection, and support for both TIFF and JPEG output. It is intended for use with photographic film scans, especially those with a border of unexposed film around the frame.

---

## Key Features

- **Automatic Black Reference Generation:**  
  The script can automatically generate a "black reference" by sampling the border of the negative, which is assumed to be unexposed film. This reference is used to calibrate color and exposure corrections.

- **Preset Support:**  
  Users can specify a preset for black reference values for known film stocks, bypassing the need for border analysis.

- **Border Detection:**  
  The script can analyze specific borders (left, right, top, bottom) or all, depending on user input, to generate the black reference.

- **Color and Exposure Correction:**  
  The script calculates gamma corrections and color channel shifts based on the black reference, and applies these to the negative image to produce a well-balanced positive.

- **Batch and CLI Usage:**  
  The script is designed to be called from the command line, with many options for customization, and is suitable for batch processing.

- **Flexible Output:**  
  By default, the script outputs TIFF files, but can also output JPEGs if the `--jpeg` flag is used.

- **Advanced Options:**  
  Includes options for flipping/flopping the image, ignoring specific borders, saving the black reference swatch, and more.

---

## How It Works (High-Level Flow)

1. **Argument Parsing:**  
   The script uses `argparse` to parse command-line arguments, allowing the user to specify input/output files, presets, border options, output format, and more.

2. **Film Class Initialization:**  
   The main logic is encapsulated in the `Film` class, which is initialized with all relevant parameters.

3. **Black Reference Calculation:**  
   - If a preset is provided, it uses preset values.
   - Otherwise, it generates a black reference image by sampling the specified borders of the negative.
   - The black reference is analyzed to determine color, gamma, and channel shift values.

4. **Negative Adjustment and Inversion:**  
   - The negative image is loaded.
   - Black and white pixels (from the border or artifacts) are removed or replaced.
   - Gamma correction, color channel shifts, and normalization are applied.
   - The image is inverted (negative to positive).
   - Additional color balancing and contrast adjustments are performed.
   - Optional flipping/flopping and grayscale conversion are applied.

5. **Saving the Output:**  
   - The processed positive image is saved as either TIFF or JPEG, depending on the arguments.

6. **CLI Entrypoint:**  
   The script can be run directly from the command line, specifying the negative and positive file paths and any desired options.

---

## Example Usage

```bash
python processor/image_processing_experimental.py input_negative.tif output_positive.tif
# or for JPEG output:
python processor/image_processing_experimental.py input_negative.tif output_positive.jpg --jpeg
```

---

## Advanced Options

- `--preset`: Use a preset for black reference (e.g., for specific film stocks).
- `--blackref`: Use a supplied black reference image instead of generating one.
- `--border-size`: Set the size of the border region to sample.
- `--ignore-border-*`: Ignore specific borders when generating the black reference.
- `--contrast`, `--clipping-fuzz-black`, `--clipping-fuzz-white`: Fine-tune color and contrast adjustments.
- `--flip`, `--flop`: Flip the image vertically or horizontally.
- `--shift-color-channels`: Enable/disable color channel shifting.
- `--bw-autodetect-off`: Disable automatic detection of black and white images.
- `--save-blackref`: Save the generated black reference image for inspection.
- `-v`, `--verbose`: Enable verbose logging.

---

## Libraries Used

- **wand**: Python bindings for ImageMagick, used for advanced image processing.
- **halo**: For CLI spinners/progress indication.
- **argparse**: For command-line argument parsing.
- **logging**: For logging and debug output.
- **math, statistics, os, sys, signal**: Standard Python libraries for calculations, file handling, and system interaction.

---

## Summary

This script is a robust, flexible tool for converting film negatives to positives, with advanced color correction and border analysis. It is suitable for both single-image and batch processing, and is highly configurable for different film types and scanning scenarios.
