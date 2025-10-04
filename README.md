# OpenVPN for Docker

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/chadoe/docker-openvpn/master/LICENSE)

Setup a tiny (22MB), but full featured and secure OpenVPN server without effort using Docker.

## Quick Start

1. Create the docker-compose.yml file
   ```yaml
   services:
     openvpn:
       image: ghcr.io/yokitoki/openvpn:2.6.15-1.0.0
       container_name: openvpn
       restart: unless-stopped
       cap_add:
         - NET_ADMIN
       ports:
         - "1194:1194/udp"
       volumes:
         - /etc/localtime:/etc/localtime:ro
         - ./openvpn-data/conf:/etc/openvpn
   ```
   and start

   ```shell
   docker compose up -d
   ```

2. Initialize the OpenVPN configurations
   ```shell
   ovpnctl init host=vpn.example.com
   ovpnctl initpki
   ```

3. Generate a client certificate (nopass)
   ```shell
   ovpnctl new username=test
   ```
Profile in `.ovpn` will stored in `/etc/openvpn`

4. Revoke a client certificate
   ```shell
   ovpnctl revoke username=test
   ```
5. List all generated certificate names (includes the server certificate name)
   ```shell
   ovpnctl list
   ```

6. Renew the CRL
   ```shell
   ovpnctl renewcrl
   ```


* To enable (bash) debug output set an environment variable with the name DEBUG and value of 1
* To view the log output run `docker compose logs openvpn`, to view it realtime run `docker compose logs -f openvpn`

## Settings and features
* OpenVPN 2.6.12
* Easy-RSA v3.1.5+
* `tun` mode because it works on the widest range of devices. `tap` mode, for instance, does not work on Android, except if the device is rooted.
* The UDP server uses`192.168.255.0/24` for clients.
* TLS 1.2 minimum
* TLS auth key for HMAC security
* Diffie-Hellman parameters for perfect forward secrecy
* Verification of the server certificate subject
* Extended Key usage check of both client and server certificates
* 2048 bits key size
* Client certificate revocation functionality
* SHA256 signature hash
* AES-256-GCM cipher
* TLS cipher limited to TLS-ECDHE-RSA-WITH-AES-128-GCM-SHA256, TLS-ECDHE-ECDSA-WITH-AES-128-GCM-SHA256, TLS-DHE-RSA-WITH-AES-256-GCM-SHA384 or TLS-DHE-RSA-WITH-AES-256-CBC-SHA256
* Compression enabled and set to adaptive
* Floating client ip's enabled
* Tweaks for Windows clients
* `net30` topology because it works on the widest range of OS's. `p2p`, for instance, does not work on Windows.
* Google DNS (8.8.4.4 and 8.8.8.8)

* The configuration is located in `/etc/openvpn`
* Certificates are generated in `/etc/openvpn/pki`.


## Tested On

* Clients
  * Android, OpenVPN for Android 0.7.46
  * Windows 10 64 bit using openvpn-2.6.5

## Credits

- Based on [chadoe/docker-openvpn](https://github.com/chadoe/docker-openvpn).
- Based on [kylemanna/docker-openvpn](https://github.com/kylemanna/docker-openvpn).

