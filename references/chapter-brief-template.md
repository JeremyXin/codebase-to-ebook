# Chapter Brief Template

## Chapter Metadata

**Chapter Number:** [e.g., 3]  
**Chapter Title:** [e.g., "State Management with Redux"]  
**Word Count Target:** [e.g., 2500-3000 words]

---

## Teaching Objective

**What should the reader understand after this chapter?**

[Describe the core learning goal. Be specific. Example: "The reader should understand how Redux manages global state through actions, reducers, and the store, and be able to implement a basic Redux setup in a React app."]

**Key Concepts to Cover:**
- [Concept 1: e.g., "Store as single source of truth"]
- [Concept 2: e.g., "Actions as plain objects describing changes"]
- [Concept 3: e.g., "Reducers as pure functions"]

---

## Chapter Structure

> **Purpose:** Define the building block sequence for this chapter. The writing agent follows this sequence exactly. Refer to `references/block-reference.md` for each block's rules and examples.

**Block Sequence:**

```
HOOK → [BLOCK] → [BLOCK] → ... → RECAP-BRIDGE
```

[Replace the placeholders with the chosen blocks in order. Example:
`HOOK → BIG-PICTURE-DIAGRAM → MECHANISM → CODE-WALKTHROUGH → MINI-DEMO → RECAP-BRIDGE`]

**Structure Rationale:**

[Explain why this specific block sequence best serves this chapter's teaching objective.
Cover: why each selected block was included, why blocks were ordered this way, and
which blocks from the full list were deliberately excluded and why.

Example: "This chapter's core insight is the Reactor threading model — a mechanism
the reader can't intuit from API usage alone. BIG-PICTURE-DIAGRAM establishes spatial
orientation first. MECHANISM explains the select-loop design and why it solves the
thread-per-connection problem. CODE-WALKTHROUGH grounds the explanation in NioEventLoop.
MINI-DEMO strips the 800-line class to 30 lines of plain NIO to crystallize the core.
ANALOGY and COMPARISON were excluded — MECHANISM + MINI-DEMO are sufficient, and
stacking more explanatory blocks would slow the chapter's pace."]

**Per-Block Content Notes:**

For each block in the sequence, briefly note what specific content it should contain
(the writing agent uses these notes when the pre-extracted snippets below are not
self-explanatory):

- **HOOK:** [What question or scenario opens this chapter]
- **[BLOCK]:** [What specific content, diagram, or code this block covers]
- **[BLOCK]:** [...]
- **RECAP-BRIDGE:** [What the reader now understands + what problem the next chapter introduces]

---

## Pre-Extracted Code Snippets

> **Purpose:** These snippets are pre-selected from the codebase. Subagents writing the chapter should use these directly without re-reading the codebase.

### Snippet 1: [Brief Description]

**File:** `src/path/to/file.js`  
**Lines:** 45-67  
**Purpose:** [What this snippet demonstrates, e.g., "Shows how the store is configured with middleware"]

```language
[Paste the actual code here]
```

**Teaching Notes:**
- [Point out key lines or patterns]
- [Explain why this code matters for the teaching objective]

---

### Snippet 2: [Brief Description]

**File:** `src/path/to/another-file.js`  
**Lines:** 12-28  
**Purpose:** [What this snippet demonstrates]

```language
[Paste the actual code here]
```

**Teaching Notes:**
- [Key observations]

---

[Add more snippets as needed]

---

## Mermaid Diagram Plans

> **Purpose:** Define what diagrams should be included and what they should illustrate.

### Diagram 1: [Diagram Title]

**Type:** [e.g., flowchart, sequence, class diagram]  
**Purpose:** [What the diagram explains, e.g., "Show the flow of an action from dispatch to state update"]

**Elements to Include:**
- [Element 1: e.g., "User action triggers dispatch()"]
- [Element 2: e.g., "Reducer processes action"]
- [Element 3: e.g., "Store updates and notifies subscribers"]

**Suggested Mermaid Syntax:**
```mermaid
[Provide a rough draft or outline of the Mermaid code, e.g.:]
flowchart LR
    A[User clicks button] --> B[dispatch action]
    B --> C[Reducer processes]
    C --> D[Store updates]
```

---

### Diagram 2: [Diagram Title]

**Type:** [e.g., class diagram]  
**Purpose:** [What it shows]

**Elements to Include:**
- [Key classes/components]

---

[Add more diagrams as needed]

---

## Chapter Structure Outline

> **Purpose:** Define the section breakdown and flow for this chapter.

### Introduction (200-300 words)
- Hook: [e.g., "State management becomes critical as apps scale"]
- Preview: [What will be covered in this chapter]
- Connection to previous chapter: [Brief reference]

### Section 1: [Section Title]
**Word Count:** ~500 words  
**Focus:** [What this section teaches]  
**Snippets Used:** [Reference Snippet 1, Snippet 3]  
**Diagrams Used:** [Reference Diagram 1]

**Key Points:**
- [Point 1]
- [Point 2]

---

### Section 2: [Section Title]
**Word Count:** ~600 words  
**Focus:** [What this section teaches]  
**Snippets Used:** [Reference Snippet 2]  
**Diagrams Used:** [None]

**Key Points:**
- [Point 1]
- [Point 2]

---

### Section 3: [Section Title]
**Word Count:** ~700 words  
**Focus:** [What this section teaches]  
**Snippets Used:** [Reference Snippet 4, Snippet 5]  
**Diagrams Used:** [Reference Diagram 2]

**Key Points:**
- [Point 1]
- [Point 2]

---

[Add more sections as needed]

### RECAP-BRIDGE (2-4 sentences)
- What the reader now understands that they didn't before (1-2 sentences)
- What problem the next chapter solves — and why it's necessary given what was just learned (1-2 sentences)
- Note: do NOT write a bullet-point summary of everything covered; this is a forward pass, not a recap list

---

## Connections to Other Chapters

### Previous Chapter Context
**Chapter [N-1] Title:** [e.g., "Component Architecture"]  
**What the reader already knows:**
- [Concept from previous chapter that this builds on]
- [Any setup or context established previously]

**How to reference it:**
- [e.g., "In the previous chapter, we built modular components. Now we need a way to share state between them."]

---

### Next Chapter Preview
**Chapter [N+1] Title:** [e.g., "Async Operations with Redux Thunk"]  
**What this chapter sets up:**
- [Concept this chapter introduces that the next builds on]
- [Any groundwork laid for the next topic]

**Transition hook:**
- [e.g., "Now that we understand synchronous state updates, we'll tackle async operations in the next chapter."]

---

## Additional Notes for Subagent

**Tone:** [e.g., "Conversational and beginner-friendly, avoid jargon"]  
**Audience:** [e.g., "Developers with basic React knowledge"]  
**Special Instructions:**
- [Any specific guidelines, e.g., "Avoid deep-diving into middleware; that's covered in Chapter 5"]
- [Any gotchas or common mistakes to address]

**Codebase Context:**
- [Brief overview of the project this codebase represents, e.g., "This is a task management app using React and Redux"]
- [Any architectural quirks the subagent should know]

---

## Checklist for Subagent

Before submitting the chapter draft, confirm:
- [ ] All pre-extracted snippets are used and explained
- [ ] All planned diagrams are included
- [ ] Chapter structure follows the outline
- [ ] Word count is within target range
- [ ] Transitions to prev/next chapters are present
- [ ] Teaching objective is clearly addressed
- [ ] Tone matches project requirements
- [ ] No new codebase exploration was needed (all snippets pre-provided)

---

**Template Version:** 1.0  
**Last Updated:** [Date]
