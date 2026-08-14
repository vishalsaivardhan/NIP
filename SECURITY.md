# Security

## Cryptography & Identity
- **Device Identity:** Asymmetric key pairs (Ed25519) bind accounts securely to a device.
- **Packet Encryption:** Inter-node packets use AES-GCM to prevent eavesdropping by intermediary hops.
- **Message Signing:** Offline payment requests are signed with device private keys. Non-repudiation is maintained.

## Offline Limitations
- Transactions enforce offline limits on a local level to reduce exposure before settlement occurs. Total limits and frequency controls mitigate potential duplicate or double-spend attacks in a purely P2P offline state.

**Note:** Physical extraction of keys from compromised devices is mitigated via Android Keystore system constraints.
