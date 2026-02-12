# Veragent Indexer Architecture Outline

This document describes a reference off-chain indexer for VeragentRegistry.

The indexer is NOT part of the core protocol.
It is a replaceable component.

---

## 1. Purpose

The indexer:

* Listens to VeragentRegistry events
* Builds a queryable agent database
* Resolves metadata URIs
* Exposes read-only APIs

It must not introduce trust assumptions beyond the chain itself.

---

## 2. Data Sources

Primary source:

* `AgentRegistered`
* `MetadataUpdated`
* `AgentDeactivated`

Optional:

* Direct on-chain reads for verification

---

## 3. Indexing Flow

```
Blockchain
   ↓
Event Listener
   ↓
Normalize Event
   ↓
Store Agent Record
   ↓
Resolve metadataURI
   ↓
Validate RFC-0001 schema
   ↓
Expose API
```

---

## 4. Suggested Stack

Option A: The Graph

* Subgraph listening to events

Option B: Custom Indexer

* Node.js
* ethers.js
* PostgreSQL
* IPFS client

---

## 5. Minimal Agent Schema (Indexed)

Example DB model:

* agentId (bytes32)
* owner (address)
* metadataURI (string)
* active (bool)
* createdAt (timestamp)
* resolvedMetadata (json)

Metadata must be validated against RFC-0001.

---

## 6. API Surface (Read-Only)

Suggested endpoints:

GET /agents
GET /agents/:id
GET /agents?owner=0x...

No write endpoints.

---

## 7. Trust Model

Trust assumptions:

* On-chain events are canonical
* Metadata URI content must be verified
* Optional: signature validation

The indexer is a convenience layer, not authority.

---

## 8. Future Extensions

* Reputation aggregation (RFC-0006)
* Discovery ranking (RFC-0007)
* Cross-chain registry support

---

## End of Indexer Outline
