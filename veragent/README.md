Veragent — Verifiable AI Agents over HTTP

> No accounts. No API keys. No subscriptions.



Veragent turns AI agents into verifiable, paid HTTP services using open standards.


---

ai-agent-marketplace-mvp (Monorepo)

This is a minimal but production-oriented skeleton for an AI Agent Marketplace using:

OpenClaw (agent runtime)

x402 (HTTP crypto payments)

ERC-8004 (agent identity & permission)



---

📦 Repository Structure (Rebranded)

veragent/
├─ apps/
│  ├─ web/                 # Veragent marketplace UI
│  └─ gateway/             # Veragent Gateway (OpenClaw + x402)
│
├─ agents/                 # Veragent Agents
│  ├─ defi-monitor/
│  ├─ contract-explainer/
│  └─ web-scraper/
│
├─ contracts/
│  └─ VeragentRegistry.sol # ERC-8004 implementation
│
├─ packages/
│  ├─ erc8004-sdk/
│  └─ agent-registry/
│
├─ docker-compose.yml
├─ README.md
└─ tsconfig.base.json

ai-agent-marketplace-mvp/
├─ apps/
│  ├─ web/                 # Next.js frontend (marketplace UI)
│  └─ gateway/             # API Gateway (OpenClaw + x402)
│
├─ agents/                 # OpenClaw agents
│  └─ defi-monitor/
│     ├─ agent.yaml
│     ├─ handler.ts
│     └─ tools.ts
│
├─ contracts/              # Smart contracts
│  └─ ERC8004Registry.sol
│
├─ packages/
│  ├─ erc8004-sdk/         # TS helper for ERC-8004 read/check
│  └─ agent-registry/      # Off-chain agent metadata
│
├─ docker-compose.yml
├─ package.json
├─ tsconfig.base.json
└─ README.md


---

🧠 apps/gateway (OpenClaw + x402)

apps/gateway/src/index.ts

import express from "express";
import { x402Middleware } from "@coinbase/x402-express";
import { runAgent } from "./runAgent";
import { checkPermission } from "@repo/erc8004-sdk";

const app = express();
app.use(express.json());

app.post(
  "/agent/:id/run",
  x402Middleware({ price: "0.0005 ETH" }),
  async (req, res) => {
    const agentId = req.params.id;
    const caller = req.headers["x-wallet-address"] as string;

    await checkPermission(
      process.env.RPC_URL!,
      process.env.ERC8004_REGISTRY!,
      agentId,
      caller
    );

    const result = await runAgent(agentId, req.body);
    res.json(result);
  }
);

app.listen(3001, () => {
  console.log("Gateway running on :3001");
});
```ts
import express from "express";
import { x402Middleware } from "@coinbase/x402-express";
import { runAgent } from "./runAgent";
import { checkPermission } from "@repo/erc8004-sdk";

const app = express();
app.use(express.json());

app.post(
  "/agent/:id/run",
  x402Middleware({ price: "0.0005 ETH" }),
  async (req, res) => {
    const agentId = req.params.id;
    const caller = req.headers["x-wallet-address"] as string;

    await checkPermission(agentId, caller);

    const result = await runAgent(agentId, req.body);
    res.json(result);
  }
);

app.listen(3001, () => {
  console.log("Gateway running on :3001");
});


---

🤖 agents/defi-monitor

agent.yaml

name: defi-monitor
description: Scan DeFi protocol risk signals
entry: handler.ts
permissions:
  - chain:read
  - http:fetch

handler.ts

import { fetchTVL } from "./tools";

export async function run(input: { protocol: string }) {
  const tvl = await fetchTVL(input.protocol);

  return {
    protocol: input.protocol,
    tvl,
    risk: tvl < 10_000_000 ? "HIGH" : "LOW"
  };
}


---

🤖 agents/contract-explainer

agent.yaml

name: contract-explainer
description: Explain smart contract source code
entry: handler.ts
permissions:
  - llm:inference

handler.ts

export async function run(input: { source: string }) {
  return {
    summary: "This smart contract manages token transfers and ownership.",
    risks: ["No reentrancy guard", "Owner has full control"]
  };
}


---

🤖 agents/web-scraper

agent.yaml

name: web-scraper
description: Scrape and summarize a webpage
entry: handler.ts
permissions:
  - http:fetch
  - llm:inference

handler.ts

export async function run(input: { url: string }) {
  return {
    url: input.url,
    title: "Example Page",
    summary: "This page discusses blockchain and AI agents."
  };
}

yaml name: defi-monitor description: Scan DeFi protocol risk signals entry: handler.ts permissions:

chain:read

http:fetch


### handler.ts
```ts
import { fetchTVL } from "./tools";

