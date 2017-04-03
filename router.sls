firewall:
  enabled: True
  install: True
  strict: True
  tables:
    nat:
      POSTROUTING:
        - jump: MASQUERADE
          out-interface: eth0
      PREROUTING:
        - jump: DNAT
          proto: tcp
          extension_parameters:
            dport: 80
            to-destination: '10.0.0.100-10.0.0.199'
        - jump: DNAT
          proto: tcp
          extension_parameters:
            dport: 443
            to-destination: '10.0.0.100-10.0.0.199'
        - jump: DNAT
          proto: tcp
          extension_parameters:
            dport: 139
            to-destination: '10.0.0.100-10.0.0.199'
        - jump: DNAT
          proto: tcp
          extension_parameters:
            dport: 445
            to-destination: '10.0.0.100-10.0.0.199'
        - jump: DNAT
          proto: udp
          extension_parameters:
            dport: 137
            to-destination: '10.0.0.100-10.0.0.199'
        - jump: DNAT
          proto: udp
          extension_parameters:
            dport: 138
            to-destination: '10.0.0.100-10.0.0.199'
    filter:
      INPUT:
        - jump: ACCEPT
          proto: tcp
          extension_parameters:
            dport: 22
        - jump: ACCEPT
          proto: tcp
          extension_parameters:
            dport: 4505
        - jump: ACCEPT
          proto: tcp
          extension_parameters:
            dport: 4506
        - jump: ACCEPT
          proto: tcp
          interface: br0
          extension_parameters:
            dport: 53
        - jump: ACCEPT
          proto: udp
          extension_parameters:
            dport: 67:68
            sport: 67:68
        - jump: ACCEPT
          proto: udp
          interface: br0
          extension_parameters:
            dport: 53
      FORWARD:
        - jump: ACCEPT
          in-interface: br0
        - jump: ACCEPT
          proto: tcp
          source: '192.168.1.0/24'
          destination: '10.0.0.0/24'
          extension_parameters:
            dport: 80
        - jump: ACCEPT
          proto: tcp
          source: '192.168.1.0/24'
          destination: '10.0.0.0/24'
          extension_parameters:
            dport: 443
        - jump: ACCEPT
          proto: tcp
          source: '192.168.1.0/24'
          destination: '10.0.0.0/24'
          extension_parameters:
            dport: 445
        - jump: ACCEPT
          proto: tcp
          source: '192.168.1.0/24'
          destination: '10.0.0.0/24'
          extension_parameters:
            dport: 139
        - jump: ACCEPT
          proto: udp
          source: '192.168.1.0/24'
          destination: '10.0.0.0/24'
          extension_parameters:
            dport: 137
        - jump: ACCEPT
          proto: udp
          source: '192.168.1.0/24'
          destination: '10.0.0.0/24'
          extension_parameters:
            dport: 138

dhcpd:
  domain_name: whobe.us
  domain_name_servers:
    - seed01.whobe.us
  listen_interfaces:
    - br0
  subnets:
    10.0.0.0:
      comment: This 
