# MacPrompt - macOS Menu Bar App

## Overview

Stay Awake is a lightweight macOS menu bar app designed for non-technical users. It provides a simple way to prevent your Mac from going to sleep or turning off the display, without needing to use the terminal or command line.

## Features

- Prevent your Mac from sleeping indefinitely or for a set period (15 minutes, 30 minutes, or 1 hour).
- Easily toggle sleep prevention from the menu bar icon.
- Simple, intuitive interface with no complicated commands.
- Perfect for presentations, downloads, or any activity where you want your Mac to stay awake.

## How to Use

1. Launch the app — the icon will appear in the top-right menu bar.
2. Click the icon to open the menu.
3. Choose how long you want to keep your Mac awake:
   - Stay Awake Indefinitely
   - Stay Awake for 15 Minutes
   - Stay Awake for 30 Minutes
   - Stay Awake for 1 Hour
4. To re-enable normal sleep behavior, select **Disable Stay Awake** from the menu.

## Installation

1. Download the `.app` file from the release.
2. Drag and drop it into your `/Applications` folder.
3. Launch the app from Applications.
4. (Optional) Add it to your login items for automatic launch on startup.

## Requirements

- macOS 10.15 (Catalina) or later
- Swift 5+ (for building from source)

## Building from Source

1. Clone the repository.
2. Open `MacPrompt.xcodeproj` in Xcode.
3. Build and run the project.
4. Archive the app via **Product > Archive** for distribution.

---

*Developed by Graham Schomp*
