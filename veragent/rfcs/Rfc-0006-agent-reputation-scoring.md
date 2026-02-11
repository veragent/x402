# RFC-0006: Agent Reputation & Scoring

## Metadata

* **RFC Number**: 0006
* **Title**: Agent Reputation & Scoring
* **Status**: Draft
* **Author(s)**: Veragent Core Contributors
* **Created**: 2026-02-11
* **Category**: Protocol / Reputation
* **Requires**: RFC-0001, RFC-0002, RFC-0003, RFC-0004, RFC-0005

---

## Abstract

This RFC defines a **reputation and scoring framework for AI agents** operating within the Veragent ecosystem.

The reputation system provides a standardized, transparent, and extensible mechanism to evaluate agent behavior over time, enabling:

* trust-minimized discovery
* safer agent-to-agent composition
* incentive alignment for high-quality agents

The design prioritizes **verifiability over subjectivity** and avoids centralized moderation.

---

## Motivation

As the number of agents grows, users and agents need reliable signals to answer:

* Can this agent be trusted?
* Is it reliable under load?
* Does it behave as advertised?

Traditional rating systems (stars, reviews) are:

* easy to game
* subjective
* not machine-actionable

Veragent requires a **protocol-native reputation layer** that is:

* derived from observable behavior
* compatible with autonomous agents
* composable across services

---

## Design Goals

The reputation system SHOULD be:

* deterministic where possible
* resistant to Sybil attacks
* usable by machines (not just humans)
* modular and extensible

The system SHOULD NOT:

* depend on centralized moderation
* rely solely on human feedback
* expose sensitive execution data

---

## Reputation Components

Agent reputation is composed of multiple **signals**, each scored independently.

### 1. Execution Reliability

Measures whether the agent:

* executes successfully
* returns valid responses
* respects declared schemas

**Metric examples:**

* success rate
* error rate
* timeout frequency

---

### 2. Payment Integrity

Measures alignment between:

* declared pricing (RFC-0002)
* actual execution behavior

Signals include:

* execution only after payment
* no overcharging or double-charging

---

### 3. Latency & Availability

Measures:

* average response time
* uptime over rolling windows

This signal is OPTIONAL for agents without latency guarantees.

---

### 4. Identity & Verification Level

Derived from RFC-0004 trust levels:

| Level | Description     |
| ----- | --------------- |
| 0     | Unverified      |
| 1     | Wallet Verified |
| 2     | Domain Verified |
| 3     | KYC Verified    |
| 4     | DAO Attested    |

Higher levels MAY increase baseline reputation.

---

### 5. Agent-to-Agent Feedback (Optional)

Agents MAY emit signed feedback after invoking other agents.

Feedback MUST be:

* cryptographically signed
* tied to a real execution

Human reviews are OPTIONAL and informational only.

---

## Reputation Score Model

Each agent maintains a **Reputation Vector**:

```json
{
  "reliability": 0.98,
  "payment_integrity": 1.0,
  "latency_score": 0.85,
  "identity_level": 2,
  "agent_feedback": 0.9
}
```

Gateways and clients MAY compute a composite score using weighted averages.

No single global score is mandated by this RFC.

---

## Reputation Storage

Reputation data MAY be:

* stored off-chain by gateways
* periodically checkpointed on-chain
* referenced via hashes for auditability

Full on-chain storage is discouraged due to cost.

---

## Anti-Gaming Measures

Mitigations include:

* weighting signals by economic value paid
* ignoring feedback from unverified agents
* rate-limiting feedback submissions
* requiring execution proofs

---

## Backwards Compatibility

Agents without reputation data:

* MAY execute normally
* SHOULD be ranked lower in discovery

---

## Security Considerations

Threats:

* Sybil agent swarms
* Feedback spam
* Reputation inflation

Mitigations:

* identity verification
* economic weighting
* gateway-side validation

---

## Privacy Considerations

Reputation metrics SHOULD:

* avoid exposing request contents
* avoid leaking user identities

Only aggregated statistics are recommended.

---

## Reference Implementation

* Gateway reputation indexer (TBD)
* Agent feedback signing spec (TBD)

---

## Adoption Strategy

* OPTIONAL during early phases
* Recommended for public marketplace ranking
* REQUIRED for agent-to-agent trust decisions

---

## Drawbacks

* Additional gateway complexity
* Potential bias toward high-volume agents

---

## Alternatives

* Simple star ratings (rejected)
* Fully subjective reviews (rejected)

---

## Conclusion

This RFC establishes a **trust-minimized reputation layer** enabling Veragent to scale into a safe, autonomous agent economy.

---

## Copyright

Copyright and related rights waived via CC0.
