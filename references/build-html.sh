#!/bin/bash
# Build HTML ebook from Markdown chapters
# Usage: ./build-html.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "Building HTML ebook..."

# Check required files
if [ ! -f "metadata.yaml" ]; then
    echo "Error: metadata.yaml not found"
    exit 1
fi

if [ ! -d "chapters" ]; then
    echo "Error: chapters directory not found"
    exit 1
fi

if [ ! -f "_base.html" ]; then
    echo "Error: _base.html template not found"
    exit 1
fi

if [ ! -f "styles/html-book.css" ]; then
    echo "Error: styles/html-book.css not found"
    exit 1
fi

# Check if pandoc is installed
if ! command -v pandoc &> /dev/null; then
    echo "Error: pandoc is not installed. Please install pandoc first."
    exit 1
fi

# Build HTML with Pandoc
pandoc \
    metadata.yaml \
    chapters/*.md \
    -o index.html \
    --template=_base.html \
    --include-after-body=_footer.html \
    --css=styles/html-book.css \
    --toc \
    --toc-depth=2 \
    --highlight-style=breezedark \
    --standalone \
    --self-contained \
    --variable=mermaid-cdn:https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.min.js

if [ $? -eq 0 ]; then
    echo "✓ HTML ebook built successfully: index.html"
else
    echo "Error: Failed to build HTML ebook"
    exit 1
fi
