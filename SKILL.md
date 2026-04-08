---
name: codebase-to-ebook
description: Transform any codebase into a professional technical ebook (HTML or EPUB) with architecture diagrams, code walkthroughs, and design decision documentation. Use this skill when someone wants to create a technical book from a codebase, generate architecture documentation, or understand a project's design through a structured ebook format.
---

# Codebase-to-Ebook

Transform any codebase into a professional technical ebook. The output is a directory containing Markdown chapters, pre-built stylesheets, and assembly scripts that generate either an HTML ebook (with interactive Mermaid diagrams) or an EPUB ebook (for e-readers) — all from the same source content.

## First-Run Welcome

When the skill is first triggered and the user hasn't specified a codebase yet, introduce yourself:

> **I can turn any codebase into a professional technical ebook — an architecture guide that teaches how the system is designed.**
>
> Just point me at a project:
> - **A local folder** — e.g., "turn ./my-project into an ebook"
> - **A GitHub link** — e.g., "make an ebook from https://github.com/user/repo"
> - **The current project** — if you're already in a codebase, just say "turn this into an ebook"
>
> I'll analyze the code, design a logical chapter structure, and generate a complete ebook with architecture diagrams, code walkthroughs, and design decision documentation. You can choose HTML (for browser reading) or EPUB (for e-readers).

If the user provides a GitHub link, clone the repo first (`git clone <url> /tmp/<repo-name>`) before starting the analysis. If they say "this codebase" or similar, use the current working directory.

## Trigger Phrases

- "Turn this into an ebook"
- "Generate an ebook from this codebase"
- "Create a technical book from this project"
- "Make an architecture guide from this code"
- "Document this codebase as an ebook"
- "Turn this repo into a book"

## Who This Is For

The target reader is a **technical developer** — someone who:
- Is a junior/intermediate programmer
- Wants to understand a codebase's architecture and design decisions
- Needs to onboard to a new project, evaluate a library, or learn from open-source
- Prefers structured, in-depth documentation over scattered READMEs

**Content style**: Technical but not dry. Think O'Reilly technical book or well-written architecture guide. Explain the "why" behind design decisions, not just the "what."

## Output Format Selection

Ask the user which format they prefer:

> **Which format would you like?**
> - **HTML** — Open in any browser, interactive Mermaid diagrams, best for desktop reading
> - **EPUB** — Read on Kindle, iBooks, or any e-reader, diagrams pre-rendered as images

If they don't specify, default to **HTML** (better diagram interactivity).

## Skill Dependencies

This skill depends on **mermaid-diagrams** for professional diagram generation. Before generating chapter content (Phase 3), install it:

```bash
npx skills add https://github.com/softaworks/agent-toolkit --skill mermaid-diagrams
```

This installs the skill to `.skills/mermaid-diagrams/` in the current project directory. The installed skill contains:
- `SKILL.md` — Diagram type selection guide, core syntax, best practices
- `references/` — Detailed references for each diagram type (class, sequence, flowchart, ERD, C4, architecture, advanced features)

**When to read**: At the start of Phase 3. Read `.skills/mermaid-diagrams/SKILL.md` first, then consult specific `references/*.md` files as needed for the diagram types you're generating.

## The Process

### Phase 1: Deep Codebase Analysis

Before writing any content, thoroughly understand the codebase. Read all key files, trace data flows, identify the main modules, and map how they communicate.

**What to extract:**

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
   - Git history showing major refactoring

**Figure out what the system does yourself** by reading the README, entry points, and core modules. Don't ask the user to explain the project — they may not know it either.

### Phase 2: Chapter Structure Design

Design a logically progressive technical book structure. This is a reference template — adapt to the actual codebase:

| Position | Typical Content | Purpose |
|----------|----------------|---------|
| Preface | Project intro, who should read, how to read | Set expectations |
| Chapter 1 | Project overview + tech stack | Establish global perspective |
| Chapter 2 | Architecture overview + module relationships | Understand system skeleton |
| Chapters 3-N | Deep dive into each core module | Module-by-module exploration |
| Second-to-last | Cross-cutting concerns (error handling, config, security) | Engineering practices |
| Last chapter | Summary + extension directions | Wrap-up |

**Chapter count guidance** (AI auto-adaptive):
- Small project (<10 core files): 3-5 chapters
- Medium project (10-50 core files): 5-8 chapters
- Large project (50+ core files): 8-12 chapters

