Dashcore Node + Insight API + Insight UI in Docker
=========

This image contains only Dashcore Node (JS). You also need to run **dashd** separately. See docker-compose examples.

To run **testnet** using docker-compose:
```bash
docker-compose -f docker-compose.testnet.yml up -d
```

### Environment variables

- `DASH_TESTNET` (default: 1) - Set 0 to enable livenet
- `DASH_RPC_HOST` (default: 127.0.0.1) - Dash node RPC host
- `DASH_RPC_PORT` (default: 9999) - Dash node RPC port
- `DASH_RPC_USER` (default: dash) - Dash node RPC user
- `DASH_RPC_PASSWORD` (default: dash) - Dash node RPC password
- `DASH_ZMQ_HOST` (default: empty, equals to `DASH_RPC_HOST`) - Dash node ZMQ host
- `DASH_ZMQ_PORT` (default: 28332) - Dash node ZMQ port
- `API_ROUTE_PREFIX` (default: api) - Set URL prefix for Insight API
- `UI_ROUTE_PREFIX` (default: "") - Set URL prefix for Insight UI
- `API_CACHE_ENABLE` (default: 1) - Enable/disable Insight API cache
- `API_LIMIT_ENABLE` (default: 1) - Enable/disable Insight API rate limiter
- `API_LIMIT_WHITELIST` (default: "127.0.0.1 ::1") - Whitelist, delimited by space
- `API_LIMIT_BLACKLIST` (default: "") - Blacklist, delimited by space
- `API_LIMIT_COUNT` (default: 10800)
- `API_LIMIT_INTERVAL` (default: 10800000)
- `API_LIMIT_WHITELIST_COUNT` (default: 108000)
- `API_LIMIT_WHITELIST_INTERVAL` (default: 10800000)
- `API_LIMIT_BLACKLIST_COUNT` (default: 0)
- `API_LIMIT_BLACKLIST_INTERVAL` (default: 10800000)
