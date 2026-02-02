# iOS-rpenya-stories-challenge
Instagram stories-like app built for a challenge

- XcodeGen
- ...


# Project Setup Guide

Follow these steps to generate and open the Xcode project from scratch.

---

## Install Homebrew

### 1. Open **Terminal** and run:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
When the installer finishes, run the command it prints to add Homebrew to your shell
(Apple Silicon example):
```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```
Verify:
```bash
brew --version
```
### 2. Install XcodeGen
```bash
brew install xcodegen
```
Verify:
```bash
xcodegen --version
```
### 3. Clone the repository 
```bash
git clone <REPO_URL>
cd <PROJECT_FOLDER>
```
### 4. Generate and open the project
```bash
make generate
```
This will:
- Generate the .xcodeproj
- Open the project in Xcode automatically
