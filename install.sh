#!/bin/bash
# Quick setup script for clang-format multi-version

set -e

INSTALL_DIR="/usr/local/bin"
REPO_URL="https://github.com/pachadotdev/clang-format"
LATEST_RELEASE_URL="$REPO_URL/releases/latest/download"

echo "🚀 Installing clang-format multi-version..."

# Check if running as root or with sudo
if [[ $EUID -eq 0 ]]; then
    SUDO=""
    echo "✓ Running as root"
elif command -v sudo &> /dev/null; then
    SUDO="sudo"
    echo "✓ Using sudo for installation"
else
    echo "❌ Error: This script needs root access or sudo to install to $INSTALL_DIR"
    echo "   Either run as root or install sudo"
    exit 1
fi

# Create temporary directory
TMP_DIR=$(mktemp -d)
cd "$TMP_DIR"

echo "📦 Downloading latest release..."

# Download the release
if command -v wget &> /dev/null; then
    wget -q "$LATEST_RELEASE_URL/clang-format.tar.gz" -O clang-format.tar.gz
elif command -v curl &> /dev/null; then
    curl -sL "$LATEST_RELEASE_URL/clang-format.tar.gz" -o clang-format.tar.gz
else
    echo "❌ Error: wget or curl is required"
    exit 1
fi

echo "🔧 Installing to $INSTALL_DIR..."

# Extract and install
tar -xzf clang-format.tar.gz
$SUDO cp clang-format* "$INSTALL_DIR/"
$SUDO chmod +x "$INSTALL_DIR"/clang-format*

# Cleanup
cd /
rm -rf "$TMP_DIR"

echo "✅ Installation complete!"
echo ""
echo "Usage examples:"
echo "  clang-format example.cpp              # Format with default version"
echo "  clang-format 14 example.cpp           # Format with clang-format-14"
echo "  clang-format                          # Format all C/C++ files in directory"
echo ""
echo "Available versions:"
for version in {11..19}; do
    if command -v "clang-format-$version" &> /dev/null; then
        echo "  ✓ clang-format-$version"
    fi
done
echo ""
echo "For GitHub Actions integration, see: $REPO_URL#github-actions"
