# Veragent Subgraph — Reputation Extension (RFC-0006)

This document defines a **reputation indexing extension** for the Veragent Subgraph.

It is designed to align with **RFC-0006 (Agent Reputation & Scoring)** while preserving the core principle:

> **Registry is minimal. Reputation is modular.**

This extension is OPTIONAL and can be adopted independently by any indexer.

---

## 1. Design Goals

The reputation extension MUST:

* Remain separate from the core registry
* Avoid mutating agent identity
* Be replaceable and non-authoritative
* Be compatible with multiple reputation sources

The extension MUST NOT:

* Introduce central trust assumptions
* Require changes to `VeragentRegistry`
* Block agent execution if unavailable

---

## 2. Architectural Position

```
On-chain
 ├─ VeragentRegistry (RFC-0008)
 └─ (Optional) VeragentReputation Contract

Off-chain
 ├─ Subgraph (Registry)
 ├─ Subgraph (Reputation Extension)
 └─ Marketplace / Aggregators
```

Reputation lives **above** identity and execution layers.

---

## 3. Reputation Sources

Reputation signals MAY originate from:

* Agent execution success / failure
* Latency & availability metrics
* Payment integrity
* Agent-to-agent signed feedback
* Optional human review signals

This extension assumes **on-chain anchoring** of aggregated reputation via events.

---

## 4. Contract Event Interface (Recommended)

If a separate reputation contract is used, it SHOULD emit:

```solidity
event ReputationUpdated(
    bytes32 indexed agentId,
    uint256 score,
    uint256 totalObservations
);
```

Notes:

* `score` is implementation-defined
* `totalObservations` provides weighting context

---

## 5. Extended GraphQL Schema

```graphql
entity Agent @entity {
  id: ID!
  owner: Bytes!
  metadataURI: String!
  active: Boolean!
  createdAt: BigInt!
  updatedAt: BigInt!

  reputation: Reputation
}

entity Reputation @entity {
  id: ID!                 # agentId
  agent: Agent!
  score: BigInt!
  totalObservations: BigInt!
  lastUpdated: BigInt!
}
```

---

## 6. Subgraph Configuration (Additional Data Source)

Example addition to `subgraph.yaml`:

```yaml
- kind: ethereum
  name: VeragentReputation
  network: base-sepolia
  source:
    address: "REPUTATION_CONTRACT_ADDRESS"
    abi: VeragentReputation
    startBlock: START_BLOCK
  mapping:
    kind: ethereum/events
    apiVersion: 0.0.7
    language: wasm/assemblyscript
    entities:
      - Reputation
    abis:
      - name: VeragentReputation
        file: ./abis/VeragentReputation.json
    eventHandlers:
      - event: ReputationUpdated(bytes32,uint256,uint256)
        handler: handleReputationUpdated
    file: ./src/reputation.ts
```

---

## 7. Mapping Implementation

```ts
import { ReputationUpdated } from "../generated/VeragentReputation/VeragentReputation"
import { Reputation, Agent } from "../generated/schema"

export function handleReputationUpdated(event: ReputationUpdated): void {
  let id = event.params.agentId.toHexString()

  let agent = Agent.load(id)
  if (agent == null) return

  let rep = Reputation.load(id)
  if (rep == null) {
    rep = new Reputation(id)
    rep.agent = id
  }

  rep.score = event.params.score
  rep.totalObservations = event.params.totalObservations
  rep.lastUpdated = event.block.timestamp

  rep.save()
}
```

---

## 8. Trust Model

The reputation extension assumes:

* Registry events are canonical
* Reputation events are advisory
* Clients MAY choose which reputation indexer to trust

No single reputation source is authoritative.

---

## 9. Failure Modes

If reputation data is unavailable:

* Agent discovery MUST still function
* Execution MUST NOT be blocked
* UI SHOULD degrade gracefully

Reputation is a signal, not a gate.

---

## 10. Future Extensions

* Multiple reputation providers
* Weighted aggregation strategies
* On-chain reputation checkpoints
* ZK-verifiable reputation proofs

All extensions MUST be RFC-defined.

---

## 11. Summary

This extension enables Veragent to support:

* Scalable trust signals
* Machine-readable reputation
* Open discovery without central control

While preserving the protocol's core principle:

> **Identity is on-chain. Reputation is modular.**

---

End of Reputation Extension
