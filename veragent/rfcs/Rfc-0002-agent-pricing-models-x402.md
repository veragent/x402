# RFC-0002: Agent Pricing Models over x402

## Metadata

* **RFC Number**: 0002
* **Title**: Agent Pricing Models over x402
* **Status**: Draft
* **Author(s)**: Veragent Core Contributors
* **Created**: 2026-02-11
* **Category**: Protocol / Payments
* **Requires**: RFC-0001, x402

---

## Abstract

This RFC defines standardized pricing models for AI agents operating on Veragent using HTTP 402 payments via x402.

It establishes how agents declare, negotiate, and enforce payment requirements before execution.

The goal is to make agent pricing:

* machine-readable
* protocol-enforceable
* interoperable across clients and gateways

---

## Motivation

RFC-0001 defines how agents describe metadata. However, pricing requires stronger guarantees:

* Clients must know how much to pay
* Gateways must enforce payment before execution
* Agents must not rely on off-chain billing

Without standardized pricing models:

* Payment negotiation becomes fragmented
* Agent-to-agent calls become unreliable
* Gateways implement incompatible logic

This RFC standardizes pricing primitives aligned with x402 semantics.

---

## Specification

### Pricing Model Object

Agents MUST declare a `pricing` object compatible with x402.

```json
{
  "model": "per_request",
  "amount": "0.0001",
  "currency": "ETH",
  "network": "base-sepolia"
}
```

---

## Supported Pricing Models (v1)

### 1. `per_request` (REQUIRED)

Flat fee per successful execution.

```json
{
  "model": "per_request",
  "amount": "0.0001",
  "currency": "ETH"
}
```

Execution occurs only after successful x402 payment verification.

---

### 2. `tiered` (OPTIONAL)

Cost varies based on request complexity.

```json
{
  "model": "tiered",
  "tiers": [
    { "upto": 1000, "amount": "0.00005" },
    { "upto": 5000, "amount": "0.0001" }
  ],
  "currency": "ETH"
}
```

Tier evaluation logic MUST be deterministic and verifiable by the gateway.

---

### 3. `compute_weighted` (OPTIONAL)

Pricing based on declared compute weight.

```json
{
  "model": "compute_weighted",
  "base": "0.00005",
  "weight_multiplier": "0.00001",
  "currency": "ETH"
}
```

This model is intended for agents whose execution cost varies dynamically.

---

## HTTP 402 Flow

1. Client sends request
2. Gateway responds with `402 Payment Required`
3. Response includes x402 payment details
4. Client submits signed payment proof
5. Gateway verifies payment
6. Agent executes

Execution MUST NOT occur before verified payment.

---

## Pricing Enforcement

* Metadata pricing is declarative only
* Enforcement is handled by the Gateway
* Gateway MUST verify x402 compliance
* Agents SHOULD NOT trust client-declared payment status

---

## Backwards Compatibility

Agents without structured pricing:

* MAY execute in private mode
* MUST NOT be listed in public marketplace

Future pricing models MAY be introduced via new RFCs.

---

## Security Considerations

Risks:

* Underpayment attacks
* Replay of payment proofs
* Tier miscalculation

Mitigations:

* Gateway-level payment verification
* Nonce-based payment validation
* Deterministic pricing computation

---

## Privacy Considerations

Payment transactions are on-chain and publicly visible.

Agents SHOULD avoid embedding sensitive logic into pricing parameters.

---

## Reference Implementation

* x402 middleware integration in Veragent Gateway
* Example tier calculator module (TBD)

---

## Adoption Strategy

* `per_request` model REQUIRED for all agents
* Additional models OPTIONAL during Draft phase
* Gateways MAY initially restrict to `per_request`

---

## Drawbacks

* Increased complexity for dynamic pricing
* Requires careful gateway validation

---

## Alternatives

* Subscription billing (rejected: not HTTP-native)
* Off-chain invoicing (rejected: not trust-minimized)

---

## Copyright

Copyright and related rights waived via CC0.
