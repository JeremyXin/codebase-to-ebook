# Codebase-to-Ebook

Transform any codebase into a professional technical ebook with architecture diagrams, code walkthroughs, and design decision documentation.

## What This Skill Does

1. **Analyzes** your codebase deeply — modules, architecture, data flows, tech stack
2. **Designs** a logical chapter structure — from overview to deep dives
3. **Generates** professional content — Markdown with Mermaid diagrams, code blocks, tables
4. **Builds** your ebook — HTML (browser) or EPUB (e-reader) format

## Quick Start

Ask: **"Turn this codebase into an ebook"**

Or specify a project:
- "Generate an ebook from https://github.com/user/repo"
- "Create a technical book from ./my-project"

## Output Formats

- **HTML** — Open in any browser, interactive Mermaid diagrams, best for desktop
- **EPUB** — Read on Kindle, iBooks, or any e-reader, diagrams as images

## What You Get

A complete ebook with:

- **Preface** — Project overview and how to read the book
- **Architecture chapters** — System skeleton with diagrams
- **Module deep dives** — Each core component explained
- **Design decision tables** — Trade-offs and rationale
- **Code walkthroughs** — Key functions with detailed explanations

## Example Output Structure

```
ebook-name/
├── metadata.yaml          # Book metadata
├── chapters/
│   ├── 00-preface.md      # Introduction
│   ├── 01-overview.md     # Project overview
│   ├── 02-architecture.md # System architecture
│   ├── 03-module-a.md     # Deep dive: Module A
│   └── ...
├── index.html             # HTML output
└── book.epub              # EPUB output
```

## Who Is This For

**Technical developers** who want to:
- Understand a codebase's architecture and design decisions
- Onboard to a new project quickly
- Evaluate a library or framework
- Learn from open-source projects
- Document their own projects

## Key Features

- **Automatic chapter design** — AI analyzes and structures the content
- **Architecture diagrams** — Mermaid diagrams showing module relationships
- **Design decision documentation** — Tables explaining trade-offs
- **Code walkthroughs** — Detailed explanations of key code
- **Dual output** — Same source generates HTML or EPUB
- **Professional formatting** — Clean typography and syntax highlighting

## Requirements

- Pandoc (for ebook generation)
- mermaid-cli (for EPUB diagram rendering)

Install on macOS:
```bash
brew install pandoc
npm install -g @mermaid-js/mermaid-cli
```

## How It Works

The skill follows a 5-phase pipeline:

1. **Analysis** — Deep codebase reading and understanding
2. **Design** — Chapter structure planning
3. **Generation** — Markdown content creation
4. **Assembly** — Build scripts generate HTML/EPUB
5. **Delivery** — Output files ready to use

## Customization

The generated ebook is fully editable:
- Modify any `.md` file in the `chapters/` directory
- Re-run `build-html.sh` or `build-epub.sh` to regenerate
- Adjust styles in `styles/` directory

## Comparison: Codebase-to-Course vs Codebase-to-Ebook

| | Codebase-to-Course | Codebase-to-Ebook |
|---|---|---|
| **Audience** | Non-technical / Vibe Coders | Technical developers |
| **Format** | Interactive HTML course | Static ebook (HTML/EPUB) |
| **Content** | Tutorials with quizzes | Architecture guide |
| **Visuals** | Animations, interactions | Mermaid diagrams, tables |
| **Depth** | Concept explanations | Design decisions, trade-offs |

Use **codebase-to-course** when teaching non-coders how software works.
Use **codebase-to-ebook** when documenting architecture for developers.

---

Built with Claude Code.
