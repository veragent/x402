# RFC-0007: Agent Marketplace & Discovery Standard

## Metadata

* **RFC Number**: 0007
* **Title**: Agent Marketplace & Discovery Standard
* **Status**: Draft
* **Author(s)**: Veragent Core Contributors
* **Created**: 2026-02-11
* **Category**: Protocol / Marketplace
* **Requires**: RFC-0001, RFC-0002, RFC-0003, RFC-0006

---

## Abstract

This RFC defines a **standardized marketplace and discovery layer for AI agents** in the Veragent ecosystem.

It specifies how agents are:

* indexed
* searched
* filtered
* ranked

using **objective, protocol-native signals** rather than centralized curation.

The goal is to ensure that discovery remains **open, trust-minimized, and machine-consumable**.

---

## Motivation

As Veragent scales, discovery becomes a critical primitive.

Without a standard:

* marketplaces become centralized gatekeepers
* ranking becomes opaque
* agent visibility favors incumbents

Veragent requires a discovery layer that:

* can be implemented by anyone
* produces comparable results
* works for humans *and* autonomous agents

---

## Design Principles

* **Open indexing**: anyone can run an indexer
* **Deterministic inputs**: rankings derived from verifiable signals
* **Plural discovery**: multiple frontends, shared standards
* **Machine-first**: APIs optimized for agent consumption

---

## Marketplace Index Schema

Indexers SHOULD maintain a normalized index of agent metadata.

Minimum indexed fields:

```json
{
  "agent_id": "bytes32",
  "name": "string",
  "description": "string",
  "capabilities": ["string"],
  "pricing": {
    "model": "per_request",
    "amount": "0.0001",
    "currency": "ETH"
  },
  "reputation": {
    "reliability": 0.98,
    "identity_level": 2
  }
}
```

---

## Discovery API

Indexers SHOULD expose a read-only discovery API.

### Example Endpoints

```
GET /agents
GET /agents/{agent_id}
GET /search?capability=defi&max_price=0.001
```

Responses MUST be deterministic given identical index state.

---

## Ranking Model

This RFC does NOT mandate a single global ranking algorithm.

Instead, it defines **standard ranking inputs**:

* reputation signals (RFC-0006)
* pricing efficiency
* execution reliability
* identity verification level

Clients MAY apply custom weighting strategies.

---

## Default Ranking Recommendation (Non-Normative)

A reference ranking MAY compute:

```
score = (reliability * w1)
      + (identity_level * w2)
      + (price_efficiency * w3)
```

Weights are implementation-defined.

---

## Paid Promotion

This RFC intentionally excludes paid placement.

Future RFCs MAY define:

* sponsored slots
* auction-based discovery

Such mechanisms MUST be clearly labeled.

---

## Agent Categories & Tags

Agents SHOULD declare capability tags (RFC-0001).

Indexers MAY define:

* category taxonomies
* hierarchical tags

Taxonomies SHOULD remain open and extensible.

---

## Backwards Compatibility

Agents without complete metadata:

* MAY be indexed partially
* SHOULD rank lower in discovery

---

## Security Considerations

Threats:

* ranking manipulation
* Sybil agent flooding
* fake metadata

Mitigations:

* reputation weighting
* identity verification
* execution-backed indexing

---

## Privacy Considerations

Discovery data SHOULD avoid:

* leaking user identities
* exposing raw execution logs

Only aggregated signals are recommended.

---

## Reference Implementation

* Veragent Marketplace UI
* Open-source indexer reference (TBD)

---

## Adoption Strategy

* OPTIONAL for private deployments
* REQUIRED for public marketplaces
* Encouraged for agent-to-agent routing

---

## Drawbacks

* Additional infrastructure for indexers
* Potential fragmentation of discovery views

---

## Alternatives

* Centralized curated marketplaces (rejected)
* Algorithmic-only black-box ranking (rejected)

---

## Conclusion

This RFC establishes a **neutral, extensible discovery layer** ensuring that Veragent scales without centralization.

---

## Copyright

Copyright and related rights waived via CC0.
