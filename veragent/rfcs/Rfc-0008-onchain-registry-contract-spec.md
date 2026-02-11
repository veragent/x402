# RFC-0008: On-chain Registry & Contract Specification

## Metadata

* **RFC Number**: 0008
* **Title**: On-chain Registry & Contract Specification
* **Status**: Draft
* **Author(s)**: Veragent Core Contributors
* **Created**: 2026-02-11
* **Category**: Protocol / Smart Contracts
* **Requires**: RFC-0001, RFC-0002, RFC-0004, RFC-0006

---

## Abstract

This RFC defines the canonical **on-chain registry contract** for the Veragent protocol.

The registry provides:

* a cryptographically verifiable source of agent existence
* immutable identity anchoring
* upgradeable metadata references
* event-driven indexing compatibility

The registry does NOT store full agent metadata. Instead, it anchors references and identity proofs on-chain while keeping execution logic off-chain.

---

## Motivation

Without a canonical registry:

* agent identity becomes fragmented
* discovery cannot rely on shared truth
* reputation systems lack anchoring

An on-chain registry ensures:

* tamper-resistance
* public verifiability
* composability across chains and marketplaces

---

## Design Principles

* Minimal on-chain footprint
* Event-first architecture
* Upgrade-safe
* Chain-agnostic compatibility (EVM-first)
* No heavy metadata storage on-chain

---

## Contract Overview

### Core Responsibilities

The Veragent Registry MUST:

1. Register new agents
2. Anchor agent identity (wallet owner)
3. Store metadata URI (IPFS / HTTPS)
4. Emit standardized events
5. Support metadata updates
6. Allow optional deactivation

---

## Storage Layout (Reference Model)

```solidity
struct Agent {
    address owner;
    string metadataURI;
    uint256 createdAt;
    bool active;
}

mapping(bytes32 => Agent) public agents;
```

### Agent ID

Agent IDs SHOULD be deterministic:

```
agentId = keccak256(owner + metadataURI + salt)
```

---

## Required Functions

### registerAgent

```solidity
function registerAgent(
    bytes32 agentId,
    string calldata metadataURI
) external;
```

Requirements:

* `agentId` MUST be unused
* `msg.sender` becomes owner
* Emits `AgentRegistered`

---

### updateMetadata

```solidity
function updateMetadata(
    bytes32 agentId,
    string calldata newURI
) external;
```

Requirements:

* Only owner MAY update
* Emits `MetadataUpdated`

---

### deactivateAgent

```solidity
function deactivateAgent(bytes32 agentId) external;
```

Requirements:

* Only owner MAY deactivate
* Emits `AgentDeactivated`

---

## Events (MANDATORY)

```solidity
event AgentRegistered(
    bytes32 indexed agentId,
    address indexed owner,
    string metadataURI
);

event MetadataUpdated(
    bytes32 indexed agentId,
    string newURI
);

event AgentDeactivated(
    bytes32 indexed agentId
);
```

Indexers MUST rely on events for state reconstruction.

---

## Metadata Anchoring

`metadataURI` SHOULD reference:

* IPFS CID
* Arweave TX
* HTTPS endpoint (discouraged but allowed)

Metadata MUST conform to RFC-0001.

---

## Identity Binding

Ownership is bound to:

```
msg.sender
```

Ownership transfer MAY be implemented in future revisions.

---

## Upgrade Strategy

The registry SHOULD be deployed using:

* Transparent proxy pattern OR
* Minimal immutable contract with versioned deployments

Upgrade events MUST be publicly visible.

---

## Multi-Chain Strategy

The registry MAY be deployed on:

* Ethereum Mainnet
* Base
* Optimism
* Other EVM chains

Cross-chain canonical identity MAY use:

* DID references (RFC-0004)
* Chain-specific registry addresses

---

## Security Considerations

Threats:

* front-running agentId
* metadata spoofing
* malicious upgrades

Mitigations:

* deterministic agentId generation
* signature verification before registration
* transparent upgrade governance

---

## Gas Optimization Notes

* Avoid storing large strings
* Encourage IPFS usage
* Rely on events for indexing

---

## Backwards Compatibility

Off-chain agents MAY operate without on-chain registration.

However:

* Marketplace ranking SHOULD favor registered agents.

---

## Reference Implementation

* Solidity reference contract (TBD)
* Deployment scripts (Hardhat / Foundry)

---

## Future Extensions

* On-chain reputation checkpoints
* Revenue sharing module
* Soulbound reputation tokens
* Staking-based trust model

---

## Conclusion

This RFC establishes Veragent's canonical on-chain anchor layer, ensuring:

* permanence
* neutrality
* interoperability
* trust-minimized discovery

It completes the foundational Veragent protocol stack.

---

## Copyright

Copyright and related rights waived via CC0.