**Do NOT present the outline for approval** — just build it. The user wants an ebook, not a planning document.

### Phase 2.5: Chapter Briefs (Complex Projects Only)

If the codebase has 6+ chapters, write a brief for each chapter before generating content. This enables parallel writing.

Read `references/chapter-brief-template.md` for the template structure.

**For each chapter, write a brief to `ebook-name/briefs/0N-slug.md` containing:**
- Teaching objective (what the reader should understand)
- Pre-extracted code snippets (copy-pasted from codebase with file paths)
- Mermaid diagram plans (what to diagram and why)
- Chapter structure outline
- Connections to previous/next chapters

The pre-extracted code is critical — it allows writing agents to work without re-reading the codebase.

### Phase 3: Chapter Content Generation

Generate each chapter as a Markdown file. Use the standard structure:

```markdown
# Chapter N: Title

> 📌 Core question: [What this chapter answers]

## N.1 Overview
[2-3 paragraphs introducing the module/topic]

## N.2 Architecture & Design
[Mermaid diagram + explanation of relationships and design decisions]

## N.3 Core Code Walkthrough
[Key functions/classes with code blocks + detailed explanations]

## N.4 Design Decisions
[Tables comparing choices, trade-offs, rationale]

## N.5 Summary
[Key takeaways + connection to next chapter]
```

**Rich elements to use** (read `references/rich-elements.md` for detailed patterns):

| Element | Guidance Source | Purpose |
|---------|----------------|---------|
| Mermaid diagrams | `.skills/mermaid-diagrams/SKILL.md` + its `references/` | Architecture, flows, ERDs, C4 diagrams |
| Code blocks | `references/rich-elements.md` | Core code showcase with file path comments |
| Tables | `references/rich-elements.md` | Design decision comparisons, API docs |
| Callouts | `references/rich-elements.md` | Design highlights, caveats, best practices |

**Mermaid diagram generation**: Before writing any Mermaid diagrams, read `.skills/mermaid-diagrams/SKILL.md` for diagram type selection (class, sequence, flowchart, ERD, C4, state, etc.) and best practices. For complex diagrams, consult the corresponding `references/*.md` file in the mermaid-diagrams skill for detailed syntax and patterns.

**Content guidelines** (read `references/content-guidelines.md` for full details):
- Assume programming knowledge — don't explain basics
- Explain design decisions — WHY this pattern, not just WHAT
- Code first, then explain — show the code, then walk through it
- Use original code only — exact copies, never modified
- Tables for comparisons — choices, alternatives, trade-offs
- One core concept per section
- Connect chapters — each ends with bridge to next

**Writing paths:**
- **Sequential** (<6 chapters simple codebases): 
For codebases with less than 6 chapters, write modules one at a time. Write the content of each chapter in order, and output the document for each chapter to `ebook-name/chapters/`. Read `references/content-guidelines.md` to guide content generation.

- **Parallel** (≥6 chapters complex codebases): 
Dispatch subagents using Chapter Briefs. 
- Each subagent claims the brief document in the `ebook-name/briefs/` directory to complete writing the corresponding chapter content. 
- Each subagent is assigned a maximum of 3 briefs.

**Subagent instructions:**
- Each subagent MUST read `.skills/mermaid-diagrams/SKILL.md` before generating any Mermaid diagrams. For specific diagram types, consult the corresponding reference file (e.g., `.skills/mermaid-diagrams/references/sequence-diagrams.md` for sequence diagrams).
- Each subagent MUST read `references/content-guidelines.md` for writing style guidance.
- Subagents should NOT read the full codebase — all needed code snippets are pre-extracted in the brief document. This avoids unnecessary token waste.

The main Agent is responsible for monitoring the execution of subagent tasks. When all subagent tasks have been completed, the main agent needs to make a check to see if the `ebook-name/chapters/` directory contains all expected chapters. If there are any missing items, please continue to call up the subagent to complete the missing chapter.

### Phase 4: Assembly & Output

**Output directory structure:**
```
ebook-name/
  metadata.yaml           ← Book metadata (title, author, language)
  styles/
    html-book.css          ← Copied from references/
    epub-book.css          ← Copied from references/
  chapters/
    00-preface.md
    01-overview.md
    02-architecture.md
    ...
  briefs/                  ← Chapter Briefs (complex projects only)
  assets/                  ← Mermaid pre-rendered images (EPUB build)
  _base.html               ← HTML shell template
  _footer.html             ← HTML footer
  build-html.sh            ← Build HTML version
  build-epub.sh            ← Build EPUB version
  index.html               ← HTML output
  book.epub                ← EPUB output
```

