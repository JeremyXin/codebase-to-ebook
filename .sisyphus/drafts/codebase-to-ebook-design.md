# Design: Codebase-to-Ebook Skill

> **Status**: APPROVED — Ready for implementation planning
> **Date**: 2026-04-01
> **References**: codebase-to-course (analysis methodology), youtube-to-ebook (EPUB generation)

---

## TL;DR

An AI Agent Skill (SKILL.md) that transforms any codebase into a professional-quality technical ebook. The Skill guides Claude through a 5-phase pipeline: deep codebase analysis → chapter structure design → chapter content generation (Markdown with Mermaid diagrams, code blocks, tables, callouts) → assembly into HTML or EPUB output. Targets technical developers who want architecture guides, not tutorials.

---

## Requirements

- **Target audience**: Technical developers wanting high-quality architecture guides / technical documentation
- **Content depth**: Technical but not dry — moderate explanation and context (O'Reilly book level)
- **Output format**: User-selectable — HTML or EPUB
- **Intermediate format**: Markdown as single source-of-truth
- **Chapter structure**: AI fully automatic (no user approval step)
- **Rich elements**: Mermaid diagrams, syntax-highlighted code blocks, tables, callout/tip boxes. NO AI-generated images, NO interactive elements.
- **Content language**: User-selectable or auto-detect from conversation language
- **Content depth**: AI auto-adaptive based on codebase complexity
- **Analysis scope**: Full codebase (source + README + config + docs + comments)

---

## Skill File Structure

```
codebase-to-ebook/
├── SKILL.md                           # Main skill instructions (AI Skill core)
├── README.md                          # Usage documentation
└── references/                        # Reference files (lazy-loaded per phase)
    ├── content-guidelines.md          # Technical writing style guide
    ├── chapter-brief-template.md      # Chapter Brief template (for parallel writing)
    ├── rich-elements.md               # Rich element usage guide (Mermaid, callout, table patterns)
    ├── gotchas.md                     # Common pitfalls checklist
    ├── html-book.css                  # Pre-built HTML book stylesheet
    ├── epub-book.css                  # Pre-built EPUB simplified stylesheet
    ├── _base.html                     # HTML shell template (title, nav, Mermaid.js CDN)
    ├── _footer.html                   # HTML footer
    ├── build-html.sh                  # HTML assembly script (Pandoc)
    └── build-epub.sh                  # EPUB assembly script (mermaid-cli + Pandoc)
```

---

## Core Design Principles

1. **Markdown-First**: All content as Markdown — LLM's most natural output format
2. **Separation & Assembly**: Each chapter = independent `.md` file, assembled via build scripts
3. **Rich but Not Interactive**: Mermaid diagrams, tables, callouts for richness; no JavaScript interactions
4. **Dual Output Pipeline**: Same Markdown source → different toolchains for HTML vs EPUB
5. **Developer-Depth Content**: Assumes programming knowledge; explains design decisions and trade-offs, not basic concepts

---

## Differentiation from codebase-to-course

| Dimension | codebase-to-course | codebase-to-ebook |
|-----------|-------------------|-------------------|
| Source format | HTML sections | Markdown files |
| Target audience | Non-technical / Vibe Coders | Technical developers |
| Content density | 1 concept per screen, 50% visual | Denser, longer paragraphs allowed |
| Interactivity | High (quiz, animation, drag-drop) | None (static reading) |
| Visualization | CSS animations + JS interactions | Mermaid static diagrams |
| Output format | Single-page HTML | HTML or EPUB (user choice) |
| JS dependency | Pre-built main.js (interaction engine) | Mermaid.js only (HTML version) |
| Code display | Code ↔ English side-by-side translation | Code blocks + inline comments + explanation paragraphs |
| Narrative arc | Experience-driven (user action → code) | Structure-driven (overview → modules → cross-cutting) |

---

## Phase Pipeline

### Phase 1: Deep Codebase Analysis

**Goal**: Understand the codebase holistically — modules, architecture, data flow, tech stack, design decisions.

**Extraction dimensions**:

1. **Project Overview**
   - Name, purpose, problem it solves (from README)
   - Tech stack (language, frameworks, libraries, build tools)
   - Directory structure and organizational patterns

2. **Architecture Analysis**
   - Core modules/packages and their responsibilities
   - Inter-module dependencies (who calls whom)
   - Data flow (request → processing → response paths)
   - Layering structure (e.g., Controller → Service → Repository)

3. **Core Code Reading**
   - Entry points (main, index, app)
   - Key interfaces/API definitions
   - Critical business logic locations
   - Important design pattern usage

4. **Engineering Practices**
   - Configuration management approach
   - Error handling strategy
   - Test structure
   - Build and deployment pipeline

5. **Design Decision Clues**
   - ADRs (Architecture Decision Records) in README/docs
   - "Why" comments in code
   - TODO/FIXME exposing known issues
   - Major refactoring evidence in git history

**Key distinction from codebase-to-course**: Course analysis focuses on "what does the app do and how does the user interact with it." Ebook analysis focuses on "how is the system designed, why these choices, and how to extend it."

### Phase 2: Chapter Structure Design

**Goal**: Design a logically progressive technical book chapter structure.

**Recommended chapter arc** (reference template, AI adapts per project):

| Position | Typical Content | Purpose |
|----------|----------------|---------|
| Preface | Project intro, who should read, how to read | Set expectations |
| Chapter 1 | Project overview + quick start + tech stack | Establish global perspective |
| Chapter 2 | Architecture overview + directory structure + module relationship diagram | Understand system skeleton |
| Chapters 3-N | Deep dive into each core module | Module-by-module exploration |
| Second-to-last | Cross-cutting concerns (error handling, config, security, performance) | Engineering practices |
| Last chapter | Summary + extension directions + contribution guide | Wrap-up and next steps |

**Chapter count guidance**:
- Small project (<10 core files): 3-5 chapters
- Medium project (10-50 core files): 5-8 chapters
- Large project (50+ core files): 8-12 chapters

**Do NOT present outline for user approval** — just build it. Consistent with codebase-to-course: "User wants an ebook, not a planning document."

### Phase 2.5: Chapter Briefs (Complex Projects)

**Trigger**: When chapter count ≥ 6, switch to parallel path.

Each brief contains:
- **Teaching objective**: What the reader should understand after this chapter
- **Pre-extracted code snippets**: Copy-pasted from codebase with file paths and line numbers
- **Mermaid diagram plans**: What diagrams to include and what they show
- **Chapter structure outline**: Section breakdown
- **Connections**: What previous chapter covered, what next chapter will cover

### Phase 3: Chapter Content Generation (Markdown)

**Standard chapter structure**:

```markdown
# Chapter N: Title

> 📌 Core question: [One sentence summarizing what this chapter answers]

## N.1 Overview
(Brief introduction to this module/topic, 2-3 paragraphs)

## N.2 Architecture & Design
(Mermaid diagram + explanation of relationships and design decisions)

## N.3 Core Code Walkthrough
(Key functions/classes with code blocks + detailed explanations)

## N.4 Design Decisions
(Tables comparing choices, trade-offs, rationale)

## N.5 Summary
(Key takeaways + connection to next chapter)
```

**Rich elements specification**:

| Element | When to Use | Markdown Syntax |
|---------|------------|-----------------|
| **Mermaid architecture diagram** | Module relationships, layering | ` ```mermaid graph TD ... ``` ` |
| **Mermaid sequence diagram** | Request processing, module interactions | ` ```mermaid sequenceDiagram ... ``` ` |
| **Mermaid flowchart** | Business logic, decision trees | ` ```mermaid flowchart ... ``` ` |
| **Code block** | Core code showcase | ` ```lang ... ``` ` with file path comment |
| **Table** | Comparisons, config docs, API listings | Markdown table syntax |
| **Callout block** | Design highlights, caveats, best practices | `> 💡 **Title**: Content` |
| **Directory tree** | Project structure display | ` ```text (tree format) ``` ` |

**Correspondence table (course interactive → ebook static)**:

| Course Interactive Element | Ebook Static Equivalent |
|---------------------------|------------------------|
| Group Chat Animation | Mermaid sequence diagram |
| Data Flow Animation | Mermaid flowchart |
| Interactive Architecture Diagram | Mermaid C4/architecture diagram (static) |
| Code ↔ English Translation | Code blocks + line comments + explanation sections |
| Quiz | End-of-chapter thought questions (no interaction, with answers) |
| Glossary Tooltip | Footnotes or glossary appendix |
| Pattern Cards | Markdown tables or callout blocks |
| File Tree Visualization | Indented text directory tree |

**Writing paths**:
- **Sequential path** (simple codebases, <6 chapters): Write chapters one at a time
- **Parallel path** (complex codebases, ≥6 chapters): Dispatch to subagents using Chapter Briefs

### Phase 4: Assembly & Output

**Generated ebook directory structure**:
```
ebook-name/
  metadata.yaml           ← Book metadata (title, author, language, etc.)
  styles/
    html-book.css          ← Copied from references/
    epub-book.css          ← Copied from references/
  chapters/
    00-preface.md
    01-overview.md
    02-architecture.md
    ...
  briefs/                  ← Chapter Briefs (complex projects only, deletable after build)
  assets/                  ← Mermaid pre-rendered images (generated during EPUB build)
  _base.html               ← HTML shell template
  _footer.html             ← HTML footer
  build-html.sh            ← Build HTML version
  build-epub.sh            ← Build EPUB version
  index.html               ← HTML output
  book.epub                ← EPUB output
```

**HTML path**: Pandoc converts merged Markdown → HTML with Mermaid.js CDN + custom CSS
**EPUB path**: mermaid-cli pre-renders diagrams → Pandoc converts to EPUB with simplified CSS

### Phase 5: Review & Delivery

- Inform user of output location after build
- Provide preview guidance (HTML → browser, EPUB → reader app)
- Support per-chapter iterative modification on feedback

---

## Content Writing Guidelines (Summary)

For technical developer audience:

1. **Assume programming knowledge** — don't explain variables, functions, classes
2. **Explain design decisions** — WHY this pattern, not just WHAT it does
3. **Code first, then explain** — show code, then walk through it
4. **Use original code only** — exact copies from codebase, never modified
5. **Tables for comparisons** — design decision tables showing choices, alternatives, trade-offs
6. **Mermaid for architecture** — every chapter with inter-module relationships gets a diagram
7. **Callouts for insights** — `> 💡` for design highlights, `> ⚠️` for caveats, `> 📝` for notes
8. **One core concept per section** — avoid mixing multiple unrelated topics in one section
9. **Connect chapters** — each chapter ends with connection to the next

---

## Scope Boundaries

### IN Scope
- Full codebase analysis (source + README + config + docs + comments)
- Mermaid diagrams (architecture, sequence, flow)
- Code blocks with syntax highlighting
- Tables and callout boxes
- HTML and EPUB output
- AI auto chapter design
- User-selectable language
- Auto-adaptive depth

### OUT of Scope
- AI-generated images
- Interactive elements (quizzes, drag-drop, animations)
- PDF output (can be added later via EPUB→PDF)
- Video/audio content
- Real-time collaboration features
