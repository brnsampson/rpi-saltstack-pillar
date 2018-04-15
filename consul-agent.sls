consul:
  # Start Consul agent service and enable it at boot time
  service: True

  # Set user and group for Consul config files and running service
  user: consul
  group: consul

  config:
    server: False
    bind_addr: 127.0.0.1

    enable_debug: True

    datacenter: rwc

    encrypt: "OjkSmQpYnaaX/VPihAfEWq=="

# vim: ft=yaml
