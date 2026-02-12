# Veragent — GitHub Copilot Operating Guide

This document defines how AI assistants (GitHub Copilot, Claude Opus, etc.)
must behave when contributing to this repository.

Copilot must treat this file as a persistent instruction layer.

If conflicts arise:
1. PROTOCOL_INSTRUCTIONS.md
2. WEB_INSTRUCTIONS.md
3. COPILOT.md
(in that order of priority)

---

# 1. Project Identity Reminder

Veragent is a protocol repository.

It is NOT:
- A SaaS app
- A startup landing page
- A user dashboard product
- A token launch platform

It IS:
- A specification-first protocol
- An RFC-driven system
- Infrastructure for machine-native agents
- Inspired by x402, Ethereum RFCs, and Internet standards

When generating code:
Always think infrastructure > product.

---

# 2. How Copilot Should Think

Before generating code, Copilot must internally answer:

- Which RFC layer does this belong to?
- Is this introducing undocumented behavior?
- Is this adding centralization?
- Is this violating protocol-first design?

If unclear:
Propose an RFC draft instead of inventing behavior.

---

# 3. RFC Awareness Mode

If generating:

- New feature → reference an RFC
- New schema → ensure compatibility with RFC-0001
- Payment logic → ensure compatibility with RFC-0002
- Execution flow → align with RFC-0003
- Reputation logic → align with RFC-0006
- Discovery logic → align with RFC-0007
- Registry logic → align with RFC-0008

Never generate protocol logic without referencing RFC alignment.

---

# 4. Smart Contract Generation Mode

When writing Solidity:

- Minimal state
- Event-driven design
- No heavy on-chain storage
- Deterministic ID generation
- No unnecessary inheritance
- No token logic unless explicitly requested

Always include:
- Clear comments (WHY, not WHAT)
- SPDX license
- Solidity version pragma
- Basic security considerations

Avoid:
- Over-abstracting
- Introducing upgrade patterns unless specified
- Complex proxy systems without RFC

---

# 5. Next.js Generation Mode

When writing frontend code:

- Default to Server Components
- Avoid client state unless required
- No authentication
- No user database
- No admin panel
- No marketing funnel

Website is:
Documentation + Protocol Explorer

NOT:
User SaaS dashboard.

---

# 6. Commit-Ready Code Policy

Generated code must:

- Compile
- Have consistent naming
- Avoid placeholder variables
- Avoid TODO comments unless explicitly requested
- Avoid console.log debugging
- Avoid dead code

Output should be production-ready unless labeled as draft.

---

# 7. Dependency Policy

Before introducing a dependency, Copilot must consider:

- Can this be done with native tools?
- Is this adding long-term complexity?
- Is this required by protocol logic?

Avoid:
- Large UI frameworks
- ORM systems
- Authentication libraries
- Heavy SDKs

Minimalism is preferred.

---

# 8. Folder Discipline

Copilot must respect repository structure:

/rfcs → All RFC documents
/contracts → Smart contracts
/apps/web → Next.js frontend
/prompts → AI instruction layer
/tools → CLI or utilities

Do not:
- Mix frontend and protocol logic
- Place contracts in web folder
- Introduce random root-level files

---

# 9. Documentation First Rule

If generating a new feature:

Step 1: Ensure documentation exists
Step 2: Then generate code

Never reverse this order.

---

# 10. Determinism Rule

Generated artifacts must:

- Use explicit types
- Avoid dynamic inference where possible
- Avoid magic strings
- Use named constants
- Be reproducible

Protocol code must be predictable.

---

# 11. Anti-Pattern Detection

Copilot MUST NOT generate:

- Login pages
- Signup forms
- Role-based access control
- Subscription billing flows
- Growth popups
- Cookie banners
- Analytics tracking
- Referral systems
- Tokenomics speculation

If such logic appears, remove it.

---

# 12. When Generating UI Text

Tone must be:

- Technical
- Clear
- Neutral
- Minimal

Avoid:
- Marketing phrases
- Hype language
- “Revolutionary”
- “Next generation”
- “Unlock the power”

This is infrastructure documentation.

---

# 13. How to Start a New Coding Session

When beginning work, the developer should remind Copilot:

"Follow:
- prompts/PROTOCOL_INSTRUCTIONS.md
- prompts/WEB_INSTRUCTIONS.md
- COPILOT.md

This is a protocol-first repository similar to x402."

Copilot must treat that as operating context.

---

# 14. Behavior in Uncertainty

If unclear:

1. Default to minimal implementation
2. Avoid introducing state
3. Avoid centralization
4. Suggest RFC draft
5. Ask for clarification

Never hallucinate protocol behavior.

---

# 15. Output Discipline

Copilot responses should:

- Explain architecture briefly
- Then generate code
- Avoid excessive commentary
- Avoid verbosity
- Avoid speculative features

Clarity > verbosity.

---

# 16. Long-Term Vision Reminder

Veragent aims to become:

"HTTP + ENS + Stripe for autonomous AI agents."

Everything generated should move toward that vision.

---

# End of Copilot Operating Guide
