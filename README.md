Perfect 👍 Since you’re using **Foundry**, here’s a tailored `README.md` for your project with Foundry setup and commands included:

---

# 🗳️ Decentralized Survey dApp

A blockchain-based **survey application** built with Solidity.
This dApp allows users to **create surveys**, **participate in them**, and **download responses in CSV format** — all in a **decentralized, trustless way**.

---

## ✨ Features

* **Create Surveys** – Owner can publish new survey questions.
* **One Response per Participant** – Each wallet address can only respond once per survey.
* **On-Chain Transparency** – All questions and responses are stored securely on-chain.
* **CSV Export** – Frontend allows exporting survey data to CSV for analysis.
* **Owner-Restricted Access** – Only the owner can see participant details and responses.

---

## 🛠️ Tech Stack

* **Smart Contracts**: Solidity (`^0.8.0`)
* **Development Framework**: [Foundry](https://book.getfoundry.sh/)
* **Frontend**: HTML + JavaScript + Ethers.js
* **Blockchain**: Ethereum (works on Sepolia/Goerli testnets or local anvil)

---

## 📜 Smart Contract Overview

```solidity
function createSurvey(string memory question) external returns (uint256)
```

Create a new survey with a question. Returns a randomly generated `questionId`.

```solidity
function participate(string memory response, uint256 _questionId) external
```

Submit a response to a given survey question. Each address can only respond once.

```solidity
function getQuestions() external view returns (string[] memory)
```

Retrieve all survey questions.

```solidity
function getResponseOfParticipant(address participant, uint256 _questionId) external view onlyOwner
```

Get a participant’s response for a survey.

---

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/decentralized-survey-dapp.git
cd decentralized-survey-dapp
```

### 2. Install Foundry

If you don’t have Foundry installed:

```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

### 3. Build the Contracts

```bash
forge build
```

### 4. Run Tests

```bash
forge test
```

### 5. Deploy Locally (with Anvil)

Start a local Ethereum node:

```bash
anvil
```

Deploy the contract:

```bash
forge create --rpc-url http://127.0.0.1:8545 \
    --private-key <YOUR_PRIVATE_KEY> \
    src/Survey.sol:Survey
```

### 6. Interact with the Contract

* Connect with **Ethers.js** or **Cast (Foundry CLI)**
* Example: call `createSurvey` with Cast

```bash
cast send <CONTRACT_ADDRESS> "createSurvey(string)" "What is your favorite programming language?" \
    --rpc-url http://127.0.0.1:8545 \
    --private-key <YOUR_PRIVATE_KEY>
```

---

## 📊 CSV Export

The frontend supports **downloading responses as a CSV file**.
This makes results portable for Excel, Google Sheets, or feeding into AI tools.

---

## 🔮 Roadmap

* 🤖 **AI Insights** – Automatic summaries, sentiment analysis, and trends.
* 🎁 **Token Rewards** – Incentivize participants with tokens.
* 📋 **Multi-Question Surveys** – Support for structured forms.
* 🔐 **Privacy Enhancements** – zk-SNARKs / off-chain encrypted storage.

---

## 🤝 Contributing

Pull requests are welcome! Fork the repo, create a branch, and open a PR.

---

## 📜 License

This project is licensed under the **MIT License**.

