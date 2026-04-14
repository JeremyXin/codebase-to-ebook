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

Before writing any content, thoroughly understand the codebase through a structured, progressive analysis.

**Figure out what the system does yourself** by reading the README, entry points, and core modules. Don't ask the user to explain the project — they may not know it either.

#### Analysis Strategy: Three-Layer Progressive Reading

Read files in priority order. Do not read all files upfront — expand scope only when needed.

**Layer 1 — Orientation (always read these first):**
- `README.md` / `README.rst` — project purpose, tech stack, architecture notes
- Directory structure (2-3 levels deep) — organizational patterns
- Entry points — `main.*`, `index.*`, `app.*`, `server.*`, `cmd/`
- Dependency manifest — `package.json`, `go.mod`, `pom.xml`, `requirements.txt`, `Cargo.toml`
  - Purpose: infer frameworks, core libraries, and responsibility boundaries from dependencies

**Layer 2 — Core Module Sampling (based on Layer 1 findings):**
- Identify directory types and read representative files from each:
  - Core business directories (`src/core/`, `internal/`, `lib/`) — read the most complex files
  - Interface definitions (`api/`, `interfaces/`, `types/`) — read all (usually few files)
  - Configuration (`config/`, `settings/`) — read default config file
  - Tests (`test/`, `__tests__/`) — read 1 integration test to understand expected behavior
- Skip directories: `vendor/`, `node_modules/`, `dist/`, `build/`, generated code

**Layer 3 — Targeted Deep Exploration (on-demand, not default):**
Trigger only when:
- A module is referenced by multiple others but hasn't been read yet
- An important interface is found but its implementation is missing
- Dependency relationships are unclear — can't trace the data flow

For **large projects** (50+ core files): prioritize files with the highest in-degree (most depended upon by other modules).

#### Stop Condition

Stop reading when you can answer all three:
1. **Data flow**: What is the core request/data path? (entry → processing → output)
2. **Module boundaries**: What does each module own, and what are the dependency directions?
3. **Design decisions**: What are the notable architectural choices and their visible rationale?

If all three are answerable, proceed to output — do not keep reading for completeness.

#### Phase 1 Output: `analysis-notes.md`

After analysis, **immediately** write `ebook-name/analysis-notes.md` with the following structure. This file is the single source of truth for all subsequent phases — no phase should rely on chat history for codebase understanding.

```markdown
# Analysis Notes: {Project Name}

## Project Overview
- **Purpose:** [One sentence]
- **Tech Stack:** [Language / Framework / Key libraries]
- **Scale:** [File count, module count, approximate LOC]
- **Output Language:** [Detected from user's conversation language, e.g., "zh-CN", "en"]

## Module Map
| Module | Path | Responsibility | Key Files | Depended-on By |
|--------|------|----------------|-----------|---------------|

## Dependency Graph
[Module A] → [Module B], [Module C]
[Module B] → [Module D]

## Core Data Flow
[Entry Point] → [Step 1: what happens] → [Step 2] → ... → [Output]

## Design Decision Clues
- [ADR / why-comment / TODO-FIXME / refactoring evidence with file locations]

## Code Snippet Index
> Purpose: Pre-register code snippets suitable for chapter examples.
> Phase 2.5 briefs will reference this index directly instead of re-scanning the codebase.

| Module | File:Lines | What It Shows | Suitable For Block |
|--------|-----------|---------------|-------------------|
| [e.g., Auth] | [src/auth/jwt.ts:45-78] | [JWT validation logic] | [CODE-WALKTHROUGH] |

## Terminology
| Term in Codebase | Standardized Term for Ebook | Notes |
|-----------------|---------------------------|-------|
| [e.g., "handler" and "controller" both used] | [controller] | [Standardize to match the dominant usage] |
```

**This file enables:**
- Phase 2: chapter selection based on Module Map and Dependency Graph
- Phase 2.5: brief writing using Code Snippet Index (no codebase re-reading)
- Phase 3: writing agents reference Terminology for consistency
- Resumption: any interrupted session can read this file to restore full context

### Phase 2: Chapter Structure Design

Using the `analysis-notes.md` from Phase 1, determine which chapters the book needs and in what order.

#### Typical Book Arc