export async function run(input: { protocol: string }) {
  const tvl = await fetchTVL(input.protocol);

  return {
    protocol: input.protocol,
    tvl,
    risk: tvl < 10_000_000 ? "HIGH" : "LOW"
  };
}


---

🪪 contracts/ERC8004Registry.sol (MVP – Permissioned Agent Identity)

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ERC8004Registry {
    struct Agent {
        address owner;
        string metadataURI;
        bool exists;
    }

    mapping(bytes32 => Agent) public agents;
    mapping(bytes32 => mapping(address => bool)) public permissions;

    event AgentRegistered(bytes32 indexed agentId, address indexed owner);
    event PermissionGranted(bytes32 indexed agentId, address indexed caller);

    function registerAgent(bytes32 agentId, string calldata metadataURI) external {
        require(!agents[agentId].exists, "Agent exists");
        agents[agentId] = Agent({
            owner: msg.sender,
            metadataURI: metadataURI,
            exists: true
        });
        emit AgentRegistered(agentId, msg.sender);
    }

    function grantPermission(bytes32 agentId, address caller) external {
        require(msg.sender == agents[agentId].owner, "Not owner");
        permissions[agentId][caller] = true;
        emit PermissionGranted(agentId, caller);
    }

    function canCall(bytes32 agentId, address caller) external view returns (bool) {
        return permissions[agentId][caller];
    }
}
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ERC8004Registry {
    struct Agent {
        address owner;
        string metadataURI;
        mapping(address => bool) allowed;
    }

    mapping(bytes32 => Agent) private agents;

    function registerAgent(bytes32 agentId, string calldata metadataURI) external {
        agents[agentId].owner = msg.sender;
        agents[agentId].metadataURI = metadataURI;
    }

    function allowCaller(bytes32 agentId, address caller) external {
        require(msg.sender == agents[agentId].owner, "Not owner");
        agents[agentId].allowed[caller] = true;
    }

    function canCall(bytes32 agentId, address caller) external view returns (bool) {
        return agents[agentId].allowed[caller];
    }
}


---

🔗 packages/erc8004-sdk

index.ts

import { ethers } from "ethers";

const ABI = [
  "function canCall(bytes32 agentId, address caller) view returns (bool)"
];

export async function checkPermission(
  providerUrl: string,
  registry: string,
  agentId: string,
  caller: string
) {
  const provider = new ethers.JsonRpcProvider(providerUrl);
  const contract = new ethers.Contract(registry, ABI, provider);

  const ok = await contract.canCall(agentId, caller);
  if (!ok) throw new Error("ERC-8004: permission denied");
}
```ts
import { ethers } from "ethers";

export async function checkPermission(agentId: string, caller: string) {
  // call canCall(agentId, caller)
  // throw if false
  return true;
}


---

🖥 apps/web (Veragent UI – Homepage & Playground)

pages/index.tsx

export default function Home() {
  return (
    <main className="p-12 max-w-3xl mx-auto">
      <h1 className="text-4xl font-bold mb-4">Veragent</h1>
      <p className="text-lg mb-6">
        Verifiable, paid AI agents over HTTP.
      </p>

      <ul className="space-y-2 mb-8">
        <li>• No accounts</li>
        <li>• No API keys</li>
        <li>• Pay per execution</li>
      </ul>

      <a
        href="/agent/defi-monitor"
        className="px-6 py-3 bg-black text-white rounded"
      >
        Run an Agent
      </a>
    </main>
  );
}
```tsx
import Link from "next/link";

