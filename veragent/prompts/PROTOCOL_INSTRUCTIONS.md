# Veragent Protocol Instructions

This document defines the architectural, documentation, and engineering principles for the Veragent repository.

All AI assistants (Claude, Copilot, etc.) MUST follow these instructions when generating code, specifications, or documentation.

---

# 1. Project Identity

Veragent is NOT:
- A SaaS platform
- A chatbot product
- A dashboard application
- A centralized AI marketplace

Veragent IS:
- An open protocol
- A specification-first project
- A modular infrastructure layer
- A machine-native agent economy framework

Think:
- Ethereum Improvement Proposals (EIPs)
- x402 specification style
- Internet RFC standards

---

# 2. Architectural Principles

Veragent follows a layered protocol design:

1. Metadata Layer (RFC-0001)
2. Pricing Layer (RFC-0002)
3. Execution Layer (RFC-0003)
4. Identity Layer (RFC-0004)
5. Monetization Layer (RFC-0005)
6. Reputation Layer (RFC-0006)
7. Discovery Layer (RFC-0007)
8. On-chain Registry (RFC-0008)

All new work MUST respect this architecture.

No feature should bypass defined layers.

---

# 3. Specification-First Development

Veragent is RFC-driven.

## Rule:
No major feature should be implemented without:
- Either referencing an existing RFC
- Or proposing a new RFC

When generating new features:
- If spec is unclear → propose RFC draft
- Do not invent undocumented behavior

---

# 4. RFC Style Requirements

All RFC documents MUST include:

- RFC Number
- Title
- Status (Draft / Review / Accepted / Implemented)
- Author(s)
- Created Date
- Category
- Requires (dependencies)

Mandatory Sections:
- Abstract
- Motivation
- Specification
- Rationale
- Security Considerations
- Backwards Compatibility
- Alternatives
- Copyright

RFC writing style:
- Clear
- Deterministic
- Minimal marketing tone
- Precise terminology

Follow style conventions similar to:
https://github.com/coinbase/x402

---

# 5. Smart Contract Design Rules

Smart contracts must be:

- Minimal
- Gas-conscious
- Event-driven
- Upgrade-aware
- Deterministic

Do NOT:
- Store large metadata on-chain
- Introduce complex logic without justification
- Hardcode chain-specific assumptions

Prefer:
- Events for indexing
- External metadata references (IPFS / Arweave)
- Deterministic ID generation

All contracts MUST:
- Compile
- Include comments explaining rationale
- Avoid unnecessary dependencies

---

# 6. Off-Chain Components

Gateways, indexers, and CLI tools:

- Must remain modular
- Must not introduce central trust assumptions
- Must rely on verifiable signals
- Should avoid persistent centralized state when possible

Machine-readable APIs are preferred over human-only interfaces.

---

# 7. Marketplace & Discovery Philosophy

Discovery must be:

- Open
- Indexable
- Deterministic
- Ranking-input-based (not black-box)

Avoid:
- Opaque ranking
- Hardcoded promotions
- Centralized curation

---

# 8. Identity & Trust

Identity must be:

- Cryptographically verifiable
- Wallet-bound (EVM-compatible)
- Compatible with ERC-8004 concepts

Reputation must:
- Be derived from observable signals
- Not rely solely on subjective reviews
- Be machine-consumable

---

# 9. Economic Design Constraints

Payments must:
- Support x402-compatible flows
- Be machine-to-machine friendly
- Avoid requiring accounts or API keys

Monetization should:
- Be optional
- Be modular
- Not enforce protocol fees unless explicitly specified

---

# 10. Code Style Rules

- Clarity > Cleverness
- Explicit > Implicit
- Deterministic naming
- No magic numbers
- Comments explain WHY, not WHAT
- Avoid premature abstraction
- Prefer simple architecture over microservices

---

# 11. Prohibited Patterns

AI assistants MUST NOT introduce:

- User authentication systems
- Traditional SaaS billing logic
- Centralized admin dashboards
- Hidden ranking manipulation
- Token launch mechanics unless explicitly requested
- Governance token assumptions unless defined in RFC

---

# 12. When in Doubt

If unclear:

1. Ask whether an RFC should be written
2. Default to minimal implementation
3. Preserve neutrality
4. Preserve modularity

Never invent undocumented protocol behavior.

---

# 13. Mental Model

Always think:

Veragent is building the "HTTP + ENS + npm + Stripe" layer
for autonomous AI agents.

This is infrastructure.
Not an app.
Not a startup landing page.

---

# 14. Output Expectations for AI Assistants

When generating:

- RFCs → Follow RFC template strictly
- Smart contracts → Production-ready Solidity
- Scripts → Deterministic deploy scripts
- CLI tools → Clear command list + config spec
- Docs → Markdown-first
- Architecture → Layered and explicit

Avoid fluff.
Avoid marketing copy.
Avoid assumptions.

---

# End of Instructions

All AI-generated contributions must comply with this document.
If conflicts arise, this document takes precedence.
