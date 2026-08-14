# Limitations

- **iOS Support:** Currently targeting Android first due to deeper BLE GATT and background advertisement integrations. iOS will be considered once Android architecture is stable.
- **Double Spend Window:** Until synchronization with a Gateway, deeply uncoupled peers face an unresolvable double-spend risk. We mitigate this with local limits and trust-scoring.
