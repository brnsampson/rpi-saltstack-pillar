firewall:
  enabled: True
  install: True
  strict: True
  tables:
    nat:
      POSTROUTING:
        - jump: MASQUERADE
          out-interface: eth0
#      PREROUTING:
#        - jump: DNAT
#          proto: tcp
#          in-interface: eth0
#          extension_parameters:
#            dport: 80
#            to-destination: '10.0.0.100-10.0.0.199'
#        - jump: DNAT
#          proto: tcp
#          in-interface: eth0
#          extension_parameters:
#            dport: 443
#            to-destination: '10.0.0.100-10.0.0.199'
    filter:
      INPUT:
        - jump: ACCEPT
          proto: tcp
          in-interface: br0
          source: '10.0.0.0/24'
          extension_parameters:
            dport: 22
        - jump: ACCEPT
          proto: tcp
          source: '10.0.0.0/24'
          module:
            state:
              state: new
          extension_parameters:
            dport: 4505
        - jump: ACCEPT
          proto: tcp
          source: '10.0.0.0/24'
          module:
            state:
              state: new
          extension_parameters:
            dport: 4506
        - jump: ACCEPT
          proto: tcp
          source: '10.0.0.0/24'
          extension_parameters:
            dport: 53
        - jump: ACCEPT
          proto: udp
          in-interface: br0
          extension_parameters:
            dport: 67:68
            sport: 67:68
        - jump: ACCEPT
          proto: udp
          source: '10.0.0.0/24'
          extension_parameters:
            dport: 53
      FORWARD:
        - jump: ACCEPT
          in-interface: br0
#        - jump: ACCEPT
#          proto: tcp
#          source: '192.168.1.0/24'
#          destination: '10.0.0.0/24'
#          extension_parameters:
#            dport: 80
#        - jump: ACCEPT
#          proto: tcp
#          source: '192.168.1.0/24'
#          destination: '10.0.0.0/24'
#          extension_parameters:
#            dport: 443

dhcpd:
  authoritative: True
  domain_name: whobe.us
  domain_name_servers:
    - 10.0.0.1
  default_lease_time: 600
  max_lease_time: 7200
  listen_interfaces:
    - br0
  subnets:
    10.0.0.0:
      comment: Home network subnet. Only planning on using the /24 block.
      netmask: 255.255.255.0
      range:
        - 10.0.0.100
        - 10.0.0.199
      routers:
        - 10.0.0.1
      broadcast_address: 10.0.0.255
  hosts:
    seed01:
      comment: This host (the router)
      host_name: seed01.whobe.us
      hardware: ethernet 00:0e:c4:ce:7d:65
      fixed_address: 10.0.0.1
    switch01:
      comment: A rosewill router we are using as a switch and wireless access point
      host_name: switch01.whobe.us
      hardware: ethernet 68:1C:A2:06:12:AB
      fixed_address: 10.0.0.2
    app01:
      comment: raspberry pi3 app host
      host_name: app01.whobe.us
      hardware: ethernet b8:27:eb:ec:b2:0e
      fixed_address: 10.0.0.10
    app02:
      comment: raspberry pi3 app host
      host_name: app02.whobe.us
      hardware: ethernet b8:27:eb:49:da:bf
      fixed_address: 10.0.0.11

### Overrides for the defaults specified by ###
### map.jinja                               ###
bind:
  lookup:
    pkgs:
      - bind9                                     # Need to install
    service: bind9                                # Service name

    # zones_source_dir: bind/zonedata             # Take zonefiles from `salt://bind/zonedata`
                                                  # instead of `salt://zones`
### General config options                  ###
  config:
    tmpl: salt://bind/files/debian/named.conf     # Template we'd like to use (not implemented?)
    user: bind                                    # File & Directory user
    group: bind                                   # File & Directory group
    mode: 640                                     # File & Directory mode
    options:
      listen-on:
        - '10.0.0.1'
      recursion: yes
      allow-recursion:
        - trusted
      allow-transfer:
        - none
      dnssec-validation: auto
      forwarders:
        - '8.8.8.8'
        - '8.8.4.4'
    protocol: 4                                   # Force bind to serve only one IP protocol
                                                  # (ipv4: 4, ipv6: 6). Omitting this reverts to
                                                  # binds default of both.
# Debian and FreeBSD based systems
    # default_zones: True                           # If set to True, the default-zones configuration
                                                  # will be enabled. Defaults to False.
# End Debian based systems

### Keys, Zones, ACLs and Views             ###
  configured_zones:
    whobe.us:                                     # First domain zone
      type: master                                # We're the master of this zone
      notify: False                               # Don't notify any NS RRs of any changes to zone

    0.0.10.in-addr-arpa:                          # Reverse lookup for local IPs
      type: master                                # As above
      notify: False                               # As above

### Externally defined Zones ###
  available_zones:
    whobe.us:
      file: db.whobe.us                           # DB file containing our zone
      masters: "10.0.0.1;"                        # Masters of this zone
    0.0.10.in-addr-arpa:
      file: db.0.0.10                             # DB file containing our zone
      masters: "10.0.0.1;"                        # Masters of this zone

  configured_acls:                                # And now for some ACLs
    trusted:                                      # Our ACL's name
      - 127.0.0.0/8                               # And the applicable IP addresses
      - 10.0.0.0/24
