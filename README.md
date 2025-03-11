# containerized-xmr-miner

This repository provides a Dockerized version of [XMRig](https://github.com/xmrig/xmrig), a high-performance Monero (XMR) miner. The donation level has been set to **0%**, meaning no mining power is contributed to the XMRig developers by default.

The container is available on **Docker Hub**: [kebza/xmr-miner](https://hub.docker.com/repository/docker/kebza/xmr-miner)

## Usage
This container runs **XMRig** and requires arguments to be passed at runtime via `docker run`. You must provide the necessary mining parameters as per XMRig's [command-line options](https://xmrig.com/docs/miner/command-line-options).

### Running the Container
Use the following command to start mining, replacing `<XMRIG_ARGUMENTS>` with your desired arguments:

```bash
docker run --rm kebza/xmr-miner <XMRIG_ARGUMENTS>
```

### Example: Mine on a Pool Using Your Wallet
To mine using the `pool.supportxmr.com` pool with your Monero wallet, use:

```bash
docker run --rm kebza/xmr-miner -o pool.supportxmr.com:3333 -u YOUR_WALLET_ADDRESS -p x -k
```

Replace `YOUR_WALLET_ADDRESS` with your actual Monero wallet address.

## Features
- **Containerized XMRig** for easy deployment.
- **No donation fee** (modified `donate.h` to set the donation level to `0%`).
- **Lightweight Alpine-based image** for minimal overhead.
- **Pass runtime arguments** dynamically when starting the container.
