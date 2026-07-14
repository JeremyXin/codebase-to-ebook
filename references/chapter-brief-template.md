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
and which knowledge point it serves (from the Knowledge Point Plan below). The writing
agent uses these notes when the pre-extracted snippets below are not self-explanatory:

- **HOOK:** [What question or scenario opens this chapter]
- **CONCEPT-FOUNDATION:** [Concept to define] — serves core point #[N] / concept-foundation layer
- **MECHANISM:** [Principle to explain] — serves core point #[N] / principle layer
- **CODE-WALKTHROUGH:** [Specific code] — serves core point #[N] (implementation layer) or secondary point [name] (single-layer pass)
- **[ELEVATION BLOCK]:** [What it reveals] — serves core point #[N] / elevation layer
- **RECAP-BRIDGE:** [What the reader now understands + what problem the next chapter introduces]

---

## Knowledge Point Plan

> **Purpose:** Divide this chapter's content by importance so the writing agent spends depth where it matters. Each tier maps to a depth chain (see `references/block-reference.md` → Depth Chain Rules). The writing agent MUST satisfy the hard minimums for each core point.

### Core Knowledge Points (max 2-3)
> Each core point walks the full depth chain: CONCEPT-FOUNDATION → MECHANISM → CODE-WALKTHROUGH → [elevation block]. Allocate the majority of the chapter's word budget here. Core points must have ≥3 depth layers and ≥1 elevation block after their CODE-WALKTHROUGH.

| # | Core Point | Depth Chain (blocks used) | Concept Requiring Foundation | Elevation Block |
|---|------------|---------------------------|------------------------------|-----------------|
| 1 | [e.g., Reactor threading model] | CONCEPT-FOUNDATION → MECHANISM → CODE-WALKTHROUGH → MINI-DEMO → DESIGN-DECISION | Reactor pattern | MINI-DEMO |
| 2 | [e.g., Task queue I/O ratio] | CONCEPT-FOUNDATION → CODE-WALKTHROUGH → DESIGN-DECISION | ioRatio | DESIGN-DECISION |
| 3 | [...] | [...] | [...] | [...] |

### Secondary Knowledge Points (pass over)
> A single CODE-WALKTHROUGH pass is enough. Do not elevate unless it reveals a core point.

- [e.g., Task queue scheduling] → CODE-WALKTHROUGH only
- [e.g., Channel lifecycle states] → CODE-WALKTHROUGH only

### Domain Concepts Requiring Foundation (route to CONCEPT-FOUNDATION)
> Concepts the reader has not met and that must be defined before the core chain lands. One CONCEPT-FOUNDATION block per distinct concept (fold minor concepts into the major one).

- [e.g., ByteBuf] → CONCEPT-FOUNDATION before CODE-WALKTHROUGH #1
- [e.g., Backpressure] → CONCEPT-FOUNDATION before MECHANISM

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

> Removed. Chapter structure is defined entirely by the **Chapter Structure** section above (block sequence + Per-Block Content Notes) together with the **Knowledge Point Plan**. Do not write a separate "Section 1/2/3 ~500 words" outline — it duplicates and conflicts with the block sequence. Each `##` heading in the chapter corresponds to a block; each block's depth is set by its tier in the Knowledge Point Plan.

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
- [ ] Block sequence matches the Knowledge Point Plan depth chains (core points have ≥3 layers + ≥1 elevation block)
- [ ] Word count is within target range
- [ ] Transitions to prev/next chapters are present
- [ ] Every core knowledge point has ≥3 depth layers including an elevation block after its CODE-WALKTHROUGH
- [ ] Every concept under "Domain Concepts Requiring Foundation" has a CONCEPT-FOUNDATION block before the code that uses it
- [ ] No 3+ consecutive CODE-WALKTHROUGH blocks without an elevation block between
- [ ] Chapter does not end on a core-point CODE-WALKTHROUGH
- [ ] Teaching objective is clearly addressed
- [ ] Tone matches project requirements
- [ ] No new codebase exploration was needed (all snippets pre-provided)

---

**Template Version:** 1.0  
**Last Updated:** [Date]
