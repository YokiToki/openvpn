FROM alpine:3.22

# previous LABEL org.opencontainers.image.authors="Martin van Beurden <chadoe@gmail.com>"
LABEL org.opencontainers.image.authors="Stanislav Karakovskii <toodeadtofeel@gmail.com>"

ARG OPENVPN_V

COPY ./bin /usr/local/bin
COPY ./Makefile /etc/ovpnctl

RUN set -xe && \
    apk add --update --no-cache bash make easy-rsa iptables openssl openvpn=$OPENVPN_V && \
    ln -s /usr/share/easy-rsa/easyrsa /usr/local/bin && \
    chmod 774 /usr/local/bin/*

# Needed by scripts
ENV OPENVPN="/etc/openvpn" \
    EASYRSA="/usr/share/easy-rsa" \
    EASYRSA_PKI="/etc/openvpn/pki" \
    EASYRSA_VARS_FILE="/etc/openvpn/vars"

VOLUME ["/etc/openvpn"]

EXPOSE 1194/udp

WORKDIR /etc/openvpn

CMD ["startopenvpn"]
