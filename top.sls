base:
  '*':
    - packages
    - users
    - salt-service
    - salt-formula
    - golang
  'roles:bootstrap':
    - match: grain
    - consul-bootstrap
    - nomad-bootstrap