| Position | Typical Content | Purpose |
|----------|----------------|---------|
| Preface | Project intro, who should read, how to read | Set expectations |
| Chapter 1 | Project overview + tech stack | Establish global perspective |
| Chapter 2 | Architecture overview + module relationships | Understand system skeleton |
| Chapters 3-N | Deep dive into each core module | Module-by-module exploration |
| Second-to-last | Cross-cutting concerns (error handling, config, security) | Engineering practices |
| Last chapter | Summary + extension directions | Wrap-up |

#### Chapter Selection Rules

Use the Module Map and Dependency Graph from `analysis-notes.md` to decide chapter topics.

**Rule 1 — When a module deserves its own chapter:**
A module gets its own chapter if it meets **two or more** of these criteria:
- **Depended-on breadth:** 3+ other modules directly depend on it
- **Code volume:** module has ≥3 files or a core file ≥300 lines
- **Conceptual independence:** it exposes its own abstraction (interface, core class, protocol) that other modules consume
- **README prominence:** it has a dedicated section in the project README
- **Design decision density:** contains visible technical choices (ADRs, why-comments, multiple implementations)

**Rule 2 — When modules should be merged into one chapter:**
Merge when **any one** of these applies:
- Both modules individually fail to meet Rule 1 criteria
- Two modules are conceptually inseparable — explaining one without the other creates a gap (e.g., Encoder/Decoder, Request/Response)
- One module is a dedicated utility for another with no independent conceptual value

**Rule 3 — Chapter ordering (by cognitive dependency):**
Order chapters by what the reader needs to understand first, not by code dependency:
1. Fixed positions: Preface → Overview → Architecture (always first three)
2. Deep Dive chapters: order by **data flow position** — modules closer to the entry point come first; if tied, modules with higher in-degree (depended upon by more others) come first
3. Cross-cutting concerns chapters: placed after all Deep Dive chapters (the reader needs full context). A topic becomes a cross-cutting chapter when it appears in 3+ Deep Dive chapters but belongs to no single module (e.g., error handling, configuration, auth)
4. Final chapter: Summary / Extension Points (always last)