const agents = [
  { id: "defi-monitor", name: "DeFi Monitor" },
  { id: "contract-explainer", name: "Contract Explainer" },
  { id: "web-scraper", name: "Web Scraper" }
];

export default function Home() {
  return (
    <main className="p-8">
      <h1 className="text-2xl font-bold mb-4">AI Agent Marketplace</h1>
      <ul className="space-y-2">
        {agents.map(a => (
          <li key={a.id}>
            <Link href={`/agent/${a.id}`} className="text-blue-600">
              {a.name}
            </Link>
          </li>
        ))}
      </ul>
    </main>
  );
}

pages/agent/[id].tsx

import { useState } from "react";
import { useRouter } from "next/router";

export default function AgentPage() {
  const { query } = useRouter();
  const [result, setResult] = useState<any>(null);

  async function runAgent() {
    const res = await fetch(`http://localhost:3001/agent/${query.id}/run`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ input: "demo" })
    });
    const data = await res.json();
    setResult(data);
  }

  return (
    <main className="p-8">
      <h2 className="text-xl font-semibold">Agent: {query.id}</h2>
      <button
        onClick={runAgent}
        className="mt-4 px-4 py-2 bg-black text-white rounded"
      >
        Run Agent (Pay per call)
      </button>

      {result && (
        <pre className="mt-4 bg-gray-100 p-4 rounded">
          {JSON.stringify(result, null, 2)}
        </pre>
      )}
    </main>
  );
}
```tsx
export default function Home() {
  return (
    <main className="p-8">
      <h1 className="text-2xl font-bold">AI Agent Marketplace</h1>
      <p>Pay-per-call AI agents via x402</p>
    </main>
  );
}


---

🐳 docker-compose.yml

version: "3.9"
services:
  gateway:
    build: ./apps/gateway
    ports:
      - "3001:3001"

  web:
    build: ./apps/web
    ports:
      - "3000:3000"


---

✅ MVP Guarantees

No API keys

No user accounts

Agent = product

Payment = protocol

Identity & permission = on-chain



---

🌍 Public Demo (veragent.xyz)

Live Demo Script (90 seconds)

1. Open veragent.xyz

> "This is Veragent — verifiable AI agents over HTTP."




2. Click an agent

> "Each agent is a paid HTTP endpoint."




3. Run agent

> "No login, no API key. The request returns 402 Payment Required."




4. Wallet pays

> "Payment is native to HTTP using x402."




5. Result returns

> "Execution is permissioned via on-chain identity."




6. Close

> "This is what AI services look like without SaaS."





---|---| | VPS | Hetzner / DigitalOcean (2GB RAM cukup) | | OS | Ubuntu 22.04 | | Domain | agent.yourdomain.xyz | | Chain | Base Sepolia |

Deployment Flow

# VPS
sudo apt update && sudo apt install docker docker-compose -y

# Clone repo
git clone https://github.com/you/ai-agent-marketplace-mvp
cd ai-agent-marketplace-mvp

# Env
cp .env.example .env
RPC_URL=...
ERC8004_REGISTRY=0x...

# Run
sudo docker-compose up -d

Gateway → https://api.agent.yourdomain.xyz Web → https://agent.yourdomain.xyz


---

🎤 Veragent Pitch (5 Slides)

Slide 1 — Problem

AI services are locked behind:

API keys

Accounts

Subscriptions


These models break for autonomous AI agents.


---

Slide 2 — Solution

Veragent

AI agents = paid HTTP services

Crypto-native payments (x402)

On-chain identity & permission (ERC-8004)



---

Slide 3 — Architecture

Client → HTTP → x402 → Veragent Gateway → ERC-8004 → Agent

Protocol-first. Vendor-neutral.


---

Slide 4 — Demo

Live demo:

Click

Pay

Execute


No signup. No keys.


---

Slide 5 — Vision

Veragent is the missing payment & identity layer for AI agents on the web.

The App Store moment for AI agents.


---

📄 Veragent README (Protocol-Grade)

What is Veragent?

Veragent is a protocol-first marketplace where AI agents become verifiable, paid HTTP services.

Instead of API keys, accounts, or subscriptions, Veragent uses:

HTTP-native crypto payments (x402)

On-chain agent identity & permission (ERC-8004)

Open agent runtimes (OpenClaw)


> No accounts. No API keys. No subscriptions.




---

Why Veragent Exists

Modern AI systems are becoming autonomous agents, not just chatbots.

But today’s AI infrastructure is still built for:

human users

centralized SaaS

static API keys


These models break for autonomous agents.

Veragent introduces a new primitive:

> Pay-per-execution AI agents with verifiable identity.




---

Core Concepts

1. Agents, not APIs

Each AI agent is:

a standalone service

callable over HTTP

priced per execution


2. Payment is part of the protocol

Requests use HTTP 402 Payment Required via x402.

Payment happens before execution.

3. Verifiable identity

Every agent has an on-chain identity using ERC-8004:

ownership

permissioned execution

auditable access



---

Architecture

Client
  → HTTP request
  → 402 Payment Required (x402)
  → Payment sent
  → Veragent Gateway
  → ERC-8004 permission check
  → Agent execution
  → Response


---

What Veragent is NOT

❌ Not a chatbot platform

❌ Not a prompt marketplace

❌ Not a SaaS AI product

❌ Not subscription-based


Veragent is infrastructure.


---

Current Status

MVP: Live

Agents: DeFi Monitor, Contract Explainer, Web Scraper

Network: Base testnet

Payments: x402



---

Vision

AI agents will transact with:

other agents

software systems

smart contracts


Veragent is the identity and payment layer that makes this possible.

> The App Store moment for AI agents.




---

Get Involved

Build an agent

Integrate the gateway

Contribute to the protocol


Veragent is open by default.


---

🧩 Agent Creator Onboarding

This guide helps developers publish their first paid, verifiable AI agent on Veragent in under 30 minutes.

0. Prerequisites

Basic HTTP knowledge

One runnable agent (AI model, script, or service)

Wallet that supports EVM (for ERC‑8004)



---

1. Wrap Your Agent as an HTTP Service

Your agent must expose a simple HTTP interface.

Minimal requirements:

POST /execute

JSON input

JSON output


Example:

POST /execute
Content-Type: application/json

{
  "task": "summarize",
  "input": "long text here"
}

The agent should be stateless or internally handle state.


---

2. Define Pricing (x402)

Choose a price per execution.

Example:

{
  "price": "0.0001",
  "currency": "ETH",
  "unit": "per_request"
}

Pricing is enforced via HTTP 402 Payment Required using x402.

No subscriptions. No API keys.


---

3. Register Agent Identity (ERC‑8004)

Each agent has an on‑chain identity.

You will register:

Agent name

Owner address

Endpoint URL

Capabilities metadata


This enables:

Verifiable ownership

Permissioned execution

Future composability between agents



---

4. Connect to Veragent Gateway

Deploy your agent behind the Veragent Gateway.

Gateway handles:

x402 payment verification

Routing requests

Execution authorization


Your agent never handles payments directly.


---

5. Test Execution Flow

End‑to‑end flow:

Client → HTTP request → 402 challenge → payment → execution → response

Test using:

curl

Postman

agent‑to‑agent calls



---

6. Publish to Marketplace

Once live, your agent appears in the Veragent Marketplace.

Users can discover agents by:

capability

price

protocol compatibility


Agents are callable instantly — no signup required.


---

7. Earn Automatically

Revenue flows directly to the agent owner.

Per execution

On‑chain settlement

Transparent by default



---

What Veragent Is NOT

Not a prompt marketplace

Not an AI SaaS

Not a chatbot builder


Veragent is protocol infrastructure for autonomous agents.


---

Next Steps

Add rate limits

Add versioning

Enable agent‑to‑agent calls


Welcome to the agent economy.
