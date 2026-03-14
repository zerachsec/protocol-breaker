# 🔐 Business Logic Vulnerabilities in Smart Contracts

### CTF Challenges + Real‑World Exploit Examples (Foundry)

This repository demonstrates **Business Logic Vulnerabilities**, one of
the most dangerous and hardest‑to‑detect classes of smart contract
exploits.

Unlike traditional bugs such as **reentrancy, overflow, or
access‑control mistakes**, business logic vulnerabilities occur when the
**economic rules or state transitions of a protocol allow unintended
behavior**.

In these cases:

> The smart contract executes exactly as written --- but the protocol
> design itself is flawed.

------------------------------------------------------------------------

# 📚 What You Will Learn

This repository contains **two practical examples**:

### 🧩 Example 1 --- CTF Style Vault Exploit

A complex reward vault where attackers manipulate reward accounting by
exploiting a flaw in the reward distribution logic.

Attackers can artificially inflate rewards by manipulating the contract
balance.

Key concept: - Incorrect reward index calculation - Reward distribution
based on `address(this).balance` - Manipulation via direct ETH transfers

This is designed as a **CTF-style challenge for security researchers**.

------------------------------------------------------------------------

### 💣 Example 2 --- Real‑World DeFi Logic Exploit

A simplified lending protocol that allows borrowers to:

1.  Deposit collateral
2.  Borrow assets
3.  Withdraw collateral

Because the protocol **does not recheck collateralization after
borrowing**, attackers can leave the system undercollateralized and
drain liquidity.

This pattern has appeared in multiple real DeFi exploits.

Key concept: - Broken collateral invariants - Missing health factor
validation - Borrow → withdraw attack sequence

------------------------------------------------------------------------

# 📂 Repository Structure

    business-logic-vulnerabilities

    ├─ src
    │  ├─ CTFVault.sol
    │  ├─ RewardVault.sol
    │
    ├─ test
    │  ├─ CTFVault.t.sol
    │  ├─ RewardVault.t.sol
    │
    └─ README.md

------------------------------------------------------------------------

# ⚙️ Setup (Foundry)

Install Foundry:

    curl -L https://foundry.paradigm.xyz | bash
    foundryup

Clone the repository and run tests:

    forge test -vv

------------------------------------------------------------------------

# 🧪 Running the Exploit Tests

The test suite demonstrates how attackers exploit the vulnerabilities.

Run:

    forge test -vv

You should see the exploit tests succeed, demonstrating that the
attacker profits from the flawed protocol logic.

------------------------------------------------------------------------

# 🧠 Key Security Lessons

Developers building DeFi protocols must carefully design **economic
invariants**.

Examples include:

    TotalAssets >= TotalLiabilities
    Debt <= CollateralValue
    RewardsDistributed <= RewardsGenerated

Violating these invariants can allow attackers to extract funds from the
protocol.

------------------------------------------------------------------------

# 🛡 Recommended Security Practices

### Define Protocol Invariants

Clearly define what conditions must always remain true.

Example:

    debt <= collateral * collateralFactor

------------------------------------------------------------------------

### Use Invariant Testing

Tools such as:

-   Foundry invariant testing
-   Echidna
-   Medusa

can automatically test adversarial scenarios and detect logic flaws.

------------------------------------------------------------------------

### Deploy With Limits

New strategies and protocol features should be deployed with safety
controls:

-   Deposit caps
-   Borrow limits
-   Governance timelocks

This limits losses if a vulnerability exists.

------------------------------------------------------------------------

# 🎯 Challenge for Security Researchers

Try to:

• Write your own Foundry exploit test\
• Break protocol invariants\
• Discover alternative attack paths

Can you drain the vault without sending ETH directly?

------------------------------------------------------------------------

# 🔎 Why Business Logic Bugs Matter

Many of the **largest DeFi exploits** were caused by business logic
flaws rather than technical coding mistakes.

Understanding these vulnerabilities is essential for:

-   Smart contract developers
-   Security auditors
-   DeFi protocol designers

Mastering this area will significantly improve your **smart contract
security expertise**.

------------------------------------------------------------------------

# 📢 Educational Use

This repository is intended for **security research and educational
purposes only**. Do not deploy vulnerable contracts in production
environments.
