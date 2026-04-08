#!/bin/bash
# Build EPUB ebook from Markdown chapters
# Pre-renders Mermaid diagrams to SVG before conversion
# Usage: ./build-epub.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "Building EPUB ebook..."

# Check required files
if [ ! -f "metadata.yaml" ]; then
    echo "Error: metadata.yaml not found"
    exit 1
fi

if [ ! -d "chapters" ]; then
    echo "Error: chapters directory not found"
    exit 1
fi

if [ ! -f "styles/epub-book.css" ]; then
    echo "Error: styles/epub-book.css not found"
    exit 1
fi

# Check if pandoc is installed
if ! command -v pandoc &> /dev/null; then
    echo "Error: pandoc is not installed. Please install pandoc first."
    exit 1
fi

# Create assets directory for SVG files
mkdir -p assets

# Check if mmdc is installed for Mermaid diagram rendering
HAS_MMDC=false
if command -v mmdc &> /dev/null; then
    HAS_MMDC=true
    echo "Found mmdc (mermaid-cli) - will pre-render diagrams"
else
    echo "Warning: mmdc not found. Mermaid diagrams will not be rendered."
    echo "Install with: npm install -g @mermaid-js/mermaid-cli"
fi

# Create temporary directory for processed chapters
TEMP_DIR=$(mktemp -d)
trap "rm -rf $TEMP_DIR" EXIT

# Process each chapter file - pre-render Mermaid diagrams
echo "Processing chapters..."
diagram_count=0

for chapter in chapters/*.md; do
    if [ ! -f "$chapter" ]; then
        continue
    fi
    
    filename=$(basename "$chapter" .md)
    output_file="$TEMP_DIR/$filename.md"
    
    echo "  Processing $(basename "$chapter")..."
    
    if [ "$HAS_MMDC" = false ]; then
        # No mmdc, just copy the file
        cp "$chapter" "$output_file"
        continue
    fi
    
    # Process file to extract and replace Mermaid blocks
    in_mermaid=false
    mermaid_content=""
    mermaid_num=0
    
    while IFS= read -r line || [ -n "$line" ]; do
        if [ "$line" = "\`\`\`mermaid" ]; then
            in_mermaid=true
            mermaid_content=""
            mermaid_num=$((mermaid_num + 1))
        elif [ "$in_mermaid" = true ] && [ "$line" = "\`\`\`" ]; then
            in_mermaid=false
            diagram_count=$((diagram_count + 1))
            
            # Generate unique filenames
            mmd_file="assets/diagram_${filename}_${mermaid_num}.mmd"
            svg_file="assets/diagram_${filename}_${mermaid_num}.svg"
            
            # Save Mermaid content
            echo "$mermaid_content" > "$mmd_file"
            
            # Render to SVG
            if mmdc -i "$mmd_file" -o "$svg_file" -b transparent 2>/dev/null; then
                # Replace with image reference
                echo "![Diagram $diagram_count]($svg_file)" >> "$output_file"
            else
                echo "Warning: Failed to render diagram $diagram_count"
                # Keep original code block as fallback
                echo "\`\`\`mermaid" >> "$output_file"
                echo "$mermaid_content" >> "$output_file"
                echo "\`\`\`" >> "$output_file"
            fi
        elif [ "$in_mermaid" = true ]; then
            mermaid_content="${mermaid_content}${line}"$'\n'
        else
            echo "$line" >> "$output_file"
        fi
    done < "$chapter"
done

if [ $diagram_count -gt 0 ]; then
    echo "  Rendered $diagram_count Mermaid diagram(s)"
fi

# Build EPUB with Pandoc
echo "Building EPUB..."

if [ "$HAS_MMDC" = true ] && [ -d "$TEMP_DIR" ] && [ "$(ls -A "$TEMP_DIR")" ]; then
    # Use processed chapters with SVG images
    pandoc \
        metadata.yaml \
        "$TEMP_DIR"/*.md \
        -o book.epub \
        --css=styles/epub-book.css \
        --toc \
        --toc-depth=2 \
        --highlight-style=breezedark \
        --epub-cover-image=cover.png \
        --resource-path=.:assets \
        2>/dev/null || pandoc \
            metadata.yaml \
            "$TEMP_DIR"/*.md \
            -o book.epub \
            --css=styles/epub-book.css \
            --toc \
            --toc-depth=2 \
            --highlight-style=breezedark \
            --resource-path=.:assets
else
    # Use original chapters (no Mermaid processing)
    pandoc \
        metadata.yaml \
        chapters/*.md \
        -o book.epub \
        --css=styles/epub-book.css \
        --toc \
        --toc-depth=2 \
        --highlight-style=breezedark \
        --epub-cover-image=cover.png \
        2>/dev/null || pandoc \
            metadata.yaml \
            chapters/*.md \
            -o book.epub \
            --css=styles/epub-book.css \
            --toc \
            --toc-depth=2 \
            --highlight-style=breezedark
fi

if [ $? -eq 0 ]; then
    echo "✓ EPUB ebook built successfully: book.epub"
else
    echo "Error: Failed to build EPUB ebook"
    exit 1
fi
