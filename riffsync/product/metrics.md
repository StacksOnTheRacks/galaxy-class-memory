# Primary metrics

- Successful guest joins to active hosted rooms (lobby or share URL)
- Hosted rooms that start shared video (broadcast) at least once
- Catalog → room create / solo watch conversion for signed-in hosts
- Indexable public page usefulness (search/social unfurls on catalog, watch, Live) — qualitative until analytics wired

# Supporting metrics

- Cast start / stop / failure rates among Cast-capable senders (when ops telemetry exists)
- Friends invite accept rate and DM send success among signed-in fans
- Stale-room sweep effectiveness (dead lobby rows)
- SFU / chat reconnect recovery without full session teardown

# Targets

- TBD after first metrics-review (no baseline instrumentation contract in product memory yet)
- Directional: guests never blocked from join/watch/read by auth walls; hosts can create and share within one session

# Current read

- Stub: production site live at https://riffsync.tv. Open board is the host Chrome MV3 control-panel MVP (#426 tracking; Ready #428–#431). Scaffold #427 closed. No quantified product dashboard read captured.
