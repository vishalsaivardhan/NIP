# NIP / ProxiUPI
Secure Offline Proximity Payment Mesh

ProxiUPI is a Flutter application that enables offline, secure proximity payments over a custom Bluetooth Low Energy (BLE) mesh network. It acts as a resilient, localized financial network when internet connection is unavailable, with eventual synchronization to a backend ledger when a gateway device gains connectivity.

## Core Features
*   **Offline Payments:** Transact securely with zero internet connection via BLE.
*   **Encrypted Mesh Routing:** Multi-hop store-and-forward architecture for payment routing.
*   **Cryptographic Verifiability:** Ed25519 signatures and AES-GCM encryption ensure transaction security.
*   **Gateway Synchronization:** Certain devices can act as internet gateways to settle offline transactions to the Supabase backend.
*   **Risk Dashboard:** Visualizes transaction flow, flags potential anomalies, and provides a security overview.

## Getting Started
See [DEVELOPMENT.md](DEVELOPMENT.md) for environment setup and build instructions.
See [ARCHITECTURE.md](ARCHITECTURE.md) for deep dives into the app structure and mesh concepts.
