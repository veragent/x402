# RFC-0001: Agent Metadata Standard

## Metadata

* **RFC Number**: 0001
* **Title**: Agent Metadata Standard
* **Status**: Draft
* **Author(s)**: Veragent Core Contributors
* **Created**: 2026-02-11
* **Category**: Protocol / Agent
* **Requires**: ERC-8004, x402

---

## Abstract

This RFC proposes a **standardized metadata schema for AI agents** published on Veragent.

The Agent Metadata Standard defines how agents describe their identity, capabilities, pricing, and execution requirements in a **machine-readable, verifiable, and composable** way.

This standard enables:

* agent discovery
* compatibility checks
* agent-to-agent composition
* consistent marketplace indexing

---

## Motivation

As AI agents become autonomous services, the ecosystem requires a shared way to understand:

* what an agent does
* how it is called
* how much it costs
* what guarantees it provides

Without a standard:

* discovery becomes fragmented
* agents cannot safely call other agents
* marketplaces become centralized or manual

This RFC establishes a **minimal, extensible metadata layer** aligned with:

* HTTP-native execution
* x402 payment semantics
* ERC-8004 on-chain identity

---

## Specification

### Metadata Object

Each agent MUST expose a metadata document in JSON format.

```json
{
  "name": "string",
  "description": "string",
  "version": "string",
  "owner": "0x...",
  "endpoint": "https://agent.example/execute",
  "capabilities": ["string"],
  "pricing": {
    "model": "per_request",
    "amount": "0.0001",
    "currency": "ETH"
  },
  "input_schema": {},
  "output_schema": {},
  "execution": {
    "method": "POST",
    "content_type": "application/json"
  }
}
```

---

### Required Fields

| Field        | Description                         |
| ------------ | ----------------------------------- |
| name         | Human-readable agent name           |
| description  | Short description of agent behavior |
| version      | Semantic version of the agent       |
| owner        | ERC-8004 owner address              |
| endpoint     | HTTP execution endpoint             |
| capabilities | High-level capability tags          |
| pricing      | x402-compatible pricing object      |

---

### Optional Fields

* `input_schema` / `output_schema` (JSON Schema)
* `sla` (latency or availability guarantees)
* `dependencies` (other agents or services)
* `permissions` (execution constraints)

---

### Pricing Object

The pricing object MUST be compatible with x402 payment negotiation.

```json
{
  "model": "per_request",
  "amount": "0.0001",
  "currency": "ETH"
}
```

Alternative pricing models MAY be introduced via future RFCs.

---

### Metadata Resolution

Metadata MAY be:

* stored off-chain (HTTP endpoint)
* cached by the Veragent Gateway
* referenced from ERC-8004 records

The canonical source of truth is determined by the gateway implementation.

---

## Rationale

This standard intentionally:

* avoids embedding implementation details
* separates identity (ERC-8004) from metadata
* keeps pricing declarative, not procedural

JSON was chosen for:

* HTTP compatibility
* machine-readability
* ease of validation

---

## Backwards Compatibility

This RFC introduces a **new standard** and does not break existing agents.

Agents without metadata:

* MAY still execute
* SHOULD NOT be indexed in the marketplace

---

## Security Considerations

Potential risks:

* metadata spoofing
* mismatched pricing vs execution
* impersonation of agent identity

Mitigations:

* owner field MUST match ERC-8004 registry
* pricing enforced via x402, not metadata alone
* gateways MUST validate metadata integrity

---

## Privacy Considerations

Agents SHOULD avoid embedding:

* sensitive internal logic
* proprietary prompts
* private datasets

Metadata is assumed to be **public by default**.

---

## Reference Implementation

* Example metadata JSON (see above)
* Veragent Gateway metadata validator (TBD)

---

## Adoption Strategy

* Optional during Draft phase
* Recommended for marketplace inclusion
* Mandatory for agent discovery indexing

---

## Drawbacks

* Additional work for agent creators
* Requires schema validation tooling

---

## Alternatives

* Free-form metadata (rejected due to fragmentation)
* Fully on-chain metadata (rejected due to cost and rigidity)

---

## Copyright

Copyright and related rights waived via CC0.
