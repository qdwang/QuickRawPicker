# QuickRawPicker
A free and open source program that lets you cull, pick or rate raw photos captured by your camera.

[![CodeFactor](https://www.codefactor.io/repository/github/qdwang/quickrawpicker/badge)](https://www.codefactor.io/repository/github/qdwang/quickrawpicker)
[![GitHub](https://img.shields.io/badge/license-LGPL--2.1-yellow)](./LICENSE)
[![GitHub last commit](https://img.shields.io/github/last-commit/qdwang/QuickRawPicker)](#)

[![GitHub Release Date](https://img.shields.io/github/release-date/qdwang/QuickRawPicker)](https://github.com/qdwang/QuickRawPicker/releases)
[![GitHub release (latest by date)](https://img.shields.io/github/v/release/qdwang/QuickRawPicker)](https://github.com/qdwang/QuickRawPicker/releases)
[![GitHub all releases](https://img.shields.io/github/downloads/qdwang/QuickRawPicker/total)](https://github.com/qdwang/QuickRawPicker/releases)
[![platform](https://img.shields.io/badge/platform-win64%20%2F%20linux64%20%2F%20macOS%20universal-green)](#)


## Why QuickRawPicker?
* **To save time.** QuickRawPicker is very fast for checking multiple raw photos at the same time. It is speed oriented and built with C++ and Godot game engine. With the 16-bit texture feature, it is easy to check if the raw photo is overexposed or too noisy in dark areas.
* **To save money.** You can easily use QuickRawPicker as a pre-step to Rawtherapee or Darktable. This is because QuickRawPicker has XMP and PP3 ratings and is compatible with most free raw editing software on the market.
* **Cross platforms.** Most major desktop platforms are natively supported. **(Windows x64 | Linux x64 | macOS Intel / Apple silicon)**
* **Small size and ease of use.** The zip package is only about 30MB, no installation and no complicated setup.

**[🔽Download](https://github.com/qdwang/QuickRawPicker/releases/latest) the latest precompiled binaries.**
> You may need to run `xattr -dr com.apple.quarantine QuickRawPicker.app` to fix the **"file is damaged"** issue under macOS.

![QuickRawPicker-v0 1 7-Windows-x86_64](https://user-images.githubusercontent.com/403616/126796723-4b8fa0f6-8e29-429c-9dbc-6b59e4883d56.jpg)

## Features
* Compare multiple (up to 100) photos of multiple scales at the same time.
* Read XMP rating score from the raw file, sidecar `.xmp` file or `.pp3` file.
* Write XMP or PP3 rating score to sidecar `.xmp` or `.pp3` file.
* Adjust EV and shift Gamma.
* Draw highlight area and shadow area.
* Display as 16 bit texture on screen.
* Display as low contrast texture.
* Display color space setting available.
* Export marked photos by copying.
* Display AF point for different cameras' raw, including Sony, Panasonic, Canon, Nikon, Olympus.

## Shortcut list

### Global
|Key|Description|
|---|-----------|
|Key_C|Compare the selected photos|
|Key_F11|Toggle the fullscreen mode|

### In thumbnail list
|Key|Description|
|---|-----------|
|Alt + LeftClick|Toggle mark at the pointing photo|
|Shift + LeftClick|Select multiple photos from start to end to compare|
|Command/Ctrl + LeftClick|Pick multiple photos to compare|

### In photo area
|Key|Description|
|---|-----------|
|MouseWheel / Key, Key. / Key- Key= / Key_Q Key_E|Resize all photos|
|Command/Ctrl + Resize|Adjust all photos' EV|
|Alt + Resize|Adjust all photos' Gamma|
|Shift + **one of the above three**|Resize/adjust the pointing photo|
|Alt + LeftClick|Toggle mark at the pointing photo|
|Command/Ctrl + LeftClick|Toggle selection at the pointing photo|
|Key_F|View the pointing photo at fullscreen|
|Key_A|Toggle the AF point of the pointing photo|
|Key_H|Turn the highlight area of the pointing photo into red color|
|Key_S|Turn the shadow area of the pointing photo into green color|
|1,2,3,4,5|Rate the pointing photo|

## Sample workflows
### Workflow 1 - rate raw photos
Rate your raw photos with the fast QuickRawPicker and then edit them in Bridge, Lightroom or Rawtherapee.

https://user-images.githubusercontent.com/403616/124418975-3a1d6980-dd8f-11eb-84dc-61edf32fd425.mp4

> The rating operation is performed by pressing `3` on keyboard.

### Workflow 2 - mark raw photos and export
Mark your raw photos and then copy them to the folder desired.

https://user-images.githubusercontent.com/403616/124419023-50c3c080-dd8f-11eb-8931-8b7a4d2afb2d.mp4

> The marking operation is performed by holding `alt` and clicking mouse left button.

## Need any help, support or discussion
**[👉 Go github discussions](https://github.com/qdwang/QuickRawPicker/discussions)**
