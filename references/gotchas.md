# Gotchas Checklist

Common pitfalls when generating ebooks from codebases. Review this before delivery.

---

## Code Integrity

### ❌ NEVER modify original code
**Problem:** Changing variable names, restructuring, or "cleaning up" code in examples.

**Why it matters:** The ebook must reflect the actual codebase. Modified code breaks trust and creates confusion when readers reference the source.

**How to fix:**
- Copy code exactly as written
- Use ellipsis (`...`) to show omitted sections instead of rewriting
- Add comments OUTSIDE code blocks if clarification is needed
- If code quality is poor, note it in prose, don't fix it in the example

---

## Mermaid Diagrams

### ❌ Invalid Mermaid syntax
**Problem:** Broken arrows (`->` instead of `-->`), missing quotes on labels with spaces, invalid node IDs with special characters.

**Common errors:**
- `A -> B` instead of `A --> B`
- `[User Input]` instead of `["User Input"]` (spaces need quotes)
- Node IDs with hyphens/dots: `API-Handler` breaks in some contexts
- Missing semicolons in complex diagrams

**How to fix:**
- Validate syntax at https://mermaid.live before including
- Use quotes for labels: `A["API Handler"] --> B["Data Store"]`
- Keep node IDs simple: `apiHandler` not `API-Handler`
- End complex statements with semicolons

### ❌ Forgetting EPUB Mermaid pre-rendering
**Problem:** Mermaid code blocks work in Markdown viewers but break in EPUB readers.

**How to fix:**
- Generate PNG/SVG from Mermaid diagrams
- Include rendered images in EPUB output
- Keep Mermaid source in comments for Markdown version

---

## Markdown Structure

### ❌ Broken Markdown tables
**Problem:** Misaligned pipes, missing header separators, unescaped pipes in content.

**Example of broken table:**
```markdown
| Column 1 | Column 2 |
| Value with | pipe inside |
```

**How to fix:**
- Escape pipes in content: `Value with \| pipe inside`
- Align pipes (improves readability): 
```markdown
| Column 1         | Column 2          |
|------------------|-------------------|
| Value            | Another value     |
```
- Validate table renders correctly before delivery

### ❌ Inconsistent heading levels
**Problem:** Jumping from `#` to `###`, using `##` for subsections of `####`.

**How to fix:**
- Structure must be hierarchical: `#` → `##` → `###` → `####`
- Never skip levels
- Each chapter starts with `#` (or `##` if book title is `#`)

### ❌ Missing file path annotations on code blocks
**Problem:** Code examples without source file reference.

**How to fix:**
- Annotate every code block:
  ````markdown
  ```typescript
  // src/components/Button.tsx
  export const Button = () => { ... }
  ```
  ````
- Use comments appropriate to language (// for JS/TS, # for Python, <!-- --> for HTML)

---

## Chapter Quality

### ❌ Too-short chapters
**Problem:** Chapters under 500 words feel incomplete and lack depth.

**How to fix:**
- Combine small sections into coherent chapters
- Add context, examples, and connections to other chapters
- Aim for 800-2000 words per chapter (adjust based on complexity)

### ❌ Too-long chapters
**Problem:** Chapters over 3000 words become overwhelming and hard to navigate.

**How to fix:**
- Split into logical sub-chapters
- Use clear section breaks with `##` headings
- Consider breaking into separate chapters if topics diverge

### ❌ Missing chapter connections
**Problem:** Chapters feel isolated, no flow between sections.

**How to fix:**
- Add forward references: "We'll explore this in Chapter 5"
- Add backward references: "As we saw in Chapter 2..."
- Include a "Where we are" paragraph at chapter start
- End with "Next up" or "Coming next" transition

---

## Terminology

### ❌ Inconsistent terminology
**Problem:** Switching between "handler" and "controller", "repo" and "repository", "DB" and "database".

**How to fix:**
- Create a terminology glossary during Phase 1
- Stick to codebase's preferred terms
- If codebase is inconsistent, pick ONE term and use it throughout
- Note the choice in `decisions.md`

---

## Output Formats

### ❌ CSS that EPUB readers can't handle
**Problem:** Advanced CSS (flexbox, grid, custom fonts) breaks in EPUB readers.

**Common issues:**
- `display: flex` not supported in older readers
- Custom fonts may not embed correctly
- Absolute positioning breaks pagination

**How to fix:**
- Use simple, semantic HTML: `<strong>`, `<em>`, `<code>`
- Stick to basic CSS: margins, padding, font-size, color
- Test in multiple EPUB readers (Calibre, Apple Books, Google Play Books)
- Provide fallback styles

---

## Pre-Delivery Review

### ✅ Final checklist before delivery
- [ ] No code modifications (compared original vs ebook)
- [ ] All Mermaid diagrams render correctly
- [ ] All code blocks have file path annotations
- [ ] No broken Markdown tables
- [ ] Heading hierarchy is correct (no skipped levels)
- [ ] Chapter lengths are appropriate (800-2000 words)
- [ ] Terminology is consistent throughout
- [ ] Chapter transitions exist
- [ ] EPUB-specific: Mermaid diagrams are pre-rendered
- [ ] EPUB-specific: CSS uses only safe properties
- [ ] Cross-references are accurate (chapter numbers, section titles)

---

## Recording New Gotchas

When you discover a new pitfall during work:
1. Add it to this file immediately
2. Include clear "How to fix" instructions
3. Note it in `.sisyphus/notepads/{plan}/learnings.md`
