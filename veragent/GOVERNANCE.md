# Veragent Governance

This document defines the **governance model and RFC lifecycle** for the Veragent protocol.

Governance in Veragent is designed to be:

* lightweight
* transparent
* specification-driven
* resistant to premature centralization

This is a **future-facing governance framework** and does not introduce tokens or voting mechanisms in v0.x.

---

## 1. Governance Philosophy

Veragent governance follows these principles:

* **Specs over people**: decisions are encoded in RFCs, not individuals
* **Rough consensus and running code**
* **Minimal governance early**
* **Progressive decentralization**

The goal is to coordinate contributors without introducing heavy political or economic systems too early.

---

## 2. Governance Scope

Governance applies to:

* Protocol specifications (RFCs)
* Canonical smart contracts
* Reference implementations
* Breaking changes

Governance does NOT apply to:

* Individual applications built on Veragent
* UI/UX experiments
* Third-party marketplaces or indexers

---

## 3. RFC-Centric Governance Model

The RFC process is the **primary governance mechanism**.

All meaningful protocol changes MUST go through the RFC process.

### What Requires an RFC

An RFC is REQUIRED for:

* New protocol layers

* Changes to existing RFCs

* Smart contract interface changes

* Payment, identity, or execution semantics

* Reputation or discovery logic
  n
  An RFC is NOT REQUIRED for:

* Documentation fixes

* Non-breaking refactors

* Experimental code behind feature flags

---

## 4. RFC Lifecycle

Each RFC progresses through the following stages:

```
Draft → Review → Accepted → Implemented → Final
```

### 4.1 Draft

* Anyone may submit an RFC draft
* Stored in `/rfcs` with Draft status
* Feedback collected via issues or PR comments

---

### 4.2 Review

* RFC is discussed publicly
* Maintainers ensure clarity and scope
* Security and backwards compatibility reviewed

---

### 4.3 Accepted

* Rough consensus achieved
* RFC marked as Accepted
* No formal voting required

Acceptance criteria:

* Clear problem statement
* Well-defined specification
* No unresolved critical objections

---

### 4.4 Implemented

* Reference implementation exists
* Tests or demos available
* Implementation aligns with specification

---

### 4.5 Final

* RFC considered stable
* May only be modified via a new RFC

---

## 5. Decision-Making Process

Veragent uses **rough consensus**, not formal voting.

Consensus means:

* Most active contributors agree
* Objections have been addressed
* No strong technical blockers remain

Maintainers act as facilitators, not rulers.

---

## 6. Maintainer Role

Maintainers:

* Review RFCs for completeness
* Enforce process discipline
* Merge accepted RFCs
* Safeguard architectural consistency

Maintainers MUST:

* Act transparently
* Avoid unilateral decisions
* Defer to RFCs over personal opinion

---

## 7. Breaking Changes

Breaking changes:

* MUST be proposed via RFC
* MUST clearly describe migration paths
* SHOULD minimize ecosystem disruption

Versioning should follow semantic principles where applicable.

---

## 8. On-Chain Governance (Future)

On-chain governance MAY be introduced later to:

* Manage registry upgrades
* Approve parameter changes
* Delegate stewardship

However:

* No governance token is required in early phases
* Off-chain governance remains primary in v0.x

---

## 9. Dispute Resolution

If consensus cannot be reached:

* Discussion continues
* Competing RFCs MAY coexist
* Implementations may diverge experimentally

Forking is considered a valid outcome in open systems.

---

## 10. Transparency

All governance activity should be:

* Public
* Documented
* Traceable via GitHub history

Private decision-making is discouraged.

---

## 11. Evolution of Governance

This governance model is expected to evolve.

Changes to governance itself:

* MUST be proposed via RFC
* MUST follow the same lifecycle

Governance is part of the protocol surface.

---

## 12. Mental Model

Veragent governance should feel like:

* Ethereum EIPs
* IETF RFCs
* Open-source protocol stewardship

Not:

* Corporate board voting
* DAO politics
* Token-weighted power structures

---

## End of Governance Document
