nomad:
  bin_dir: /usr/bin
  config_dir: /etc/nomad
  config:
    data_dir: /var/lib/nomad
    # Nodes not bound to consul must be configured to advertise themselves.
    advertise:
      http: "{{grains['fqdn_ip4'][0]}}"
      rpc: "{{grains['fqdn_ip4'][0]}}"
      serf: "{{grains['fqdn_ip4'][0]}}"
    server:
      enabled: True
      bootstrap_expect: 1
      encrypt: "OicYnw+SToxUwNQgpYmndk=="
    client:
      enabled: True
# Sample configuration for a Consul deployment:
#    consul:
#      ssl: True
#      address: "{{grains['id']}}:8543"
#      token: "deadbeef-dead-beef-dead-beefdeadbee"
#      ca_file: "/srv/certs/ca.crt"
#      cert_file: "/srv/certs/{{grains['id']}}.pem"
#      key_file: "/srv/certs/{{grains['id']}}.key"
#      server_auto_join: True
#      client_auto_join: True
# Sample configuration for TLS encryption:
#    tls:
#      http: True
#      rpc: True
#      ca_file: "/srv/certs/ca.crt"
#      cert_file: "/srv/certs/{{grains['id']}}.pem"
#      key_file: "/srv/certs/{{grains['id']}}.key"
#      verify_server_hostname: True
