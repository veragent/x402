# Veragent Design Tokens

Protocol-style typography & spacing system for the Veragent web properties.

This document defines **design tokens**, not UI components.
It exists to keep the Veragent website:

* calm
* technical
* documentation-first
* non-marketing

These tokens MUST be followed by all frontend implementations.

---

## 1. Design Philosophy

Veragent UI is:

* informational, not promotional
* neutral, not persuasive
* precise, not decorative

Think:

* RFC documents
* Ethereum.org docs
* Cloudflare technical docs

Avoid:

* landing-page aesthetics
* brand-heavy visuals
* emotional color usage

---

## 2. Typography System

### Font Stack

Primary font stack (recommended):

```css
font-family: ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont,
             "Segoe UI", Roboto, Inter, Helvetica, Arial, sans-serif;
```

Monospace (code / identifiers):

```css
font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas,
             "Liberation Mono", "Courier New", monospace;
```

Do NOT introduce custom display fonts.

---

### Font Sizes (Rem-based)

| Token         | Size     | Usage               |
| ------------- | -------- | ------------------- |
| `--text-xs`   | 0.75rem  | footnotes, metadata |
| `--text-sm`   | 0.875rem | secondary text      |
| `--text-base` | 1rem     | body text           |
| `--text-lg`   | 1.125rem | lead paragraphs     |
| `--text-xl`   | 1.25rem  | section headings    |
| `--text-2xl`  | 1.5rem   | page headings       |
| `--text-3xl`  | 1.875rem | hero title          |

Avoid oversized typography.

---

### Line Height

| Context     | Line Height |
| ----------- | ----------- |
| Body text   | 1.6         |
| Headings    | 1.25        |
| Code blocks | 1.45        |

Readable > compact.

---

### Font Weight

| Weight | Usage             |
| ------ | ----------------- |
| 400    | body text         |
| 500    | emphasis / labels |
| 600    | headings          |

Avoid ultra-bold weights.

---

## 3. Spacing System

Use a **4px base grid**.

All spacing MUST be multiples of 4.

### Spacing Scale

| Token       | Value |
| ----------- | ----- |
| `--space-1` | 4px   |
| `--space-2` | 8px   |
| `--space-3` | 12px  |
| `--space-4` | 16px  |
| `--space-5` | 24px  |
| `--space-6` | 32px  |
| `--space-7` | 48px  |
| `--space-8` | 64px  |

Prefer vertical breathing room.

---

## 4. Layout Rules

### Max Width

| Context       | Max Width |
| ------------- | --------- |
| Docs / RFC    | 720px     |
| Whitepaper    | 760px     |
| General pages | 1024px    |

Avoid full-width reading layouts.

---

### Section Spacing

* Between major sections: `--space-7`
* Between headings and content: `--space-3`
* Between paragraphs: `--space-3`

---

## 5. Color Tokens

Color usage is intentionally minimal.

### Base Colors

| Token             | Value   | Usage           |
| ----------------- | ------- | --------------- |
| `--color-bg`      | #ffffff | page background |
| `--color-text`    | #111827 | primary text    |
| `--color-muted`   | #6b7280 | secondary text  |
| `--color-border`  | #e5e7eb | separators      |
| `--color-code-bg` | #f9fafb | code blocks     |

Dark mode MAY be introduced later via RFC.

---

### Accent Colors

Accent color usage MUST be restrained.

Allowed:

* links
* focus states
* subtle highlights

Avoid:

* gradients
* decorative color blocks
* emotional color signaling

---

## 6. Code Presentation

Code blocks are first-class citizens.

Rules:

* Monospace font
* Subtle background
* No syntax highlighting themes that overpower text
* Horizontal scrolling allowed

Inline code SHOULD be visually distinct but minimal.

---

## 7. Components (Guidance, Not Tokens)

Buttons:

* Rectangular
* Minimal border or fill
* No shadows

Links:

* Underlined or clear color differentiation

Cards:

* Flat
* Border-based
* No elevation

---

## 8. Motion & Animation

Motion should be minimal or non-existent.

Allowed:

* subtle hover state
* focus outline transitions

Avoid:

* entrance animations
* parallax
* attention-grabbing motion

---

## 9. Accessibility

* Semantic HTML
* Proper heading hierarchy
* Keyboard navigable
* Sufficient contrast

Accessibility is a protocol requirement.

---

## 10. Tailwind Mapping (Reference)

These tokens map naturally to Tailwind defaults:

* `text-base`, `text-lg`, `text-xl`
* `space-y-4`, `space-y-6`, `space-y-8`
* `max-w-prose`, `max-w-3xl`

Do NOT override Tailwind defaults unless necessary.

---

## 11. Anti-Patterns

Do NOT introduce:

* Brand mascots
* Illustration-heavy layouts
* Marketing hero sections
* CTA-driven design

This is infrastructure documentation.

---

## 12. Mental Model

The UI should feel like:

"Reading a protocol specification that happens to have a UI."

Not:
"Browsing a startup landing page."

---

## End of Design Tokens

These tokens are normative guidance for all Veragent web interfaces.
