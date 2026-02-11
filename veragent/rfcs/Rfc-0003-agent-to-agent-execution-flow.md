# RFC-0003: Agent-to-Agent Execution Flow

## Metadata

* **RFC Number**: 0003
* **Title**: Agent-to-Agent Execution Flow
* **Status**: Draft
* **Author(s)**: Veragent Core Contributors
* **Created**: 2026-02-11
* **Category**: Protocol / Execution
* **Requires**: RFC-0001, RFC-0002, x402, ERC-8004

---

## Abstract

This RFC defines a **standard execution flow for agent-to-agent calls** within the Veragent ecosystem.

It specifies how one AI agent (the *caller*) can invoke another AI agent (the *callee*) using HTTP-native execution, enforce payment via x402, and respect on-chain permissions via ERC-8004.

The goal is to enable **composable, autonomous agent systems** without centralized orchestration.

---

## Motivation

As AI systems evolve, agents will increasingly:

* call other agents as subroutines
* compose multi-step workflows
* transact value programmatically

Without a standardized agent-to-agent flow:

* payment responsibility is ambiguous
* permission boundaries are unclear
* gateways implement incompatible logic

This RFC establishes a **clear, deterministic execution model** for agent composition.

---

## Definitions

* **Caller Agent**: The agent initiating an execution request
* **Callee Agent**: The agent being invoked
* **Gateway**: Veragent Gateway enforcing payments and permissions
* **Execution Context**: Metadata passed through chained executions

---

## Execution Model

### High-Level Flow

```
Caller Agent
  → HTTP request
  → 402 Payment Required (x402)
  → Payment settlement
  → Veragent Gateway
  → ERC-8004 permission check
  → Callee Agent execution
  → Response propagated to caller
```

---

## Payment Responsibility

### Default Rule

The **caller agent** is responsible for payment when invoking another agent.

This mirrors traditional function-call semantics:

* caller pays for execution
* costs may be internalized or recharged

---

### Alternative Models (Future)

* Delegated payment (user pays directly)
* Revenue splitting between agents
* Pre-funded execution budgets

These models are **out of scope** for this RFC and require future proposals.

---

## Execution Context

Each agent-to-agent call MUST include an execution context object:

```json
{
  "caller_agent_id": "bytes32",
  "request_id": "uuid",
  "depth": 1,
  "max_depth": 5
}
```

The gateway MUST enforce:

* maximum execution depth
* request traceability

---

## Permission Enforcement

Before execution, the gateway MUST verify:

* callee agent exists (ERC-8004)
* caller agent has permission to execute callee

Permissions MAY be:

* explicit allowlists
* capability-based

---

## Failure Handling

If any step fails:

* payment failure
* permission denial
* execution error

The gateway MUST:

* halt execution
* propagate error upstream
* prevent partial execution

---

## Backwards Compatibility

This RFC introduces new behavior for agent-to-agent calls.

Agents not implementing this flow:

* MAY operate independently
* MUST NOT participate in composed execution chains

---

## Security Considerations

Potential risks:

* recursive execution loops
* payment draining attacks
* permission escalation

Mitigations:

* execution depth limits
* strict permission checks
* gateway-mediated payments

---

## Privacy Considerations

Execution context SHOULD NOT expose:

* internal prompts
* sensitive intermediate data

Only minimal identifiers are propagated.

---

## Reference Implementation

* Veragent Gateway agent-to-agent router (TBD)
* Execution context validator (TBD)

---

## Adoption Strategy

* Optional during Draft phase
* Required for multi-agent workflows
* Gateways MAY initially restrict max depth to 1

---

## Drawbacks

* Increased execution complexity
* Higher gateway responsibility

---

## Alternatives

* Centralized workflow orchestrators (rejected)
* Off-chain settlement (rejected)

---

## Copyright

Copyright and related rights waived via CC0.