**Rule 4 — When to split a module into multiple chapters:**
Split when **any one** of these applies:
- The module contains two conceptually independent subsystems (e.g., Netty's Channel vs Pipeline)
- A single chapter would exceed ~4000 words and still not cover the core content
- The module has distinct "usage layer" and "implementation layer" that serve different reader needs

**Rule 5 — Chapter count sanity check:**
After selection, validate against project scale:
- Small project (<10 core files): 3-5 chapters
- Medium project (10-50 core files): 5-8 chapters
- Large project (50+ core files): 8-12 chapters

If the count exceeds the range, look for Rule 2 merge candidates. If below the range, check for missing cross-cutting concerns.

#### Chapter List Output

Record the final chapter list in `analysis-notes.md` by appending a `## Chapter Plan` section:

```markdown
## Chapter Plan
| # | Title | Type | Source Modules | Rationale |
|---|-------|------|---------------|-----------|
| 0 | Preface | preface | — | Standard |
| 1 | ... | overview | — | Standard |
| 2 | ... | architecture | all | Standard |
| 3 | ... | deep-dive | [Module A] | [Why independent: high in-degree, conceptual independence] |
| 4 | ... | deep-dive | [Module B, C] | [Why merged: B is C's utility, no independent value] |
| ... | | | | |
| N-1 | ... | cross-cutting | — | [Appears in Ch3, Ch4, Ch5] |
| N | ... | summary | — | Standard |
```

**Do NOT present the outline to the user for approval** by default — just build it. If the user explicitly requests to review the chapter structure, present the Chapter Plan table and wait for confirmation before proceeding.

### Phase 2.5: Chapter Briefs

Write a brief for **every chapter** before generating content. Briefs serve as the contract between the main agent and writing subagents — they externalize the plan so writing agents don't need codebase access or chat history.

Read `references/chapter-brief-template.md` for the full template structure.

#### Brief Scale

| Project Size | Brief Format | Rationale |
|-------------|-------------|-----------|
| **<6 chapters** | **Lightweight brief** — 4 fields only | Small projects don't need full briefs; overhead would approach the writing cost itself |
| **≥6 chapters** | **Full brief** — complete template | Complex projects need full context for parallel subagents |

**Lightweight brief** (for <6 chapters) — write to `ebook-name/briefs/0N-slug.md`:
```markdown
## Teaching Objective
[Core learning goal for this chapter]

## Block Sequence
HOOK → [BLOCK] → ... → RECAP-BRIDGE
[Structure rationale: 2-3 sentences on why these blocks in this order]

## Key Code Snippets
[Copy from analysis-notes.md Code Snippet Index — paste relevant snippets with file paths]

## RECAP-BRIDGE Notes
[What the reader now understands + what problem the next chapter introduces]
```

**Full brief** (for ≥6 chapters) — use the complete `references/chapter-brief-template.md` template.

#### Code Snippet Selection

When populating briefs, select code snippets from `analysis-notes.md`'s Code Snippet Index using these criteria:
- **Entry points** — how the module is invoked from outside
- **High-dependency files** — files imported/referenced by the most other files
- **Core business logic** — functions that implement the module's primary responsibility
- **Design pattern exemplars** — code that best illustrates a design decision

Each brief should include 2-5 snippets. Do not re-read the codebase — all snippets should come from the Phase 1 index.

### Phase 3: Chapter Content Generation

Generate each chapter as a Markdown file by executing the **building block sequence** defined in that chapter's Brief.

**Chapter structure is content-driven, not template-driven.** Each chapter's Brief specifies which building blocks to use and in what order — chosen to best serve that chapter's teaching objective. Two chapters covering different topics will have different structures.

**Before writing any chapter, read:**
- `references/block-reference.md` — rules, typical structure, and examples for each building block
- `references/content-guidelines.md` — global quality standards (voice, density, code patterns) that apply to all blocks

**Every chapter must start with HOOK and end with RECAP-BRIDGE.** All blocks in between come from the Brief's specified sequence.

**Block execution:** For each block in the sequence, consult `references/block-reference.md` for that block's content rules and structure. The Brief's "Per-Block Content Notes" provide chapter-specific guidance on what each block should cover.

**Mermaid diagrams:** Before writing any Mermaid diagram (used in BIG-PICTURE-DIAGRAM, MECHANISM, SEQUENCE-FLOW, and others), read `.skills/mermaid-diagrams/SKILL.md` for diagram type selection and best practices. For complex diagrams, consult the relevant `references/*.md` file in the mermaid-diagrams skill.

**Rich elements reference** (`references/rich-elements.md`):

| Element | Relevant Blocks | Purpose |
|---------|----------------|---------|
| Mermaid diagrams | BIG-PICTURE-DIAGRAM, MECHANISM, SEQUENCE-FLOW | Architecture, flows, ERDs, C4 diagrams |
| Code blocks | CODE-WALKTHROUGH, MINI-DEMO | Codebase code with file path; skeleton demos |
| Tables | DESIGN-DECISION, COMPARISON | Trade-off comparisons, decision matrices |
| Callouts | Any block | Design highlights, caveats — max 2 per chapter |

#### Writing Model: Always Multi-Agent

All chapters are written by dispatched subagents, regardless of project size. The main agent's role is orchestration: writing briefs, dispatching agents, monitoring completion, and handling validation.

| Project Size | Dispatch Strategy |
|-------------|------------------|
| **<6 chapters** | Dispatch subagents — 1 brief per subagent |
| **≥6 chapters** | Dispatch subagents — up to 3 briefs per subagent |

**Subagent instructions:**
- Each subagent MUST read `references/block-reference.md` before writing — the Brief specifies the block sequence; the block reference defines the rules for each block.
- Each subagent MUST read `.skills/mermaid-diagrams/SKILL.md` before generating any Mermaid diagrams. For specific diagram types, consult the corresponding reference file (e.g., `.skills/mermaid-diagrams/references/sequence-diagrams.md` for sequence diagrams).
- Each subagent MUST read `references/content-guidelines.md` for global quality standards.
- Subagents should NOT read the full codebase — all needed code snippets are pre-extracted in the brief document. This avoids unnecessary token waste.
- Output each chapter to `ebook-name/chapters/`.

**Main agent monitoring:**
The main agent monitors subagent execution. When all subagents complete, check `ebook-name/chapters/` for all expected chapter files (compare against the Chapter Plan in `analysis-notes.md`). If any chapters are missing, dispatch additional subagents to complete them.

### Phase 3.5: Chapter Content Validation

After chapters are written to `ebook-name/chapters/`, validate each chapter against **all rules** in `references/content-guidelines.md`. This is a mandatory quality gate before proceeding to assembly.

**Scope: content quality.** Phase 3.5 checks writing quality, structure, and style. Technical correctness (Mermaid syntax, Markdown rendering, EPUB compatibility) is checked separately before Phase 4 using `references/gotchas.md`.

**Validation model: the validation subagent is read-only.** It inspects the chapter, produces a structured report, and never modifies the file. A separate repair subagent is responsible for fixing any issues.

#### Validation Subagent Prompt Template

When dispatching a validation subagent for a chapter, use this prompt structure:

```
TASK: Validate the chapter at `{chapter_path}` against ALL rules in
`references/content-guidelines.md`.

EXPECTED OUTCOME: A structured validation report (format below) with a
PASS/FAIL verdict and item-level details.

REQUIRED TOOLS: Read (chapter file, references/content-guidelines.md,
ebook-name/analysis-notes.md for Output Language field)

MUST DO:
- Read `references/content-guidelines.md` completely before checking.
- Check every rule in the document, including but not limited to:
  □ Text ratio: prose must not exceed 60% of the chapter; code/diagrams ≥40%.
  □ Paragraph length: no single paragraph exceeds 10 lines.
  □ Code-first pattern: code blocks appear before their explanations.
  □ One concept per section: each section covers exactly one core concept.
  □ Design decisions: rationale ("why") is documented, not just "what."
  □ Mermaid diagrams: at least one diagram exists in chapters covering
    inter-module relationships.
  □ Callout restraint: no more than 2 callouts per logical page.
  □ Chapter connection: chapter ends with a forward-linking paragraph to
    the next chapter (except the final chapter).
  □ No AI-slop phrases: "delve", "leverage", "robust", "utilize",
    "facilitate", "comprehensive", etc.
  □ No em dashes or en dashes (— or –).
  □ Voice and tone: active voice, contractions, direct and technical tone.
  □ Information density: no filler phrases, every paragraph delivers value.
  □ Section structure: opening sentence → code example → explanation →
    trade-offs → connection.
  □ Metaphor quality: metaphors (if any) are natural, varied, and not
    recycled across sections.
  □ Output language: chapter prose matches the target language recorded
    in `ebook-name/analysis-notes.md` (Output Language field). Code
    snippets, variable names, and file paths remain in their original
    language regardless.
- For each FAIL item, provide the specific location (section/paragraph)
  and a concrete, actionable fix suggestion.

MUST NOT DO:
- Do NOT modify the chapter file.
- Do NOT rewrite or generate alternative content.
- Do NOT add commentary outside the report format.

CONTEXT:
- Chapter file: `{chapter_path}`
- Guidelines: `references/content-guidelines.md`
- Chapter brief: `{brief_path}`
- Previous/next chapter titles: `{prev_title}` / `{next_title}`
```

#### Validation Report Format

The validation subagent must output its report in this structure:

```markdown
## Validation Report: {filename}

**Verdict: PASS | FAIL**

### Passed ✅
- [x] Item description

### Failed ❌
- [ ] **{Rule name}** — {Problem description}. Location: {section/paragraph}.
      Suggested fix: {concrete action}.

### Summary
{1-2 sentences: overall quality assessment and highest-priority fixes if FAIL}
```

#### Validation Flow

After all writing subagents complete and the main agent confirms all chapters exist:

1. **Batch dispatch** validation subagents — one per chapter, all in parallel.
2. Collect all validation reports.
3. For chapters that **PASS** — no further action.
4. For chapters that **FAIL** — dispatch repair subagents (one per failed chapter, in parallel). Each repair subagent receives:
   - The chapter file path
   - The validation report (full text)
   - `references/content-guidelines.md` for reference
   - Instructions to fix only the items listed in the report
5. After repair subagents complete, re-dispatch validation subagents for the repaired chapters.
6. Repeat the validate-repair cycle up to **3 rounds** per chapter.
7. Chapters still failing after 3 rounds, mark with a comment at the top of the file:
   ```markdown
   <!-- VALIDATION: NEEDS MANUAL REVIEW — failed after 3 validation rounds -->
   ```
   Then continue the pipeline — do not block.

**Repair subagent instructions:**
- Read the validation report and the chapter file.
- Fix only the specific issues identified in the report.
- Do NOT rewrite unrelated sections.
- Read `references/content-guidelines.md` if the report references rules you need to understand.
- Output the fixed chapter to the same file path, overwriting the previous version.

#### Validation Efficiency Notes

- Validation subagents are lightweight — they only read two files (chapter + guidelines). Keep them fast.
- Launch all validation subagents simultaneously to minimize wall-clock time.
- Repair subagents should fix surgically: address report items, nothing else.
- The 3-round cap prevents infinite loops. Most chapters should pass within 1-2 rounds.

### Phase 4: Assembly & Output

**Before assembly, read `references/gotchas.md` for technical correctness checks.** Phase 3.5 validated content quality; `gotchas.md` covers a different dimension — Mermaid syntax validity, Markdown rendering, heading hierarchy, code block annotations, EPUB compatibility, and terminology consistency. Fix any gotchas issues before building.

**Output directory structure:**
```
ebook-name/
  analysis-notes.md        ← Phase 1 output: project analysis + code snippet index
  metadata.yaml           ← Book metadata (title, author, language)
  styles/
    html-book.css          ← Copied from references/
    epub-book.css          ← Copied from references/
  chapters/
    00-preface.md
    01-overview.md
    02-architecture.md
    ...
  briefs/                  ← Chapter Briefs (all projects)
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

**Step 2: Create metadata.yaml** — Write book metadata. Read the `Output Language` field from `ebook-name/analysis-notes.md` for the `lang` value:
```yaml
---
title: "Project Name: Architecture Guide"
author: "Generated by AI"
date: "2026-01-15"
lang: en  # ← Use value from analysis-notes.md Output Language field
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

## Context Management & Resumption

### Why This Matters

Generating a full ebook can span long sessions. The LLM context window is finite — early content gets pushed out. Every phase produces persistent files so that no phase depends on chat history.

### Context Externalization Map

| Phase | Persistent Output | What It Preserves |
|-------|------------------|-------------------|
| Phase 1 | `ebook-name/analysis-notes.md` | Project understanding, module map, code snippet index, terminology |
| Phase 2 | `analysis-notes.md` → `## Chapter Plan` | Chapter list with types and rationale |
| Phase 2.5 | `ebook-name/briefs/0N-slug.md` | Per-chapter structure, block sequence, pre-extracted code |
| Phase 3 | `ebook-name/chapters/0N-slug.md` | Written chapter content |
| Phase 3.5 | Validation reports (in agent output) | Pass/fail status per chapter |
| Phase 4 | `ebook-name/index.html` or `book.epub` | Final assembled output |

### Resumption Protocol

If a session is interrupted (token exhaustion, network disconnect, manual stop), resume as follows:

1. Read `ebook-name/analysis-notes.md` → restore project understanding
2. Read `## Chapter Plan` in analysis-notes → know what chapters are planned
3. List `ebook-name/briefs/` → know which briefs are written
4. List `ebook-name/chapters/` → know which chapters are completed
5. Compare briefs vs chapters → identify incomplete chapters
6. Check for `<!-- VALIDATION: NEEDS MANUAL REVIEW -->` markers → identify chapters needing attention
7. Resume from the earliest incomplete phase:
   - Missing analysis-notes → restart from Phase 1
   - Missing briefs → restart from Phase 2.5
   - Missing chapters → dispatch writing subagents for missing chapters only
   - All chapters present but no build output → proceed to Phase 4

**Never re-read the full codebase on resumption.** The analysis-notes and briefs contain everything needed.

---

## Reference Files

The `references/` directory contains detailed specs. **Read them only when you reach the relevant phase** — not upfront. This keeps context lean.

- **`references/content-guidelines.md`** — Writing style, content density, code explanation patterns (global quality standards for all blocks)
- **`references/block-reference.md`** — The 11 building blocks: trigger conditions, content rules, typical structure, examples, and block relationships
- **`references/chapter-brief-template.md`** — Template for Phase 2.5 briefs (complex projects), including Chapter Structure with block sequence
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
