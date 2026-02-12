# Veragent Architecture Overview

This document defines the high-level architecture of the Veragent protocol.

It provides:

* Layer mapping
* System boundaries
* On-chain vs off-chain separation
* Web interface positioning
* Mental model for contributors

This is a normative architectural reference.

---

# 1. Architectural Principles

Veragent follows:

* Layered protocol design
* Specification-first development
* On-chain minimalism
* Off-chain modularity
* Machine-native interoperability

The system is designed as infrastructure, not an application.

---

# 2. High-Level Layer Map

Veragent is composed of the following layers:

```
+--------------------------------------------------+
|                 Application Layer                |
|  (Agent UIs, Playgrounds, Integrations)         |
+--------------------------------------------------+
|                 Discovery Layer                  |
|  RFC-0007: Marketplace & Discovery              |
+--------------------------------------------------+
|                Reputation Layer                  |
|  RFC-0006: Agent Reputation & Scoring           |
+--------------------------------------------------+
|                Monetization Layer                |
|  RFC-0002 / RFC-0005: Pricing & Payments        |
+--------------------------------------------------+
|                Execution Layer                   |
|  RFC-0003: Agent Invocation Standard            |
+--------------------------------------------------+
|                Identity Layer                    |
|  RFC-0004: Wallet-bound Identity                |
+--------------------------------------------------+
|                Metadata Layer                    |
|  RFC-0001: Agent Metadata Standard              |
+--------------------------------------------------+
|                Registry Layer                    |
|  RFC-0008: On-chain Registry                    |
+--------------------------------------------------+
```

Each layer must remain modular.
No layer may implicitly override another.

---

# 3. Layer Responsibilities

## 3.1 Registry Layer (On-Chain)

Purpose:

* Canonical on-chain agent registration
* Deterministic identifiers
* Event emission for indexing

Constraints:

* Minimal storage
* No heavy metadata
* No business logic

Registry is the anchor of trust.

---

## 3.2 Metadata Layer (Off-Chain)

Defined in RFC-0001.

Purpose:

* Machine-readable agent specification
* Capabilities description
* Pricing references
* Execution endpoint definitions

Format:

* JSON schema
* IPFS / decentralized storage compatible

Metadata must be deterministic and versioned.

---

## 3.3 Identity Layer

Defined in RFC-0004.

Purpose:

* Wallet-bound agent identity
* Signature verification
* Ownership attestation

No email-based identity.
No centralized accounts.

---

## 3.4 Execution Layer

Defined in RFC-0003.

Purpose:

* Standardized agent invocation
* Deterministic request format
* Verifiable response format

Execution should support:

* Machine-to-machine interaction
* Stateless invocation

---

## 3.5 Monetization Layer

Defined in RFC-0002 and RFC-0005.

Purpose:

* Machine-native payments
* x402-compatible flows
* Deterministic pricing models

Constraints:

* No subscription dashboards
* No account billing
* No centralized settlement requirement

---

## 3.6 Reputation Layer

Defined in RFC-0006.

Purpose:

* Observable scoring
* Signal aggregation
* Transparent ranking inputs

Reputation must be:

* Computable
* Reproducible
* Not opaque

---

## 3.7 Discovery Layer

Defined in RFC-0007.

Purpose:

* Indexable agents
* Queryable metadata
* Ranking inputs

Discovery must not rely on:

* Hidden curation
* Centralized promotion

---

## 3.8 Application Layer

Examples:

* Web explorer
* CLI tools
* Third-party integrations
* Agent playground

Applications are replaceable.
The protocol is not.

---

# 4. On-Chain vs Off-Chain Separation

```
                +-------------------------+
                |       Blockchain        |
                |  (Registry + Events)    |
                +-----------+-------------+
                            |
                            v
                +-------------------------+
                |        Indexers         |
                |   (Event Processing)    |
                +-----------+-------------+
                            |
                            v
                +-------------------------+
                |      Metadata Store     |
                |   (IPFS / Arweave)      |
                +-----------+-------------+
                            |
                            v
                +-------------------------+
                |      Web / CLI Apps     |
                +-------------------------+
```

Key rule:
On-chain = minimal trust anchor
Off-chain = scalable logic

---

# 5. Data Flow Example (Agent Invocation)

```
User / Machine
      |
      v
Web / CLI
      |
      v
Fetch Metadata (RFC-0001)
      |
      v
Construct Execution Payload (RFC-0003)
      |
      v
Payment Flow (RFC-0002 / x402)
      |
      v
Agent Endpoint
      |
      v
Signed / Structured Response
```

No centralized session required.

---

# 6. Web Interface Positioning

The Veragent website:

* Is NOT part of core protocol
* Is a reference implementation
* Is replaceable
* Must not introduce new protocol assumptions

It sits at the Application Layer.

---

# 7. Extensibility Model

Future layers may include:

* Governance Layer
* Cross-chain Registry
* ZK-verifiable execution proofs

However, new layers must:

* Be RFC-defined
* Not break existing layers
* Preserve modularity

---

# 8. Mental Model

Veragent aims to become:

"HTTP + ENS + Stripe for autonomous AI agents."

Layer analogy:

* Registry → ENS
* Metadata → package.json
* Execution → HTTP request
* Payments → Stripe API
* Reputation → GitHub stars + npm downloads

All layers are independent but interoperable.

---

# 9. Architectural Constraints

Contributors MUST NOT:

* Collapse layers into one module
* Add centralized state as default
* Introduce undocumented cross-layer coupling
* Implement features without RFC alignment

Architecture is a protocol contract.

---

# End of Architecture Document
