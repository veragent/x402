# RFC-0004: Agent Identity & Verification Standard (AIVS)

## Metadata
* **RFC Number**: 0004
* **Title**: Agent Identity & Verification Standard (AIVS)
* **Status**: Draft
* **Author**: Veragent Core Team
* **Created**: 2026-02-11
* **Requires**: RFC-0001

---

### Abstract

RFC ini mendefinisikan standar identitas dan verifikasi untuk agent dalam ekosistem Veragent.  
Tujuannya adalah memastikan bahwa setiap agent memiliki identitas yang:

- Cryptographically verifiable
- Portable
- Interoperable
- Secure-by-default

Standar ini memungkinkan agent memiliki:

- DID (Decentralized Identifier)
- Wallet Address (EVM-based)
- Signature Proof
- Optional KYC/Trust Badge


## Motivation

Tanpa sistem identitas standar, agent rentan terhadap:

- Impersonation
- Sybil attacks
- Fraudulent monetization
- API abuse

Dengan AIVS, kita memastikan:

- Setiap agent dapat diverifikasi
- Payment flow aman
- Trust layer terbentuk sejak awal



## Specification

### 1. Agent DID Format

Agent MUST memiliki salah satu dari:

```

did:veragent:<hash>

```

Atau menggunakan standar DID existing seperti:

```

did:ethr:<address>

````


### 2. Required Identity Fields

Setiap agent metadata (lihat RFC-0001) WAJIB memiliki:

```json
{
  "identity": {
    "did": "did:veragent:abc123",
    "wallet": "0x1234...abcd",
    "publicKey": "0x04abcd...",
    "verification": {
      "signature": "0x...",
      "timestamp": 1739272732
    }
  }
}
````

---

### 3. Signature Proof

Agent MUST menandatangani message berikut:

```
Veragent Identity Verification
Agent: <agent_id>
Timestamp: <unix_timestamp>
```

Signature menggunakan:

* ECDSA secp256k1
* Compatible dengan EVM wallet

---

### 4. Verification Process

Gateway akan:

1. Validate signature
2. Verify publicKey matches wallet
3. Check replay attack via timestamp
4. Store verification hash

---

### 5. Trust Levels

Agent dapat memiliki badge opsional:

| Level | Description     |
| ----- | --------------- |
| 0     | Unverified      |
| 1     | Wallet Verified |
| 2     | Domain Verified |
| 3     | KYC Verified    |
| 4     | DAO Attested    |

---

## Security Considerations

* Timestamp expiration max 10 minutes
* Nonce recommended for replay prevention
* Wallet private key MUST remain off-server
* Gateway MUST reject unsigned agent metadata

---

## Future Extensions

* Soulbound Reputation NFTs
* Onchain agent registry
* Cross-chain identity
* zk-proof identity validation

---

## Conclusion

AIVS memastikan setiap agent dalam Veragent memiliki identitas yang:

* Aman
* Terverifikasi
* Interoperable
* Siap untuk monetisasi onchain



---

