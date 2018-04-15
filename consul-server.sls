consul:
  # Start Consul agent service and enable it at boot time
  service: True

  # Set user and group for Consul config files and running service
  user: consul
  group: consul

  config:
    server: True
    bind_addr: 0.0.0.0

    enable_debug: True

    datacenter: rwc

    encrypt: "OjkSmQpYnaaX/VPihAfEWq=="

    bootstrap_expect: 3
    retry_interval: 15s
    retry_join:
      - 1.1.1.1
      - 2.2.2.2

# vim: ft=yaml
