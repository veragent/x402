# RFC-0005 — Agent Payment & Monetization Standard (APMS)

## Metadata
* **RFC Number**: 0005
* **Title**: Agent Payment & Monetization Standard (APMS)
* **Status*: Draft
* **Author(s)**: Veragent Core Team
* **Created**: 2026-02-11
* **Requires**: RFC-0002, RFC-0004
---

## Abstract

RFC ini mendefinisikan standar monetisasi agent menggunakan:

- x402 payment flow
- Onchain settlement
- Usage-based billing
- Micropayment support

---

## Motivation

Agent perlu monetisasi yang:

- Native to internet
- Machine-to-machine compatible
- Real-time settlement
- Permissionless

x402 memungkinkan HTTP-native payment handshake.

---

## Payment Flow

### 1. Client Request

Client mengirim request ke agent:

```
POST /invoke
```

Jika agent berbayar, response:

```

402 Payment Required
X-402-Required: true
X-402-Pricing: 0.0005 ETH
X-402-Address: 0xabc...

```

---

### 2. Client Pays

Client melakukan:

- Signed payment payload
- Payment proof attached

---

### 3. Retry Request

Client kirim ulang dengan header:

```

X-402-Payment-Proof: 0xabc...

````

---

### 4. Gateway Validation

Gateway akan:

- Validate signature
- Verify amount
- Check replay attack
- Approve request

---

## Pricing Model

Agent dapat memilih model:

| Model | Description |
|-------|------------|
| Per Request | Flat cost |
| Per Token | AI usage based |
| Subscription | Monthly access |
| Streaming | Per second |

---

## Required Metadata

Agent metadata MUST include:

```json
{
  "monetization": {
    "enabled": true,
    "currency": "ETH",
    "price": "0.0005",
    "model": "per_request"
  }
}
````

---

## Revenue Distribution (Optional)

Future extension:

```json
{
  "split": {
    "creator": 90,
    "protocol": 5,
    "referral": 5
  }
}
```

---

## Security Considerations

* Replay attack protection
* Rate limiting pre-payment
* Payment proof expiry
* Signed price configuration

---

## Compliance

APMS MUST comply with:

* x402 HTTP Payment spec
* EVM signature standard
* Secure transport (HTTPS)

---

## Conclusion

APMS memungkinkan Veragent menjadi:

* Machine economy ready
* Internet-native
* Crypto composable
* Developer friendly


---

