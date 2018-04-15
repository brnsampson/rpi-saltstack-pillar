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

    bootstrap_expect: 1

# vim: ft=yaml