**Step 1: Setup** — Create the ebook directory. Copy these files verbatim from `references/`:
- `references/html-book.css` → `ebook-name/styles/html-book.css`
- `references/epub-book.css` → `ebook-name/styles/epub-book.css`
- `references/_base.html` → `ebook-name/_base.html`
- `references/_footer.html` → `ebook-name/_footer.html`
- `references/build-html.sh` → `ebook-name/build-html.sh`
- `references/build-epub.sh` → `ebook-name/build-epub.sh`

**Step 2: Create metadata.yaml** — Write book metadata:
```yaml
---
title: "Project Name: Architecture Guide"
author: "Generated by AI"
date: "2026-01-15"
lang: en
---
```

**Step 3: Write chapters** — Generate chapter Markdown files to `ebook-name/chapters/`

**Step 4: Build output** — Run the appropriate build script:

For HTML:
```bash
cd ebook-name && bash build-html.sh
```

For EPUB:
```bash
cd ebook-name && bash build-epub.sh
```

**Critical rules:**
- Never regenerate CSS files — always copy from references
- Chapter files contain only Markdown content — no HTML boilerplate
- Mermaid diagrams are inline in Markdown for HTML output
- Mermaid diagrams are pre-rendered to SVG for EPUB output

### Phase 5: Review & Delivery

After building:
1. Inform the user where the output files are located
2. Provide preview guidance:
   - HTML: Open `index.html` in any browser
   - EPUB: Open `book.epub` in Kindle, iBooks, or any e-reader
3. Ask for feedback and offer per-chapter revisions if needed

---

## Reference Files

The `references/` directory contains detailed specs. **Read them only when you reach the relevant phase** — not upfront. This keeps context lean.

- **`references/content-guidelines.md`** — Writing style, content density, code explanation patterns
- **`references/chapter-brief-template.md`** — Template for Phase 2.5 briefs (complex projects)
- **`references/rich-elements.md`** — Callout syntax, table formatting, code block patterns
- **`references/gotchas.md`** — Common pitfalls checklist (read before Phase 4)
- **`references/html-book.css`** — Pre-built HTML stylesheet
- **`references/epub-book.css`** — Pre-built EPUB stylesheet
- **`references/_base.html`** — HTML shell template
- **`references/_footer.html`** — HTML footer template
- **`references/build-html.sh`** — HTML assembly script
- **`references/build-epub.sh`** — EPUB assembly script

**External dependency** (installed at runtime):
- **`.skills/mermaid-diagrams/`** — Comprehensive Mermaid diagramming guide with diagram type selection, syntax references, and best practices. Installed via `npx skills add` at the start of Phase 3.

---

## Content Philosophy

### For Technical Developers

Unlike codebase-to-course (for non-technical learners), this skill targets developers who already code. Key differences:

- **No basic explanations** — Don't explain what a function is
- **Focus on design** — WHY this architecture, WHAT trade-offs were made
- **Code density** — More code, less hand-holding
- **Static diagrams** — Mermaid architecture diagrams, not animated visualizations
- **Decision tables** — Compare choices explicitly

### Structure-Driven Narrative

The ebook arc moves from overview to detail:
1. **Preface + Overview** — What is this, who should read, tech stack
2. **Architecture** — System skeleton, module relationships
3. **Module Deep Dives** — Each core component explained
4. **Cross-Cutting Concerns** — Error handling, config, security
5. **Summary** — Key takeaways, extension points

This is different from codebase-to-course's experience-driven arc (user action → code trace).

---

## Example Interaction

**User**: "Turn this codebase into an ebook"

**AI**: "I can turn this codebase into a professional technical ebook — an architecture guide that teaches how the system is designed.

Which format would you like?
- HTML — Open in any browser, interactive diagrams
- EPUB — Read on Kindle or e-readers

I'll start by analyzing the codebase to understand its structure and design..."

[Phase 1: Analysis]
[Phase 2: Chapter design]
[Phase 3: Content generation]
[Phase 4: Build]

**AI**: "Your ebook is ready! I've generated:
- `index.html` — HTML version (open in browser)
- `book.epub` — EPUB version (open in e-reader)

The book includes 6 chapters covering the architecture, core modules, and design decisions. Would you like me to adjust any specific chapter?"
