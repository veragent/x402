# Veragent Web Instructions (Next.js)

This document defines **mandatory rules and constraints** for building and maintaining the Veragent website.

All AI assistants (Claude, Copilot, etc.) MUST follow this document when generating frontend code, UI, or web-related documentation.

If there is a conflict, this document overrides default frontend assumptions.

---

# 1. Purpose of the Website

The Veragent website is NOT:
- A SaaS application
- A user dashboard
- A login-based product
- A growth/marketing landing page

The Veragent website IS:
- A protocol documentation portal
- A discovery interface for AI agents
- A playground for protocol interaction
- A developer-facing reference implementation

Think:
- ethereum.org
- developers.cloudflare.com/agents/x402/
- GitHub protocol docs
- x402 documentation site : https://docs.x402.org
- Coinbase : https://docs.cdp.coinbase.com/x402

---

# 2. Technology Stack (STRICT)

The website MUST use:

- Next.js (App Router)
- TypeScript
- Tailwind CSS
- Static-first rendering (SSG where possible)
- Server Components by default

The website MUST NOT introduce:

- Authentication systems
- User accounts
- Databases by default
- Backend business logic
- Session management

Wallet connection is allowed **ONLY** for agent execution demos.

---

# 3. Rendering Strategy

Default rendering mode:

- Static Generation (SSG)

Allowed:
- Server Components
- Server Actions (read-only or demo only)

Avoid:
- Client Components unless strictly required
- Complex state management
- Real-time subscriptions

---

# 4. Routing Structure (REQUIRED)

The following routes MUST exist or be planned:

## `/`
Homepage
- Explains Veragent in under 10 seconds
- No marketing language
- Clear protocol positioning
- Architecture overview

## `/docs`
Protocol documentation index

## `/rfcs`
RFC index
- RFC list (0001+)
- Status badges
- Markdown-rendered content

## `/rfcs/[id]`
Single RFC page
- Rendered from Markdown
- No custom formatting per RFC

## `/whitepaper`
Whitepaper v0.1
- Rendered from Markdown
- Table of contents
- Version label

## `/agents`
Agent discovery
- Read-only
- No login
- Data from static JSON or mock API

## `/agents/[id]`
Agent detail + playground
- Metadata view
- Pricing info
- “Run Agent” button
- Wallet interaction allowed ONLY here

## `/build`
Agent creator onboarding
- Step-by-step guide
- CLI examples
- Links to RFCs

---

# 5. Content Source Rules

- RFCs MUST be Markdown files from `/rfcs`
- Whitepaper MUST be Markdown
- Docs SHOULD be Markdown-first
- Agent metadata MUST follow RFC-0001 schema

Avoid:
- Hardcoded HTML docs
- CMS dependencies
- WYSIWYG editors

---

# 6. UI / UX Principles

Design philosophy:

- Minimal
- Technical
- Calm
- Neutral
- Documentation-first

Guidelines:
- Typography > colors
- White / neutral backgrounds
- No gradients
- No flashy animations
- No conversion funnels
- No “Get Started Free” buttons

This site is for **builders**, not consumers.

---

# 7. Styling Rules

Tailwind CSS usage:

- Prefer semantic layout utilities
- Avoid custom CSS unless necessary
- Avoid design systems that obscure intent
- Consistent spacing and typography

Accessibility:
- Semantic HTML
- Proper heading hierarchy
- Readable contrast

---

# 8. Wallet & x402 Integration

Wallet interaction is OPTIONAL and LIMITED.

Allowed only on:
- `/agents/[id]`

Rules:
- No persistent wallet state
- No user profiles
- No balances dashboard
- No transaction history UI

Purpose:
- Demonstrate x402 payment flow
- Demonstrate agent execution

---

# 9. Data Handling

Data sources may include:
- Static JSON files
- Mock APIs
- Read-only fetches

Avoid:
- Mutations
- Admin controls
- CRUD dashboards

The site is not the source of truth.
It is a **window into the protocol**.

---

# 10. Error Handling

Errors should be:
- Explicit
- Technical
- Honest

Avoid:
- Friendly marketing copy
- Obscure error messages

Prefer:
> “This agent returned 402 Payment Required.”

---

# 11. Code Style Rules

- Prefer Server Components
- Minimal client-side JavaScript
- Deterministic naming
- Clear folder structure
- Comments explain WHY, not WHAT

Avoid:
- Over-engineering
- Hidden abstractions
- Premature optimizations

---

# 12. Prohibited Patterns

AI assistants MUST NOT introduce:

- Login / signup pages
- Authentication middleware
- User dashboards
- Role-based access control
- Analytics tracking by default
- Cookie consent banners
- Growth hacks or funnels

---

# 13. Mental Model

This website should feel like:

> “A protocol explorer and documentation hub that happens to have a UI.”

Not:
> “A startup landing page.”

---

# 14. Output Expectations for AI Assistants

When generating frontend code:
- Explain structure before implementation
- Follow this document strictly
- Ask before adding dependencies
- Keep implementations minimal and readable

If unsure:
- Default to static
- Default to documentation
- Default to neutrality

---

# End of Instructions

All web-related code MUST comply with this document.
If conflicts arise, this document takes precedence.
