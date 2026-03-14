# Business Logic Vulnerabilities — CTF + Real World Exploit Examples

This repository demonstrates **Business Logic Vulnerabilities in Smart Contracts**.

Unlike low-level bugs (reentrancy, overflow), these vulnerabilities occur when the **protocol's economic rules allow unintended behavior**.

The code executes correctly, but the **protocol design is flawed**.

---

# Example 1 — CTF Style Logic Bug

A vault that distributes rewards based on deposit time.

The vulnerability occurs due to **incorrect reward checkpoint logic**, allowing attackers to claim rewards without maintaining stake.

Attackers can:

1. Deposit a small amount
2. Wait for rewards to accumulate
3. Withdraw
4. Re-deposit
5. Claim rewards multiple times

Result:
The attacker drains the reward pool.

---

# Example 2 — Real World DeFi Logic Bug

A simplified lending protocol with a **flash-loan style logic flaw**.

The protocol calculates borrowing power **before updating collateral balances**, allowing attackers to temporarily manipulate borrowing capacity.

Attack flow:

1. Deposit collateral
2. Borrow against it
3. Withdraw collateral
4. Leave protocol undercollateralized

---

# Running Tests

Install Foundry:

```
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

Run tests:

```
forge test -vv
```

---

# Security Lessons

Developers should:

• Define protocol invariants  
• Use invariant fuzz testing  
• Test adversarial transaction sequences  
• Verify economic assumptions

Business logic vulnerabilities are responsible for **many of the largest DeFi exploits**.