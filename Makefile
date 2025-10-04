#make init host=vpn.example.com
init:
    initopenvpn -u udp://$(host)

initpki:
	initpki

#make new username=test
new:
    easyrsa build-client-full $(username) nopass
    getclient $(username) > $(username).ovpn

#make revoke username=test
revoke:
	revokeclient $(username)
	rm ./$(username).ovpn

list:
	listcerts

renewcrl:
	renewcrl

