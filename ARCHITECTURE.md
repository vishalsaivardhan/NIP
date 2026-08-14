# Architecture

## Technical Stack
- **Framework:** Flutter
- **State Management:** Riverpod
- **Routing:** GoRouter
- **Local DB:** Drift (SQLite)
- **Backend:** Supabase (PostgreSQL, Edge Functions)

## Clean Architecture Layers
- `core/`: Constants, errors, utilities, and configuration.
- `data/`: Data models, local Drift DAOs, and repository implementations.
- `domain/`: Business logic, domain entities, and abstract repository interfaces.
- `features/`: UI and feature-specific logic, organized by feature component (e.g., wallet, nearby devices).
- `services/`: Specialized services like background BLE communication.

## Network Topology
- **Standard Nodes:** Typical user devices broadcasting and passing signed transaction packets.
- **Gateway Nodes:** Devices with internet access that relay pending mesh queues to the backend.
