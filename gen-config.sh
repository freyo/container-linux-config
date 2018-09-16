#!/usr/bin/env bash

# Platform to target
# Accepted values: [azure digitalocean ec2 gce packet openstack-metadata vagrant-virtualbox cloudstack-configdrive custom]
PLATFORM=custom

# Path to the container linux config
IN_FILE=container-linux-config.yml

# Path to the resulting Ignition config
OUT_FILE=ignition-config.json

# Specify Config Transpiler version
CT_VER=v0.9.0

# Specify Architecture
# ARCH=aarch64 # ARM's 64-bit architecture
ARCH=x86_64

# Specify OS
# OS=apple-darwin # MacOS
# OS=pc-windows-gnu.exe # Windows
OS=unknown-linux-gnu # Linux

# Specify download URL
DOWNLOAD_URL=https://github.com/coreos/container-linux-config-transpiler/releases/download

# Remove previous downloads
rm -f /tmp/ct-${CT_VER}-${ARCH}-${OS}

# Download Config Transpiler binary
curl -L ${DOWNLOAD_URL}/${CT_VER}/ct-${CT_VER}-${ARCH}-${OS} -o /tmp/ct-${CT_VER}-${ARCH}-${OS}
chmod u+x /tmp/ct-${CT_VER}-${ARCH}-${OS}

/tmp/ct-${CT_VER}-${ARCH}-${OS} -pretty -strict -platform "${PLATFORM}" -in-file "${IN_FILE}" -out-file "${OUT_FILE}"
